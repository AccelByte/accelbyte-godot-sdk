extends Node
## Example: P2P Connection with AccelByte SDK
##
## This script demonstrates how to:
## 1. Initialize P2P Manager with Turn Manager integration
## 2. Connect to another player via WebRTC
## 3. Send and receive data through P2P connection
##
## Prerequisites:
##   - Device login and lobby connection must be established first
##   - WebRTC plugin must be installed (see requirements below)
##
## WebRTC Plugin Requirement:
##   - Desktop (Windows/Linux/macOS): Install WebRTC plugin from Godot Asset Library
##     Asset Library ID: 2103 (https://godotengine.org/asset-library/asset/2103)
##     GitHub: https://github.com/godotengine/webrtc-native/releases
##   - Web (HTML5): Built-in, no plugin needed
##
## Setup:
##   1. Configure your project.godot with AccelByte credentials
##   2. Install WebRTC plugin for desktop platforms
##   3. Attach this script to any Node in your scene
##   4. Ensure lobby connection is established before using P2P

## Add this to your project.godot:
## [accelbyte]
## base_url="https://your-environment.accelbyte.io"
## namespace="your-namespace"
## client_id="your-client-id"
## client_secret=""

var sdk: AccelByteSDKWrapper
var p2p_manager: AccelByteP2PManager

# P2P connection state
var connected_peers: Array[String] = []

# Signals for game integration
signal p2p_peer_connected(peer_user_id: String)
signal p2p_peer_disconnected(peer_user_id: String)
signal p2p_data_received(peer_user_id: String, data: PackedByteArray)
signal p2p_turn_servers_ready(server_count: int)

func _ready() -> void:
	sdk = AccelByteSDKWrapper.new()
	sdk.initialize(self)

	# Configure SDK from project settings
	var base_url = ProjectSettings.get_setting("accelbyte/base_url", "")
	var namespace_ = ProjectSettings.get_setting("accelbyte/namespace", "")
	var client_id = ProjectSettings.get_setting("accelbyte/client_id", "")
	var client_secret = ProjectSettings.get_setting("accelbyte/client_secret", "")

	sdk.set_base_url(base_url)
	sdk.set_client_credentials(client_id, client_secret)
	sdk.set_namespace(namespace_)

	# Connect lobby signals
	sdk.lobby_connected.connect(_on_lobby_connected)
	sdk.lobby_disconnected.connect(_on_lobby_disconnected)

	# Perform login, lobby connection, and P2P setup
	await _initialize_p2p_flow()

func _initialize_p2p_flow() -> void:
	# Step 1: Login with device
	var iam = sdk.get_service(IamService)
	var device_id = OS.get_unique_id()
	if device_id.is_empty():
		device_id = str(Time.get_unix_time_from_system()).md5_text()

	print("Logging in with device ID: ", device_id)

	var login_result = await iam.platform_token_grant_v4("device", "", "", true, device_id)

	if not login_result.get("success", false):
		print("P2P Setup failed: Login error - ", login_result.get("error", "Unknown error"))
		return

	print("Login successful! User ID: ", sdk.get_user_id())

	# Step 2: Connect to lobby
	print("Connecting to lobby...")
	var lobby_error = sdk.lobby_connect()
	if not lobby_error.is_empty():
		print("P2P Setup failed: Lobby error - ", lobby_error)
		return

func _on_lobby_connected(data: Dictionary) -> void:
	print("Lobby connected! Session ID: ", data.get("sessionId", ""))

	# Step 3: Initialize P2P Manager
	await _setup_p2p_manager()

func _on_lobby_disconnected(data: Dictionary) -> void:
	print("Lobby disconnected: ", data)

	# Clean up P2P manager
	if p2p_manager:
		p2p_manager.cleanup()
		p2p_manager = null
	connected_peers.clear()

func _setup_p2p_manager() -> void:
	"""Initialize P2P Manager with Turn Manager integration"""
	print("Setting up P2P Manager...")

	# Create P2P Manager
	p2p_manager = AccelByteP2PManager.new()

	# Connect P2P signals
	p2p_manager.peer_connected.connect(_on_p2p_peer_connected)
	p2p_manager.peer_disconnected.connect(_on_p2p_peer_disconnected)
	p2p_manager.data_received.connect(_on_p2p_data_received)
	p2p_manager.ice_servers_configured.connect(_on_ice_servers_configured)

	# Initialize with SDK, lobby WebSocket, and scene tree
	var lobby_ws = sdk.get_service(LobbyWsService)
	p2p_manager.initialize(sdk, lobby_ws, get_tree().get_root())

	print("P2P Manager initialized. Waiting for TURN server configuration...")

