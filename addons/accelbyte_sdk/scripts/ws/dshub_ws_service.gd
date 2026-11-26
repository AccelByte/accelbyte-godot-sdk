## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## DshubWsService
## Auto-generated from the WebSocket schema — DO NOT EDIT
## Service: justice-dshub-ws-service
## Version: 1.0.0
## Wire format: json-envelope
## =============================================================================
##
## Typed WebSocket service: one signal per notification, one method per request.
## Get it through the SDK facade so the transport is wired up:
##   var svc: DshubWsService = sdk.get_service(DshubWsService)
##   svc.connect_service({"server_id": "...", ...})
## Field names keep the exact case of the schema.
## =============================================================================

class_name DshubWsService
extends RefCounted

## Wire format of this service (see the schema's x-wire-format).
const WIRE_FORMAT := "json-envelope"
## Path appended to the base URL when no full URL is given.
const WS_PATH := "/dshub"

## Emitted when the WebSocket connection is established.
signal ws_connected(fields: Dictionary)

## Emitted when the WebSocket connection is lost or closed.
signal ws_disconnected(reason: String)

## Emitted for messages whose wire key is not part of the schema.
signal unclassified_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary)

# =============================================================================
# Signals — notifications
# =============================================================================
## DSHUB_CONNECTED
signal connected_notif(connection_id: String)
## DSHUB_DISCONNECTED
signal disconnected_notif(namespace_param: String, code: int, message: String)
## serverClaimed
signal server_claimed_notif(
	namespace_param: String, session_id: String, game_mode: String, matching_allies: Array
)
## BACKFILL_PROPOSAL
signal backfill_proposal_notif(
	backfill_ticket_id: String,
	proposal_id: String,
	match_pool: String,
	match_session_id: String,
	proposed_teams: Array,
	added_tickets: Array
)
## SESSION_MEMBER_CHANGED
signal session_member_changed_notif(
	id: String,
	namespace_param: String,
	is_active: bool,
	members: Array,
	teams: Array,
	ds_information: String,
	backfill_ticket_id: String,
	match_pool: String,
	configuration: String,
	created_at: String,
	updated_at: String
)
## SESSION_ENDED_NOTIF
signal session_ended_notif(session_id: String, is_active: bool)
## SESSION_SERVER_SECRET
signal session_server_secret_notif(secret: String)
## BACKFILL_TICKET_EXPIRE
signal backfill_ticket_expire_notif(ticket_id: String)

## Reference to the WebSocket transport layer.
var _ws: AccelByteWsTransport
var _codec: AccelByteWsCodec = AccelByteWsJsonEnvelopeCodec.new()


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
##   base_url      base URL of the environment, e.g. https://demo.accelbyte.io (or pass url)
##   url           full wss:// URL (overrides base_url)
##   server_id     value of the X-Ab-ServerID header (required)
##   custom        true for a custom (non-AMS) server, sent as X-Ab-Custom (default false)
func connect_service(options: Dictionary = {}) -> int:
	var url: String = str(options.get("url", ""))
	if url.is_empty():
		var base_url: String = str(options.get("base_url", ""))
		if base_url.is_empty():
			push_error("[DshubWsService] connect_service() needs options.base_url or options.url")
			return ERR_INVALID_PARAMETER
		url = base_url.replace("https://", "wss://").rstrip("/") + WS_PATH
	if not url.begins_with("wss://"):
		push_error("[DshubWsService] only wss:// URLs are allowed")
		return ERR_INVALID_PARAMETER
	var headers: Dictionary = {}
	var session_value: String = str(options.get("server_id", ""))
	if session_value.is_empty():
		push_error("[DshubWsService] connect_service() needs options.server_id")
		return ERR_INVALID_PARAMETER
	headers["X-Ab-ServerID"] = session_value
	headers["X-Ab-Custom"] = "true" if options.get("custom", false) else "false"
	return _ws.connect_to_url(url, _codec, headers, str(options.get("access_token", "")))


## Disconnect from the service.
func disconnect_service() -> void:
	_ws.disconnect_service()


# =============================================================================
# Request methods — one typed method per request definition
# =============================================================================
# =============================================================================
# Internal — message router
# =============================================================================


func _on_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary) -> void:
	match msg_type:
		"DSHUB_CONNECTED":
			connected_notif.emit(_as_string(fields.get("connectionId"), ""))
		"DSHUB_DISCONNECTED":
			disconnected_notif.emit(
				_as_string(fields.get("namespace"), ""),
				_as_int(fields.get("code"), -1),
				_as_string(fields.get("message"), "")
			)
		"serverClaimed":
			server_claimed_notif.emit(
				_as_string(fields.get("namespace"), ""),
				_as_string(fields.get("session_id"), ""),
				_as_string(fields.get("game_mode"), ""),
				fields.get("matching_allies", [])
			)
		"BACKFILL_PROPOSAL":
			backfill_proposal_notif.emit(
				_as_string(fields.get("BackfillTicketID"), ""),
				_as_string(fields.get("ProposalID"), ""),
				_as_string(fields.get("MatchPool"), ""),
				_as_string(fields.get("MatchSessionID"), ""),
				fields.get("ProposedTeams", []),
				fields.get("AddedTickets", [])
			)
		"SESSION_MEMBER_CHANGED":
			session_member_changed_notif.emit(
				_as_string(fields.get("ID"), ""),
				_as_string(fields.get("Namespace"), ""),
				fields.get("IsActive", false),
				fields.get("Members", []),
				fields.get("Teams", []),
				_as_string(fields.get("DSInformation"), ""),
				_as_string(fields.get("BackfillTicketID"), ""),
				_as_string(fields.get("MatchPool"), ""),
				_as_string(fields.get("Configuration"), ""),
				_as_string(fields.get("CreatedAt"), ""),
				_as_string(fields.get("UpdatedAt"), "")
			)
		"SESSION_ENDED_NOTIF":
			session_ended_notif.emit(
				_as_string(fields.get("session_id"), ""), fields.get("is_active", false)
			)
		"SESSION_SERVER_SECRET":
			session_server_secret_notif.emit(_as_string(fields.get("secret"), ""))
		"BACKFILL_TICKET_EXPIRE":
			backfill_ticket_expire_notif.emit(_as_string(fields.get("ticket_id"), ""))
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
