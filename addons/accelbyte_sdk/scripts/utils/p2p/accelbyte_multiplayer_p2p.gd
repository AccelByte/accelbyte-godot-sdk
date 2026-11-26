## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_multiplayer_p2p.gd
## AccelByte P2P for Godot's high-level multiplayer (rpc, MultiplayerSpawner, ...)
## =============================================================================
##
## Gives a host and its clients a real Godot MultiplayerPeer, so rpc(), rpc_id(),
## MultiplayerSpawner, MultiplayerSynchronizer and multiplayer authority work as in any Godot
## game. The transport is Godot's own WebRTCMultiplayerPeer; this class only supplies what
## AccelByte adds: signaling through the Lobby, TURN/STUN ice servers, and the mapping from
## AccelByte user ids to Godot peer ids.
##
## Usage (host):
##   var p2p := AccelByteMultiplayerP2P.new()
##   p2p.initialize(AccelByteP2PLobbySignaling.new(lobby_ws), self, my_user_id)
##   p2p.ice_servers = [...]                       # from the Turn Manager service
##   multiplayer.multiplayer_peer = p2p.host()     # host is peer id 1
## Usage (client):
##   multiplayer.multiplayer_peer = p2p.join(host_user_id)
##   p2p.connection_failed.connect(_on_failed)     # multiplayer.connected_to_server on success
##
## Topology: one host (peer id 1) and clients (ids 2 and up). With Godot's default server
## relay, clients can also address each other through the host.
##
## Signaling messages use the same JSON + Base64 format as AccelByteP2PManager (Type:
## CheckRequest, CheckResponse, Offer, Answer, Candidate, GatheringDone). Two optional fields
## are added: CheckRequest.PeerId (the id the client asks for) and CheckResponse.Accepted /
## Reason (the host's verdict).
##
## Requirements: on desktop install the Godot WebRTC plugin
## (https://godotengine.org/asset-library/asset/2103); on web WebRTC is built in.
## =============================================================================

class_name AccelByteMultiplayerP2P
extends RefCounted

## Emitted when a peer is connected. `user_id` is empty for peers this node cannot map, such as
## other clients seen from a client.
signal peer_user_connected(peer_id: int, user_id: String)

## Emitted when a peer is gone.
signal peer_user_disconnected(peer_id: int, user_id: String)

## Emitted on a client when the connection to the host could not be established.
signal connection_failed(host_user_id: String, reason: String)

## Emitted when configure_ice_servers() has finished; `server_count` is 0 when none could be set up.
signal ice_servers_configured(server_count: int)

const MAX_PEER_ID := 2147483647

## ICE servers (STUN/TURN) for NAT traversal, in WebRTCPeerConnection.initialize() format.
var ice_servers: Array = []

## Seconds a client waits for the host's CheckResponse before giving up.
var host_check_timeout_sec: float = 30.0
## While a join waits for the host's answer, the request is sent again after this many seconds, so a player who joins before the
## host is listening (the host can start a moment later than the players) still connects.
var check_resend_interval_sec: float = 2.0

var _signaling
var _scene_root: Node
var _local_user_id: String = ""
var _is_host: bool = false
var _peer: WebRTCMultiplayerPeer
var _host_user_id: String = ""

## Host side: {user_id: {"peer_id": int, "conn": WebRTCPeerConnection, "pending": Array, "remote_set": bool}}
var _sessions: Dictionary = {}
## {peer_id: user_id}, filled by the host when it accepts a client
var _user_by_peer: Dictionary = {}

## Client side
var _client_state: String = "idle"  # idle, checking, negotiating, connected, failed
var _client_conn: WebRTCPeerConnection
var _client_pending: Array = []
var _client_remote_set: bool = false
var _check_started_ms: int = 0
var _check_sent_ms: int = 0
var _check_peer_id: int = 0

# =============================================================================
# Setup
# =============================================================================


