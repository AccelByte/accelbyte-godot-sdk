## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_p2p_manager.gd
## AccelByte P2P — multi-peer connection manager
## =============================================================================
##
## Manages all AccelByteP2PPeer instances for a session.
## Connects to AccelByte Lobby signaling (signalingP2PNotif) to exchange
## WebRTC offer/answer/ICE, then hands data transfer off to RTCDataChannel.
##
## Wire format (matches project-a / Unity SDK):
##   SEND: lobby WS type "signalingP2PNotif", fields {destinationId, message}
##         where message = Marshalls.utf8_to_base64(JSON.stringify(payload))
##   RECV: LobbyWsService.signaling_p2p_notif(destination_id, message)
##         where destination_id = SENDER's user ID (server flips it on delivery)
##
## Usage:
##   var p2p = AccelByteP2PManager.new()
##   p2p.initialize(sdk, lobby_ws_service, scene_root)
##   p2p.peer_connected.connect(_on_peer_connected)
##   p2p.data_received.connect(_on_data_received)
##   p2p.ice_servers_configured.connect(_on_ice_servers_ready)  # Wait for auto-configuration
##   # Then call connect_to_peer() after ice_servers_configured signal fires
##   p2p.connect_to_peer("target-user-id")
##
## Requirements:
##   On desktop (Windows/Linux/macOS): install the Godot WebRTC plugin.
##   On web (HTML5): built-in, no plugin needed.
##   Asset Library: https://godotengine.org/asset-library/asset/2103
## =============================================================================

class_name AccelByteP2PManager
extends RefCounted

# =============================================================================
# Signals
# =============================================================================

## Emitted when a data channel with a peer is fully open.
signal peer_connected(peer_user_id: String)

## Emitted when a peer disconnects or the connection fails.
signal peer_disconnected(peer_user_id: String)

## Emitted when data is received from a peer.
signal data_received(peer_user_id: String, data: PackedByteArray)

## Emitted when ICE servers are successfully configured from Turn Manager.
signal ice_servers_configured(server_count: int)

# =============================================================================
# Configuration
# =============================================================================

## ICE servers for NAT traversal. MUST be configured before connect_to_peer().
## For production deployments, use AccelByte TURN/STUN endpoints or your own infrastructure.
## Example: [{"urls": ["stun:your-stun-server.com:3478"]}, {"urls": ["turn:your-turn-server.com:3478"], "username": "user", "credential": "pass"}]
var ice_servers: Array = []

# =============================================================================
# Internal State
# =============================================================================

const _PollNodeScene = preload("res://addons/accelbyte_sdk/scripts/utils/accelbyte_poll_node.gd")
const _PeerScene = preload("res://addons/accelbyte_sdk/scripts/utils/p2p/accelbyte_p2p_peer.gd")

var _sdk: RefCounted = null       # AccelByteSDKWrapper
var _lobby: RefCounted = null     # LobbyWsService
var _scene_root: Node = null
var _poll_node: Node = null

## {peer_user_id: String -> AccelByteP2PPeer}
var _peers: Dictionary = {}

# =============================================================================
# Initialization
# =============================================================================

## Set up the manager.
##
## IMPORTANT: Auto-configures TURN servers from AccelByte Turn Manager if ice_servers is empty.
## Await ice_servers_configured signal before calling connect_to_peer() to ensure NAT traversal works.
##
## sdk: AccelByteSDKWrapper instance (used to get local user ID)
## lobby_ws: LobbyWsService (must already be connected to lobby)
## scene_root: any Node in the scene tree (used for the poll node)
func initialize(sdk: RefCounted, lobby_ws: RefCounted, scene_root: Node) -> void:
	_sdk = sdk
	_lobby = lobby_ws
	_scene_root = scene_root

	# Guard: verify the native WebRTC plugin is actually loaded, not just the stub.
	# ClassDB.class_exists() returns true even for the built-in stub that ships with
	# Godot — the stub's initialize() returns ERR_UNCONFIGURED with
	# "No default WebRTC extension configured" printed to the debugger.
	# We must probe with initialize() to confirm a real plugin is present.
	if not ClassDB.class_exists("WebRTCPeerConnection"):
		_push_webrtc_missing_error()
		return
	var _test_rtc: WebRTCPeerConnection = WebRTCPeerConnection.new()
	var _test_err: int = _test_rtc.initialize({})
	_test_rtc.close()
	if _test_err != OK:
		_push_webrtc_missing_error()
		return

	# Auto-configure ICE servers from Turn Manager if none are configured
	if ice_servers.size() == 0:
		_auto_configure_ice_servers()

	if _lobby and _lobby.has_signal("signaling_p2p_notif"):
		_lobby.signaling_p2p_notif.connect(_on_signaling_received)
	else:
		push_error("AccelByteP2PManager: lobby_ws does not have signaling_p2p_notif. "
			+ "Make sure LobbyWsService is connected.")

	_attach_poll_node()


