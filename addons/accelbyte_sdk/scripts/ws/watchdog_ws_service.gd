## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## AmsWatchdogWsService
## Auto-generated from the WebSocket schema — DO NOT EDIT
## Service: justice-ams-watchdog-ws-service
## Version: 1.0.0
## Wire format: keyed-json
## =============================================================================
##
## Typed WebSocket service: one signal per notification, one method per request.
## Get it through the SDK facade so the transport is wired up:
##   var svc: AmsWatchdogWsService = sdk.get_service(AmsWatchdogWsService)
##   svc.connect_service({"ds_id": "...", ...})
## Field names keep the exact case of the schema.
## =============================================================================

class_name AmsWatchdogWsService
extends RefCounted

## Wire format of this service (see the schema's x-wire-format).
const WIRE_FORMAT := "keyed-json"
## Path appended to the base URL when no full URL is given.
const WS_PATH := "/watchdog"

## Emitted when the WebSocket connection is established.
signal ws_connected(fields: Dictionary)

## Emitted when the WebSocket connection is lost or closed.
signal ws_disconnected(reason: String)

## Emitted for messages whose wire key is not part of the schema.
signal unclassified_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary)

# =============================================================================
# Signals — notifications
# =============================================================================
## drain
signal drain_notif(current_state: String)

## Reference to the WebSocket transport layer.
var _ws: AccelByteWsTransport
var _codec: AccelByteWsCodec = AccelByteWsKeyedJsonCodec.new("heartbeat", 15.0, "ready")


func _init(ws: AccelByteWsTransport = null) -> void:
	if ws:
		setup(ws)


## Connect this service to a WebSocket transport.
func setup(ws: AccelByteWsTransport) -> void:
	_ws = ws
	_ws.message_received.connect(_on_message_received)
	_ws.connected.connect(func(fields: Dictionary): ws_connected.emit(fields))
	_ws.disconnected.connect(func(reason: String): ws_disconnected.emit(reason))


## Returns the underlying WebSocket transport.
func get_ws_transport() -> AccelByteWsTransport:
	return _ws


## Connect to the service. Returns OK or an error code.
## options:
##   access_token  bearer token (optional)
##   url           full URL of the service (required; a plain, non-TLS WebSocket URL is allowed for this service)
##   ds_id         value of the ams-dsid header (required)
func connect_service(options: Dictionary = {}) -> int:
	var url: String = str(options.get("url", ""))
	if url.is_empty():
		push_error("[AmsWatchdogWsService] connect_service() needs options.url")
		return ERR_INVALID_PARAMETER
	var headers: Dictionary = {}
	var session_value: String = str(options.get("ds_id", ""))
	if session_value.is_empty():
		push_error("[AmsWatchdogWsService] connect_service() needs options.ds_id")
		return ERR_INVALID_PARAMETER
	headers["ams-dsid"] = session_value
	return _ws.connect_to_url(url, _codec, headers, str(options.get("access_token", "")))


## Disconnect from the service.
func disconnect_service() -> void:
	_ws.disconnect_service()


# =============================================================================
# Request methods — one typed method per request definition
# =============================================================================
## ready
func ready_request(dsid: String) -> void:
	var fields: Dictionary = {}
	fields["dsid"] = dsid
	_ws.send_request("ready", fields)


## heartbeat
func heartbeat_request() -> void:
	var fields: Dictionary = {}

	_ws.send_request("heartbeat", fields)


## claim
func claim_request(session_id: String) -> void:
	var fields: Dictionary = {}
	fields["sessionId"] = session_id
	_ws.send_request("claim", fields)


## reset_session_timeout
func reset_session_timeout_request(new_timeout: int = -1) -> void:
	var fields: Dictionary = {}
	fields["new_timeout"] = new_timeout
	_ws.send_request("reset_session_timeout", fields)


# =============================================================================
# Internal — message router
# =============================================================================


func _on_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary) -> void:
	match msg_type:
		"drain":
			drain_notif.emit(_as_string(fields.get("currentState"), ""))
		_:
			unclassified_message_received.emit(msg_type, msg_id, code, fields)


# =============================================================================
# Internal — typed field access (JSON numbers arrive as floats, int64 as strings)
# =============================================================================


static func _as_int(value, default: int = -1) -> int:
	if value is int:
		return value
	if value is float:
		return int(value)
	if value is String and value.is_valid_int():
		return value.to_int()
	return default


static func _as_float(value, default: float = -1.0) -> float:
	if value is float or value is int:
		return float(value)
	if value is String and value.is_valid_float():
		return value.to_float()
	return default


static func _as_string(value, default: String = "") -> String:
	if value == null:
		return default
	return value if value is String else str(value)