## `signaling` provides `signal signaling_received(sender_user_id, base64_message)` and
## `send_signaling(destination_user_id, base64_message)`; use AccelByteP2PLobbySignaling.
## `scene_root` is any node in the scene tree (its tree provides the frame tick).
func initialize(signaling, scene_root: Node, local_user_id: String) -> void:
	_signaling = signaling
	_scene_root = scene_root
	_local_user_id = local_user_id
	_signaling.signaling_received.connect(_on_signaling)
	scene_root.get_tree().process_frame.connect(_tick)


## Fetch the TURN servers and their credentials from the AccelByte Turn Manager and fill
## `ice_servers`. `sdk` is the logged-in AccelByteSDK (anything with get_service()). Await it, or wait
## for ice_servers_configured, before host() / join(); without ice servers a connection works only
## on the same network. Returns the number of servers configured.
func configure_ice_servers(sdk) -> int:
	ice_servers.clear()
	var service_class = AccelByteClassUtils.get_custom_class_by_name("TurnManagerService")
	if service_class == null:
		push_warning("[AccelByteMultiplayerP2P] TurnManagerService is not part of this SDK build")
		ice_servers_configured.emit(0)
		return 0
	var turn = sdk.get_service(service_class)
	var listed: Dictionary = await turn.list_server()
	if not listed.get("success", false):
		push_warning(
			(
				"[AccelByteMultiplayerP2P] Turn Manager list failed: %s"
				% listed.get("error", "unknown error")
			)
		)
		ice_servers_configured.emit(0)
		return 0
	for server in listed.get("data", {}).get("servers", []):
		if not (server is Dictionary) or str(server.get("ip", "")).is_empty():
			continue
		var ip: String = server["ip"]
		var port := str(int(server.get("port", 3478)))
		var credentials: Dictionary = await turn.generate_username_password(
			ip, port, str(server.get("region", ""))
		)
		if not credentials.get("success", false):
			continue
		var data: Dictionary = credentials.get("data", {})
		var entry := {"urls": ["turn:%s:%s" % [ip, port], "stun:%s:%s" % [ip, port]]}
		if not str(data.get("username", "")).is_empty():
			entry["username"] = data["username"]
		if not str(data.get("password", "")).is_empty():
			entry["credential"] = data["password"]
		ice_servers.append(entry)
	ice_servers_configured.emit(ice_servers.size())
	return ice_servers.size()


## Stop everything and release the peer.
func close() -> void:
	if (
		_scene_root
		and _scene_root.get_tree()
		and _scene_root.get_tree().process_frame.is_connected(_tick)
	):
		_scene_root.get_tree().process_frame.disconnect(_tick)
	if _signaling and _signaling.signaling_received.is_connected(_on_signaling):
		_signaling.signaling_received.disconnect(_on_signaling)
	if _peer:
		_peer.close()
		_peer = null
	_sessions.clear()
	_user_by_peer.clear()
	_client_conn = null
	_client_state = "idle"


# =============================================================================
# Public API
# =============================================================================


## Start hosting. Returns the MultiplayerPeer to assign to `multiplayer.multiplayer_peer`
## (the host is peer id 1), or null when WebRTC is not available.
func host() -> WebRTCMultiplayerPeer:
	if not _webrtc_available():
		return null
	_is_host = true
	_peer = WebRTCMultiplayerPeer.new()
	_peer.create_server()
	_user_by_peer[1] = _local_user_id
	_connect_peer_signals()
	return _peer


## Join a host. Returns the MultiplayerPeer to assign to `multiplayer.multiplayer_peer` at once;
## `multiplayer.connected_to_server` fires when the connection is up and `connection_failed` here
## when it cannot be made. `peer_id` is the id to ask the host for (2 to 2147483647); 0 picks a
## random one. The host refuses an id that is already taken.
func join(host_user_id: String, peer_id: int = 0) -> WebRTCMultiplayerPeer:
	if host_user_id.is_empty() or not _webrtc_available():
		return null
	var wanted := peer_id if peer_id != 0 else randi_range(2, MAX_PEER_ID)
	if wanted < 2 or wanted > MAX_PEER_ID:
		push_error("[AccelByteMultiplayerP2P] peer_id must be between 2 and %d" % MAX_PEER_ID)
		return null

	_is_host = false
	_host_user_id = host_user_id
	_peer = WebRTCMultiplayerPeer.new()
	_peer.create_client(wanted)
	_user_by_peer[1] = host_user_id
	_connect_peer_signals()

	_client_state = "checking"
	_check_started_ms = Time.get_ticks_msec()
	_check_sent_ms = _check_started_ms
	_check_peer_id = wanted
	_send(host_user_id, {"Type": "CheckRequest", "PeerId": wanted})
	return _peer


