## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_p2p_peer.gd
## AccelByte P2P — single WebRTC peer connection
## =============================================================================
##
## Manages one WebRTCPeerConnection + one RTCDataChannel to a specific peer.
## Handles the full signaling handshake via AccelByte Lobby:
##   CheckRequest → CheckResponse → Offer → Answer → Candidate → GatheringDone
##
## Wire format (matches project-a / Unity SDK):
##   - Signaling messages are JSON serialized then Base64 encoded
##   - Sent via lobby WS type "signalingP2PNotif"
##   - Received via LobbyWsService.signaling_p2p_notif signal
##   - "destinationId" field on receive = the SENDER's user ID (server flips it)
##
## Game code should NOT use this directly.
## Use AccelByteP2PManager instead.
##
## Requirements:
##   On desktop (Windows/Linux/macOS): install the Godot WebRTC plugin.
##   On web (HTML5): built-in, no plugin needed.
##   Asset Library: https://godotengine.org/asset-library/asset/2103
## =============================================================================

class_name AccelByteP2PPeer
extends RefCounted

# =============================================================================
# Signals
# =============================================================================

## Emitted when the WebRTC connection and data channel are fully open.
signal connected(peer_user_id: String)

## Emitted when the connection is closed or failed.
signal disconnected(peer_user_id: String)

## Emitted when the data channel receives data from the peer.
signal data_received(peer_user_id: String, data: PackedByteArray)

## Emitted when this peer has a Base64-encoded signaling message to send via lobby.
signal signaling_message_ready(destination_user_id: String, base64_message: String)

# =============================================================================
# Connection States
# =============================================================================

enum P2PState {
	DISCONNECTED,
	CHECKING_HOST,    ## Sent CheckRequest, waiting for CheckResponse
	CREATING_OFFER,   ## Creating SDP offer (initiator)
	WAITING_ANSWER,   ## Sent offer, waiting for answer
	CREATING_ANSWER,  ## Received offer, creating answer (receiver)
	CONNECTING,       ## ICE connecting
	CONNECTED,
	FAILED,
}

# =============================================================================
# State
# =============================================================================

var peer_user_id: String = ""
var is_initiator: bool = false
var state: P2PState = P2PState.DISCONNECTED

var _rtc_peer: WebRTCPeerConnection = null
var _data_channel: WebRTCDataChannel = null

var _ice_servers: Array = []

var _host_check_timeout_ms: int = 30000
var _host_check_start_time: int = 0

## ICE candidates received before remote description is set are queued here
## and flushed once set_remote_description() succeeds.
var _pending_candidates: Array = []

# =============================================================================
# Initialization
# =============================================================================

## Initialize with the remote peer's user ID and optional ICE servers.
func initialize(remote_user_id: String, ice_servers: Array = []) -> void:
	peer_user_id = remote_user_id
	_ice_servers = ice_servers


## Start the connection as the initiator (sends CheckRequest).
## Returns OK or ERR_UNAVAILABLE if WebRTC is not available.
func start_as_initiator() -> int:
	if not _webrtc_available():
		push_error("AccelByteP2PPeer: WebRTCPeerConnection not available. "
			+ "Install WebRTC plugin: https://godotengine.org/asset-library/asset/2103")
		return ERR_UNAVAILABLE

	is_initiator = true
	state = P2PState.CHECKING_HOST
	_host_check_start_time = Time.get_ticks_msec()

	_send_check_request()
	return OK


## Start the connection as the receiver (already received a CheckRequest).
## Returns OK or ERR_UNAVAILABLE if WebRTC is not available.
func start_as_receiver() -> int:
	if not _webrtc_available():
		push_error("AccelByteP2PPeer: WebRTCPeerConnection not available. "
			+ "Install WebRTC plugin: https://godotengine.org/asset-library/asset/2103")
		return ERR_UNAVAILABLE

	is_initiator = false
	_send_check_response()
	return OK


