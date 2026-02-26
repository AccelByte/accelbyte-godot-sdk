extends Node
## Example: Lobby Connection and Friend Request with AccelByte SDK
##
## This script demonstrates how to:
## 1. Connect to AccelByte Lobby service (WebSocket)
## 2. Send a friend request to another user
## 3. Listen for friend-related notifications
##
## Prerequisites:
##   - Device login must be completed first (see device_login_example.gd)
##   - Lobby URL is auto-derived from base_url (wss://your-env.accelbyte.io/lobby/)
##
## Setup:
##   1. Configure your project.godot with AccelByte credentials
##   2. Attach this script to any Node in your scene
##   3. Make sure you're logged in before calling connect_to_lobby()

## Add this to your project.godot:
## [accelbyte]
## base_url="https://your-environment.accelbyte.io"
## namespace="your-namespace"
## client_id="your-client-id"
## client_secret=""

var sdk: AccelByteSDKWrapper

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

	# Lobby URL is auto-derived: base_url -> wss://env.accelbyte.io/lobby/
	# No need to set manually unless you have custom lobby endpoint

	# Connect lobby signals
	sdk.lobby_connected.connect(_on_lobby_connected)
	sdk.lobby_disconnected.connect(_on_lobby_disconnected)

	# Perform device login first, then connect to lobby
	await _login_and_connect()

func _login_and_connect() -> void:
	# Step 1: Login with device
	var iam = sdk.get_service(IamService)
	var device_id = OS.get_unique_id()
	if device_id.is_empty():
		device_id = str(Time.get_unix_time_from_system()).md5_text()

	print("Logging in with device ID: ", device_id)

	var login_result = await iam.platform_token_grant_v4("device", "", "", true, device_id)

	if not login_result.get("success", false):
		print("Login failed: ", login_result.get("error", "Unknown error"))
		return

	print("Login successful! User ID: ", sdk.get_user_id())

	# Step 2: Connect to lobby
	print("Connecting to lobby...")
	var lobby_error = sdk.lobby_connect()
	if not lobby_error.is_empty():
		print("Failed to connect to lobby: ", lobby_error)

func _on_lobby_connected(data: Dictionary) -> void:
	print("Connected to lobby! Session ID: ", data.get("sessionId", ""))

	# Setup lobby WebSocket service for notifications
	var lobby_ws = sdk.get_service(LobbyWsService)
	if lobby_ws:
		# Connect to friend-related notifications
		lobby_ws.friend_request_accepted_notif.connect(_on_friend_request_accepted)
		lobby_ws.unfriend_notif.connect(_on_unfriend_notification)
		lobby_ws.request_friends_notif.connect(_on_friend_request_received)

		print("Lobby WebSocket service ready. You can now send friend requests.")

		# Example: Send a friend request (uncomment and set a real user ID)
		# await _send_friend_request("target-user-id-here")

func _on_lobby_disconnected(data: Dictionary) -> void:
	print("Disconnected from lobby: ", data)

func _send_friend_request(user_id: String) -> void:
	"""Send a friend request to another user"""
	if user_id.is_empty():
		print("Cannot send friend request: user_id is empty")
		return

	var lobby_ws = sdk.get_service(LobbyWsService)
	if not lobby_ws:
		print("Lobby WebSocket not connected")
		return

	print("Sending friend request to: ", user_id)
	lobby_ws.request_friend(user_id)

func _accept_friend_request(user_id: String) -> void:
	"""Accept a friend request from another user"""
	var lobby_ws = sdk.get_service(LobbyWsService)
	if not lobby_ws:
		print("Lobby WebSocket not connected")
		return

	print("Accepting friend request from: ", user_id)
	lobby_ws.accept_friend(user_id)

func _reject_friend_request(user_id: String) -> void:
	"""Reject a friend request from another user"""
	var lobby_ws = sdk.get_service(LobbyWsService)
	if not lobby_ws:
		print("Lobby WebSocket not connected")
		return

	print("Rejecting friend request from: ", user_id)
	lobby_ws.reject_friend(user_id)

# Notification handlers
func _on_friend_request_received(user_id: String) -> void:
	print("Received friend request from: ", user_id)

	# Auto-accept for demo purposes (in real game, show UI to player)
	print("Auto-accepting friend request...")
	_accept_friend_request(user_id)

func _on_friend_request_accepted(user_id: String) -> void:
	print("Friend request accepted by: ", user_id)
	print("You are now friends!")

func _on_unfriend_notification(user_id: String) -> void:
	print("User unfriended you: ", user_id)

# Public API for external use
## Public method to send friend request from game UI
func send_friend_request_to_user(user_id: String) -> void:
	_send_friend_request(user_id)

func is_lobby_connected() -> bool:
	"""Check if lobby is connected"""
	return sdk.is_lobby_connected()