## AccelByte user id of a peer, or an empty string when unknown.
func get_user_id(peer_id: int) -> String:
	return _user_by_peer.get(peer_id, "")


## Peer id of an AccelByte user, or 0 when unknown.
func get_peer_id(user_id: String) -> int:
	for peer_id in _user_by_peer:
		if _user_by_peer[peer_id] == user_id:
			return peer_id
	return 0


# =============================================================================
# Signaling
# =============================================================================


func _on_signaling(sender_id: String, base64_message: String) -> void:
	var data = JSON.parse_string(Marshalls.base64_to_utf8(base64_message))
	if not (data is Dictionary):
		return
	var type: String = data.get("Type", "")
	if _is_host:
		_host_handle(sender_id, type, data)
	elif sender_id == _host_user_id:
		_client_handle(type, data)


func _send(destination_user_id: String, payload: Dictionary) -> void:
	_signaling.send_signaling(
		destination_user_id, Marshalls.utf8_to_base64(JSON.stringify(payload))
	)


func _host_handle(sender_id: String, type: String, data: Dictionary) -> void:
	match type:
		"CheckRequest":
			var peer_id := int(data.get("PeerId", 0))
			var owner: String = _user_by_peer.get(peer_id, sender_id)
			if peer_id < 2 or peer_id > MAX_PEER_ID or owner != sender_id:
				_send(
					sender_id,
					{
						"Type": "CheckResponse",
						"IsHosting": true,
						"Accepted": false,
						"Reason": "peer id invalid or already in use"
					}
				)
				return
			# A repeated request (the player resends until it gets an answer) must not reset a negotiation in progress.
			if not _sessions.has(sender_id) or int(_sessions[sender_id]["peer_id"]) != peer_id:
				_sessions[sender_id] = {
					"peer_id": peer_id, "conn": null, "pending": [], "remote_set": false
				}
			_user_by_peer[peer_id] = sender_id
			_send(sender_id, {"Type": "CheckResponse", "IsHosting": true, "Accepted": true})
		"Offer":
			if _sessions.has(sender_id):
				_host_accept_offer(sender_id, str(data.get("Description", "")))
		"Candidate":
			if _sessions.has(sender_id):
				var session: Dictionary = _sessions[sender_id]
				if session["remote_set"]:
					session["conn"].add_ice_candidate("", 0, str(data.get("Description", "")))
				else:
					session["pending"].append(str(data.get("Description", "")))


func _host_accept_offer(sender_id: String, sdp: String) -> void:
	var session: Dictionary = _sessions[sender_id]
	var conn := _new_connection(sender_id)
	session["conn"] = conn
	var err := _peer.add_peer(conn, session["peer_id"])
	if err != OK:
		push_error("[AccelByteMultiplayerP2P] add_peer failed: %d" % err)
		return
	err = conn.set_remote_description("offer", sdp)
	if err != OK:
		push_error("[AccelByteMultiplayerP2P] set_remote_description(offer) failed: %d" % err)
		return
	session["remote_set"] = true
	for candidate in session["pending"]:
		conn.add_ice_candidate("", 0, candidate)
	session["pending"].clear()
	# The answer is created by the connection and sent from _on_description_created().


