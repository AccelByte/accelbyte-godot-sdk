## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_ws_transport.gd
## AccelByte WebSocket transport layer
## =============================================================================
##
## Generic WebSocket transport for AccelByte services (Lobby, DSHub, AMS watchdog,
## Chat). It owns the socket: connection lifecycle, heartbeat, reconnection and
## request/response matching. The text wire format is delegated to an
## AccelByteWsCodec, so each service plugs in its own format.
##
## This class is used by the generated *WsService classes — game code should not use
## it directly. For Lobby use AccelByteSDK.lobby_connect() and
## sdk.get_lobby_ws_service(); other services are created through the SDK facade.
## =============================================================================

class_name AccelByteWsTransport
extends RefCounted

# =============================================================================
# Signals
# =============================================================================

## Emitted when the connection is established. For Lobby this is the connectNotif
## message; for formats without such a message it is emitted when the socket opens.
signal connected(fields: Dictionary)

## Emitted when the connection is lost or closed.
signal disconnected(reason: String)

## Emitted for every incoming message (notifications, responses).
## The generated services listen on this to dispatch typed signals.
signal message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary)

# =============================================================================
# Configuration
# =============================================================================

## Heartbeat interval in seconds. A negative value (the default) uses the codec's
## own default, for example 4 s for Lobby (project setting
## accelbyte/lobby_heartbeat_interval_sec) or 15 s for the AMS watchdog.
var heartbeat_interval_sec: float = -1.0

## Interval in seconds of the WebSocket ping control frames (RFC 6455) sent while connected; 0 turns them off.
## AccelByte servers close a connection that stays silent (a DSHub connection of an unclaimed dedicated server was
## closed after about 5 minutes), and the other AccelByte SDKs send a ping every 4 s by default. It is
## independent of the message heartbeat above. Browsers do not allow it, so it has no effect on the web export.
var ping_interval_sec: float = 4.0

## Reconnection: total timeout before giving up (ms).
var reconnect_total_timeout_ms: int = 60000

## Reconnection: initial backoff delay (ms).
var reconnect_backoff_delay_ms: int = 1000

## Reconnection: maximum backoff delay cap (ms).
var reconnect_max_delay_ms: int = 30000

## Response callback timeout (ms). Callbacks older than this are cleaned up to prevent memory leaks.
var callback_timeout_ms: int = 30000

## Whether to automatically reconnect on unexpected disconnect.
var auto_reconnect: bool = true

# =============================================================================
# Internal State
# =============================================================================

const _PollNodeScene = preload("accelbyte_poll_node.gd")

var _ws: WebSocketPeer
var _scene_root: Node
var _poll_node: Node
var _url: String = ""
var _auth_token: String = ""
var _headers: Dictionary = {}
var _codec: AccelByteWsCodec
var _token_lifetime_callback: Callable  # Callback to get remaining token lifetime in seconds
var _message_id: int = 0
var _response_callbacks: Dictionary = {}  # {int: {"callback": Callable, "sent_at": int}}
var _is_connected: bool = false
var _intentional_disconnect: bool = false

# Heartbeat tracking
var _heartbeat_timer_sec: float = 0.0

# Reconnection tracking
var _is_reconnecting: bool = false
var _reconnect_elapsed_ms: int = 0
var _reconnect_current_delay_ms: int = 0
var _reconnect_timer_sec: float = 0.0

# =============================================================================
# Initialization
# =============================================================================


## Set the scene root node (needed for timers and tree access).
## Attaches an internal poll node to the scene tree so polling is automatic.
func initialize(scene_root: Node) -> void:
	_scene_root = scene_root
	_attach_poll_node()


# =============================================================================
# Connection Lifecycle
# =============================================================================


## Update the auth token for future reconnection attempts.
## This must be called after token refresh to ensure reconnects use the new token.
func set_auth_token(new_token: String) -> void:
	_auth_token = new_token
	# If we're currently in a reconnect loop, the new token will be used on next attempt


## Set a callback to get remaining token lifetime (for security warnings).
## The callback should return remaining seconds as float.
func set_token_lifetime_callback(callback: Callable) -> void:
	_token_lifetime_callback = callback