## Tear down all connections and remove the poll node.
func cleanup() -> void:
	for uid in _peers.keys():
		_peers[uid].close()
	_peers.clear()

	if _lobby and _lobby.has_signal("signaling_p2p_notif"):
		if _lobby.signaling_p2p_notif.is_connected(_on_signaling_received):
			_lobby.signaling_p2p_notif.disconnect(_on_signaling_received)

	_detach_poll_node()


# =============================================================================
# Public API
# =============================================================================

## Initiate a P2P connection to a remote peer (sends CheckRequest).
## Returns OK, ERR_ALREADY_EXISTS, or ERR_UNAVAILABLE.
func connect_to_peer(remote_user_id: String) -> int:
	if remote_user_id.is_empty():
		push_error("AccelByteP2PManager: remote_user_id cannot be empty")
		return ERR_INVALID_PARAMETER

	if _peers.has(remote_user_id):
		push_warning("AccelByteP2PManager: Already connecting/connected to %s" % remote_user_id)
		return ERR_ALREADY_EXISTS

	# Guard against empty ICE servers when auto-configuration is enabled
	if ice_servers.is_empty():
		push_error("AccelByteP2PManager: No ICE servers configured. If using auto-configuration, await ice_servers_configured signal before calling connect_to_peer()")
		return ERR_UNCONFIGURED

	var peer: AccelByteP2PPeer = _create_peer(remote_user_id)
	return peer.start_as_initiator()


## Send raw bytes to a specific peer.
func send_to_peer(peer_user_id: String, data: PackedByteArray) -> int:
	if not _peers.has(peer_user_id):
		return ERR_DOES_NOT_EXIST
	return _peers[peer_user_id].send_data(data)


## Send a UTF-8 string to a specific peer.
func send_string_to_peer(peer_user_id: String, text: String) -> int:
	return send_to_peer(peer_user_id, text.to_utf8_buffer())


## Broadcast raw bytes to all connected peers. Returns count of peers reached.
func broadcast(data: PackedByteArray) -> int:
	var sent: int = 0
	for uid in _peers.keys():
		if _peers[uid].send_data(data) == OK:
			sent += 1
	return sent


## Broadcast a string to all connected peers.
func broadcast_string(text: String) -> int:
	return broadcast(text.to_utf8_buffer())


## Returns user IDs for all peers with open data channels.
func get_connected_peers() -> Array[String]:
	var result: Array[String] = []
	for uid in _peers.keys():
		if _peers[uid].is_channel_open():
			result.append(uid)
	return result


## Disconnect from a specific peer.
func disconnect_peer(peer_user_id: String) -> void:
	if _peers.has(peer_user_id):
		_peers[peer_user_id].close()
		_peers.erase(peer_user_id)


# =============================================================================
# Internal — incoming lobby signaling
# =============================================================================