## Feed an incoming Base64-encoded signaling message from the lobby.
## Called by AccelByteP2PManager when signaling_p2p_notif fires.
func receive_signaling(base64_message: String) -> void:
	var json_str: String = Marshalls.base64_to_utf8(base64_message)
	var data = JSON.parse_string(json_str)
	if data == null or not data is Dictionary:
		push_warning("AccelByteP2PPeer: Failed to decode signaling from %s" % peer_user_id)
		return

	var msg_type: String = data.get("Type", "")

	match msg_type:
		"CheckRequest":
			_handle_check_request()
		"CheckResponse":
			_handle_check_response(data)
		"Offer":
			_handle_offer(data)
		"Answer":
			_handle_answer(data)
		"Candidate":
			_handle_candidate(data)
		"GatheringDone":
			_handle_gathering_done()
		"Error":
			state = P2PState.FAILED
			disconnected.emit(peer_user_id)
		_:
			push_warning("AccelByteP2PPeer: Unknown signaling type '%s' from %s" % [msg_type, peer_user_id])


## Poll the WebRTC connection and data channel. Called every frame by manager.
func poll() -> void:
	if _rtc_peer:
		_rtc_peer.poll()
		_check_connection_state()

	if _data_channel and _data_channel.get_ready_state() == WebRTCDataChannel.STATE_OPEN:
		while _data_channel.get_available_packet_count() > 0:
			data_received.emit(peer_user_id, _data_channel.get_packet())

	if state == P2PState.CHECKING_HOST:
		var elapsed: int = Time.get_ticks_msec() - _host_check_start_time
		if elapsed > _host_check_timeout_ms:
			state = P2PState.FAILED
			push_warning("AccelByteP2PPeer: Host check timed out for %s" % peer_user_id)
			disconnected.emit(peer_user_id)


## Send raw bytes to this peer over the data channel.
func send_data(data: PackedByteArray) -> int:
	if _data_channel == null or _data_channel.get_ready_state() != WebRTCDataChannel.STATE_OPEN:
		return ERR_UNAVAILABLE
	return _data_channel.put_packet(data)


## True if the data channel is open.
func is_channel_open() -> bool:
	return state == P2PState.CONNECTED


## Close the connection and clean up.
func close() -> void:
	state = P2PState.DISCONNECTED
	if _data_channel:
		_data_channel.close()
		_data_channel = null
	if _rtc_peer:
		_rtc_peer.close()
		_rtc_peer = null


# =============================================================================
# Signaling handlers
# =============================================================================

func _handle_check_request() -> void:
	# Remote is asking if we're ready — respond yes
	_send_check_response()


func _handle_check_response(data: Dictionary) -> void:
	if state != P2PState.CHECKING_HOST:
		return
	if data.get("IsHosting", false):
		print("AccelByteP2PPeer: Peer %s is ready, creating offer" % peer_user_id)
		_create_and_send_offer()
	else:
		state = P2PState.FAILED
		push_warning("AccelByteP2PPeer: Peer %s is not hosting" % peer_user_id)
		disconnected.emit(peer_user_id)


func _handle_offer(data: Dictionary) -> void:
	is_initiator = false
	state = P2PState.CREATING_ANSWER
	print("AccelByteP2PPeer: Received offer from %s" % peer_user_id)

	_create_rtc_peer()

	var sdp: String = data.get("Description", "")
	var err = _rtc_peer.set_remote_description("offer", sdp)
	if err != OK:
		state = P2PState.FAILED
		push_error("AccelByteP2PPeer: set_remote_description(offer) failed: %d" % err)
		disconnected.emit(peer_user_id)
		return
	# Answer is generated automatically via _on_session_description_created
	_flush_pending_candidates()


func _handle_answer(data: Dictionary) -> void:
	if _rtc_peer == null:
		return
	print("AccelByteP2PPeer: Received answer from %s" % peer_user_id)
	var sdp: String = data.get("Description", "")
	var err = _rtc_peer.set_remote_description("answer", sdp)
	if err != OK:
		push_error("AccelByteP2PPeer: set_remote_description(answer) failed: %d" % err)
		return
	_flush_pending_candidates()


func _handle_candidate(data: Dictionary) -> void:
	var sdp: String = data.get("Description", "")
	# Queue candidates that arrive before the remote description is set.
	# On fast networks (or same-machine tests) candidates race the SDP exchange —
	# add_ice_candidate() silently fails with "Got a remote candidate without remote
	# description" if called too early.
	if _rtc_peer == null or state == P2PState.CHECKING_HOST or state == P2PState.CREATING_OFFER:
		_pending_candidates.append(sdp)
		return
	_rtc_peer.add_ice_candidate("", 0, sdp)