## Connect to a WebSocket service with the given codec.
## `headers` are extra handshake headers (desktop only — browsers cannot set them).
## `auth_token`, when not empty, is sent as `Authorization: Bearer` on desktop and as a
## subprotocol on web.
## Returns OK on success, or an error code.
func connect_to_url(
	url: String, codec: AccelByteWsCodec, headers: Dictionary = {}, auth_token: String = ""
) -> int:
	if _is_connected:
		return OK
	if codec == null:
		push_error("[AccelByteWsTransport] connect_to_url() needs a codec")
		return ERR_INVALID_PARAMETER

	_url = url
	_codec = codec
	_headers = headers.duplicate()
	_auth_token = auth_token
	_intentional_disconnect = false
	_is_reconnecting = false

	_attach_poll_node()
	return _do_connect()


## Connect to the Lobby WebSocket server (Lobby text codec, bearer token).
## Returns OK on success, or an error code.
func connect_to_lobby(url: String, auth_token: String) -> int:
	return connect_to_url(url, AccelByteWsLobbyTextCodec.new(), {}, auth_token)


## Disconnect from the WebSocket server.
func disconnect_service() -> void:
	_intentional_disconnect = true
	_is_reconnecting = false
	_response_callbacks.clear()

	if _ws:
		_ws.close()

	if _is_connected:
		_is_connected = false
		disconnected.emit("client disconnected")

	_detach_poll_node()


## Disconnect from the Lobby WebSocket server.
func disconnect_from_lobby() -> void:
	disconnect_service()


## Check if the WebSocket is currently connected.
func is_ws_connected() -> bool:
	return _is_connected


## Poll the WebSocket. Called automatically by the internal poll node.
## Handles incoming packets, heartbeat, and reconnection.
func _poll() -> void:
	if _ws == null:
		if _is_reconnecting:
			_poll_reconnect()
		return

	_ws.poll()

	var state = _ws.get_ready_state()

	match state:
		WebSocketPeer.STATE_OPEN:
			if not _is_connected:
				# Just connected (or reconnected)
				_is_connected = true
				_is_reconnecting = false
				_heartbeat_timer_sec = 0.0
				if _codec.connected_on_open():
					connected.emit({})

			# Process incoming packets
			while _ws.get_available_packet_count() > 0:
				var packet = _ws.get_packet()
				var raw = packet.get_string_from_utf8()
				if not raw.is_empty():
					_on_data_received(raw)

			# Heartbeat
			_poll_heartbeat()

			# Clean up expired callbacks
			_cleanup_expired_callbacks()

		WebSocketPeer.STATE_CLOSING:
			pass  # Wait for close to complete

		WebSocketPeer.STATE_CLOSED:
			var was_connected = _is_connected
			var close_code = _ws.get_close_code()
			var close_reason = _ws.get_close_reason()
			_is_connected = false
			_ws = null

			if was_connected and not _intentional_disconnect:
				disconnected.emit(
					"connection lost (code: %d, reason: %s)" % [close_code, close_reason]
				)

				if auto_reconnect:
					_start_reconnect()
			elif was_connected and _intentional_disconnect:
				pass  # Already emitted in disconnect_service()

		WebSocketPeer.STATE_CONNECTING:
			pass  # Still connecting

	# Handle reconnection polling
	if _is_reconnecting and not _is_connected:
		_poll_reconnect()


# =============================================================================
# Sending Messages
# =============================================================================


## Send a typed request message. Automatically assigns a message ID.
## If callback is valid, it will be called when the response arrives. Formats without
## request ids (see AccelByteWsCodec.supports_correlation) cannot match a response, so the
## callback is called at once with an error and the request is still sent.
func send_request(type_param: String, fields: Dictionary, callback: Callable = Callable()) -> void:
	if not _is_connected or _ws == null:
		push_warning(
			"[AccelByteWsTransport] Request '%s' dropped - WebSocket not connected" % type_param
		)
		if callback.is_valid():
			# Call with error parameter to indicate failure
			callback.call({"error": "not_connected", "message": "WebSocket not connected"})
		return

	_message_id += 1
	var msg_id = _message_id

	if callback.is_valid():
		if _codec.supports_correlation():
			_response_callbacks[msg_id] = {"callback": callback, "sent_at": Time.get_ticks_msec()}
		else:
			push_warning(
				(
					"[AccelByteWsTransport] Request '%s': this protocol has no request ids, callback not supported"
					% type_param
				)
			)
			callback.call(
				{
					"error": "callbacks_not_supported",
					"message": "This WebSocket protocol cannot match responses to requests"
				}
			)

	_ws.send_text(_codec.encode(type_param, fields, msg_id))


# =============================================================================
# Internal — Connection
# =============================================================================