## Called when LobbyWsService emits signaling_p2p_notif.
##
## IMPORTANT: The lobby server flips destinationId on delivery.
## When we receive this signal:
##   destination_id = the SENDER's user ID  (not ours)
##   message        = Base64-encoded JSON signaling payload
func _on_signaling_received(destination_id: String, message: String) -> void:
	var sender_id: String = destination_id  # Server gives us the sender's ID here

	if sender_id.is_empty():
		push_warning("AccelByteP2PManager: Received signaling with empty sender ID")
		return

	# Peek at message type to decide whether to create a new peer
	if not _peers.has(sender_id):
		var json_str: String = Marshalls.base64_to_utf8(message)
		var data = JSON.parse_string(json_str)
		if data == null or not data is Dictionary:
			return

		var msg_type: String = data.get("Type", "")
		if msg_type == "CheckRequest":
			# Remote is initiating — create peer as receiver
			var peer: AccelByteP2PPeer = _create_peer(sender_id)
			peer.start_as_receiver()
			# The peer sent its CheckResponse, now wait for the Offer
			return
		else:
			push_warning("AccelByteP2PManager: Ignoring '%s' from unknown peer %s" % [msg_type, sender_id])
			return

	_peers[sender_id].receive_signaling(message)


# =============================================================================
# Internal — outgoing lobby signaling
# =============================================================================

## Called by AccelByteP2PPeer.signaling_message_ready.
## Sends the Base64 message to the lobby WS as "signalingP2PNotif".
func _on_signaling_message_ready(destination_user_id: String, base64_message: String) -> void:
	if _lobby == null:
		return

	if not _lobby.has_method("get_ws_transport"):
		push_error("AccelByteP2PManager: LobbyWsService missing get_ws_transport()")
		return

	var ws = _lobby.get_ws_transport()
	if ws == null or not ws.has_method("send_request"):
		push_error("AccelByteP2PManager: WS transport missing send_request()")
		return

	ws.send_request("signalingP2PNotif", {
		"destinationId": destination_user_id,
		"message": base64_message,
	})


# =============================================================================
# Internal — peer lifecycle
# =============================================================================

func _create_peer(remote_user_id: String) -> AccelByteP2PPeer:
	var peer: AccelByteP2PPeer = _PeerScene.new()
	peer.initialize(remote_user_id, ice_servers)

	peer.connected.connect(_on_peer_connected)
	peer.disconnected.connect(_on_peer_disconnected)
	peer.data_received.connect(_on_peer_data_received)
	peer.signaling_message_ready.connect(_on_signaling_message_ready)

	_peers[remote_user_id] = peer
	return peer


func _on_peer_connected(peer_user_id: String) -> void:
	peer_connected.emit(peer_user_id)


func _on_peer_disconnected(peer_user_id: String) -> void:
	peer_disconnected.emit(peer_user_id)
	_peers.erase(peer_user_id)


func _on_peer_data_received(peer_user_id: String, data: PackedByteArray) -> void:
	data_received.emit(peer_user_id, data)


# =============================================================================
# Internal — poll node
# =============================================================================

func _poll() -> void:
	for uid in _peers.keys():
		_peers[uid].poll()


func _attach_poll_node() -> void:
	if _poll_node or not _scene_root:
		return
	_poll_node = _PollNodeScene.new()
	_poll_node.name = "_ABP2PPoll"
	_poll_node._callback = Callable(self, "_poll")
	_scene_root.add_child(_poll_node)


func _detach_poll_node() -> void:
	if _poll_node:
		_poll_node._callback = Callable()
		if _poll_node.is_inside_tree():
			_poll_node.queue_free()
		_poll_node = null


func _push_webrtc_missing_error() -> void:
	push_error(
		"AccelByteP2PManager: WebRTC native plugin is not loaded.\n"
		+ "  ClassDB may report WebRTCPeerConnection as present (built-in stub),\n"
		+ "  but the stub returns ERR_UNCONFIGURED on initialize().\n"
		+ "  Install the real plugin:\n"
		+ "    Godot Asset Library: https://godotengine.org/asset-library/asset/2103\n"
		+ "    GitHub releases:     https://github.com/godotengine/webrtc-native/releases\n"
		+ "  On Web/HTML5, WebRTC is built-in — no plugin needed."
	)