func _client_handle(type: String, data: Dictionary) -> void:
	match type:
		"CheckResponse":
			if _client_state != "checking":
				return
			if not data.get("IsHosting", false) or not data.get("Accepted", true):
				_client_fail(str(data.get("Reason", "host is not accepting this connection")))
				return
			_client_state = "negotiating"
			_client_conn = _new_connection(_host_user_id)
			var err := _peer.add_peer(_client_conn, 1)
			if err != OK:
				_client_fail("add_peer failed: %d" % err)
				return
			_client_conn.create_offer()
		"Answer":
			if _client_conn == null:
				return
			var err := _client_conn.set_remote_description(
				"answer", str(data.get("Description", ""))
			)
			if err != OK:
				_client_fail("set_remote_description(answer) failed: %d" % err)
				return
			_client_remote_set = true
			for candidate in _client_pending:
				_client_conn.add_ice_candidate("", 0, candidate)
			_client_pending.clear()
		"Candidate":
			if _client_remote_set:
				_client_conn.add_ice_candidate("", 0, str(data.get("Description", "")))
			else:
				_client_pending.append(str(data.get("Description", "")))


## A new, unconfigured connection (STATE_NEW, as WebRTCMultiplayerPeer.add_peer() requires)
## that reports its description and ICE candidates to `remote_user_id` through signaling.
func _new_connection(remote_user_id: String) -> WebRTCPeerConnection:
	var conn := WebRTCPeerConnection.new()
	conn.initialize({"iceServers": ice_servers})
	conn.session_description_created.connect(
		func(type: String, sdp: String):
			conn.set_local_description(type, sdp)
			_send(
				remote_user_id,
				{"Type": "Offer" if type == "offer" else "Answer", "Description": sdp}
			)
	)
	conn.ice_candidate_created.connect(
		func(_media: String, _index: int, candidate: String):
			if candidate.is_empty():
				_send(remote_user_id, {"Type": "GatheringDone"})
			else:
				_send(remote_user_id, {"Type": "Candidate", "Description": candidate})
	)
	return conn


# =============================================================================
# Peer events and timeouts
# =============================================================================


func _connect_peer_signals() -> void:
	_peer.peer_connected.connect(_on_peer_connected)
	_peer.peer_disconnected.connect(_on_peer_disconnected)


func _on_peer_connected(peer_id: int) -> void:
	if not _is_host and peer_id == 1:
		_client_state = "connected"
	peer_user_connected.emit(peer_id, _user_by_peer.get(peer_id, ""))


func _on_peer_disconnected(peer_id: int) -> void:
	var user_id: String = _user_by_peer.get(peer_id, "")
	peer_user_disconnected.emit(peer_id, user_id)
	if _is_host and peer_id != 1:
		_sessions.erase(user_id)
		_user_by_peer.erase(peer_id)


func _tick() -> void:
	if (
		_is_host
		or _client_state == "idle"
		or _client_state == "connected"
		or _client_state == "failed"
	):
		return
	if _client_state == "checking":
		var now := Time.get_ticks_msec()
		if now - _check_started_ms > int(host_check_timeout_sec * 1000.0):
			_client_fail("host did not answer")
		elif now - _check_sent_ms >= int(check_resend_interval_sec * 1000.0):
			_check_sent_ms = now
			_send(_host_user_id, {"Type": "CheckRequest", "PeerId": _check_peer_id})
	elif _client_conn and _client_conn.get_connection_state() == WebRTCPeerConnection.STATE_FAILED:
		_client_fail("WebRTC connection failed")


func _client_fail(reason: String) -> void:
	if _client_state == "failed":
		return
	_client_state = "failed"
	push_warning("[AccelByteMultiplayerP2P] join failed: %s" % reason)
	connection_failed.emit(_host_user_id, reason)


func _webrtc_available() -> bool:
	if (
		not ClassDB.can_instantiate("WebRTCMultiplayerPeer")
		or not ClassDB.class_exists("WebRTCPeerConnection")
	):
		push_error(
			"[AccelByteMultiplayerP2P] WebRTC is not available. Install https://godotengine.org/asset-library/asset/2103"
		)
		return false
	# The built-in stub reports success for class_exists(); initialize() fails without the plugin.
	var probe = ClassDB.instantiate("WebRTCPeerConnection")
	var err: int = probe.initialize({})
	probe.close()
	if err != OK:
		push_error(
			(
				"[AccelByteMultiplayerP2P] WebRTC plugin is not configured (initialize returned %d)"
				% err
			)
		)
		return false
	return true