func _do_connect() -> int:
	_ws = WebSocketPeer.new()

	var header_list: PackedStringArray = PackedStringArray()
	for key in _headers:
		header_list.push_back("%s: %s" % [key, _headers[key]])

	# Browsers refuse to set User-Agent; desktop and servers identify the SDK.
	if not OS.has_feature("web"):
		var has_user_agent := false
		for key in _headers:
			if str(key).to_lower() == "user-agent":
				has_user_agent = true
		if not has_user_agent:
			header_list.push_back("User-Agent: " + AccelbyteHttp.get_user_agent())

	if not _auth_token.is_empty():
		# Web platform (browser) blocks custom WebSocket handshake headers for security.
		# The only value browsers allow is Sec-WebSocket-Protocol (subprotocols).
		# AccelByte lobby accepts the access token as a subprotocol — this is the same
		# mechanism the Unity SDK uses on WebGL (NativeWebSocket passes the token via
		# new WebSocket(url, [token]) in JavaScript).
		# On desktop we additionally set the Authorization header.
		#
		# SECURITY WARNING: On web platforms, Bearer tokens are exposed in WebSocket
		# subprotocol headers (Sec-WebSocket-Protocol), which are visible in browser
		# DevTools and may be logged by CDN/proxy infrastructure. This is the ONLY
		# authentication method available for WebSocket connections in browsers.
		#
		# SECURITY RECOMMENDATIONS: For production web deployments:
		# 1. Configure short-lived tokens (< 5 minutes)
		# 2. Restrict CORS headers aggressively
		# 3. Consider this exposure when handling sensitive user data
		# Note: This is a warning system only — connection proceeds regardless.

		# SECURITY WARNING: Log token exposure on web platform (does not block connection)
		if OS.has_feature("web") and not _auth_token.is_empty():
			# Check token lifetime if SDK instance is available via callback
			if _token_lifetime_callback.is_valid():
				var remaining_seconds = _token_lifetime_callback.call()
				var threshold_seconds = 300  # 5 minutes — matches "< 5 minutes" recommendation
				if remaining_seconds > threshold_seconds:
					push_error(
						(
							"[AccelByteWsTransport] SECURITY WARNING: Web platform token sent via Sec-WebSocket-Protocol header (visible in browser DevTools). Token lifetime: %.1f minutes. For production, use tokens < 5 minutes."
							% (remaining_seconds / 60.0)
						)
					)
				else:
					push_warning(
						(
							"[AccelByteWsTransport] Web: Token sent via Sec-WebSocket-Protocol header. Token lifetime: %.1f minutes."
							% (remaining_seconds / 60.0)
						)
					)
			else:
				push_warning(
					"[AccelByteWsTransport] Web: Token sent via Sec-WebSocket-Protocol header (visible in browser DevTools). Ensure short-lived tokens are configured."
				)

		if OS.has_feature("web"):
			# Sanitize token for WebSocket subprotocol (RFC 6455 compliance)
			var clean_token = _auth_token.replace("+", "-").replace("/", "_").rstrip("=")
			_ws.supported_protocols = PackedStringArray([clean_token])
		else:
			header_list.push_back("Authorization: Bearer " + _auth_token)

	if OS.has_feature("web"):
		if not _headers.is_empty():
			push_warning(
				"[AccelByteWsTransport] Web: custom handshake headers are not supported by browsers and are ignored"
			)
	elif not header_list.is_empty():
		_ws.handshake_headers = header_list

	if ping_interval_sec > 0.0 and not OS.has_feature("web"):
		_ws.heartbeat_interval = ping_interval_sec

	var err = _ws.connect_to_url(_url)
	if err != OK:
		_ws = null
		return err

	_heartbeat_timer_sec = 0.0
	return OK


# =============================================================================
# Internal — Incoming Message Handling
# =============================================================================


func _on_data_received(raw: String) -> void:
	var decoded: Dictionary = _codec.decode(raw)
	var msg_type: String = decoded.get("type", "")
	if msg_type.is_empty():
		return

	var msg_id: int = decoded.get("id", -1)
	var code: int = decoded.get("code", 0)
	# Payload fields are kept apart from transport metadata to prevent field name collisions.
	var payload_fields: Dictionary = decoded.get("fields", {})

	# Full message (payload plus type, id, code) as handed to `connected` and to callbacks.
	var msg: Dictionary = payload_fields.duplicate()
	msg["type"] = msg_type
	msg["id"] = msg_id
	msg["code"] = code

	# Handle special messages
	match _codec.control_kind(decoded):
		"connected":
			connected.emit(msg)
			return

		"disconnected":
			_is_connected = false
			_intentional_disconnect = true
			disconnected.emit(payload_fields.get("message", "server disconnected"))
			if _ws:
				_ws.close()
			return

		"heartbeat":
			# Server heartbeat — respond with heartbeat
			if _ws and _is_connected:
				_send_heartbeat()
			return

	# Handle response callbacks (messages with matching ID) - pass full message for response parsing
	if msg_id >= 0 and _response_callbacks.has(msg_id):
		var callback_data = _response_callbacks[msg_id]
		_response_callbacks.erase(msg_id)
		var callback: Callable = callback_data.get("callback", Callable())
		if callback.is_valid():
			callback.call(msg)  # Callbacks get full message including transport metadata

	# Always emit message_received for service routing (fields separated from transport metadata)
	message_received.emit(msg_type, msg_id, code, payload_fields)