## Automatically configure ICE servers from Turn Manager service.
## This follows the Unity SDK pattern: GetTurnServers() -> configure ICE servers.
func _auto_configure_ice_servers() -> void:
	if not _sdk or not _sdk.has_method("get_token_store"):
		push_warning("[AccelByteP2PManager] SDK does not support get_token_store()")
		ice_servers_configured.emit(0)
		return

	if not _sdk.is_logged_in() or _sdk.get_token_store().is_expired():
		push_warning("[AccelByteP2PManager] Cannot auto-configure ICE servers: not logged in or token expired")
		ice_servers_configured.emit(0)
		return

	print("[AccelByteP2PManager] Auto-configuring ICE servers from Turn Manager...")

	# Check if TurnManagerService is available (requires full module SDK)
	if not AccelByteClassUtils.custom_class_exists("TurnManagerService"):
		push_error("[AccelByteP2PManager] TurnManagerService not found — auto ICE configuration requires the full AccelByte Godot SDK module (PACKAGE_TYPE=module)")
		ice_servers_configured.emit(0)
		return

	# Get Turn Manager service using dynamic class resolution to avoid parse-time dependency
	var turn_service_class = AccelByteClassUtils.get_custom_class_by_name("TurnManagerService")
	if not turn_service_class:
		push_warning("[AccelByteP2PManager] Failed to resolve TurnManagerService class")
		ice_servers_configured.emit(0)
		return

	var turn_service = _sdk.get_service(turn_service_class)
	if not turn_service:
		push_warning("[AccelByteP2PManager] Turn Manager service not available")
		ice_servers_configured.emit(0)
		return

	# Get TURN server list from Turn Manager
	var result = await turn_service.list_server()
	if result.get("success", false):
		var data = result.get("data", {})
		var servers = data.get("servers", [])
		await _process_turn_servers(turn_service, servers)
	else:
		push_warning("[AccelByteP2PManager] Failed to get TURN servers from Turn Manager: %s" % result.get("error", "unknown error"))
		ice_servers_configured.emit(0)


## Process TURN server list and configure ICE servers with credentials.
## This matches Unity SDK behavior: get server list, then get credentials for each.
func _process_turn_servers(turn_service, servers: Array) -> void:
	if servers.is_empty():
		push_warning("[AccelByteP2PManager] No TURN servers available from Turn Manager")
		ice_servers_configured.emit(0)
		return

	# Clear any existing configuration
	ice_servers.clear()

	# Process each server and get credentials
	for server in servers:
		if not server is Dictionary:
			continue

		var ip = server.get("ip", "")
		var port = str(int(server.get("port", 3478)))  # Ensure integer conversion to avoid .0 suffix
		var region = server.get("region", "")

		if ip.is_empty():
			continue

		print("[AccelByteP2PManager] Getting credentials for TURN server %s:%s in %s" % [ip, port, region])

		# Get credentials for this TURN server
		var cred_result = await turn_service.generate_username_password(ip, port, region)
		if cred_result.get("success", false):
			var cred_data = cred_result.get("data", {})
			var username = cred_data.get("username", "")
			var password = cred_data.get("password", "")

			# Configure ICE server with credentials
			var ice_server = {
				"urls": [
					"turn:" + ip + ":" + port,
					"stun:" + ip + ":" + port  # Also add STUN variant
				]
			}

			if not username.is_empty():
				ice_server["username"] = username
			if not password.is_empty():
				ice_server["credential"] = password

			ice_servers.append(ice_server)
			# Only log credentials if HTTP logging is enabled in settings
			if _sdk.is_http_logging_enabled():
				print("[AccelByteP2PManager] Configured ICE server: %s with username: %s" % [ice_server["urls"][0], username])
			else:
				print("[AccelByteP2PManager] Configured ICE server: %s" % ice_server["urls"][0])
		else:
			push_warning("[AccelByteP2PManager] Failed to get credentials for TURN server %s:%s: %s" % [ip, port, cred_result.get("error", "unknown")])

	if ice_servers.size() > 0:
		print("[AccelByteP2PManager] Successfully configured %d ICE servers from Turn Manager" % ice_servers.size())
		ice_servers_configured.emit(ice_servers.size())
	else:
		push_warning("[AccelByteP2PManager] No valid TURN servers could be configured with credentials")
		ice_servers_configured.emit(0)