func _on_ice_servers_configured(server_count: int) -> void:
	"""Called when Turn Manager has configured ICE servers"""
	print("TURN/STUN servers configured: ", server_count)
	print("P2P Manager ready for connections!")

	p2p_turn_servers_ready.emit(server_count)

	# Example: Connect to a peer (uncomment and set real user ID)
	# await connect_to_peer("target-user-id-here")

func _on_p2p_peer_connected(peer_user_id: String) -> void:
	"""Called when P2P connection is established"""
	print("P2P connection established with: ", peer_user_id)

	if peer_user_id not in connected_peers:
		connected_peers.append(peer_user_id)

	p2p_peer_connected.emit(peer_user_id)

	# Send welcome message
	send_message_to_peer(peer_user_id, {
		"type": "welcome",
		"message": "Hello from " + sdk.get_user_id(),
		"timestamp": Time.get_unix_time_from_system()
	})

func _on_p2p_peer_disconnected(peer_user_id: String) -> void:
	"""Called when P2P connection is lost"""
	print("P2P connection lost with: ", peer_user_id)

	connected_peers.erase(peer_user_id)
	p2p_peer_disconnected.emit(peer_user_id)

func _on_p2p_data_received(peer_user_id: String, data: PackedByteArray) -> void:
	"""Called when data is received from a peer"""
	var text = data.get_string_from_utf8()
	print("Received P2P data from ", peer_user_id, ": ", text)

	# Try to parse as JSON
	var parsed = JSON.parse_string(text)
	if parsed is Dictionary:
		_handle_game_message(peer_user_id, parsed)

	p2p_data_received.emit(peer_user_id, data)

func _handle_game_message(peer_user_id: String, message: Dictionary) -> void:
	"""Handle structured game messages"""
	var msg_type = message.get("type", "")

	match msg_type:
		"welcome":
			print("Received welcome from ", peer_user_id, ": ", message.get("message", ""))
		"game_action":
			print("Game action from ", peer_user_id, ": ", message.get("action", ""))
		"chat":
			print("[CHAT] ", peer_user_id, ": ", message.get("text", ""))
		_:
			print("Unknown message type: ", msg_type)

# Public API for game integration

func connect_to_peer(target_user_id: String) -> bool:
	"""Initiate P2P connection to another user"""
	if not p2p_manager:
		push_error("P2P Manager not initialized")
		return false

	if target_user_id.is_empty():
		push_error("Target user ID cannot be empty")
		return false

	if target_user_id == sdk.get_user_id():
		push_error("Cannot connect to yourself")
		return false

	print("Initiating P2P connection to: ", target_user_id)
	var result = p2p_manager.connect_to_peer(target_user_id)
	return result == OK

func send_message_to_peer(peer_user_id: String, message: Dictionary) -> bool:
	"""Send structured message to a specific peer"""
	if not p2p_manager:
		return false

	var json_str = JSON.stringify(message)
	var result = p2p_manager.send_string_to_peer(peer_user_id, json_str)
	return result == OK

func send_game_action(action: String, data: Dictionary = {}) -> int:
	"""Send game action to all connected peers"""
	var message = data.duplicate()
	message["type"] = "game_action"
	message["action"] = action
	message["sender"] = sdk.get_user_id()
	message["timestamp"] = Time.get_unix_time_from_system()

	var json_str = JSON.stringify(message)
	return broadcast_to_all_peers(json_str)

func send_chat_message(text: String) -> int:
	"""Send chat message to all connected peers"""
	var message = {
		"type": "chat",
		"text": text,
		"sender": sdk.get_user_id(),
		"timestamp": Time.get_unix_time_from_system()
	}

	var json_str = JSON.stringify(message)
	return broadcast_to_all_peers(json_str)

func broadcast_to_all_peers(text: String) -> int:
	"""Broadcast text message to all connected peers"""
	if not p2p_manager:
		return 0
	return p2p_manager.broadcast_string(text)

func disconnect_from_peer(peer_user_id: String) -> void:
	"""Disconnect from a specific peer"""
	if p2p_manager:
		p2p_manager.disconnect_peer(peer_user_id)

func get_connected_peer_ids() -> Array[String]:
	"""Get list of connected peer user IDs"""
	return connected_peers.duplicate()

func is_p2p_ready() -> bool:
	"""Check if P2P system is ready for connections"""
	return p2p_manager != null and sdk.is_lobby_connected()

func cleanup() -> void:
	"""Clean up P2P connections"""
	if p2p_manager:
		p2p_manager.cleanup()
		p2p_manager = null
	connected_peers.clear()

# Optional: Auto-cleanup on exit
func _exit_tree() -> void:
	cleanup()