# =============================================================================
# Internal — Heartbeat
# =============================================================================


## Clean up response callbacks that have exceeded the timeout to prevent memory leaks.
func _cleanup_expired_callbacks() -> void:
	if _response_callbacks.is_empty():
		return

	var current_time = Time.get_ticks_msec()
	var expired_ids: Array[int] = []

	for msg_id in _response_callbacks:
		var callback_data = _response_callbacks[msg_id]
		var sent_at = callback_data.get("sent_at", current_time)
		if current_time - sent_at > callback_timeout_ms:
			expired_ids.append(msg_id)

	# Remove expired callbacks
	for msg_id in expired_ids:
		_response_callbacks.erase(msg_id)

	if expired_ids.size() > 0:
		push_warning(
			"[AccelByteWsTransport] Cleaned up %d expired response callbacks" % expired_ids.size()
		)


func _effective_heartbeat_interval() -> float:
	if heartbeat_interval_sec >= 0.0:
		return heartbeat_interval_sec
	return _codec.heartbeat_interval_sec()


func _send_heartbeat() -> void:
	var text := _codec.heartbeat_message()
	if not text.is_empty():
		_ws.send_text(text)


func _poll_heartbeat() -> void:
	if not _is_connected or not _scene_root:
		return
	if _codec.heartbeat_message().is_empty():
		return

	var delta = _scene_root.get_process_delta_time()
	_heartbeat_timer_sec += delta

	if _heartbeat_timer_sec >= _effective_heartbeat_interval():
		_heartbeat_timer_sec = 0.0
		if _ws and _is_connected:
			_send_heartbeat()


# =============================================================================
# Internal — Reconnection (exponential backoff with jitter)
# =============================================================================


func _start_reconnect() -> void:
	if _intentional_disconnect or _is_reconnecting:
		return

	_is_reconnecting = true
	_reconnect_elapsed_ms = 0
	_reconnect_current_delay_ms = reconnect_backoff_delay_ms
	_reconnect_timer_sec = 0.0

	# Clear stale callbacks and reset message ID for clean reconnection state
	_response_callbacks.clear()

	# Ensure the poll node is attached — disconnect_service() detaches it,
	# so without this the reconnect WebSocket would never be polled.
	_attach_poll_node()


func _poll_reconnect() -> void:
	if not _is_reconnecting or _intentional_disconnect:
		_is_reconnecting = false
		return

	if not _scene_root:
		_is_reconnecting = false
		return

	var delta = _scene_root.get_process_delta_time()
	_reconnect_timer_sec += delta

	var delay_sec = _reconnect_current_delay_ms / 1000.0

	if _reconnect_timer_sec >= delay_sec:
		_reconnect_timer_sec = 0.0
		_reconnect_elapsed_ms += _reconnect_current_delay_ms

		if _reconnect_elapsed_ms >= reconnect_total_timeout_ms:
			# Give up
			_is_reconnecting = false
			disconnected.emit("reconnection timed out")
			return

		# Attempt reconnect
		var err = _do_connect()
		if err != OK:
			# Exponential backoff with jitter (±25%)
			var jitter = randf_range(0.75, 1.25)
			_reconnect_current_delay_ms = mini(
				int(_reconnect_current_delay_ms * 2 * jitter), reconnect_max_delay_ms
			)


# =============================================================================
# Internal — Auto-poll Node
# =============================================================================


func _attach_poll_node() -> void:
	if _poll_node or not _scene_root:
		return
	_poll_node = _PollNodeScene.new()
	_poll_node.name = "_ABWsPoll"
	_poll_node._callback = Callable(self, "_poll")
	_scene_root.add_child(_poll_node)


func _detach_poll_node() -> void:
	if _poll_node:
		_poll_node._callback = Callable()
		if _poll_node.is_inside_tree():
			_poll_node.queue_free()
		_poll_node = null