func _flush_pending_candidates() -> void:
	for sdp in _pending_candidates:
		_rtc_peer.add_ice_candidate("", 0, sdp)
	_pending_candidates.clear()


func _handle_gathering_done() -> void:
	print("AccelByteP2PPeer: Remote gathering done for %s" % peer_user_id)


# =============================================================================
# Outgoing signaling helpers
# =============================================================================

func _send_check_request() -> void:
	_send_message({"Type": "CheckRequest"})


func _send_check_response() -> void:
	_send_message({"Type": "CheckResponse", "IsHosting": true})


func _create_and_send_offer() -> void:
	state = P2PState.CREATING_OFFER
	_create_rtc_peer()

	_data_channel = _rtc_peer.create_data_channel("data", {
		"negotiated": false,
		"ordered": true,
	})

	_rtc_peer.create_offer()


func _send_message(payload: Dictionary) -> void:
	var json_str: String = JSON.stringify(payload)
	var base64_msg: String = Marshalls.utf8_to_base64(json_str)
	signaling_message_ready.emit(peer_user_id, base64_msg)


# =============================================================================
# WebRTCPeerConnection callbacks
# =============================================================================

func _on_session_description_created(type: String, sdp: String) -> void:
	_rtc_peer.set_local_description(type, sdp)

	var payload: Dictionary = {"Description": sdp}
	if type == "offer":
		payload["Type"] = "Offer"
		state = P2PState.WAITING_ANSWER
	else:
		payload["Type"] = "Answer"
		state = P2PState.CONNECTING

	_send_message(payload)


func _on_ice_candidate_created(mid: String, index: int, sdp: String) -> void:
	if sdp.is_empty():
		_send_message({"Type": "GatheringDone"})
		return
	_send_message({"Type": "Candidate", "Description": sdp})


func _on_data_channel_received(channel: WebRTCDataChannel) -> void:
	# Receiver gets the data channel opened by the initiator
	_data_channel = channel
	_check_connection_state()


# =============================================================================
# Internal
# =============================================================================

func _create_rtc_peer() -> void:
	_rtc_peer = WebRTCPeerConnection.new()

	if _ice_servers.size() == 0:
		push_warning("[AccelByteP2PPeer] No ICE servers configured. P2P will use host-only connection, which may fail behind NAT. For production, configure TURN servers via Turn Manager service.")

	_rtc_peer.initialize({"iceServers": _ice_servers})

	_rtc_peer.session_description_created.connect(_on_session_description_created)
	_rtc_peer.ice_candidate_created.connect(_on_ice_candidate_created)
	_rtc_peer.data_channel_received.connect(_on_data_channel_received)


func _check_connection_state() -> void:
	if _rtc_peer == null:
		return

	match _rtc_peer.get_connection_state():
		WebRTCPeerConnection.STATE_CONNECTED:
			if state != P2PState.CONNECTED:
				state = P2PState.CONNECTED
				print("AccelByteP2PPeer: Connected to %s" % peer_user_id)
				connected.emit(peer_user_id)

		WebRTCPeerConnection.STATE_FAILED:
			if state != P2PState.FAILED:
				state = P2PState.FAILED
				push_warning("AccelByteP2PPeer: Connection failed to %s" % peer_user_id)
				disconnected.emit(peer_user_id)

		WebRTCPeerConnection.STATE_DISCONNECTED, WebRTCPeerConnection.STATE_CLOSED:
			if state == P2PState.CONNECTED:
				state = P2PState.DISCONNECTED
				disconnected.emit(peer_user_id)


func _webrtc_available() -> bool:
	if not ClassDB.class_exists("WebRTCPeerConnection"):
		return false
	# ClassDB.class_exists() returns true even for Godot's built-in stub.
	# The stub's initialize({}) returns ERR_UNCONFIGURED — probe to confirm real plugin.
	var test_peer = ClassDB.instantiate("WebRTCPeerConnection")
	var err: int = test_peer.initialize({})
	test_peer.close()
	return err == OK
