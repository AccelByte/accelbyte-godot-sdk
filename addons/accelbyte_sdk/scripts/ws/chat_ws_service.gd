## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## ChatWsService
## Auto-generated from the WebSocket schema — DO NOT EDIT
## Service: justice-chat-ws-service
## Version: 2.0.0
## Wire format: jsonrpc
## =============================================================================
##
## Typed WebSocket service: one signal per notification, one method per request.
## Get it through the SDK facade so the transport is wired up:
##   var svc: ChatWsService = sdk.get_service(ChatWsService)
##   svc.connect_service({"access_token": "...", ...})
## Field names keep the exact case of the schema.
## =============================================================================

class_name ChatWsService
extends RefCounted

## Wire format of this service (see the schema's x-wire-format).
const WIRE_FORMAT := "jsonrpc"
## Path appended to the base URL when no full URL is given.
const WS_PATH := "/chat/"

## Emitted when the WebSocket connection is established.
signal ws_connected(fields: Dictionary)

## Emitted when the WebSocket connection is lost or closed.
signal ws_disconnected(reason: String)

## Emitted for messages whose wire key is not part of the schema.
signal unclassified_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary)

# =============================================================================
# Signals — notifications
# =============================================================================
## eventConnected
signal connected_notif(session_id: String)
## eventDisconnected
signal disconnected_notif
## eventAddedToTopic
signal added_to_topic_notif(
	type_param: String, name_param: String, topic_id: String, sender_id: String, is_channel: bool
)
## eventRemovedFromTopic
signal removed_from_topic_notif(
	type_param: String, name_param: String, topic_id: String, sender_id: String, is_channel: bool
)
## eventTopicDeleted
signal topic_deleted_notif(name_param: String, topic_id: String, sender_id: String)
## eventNewChat
signal new_chat_notif(
	chat_id: String, message: String, topic_id: String, from: String, created_at: int
)
## eventReadChat
signal read_chat_notif(read_chat: Array)
## eventBanChat
signal ban_chat_notif(
	user_id: String,
	namespace_param: String,
	ban: String,
	end_date: String,
	reason: String,
	enable: bool
)
## eventUnbanChat
signal unban_chat_notif(
	user_id: String,
	namespace_param: String,
	ban: String,
	end_date: String,
	reason: String,
	enable: bool
)
## eventTopicBanChat
signal topic_ban_chat_notif(user_id: String, topic_id: String, enable: bool)
## eventTopicUnbanChat
signal topic_unban_chat_notif(user_id: String, topic_id: String, enable: bool)
## eventTopicUpdated
signal topic_updated_notif(name_param: String, topic_id: String, sender_id: String)
## eventUserMuted
signal user_muted_notif(topic_id: String, remaining_time: int, expired_at: int)
## eventUserUnmuted
signal user_unmuted_notif(topic_id: String)
## eventNewSystemMessage
signal new_system_message_notif(
	message_id: String, category: String, message: String, created_at: int, expired_at: int
)
## eventServerShutdown
signal server_shutdown_notif

# =============================================================================
# Signals — responses (also delivered to the callback of the request)
# =============================================================================
## actionRefreshToken
signal refresh_token_response(code: int)
## actionGetUserConfig
signal get_user_config_response(processed: int, config: Dictionary)
## actionSetUserConfig
signal set_user_config_response(processed: int)
## actionCreateTopic
signal create_topic_response(processed: int, topic_id: String)
## actionJoinTopic
signal join_topic_response(processed: int, topic_id: String)
## actionQuitTopic
signal quit_topic_response(processed: int, topic_id: String)
## actionDeleteTopic
signal delete_topic_response(processed: int, topic_id: String)
## actionQueryGroupTopic
signal query_group_topic_response(processed: int, data: Array)
## actionQueryPersonalTopic
signal query_personal_topic_response(processed: int, data: Array)
## actionQueryTopic
signal query_topic_response(processed: int, data: Array)
## actionQueryTopicById
signal query_topic_by_id_response(processed: int, data: Dictionary)
## sendChat
signal send_chat_response(processed: int, topic_id: String, chat_id: String, metadata: Dictionary)
## queryChat
signal query_chat_response(processed: int, data: Array)
## readChat
signal read_chat_response(processed: int)
## actionBlockUser
signal block_user_response(processed: int, user_id: String)
## actionUnblockUser
signal unblock_user_response(processed: int, user_id: String)
## actionQuerySystemMessage
signal query_system_message_response(data: Array)
## actionUpdateSystemMessages
signal update_system_messages_response(processed: int)
## actionDeleteSystemMessages
signal delete_system_messages_response(processed: int)
## actionGetSystemMessageStats
signal get_system_message_stats_response(oldest_unread: int, unread: int)
## actionUpdateTopic
signal update_topic_response(processed: int, topic_id: String)
## actionAddUserToTopic
signal add_user_to_topic_response(processed: int, topic_id: String, user_id: String)
## actionRemoveUserFromTopic
signal remove_user_from_topic_response(processed: int, topic_id: String, user_id: String)
## actionQueryPublicGroupTopic
signal query_public_group_topic_response(processed: int, data: Array)
## actionSyncSystemMessage
signal sync_system_message_response(processed: int)
## actionDisconnect
signal disconnect_response

## Emitted when the server answers a request with a JSON-RPC error.
signal error_received(method: String, request_id: int, code: int, message: String)

## Reference to the WebSocket transport layer.
var _ws: AccelByteWsTransport
## Created in connect_service() because it depends on the envelope markers.
var _codec: AccelByteWsCodec


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
##   session_id    chat session id, sent as X-Ab-ChatSessionID (optional)
##   envelope_start, envelope_end
##                 markers the server wraps every message in, sent as
##                 X-Ab-RpcEnvelopeStart / X-Ab-RpcEnvelopeEnd (optional; both or none)
func connect_service(options: Dictionary = {}) -> int:
	var url: String = str(options.get("url", ""))
	if url.is_empty():
		var base_url: String = str(options.get("base_url", ""))
		if base_url.is_empty():
			push_error("[ChatWsService] connect_service() needs options.base_url or options.url")
			return ERR_INVALID_PARAMETER
		url = base_url.replace("https://", "wss://").rstrip("/") + WS_PATH
	if not url.begins_with("wss://"):
		push_error("[ChatWsService] only wss:// URLs are allowed")
		return ERR_INVALID_PARAMETER
	var headers: Dictionary = {}
	var marker_start: String = str(options.get("envelope_start", ""))
	var marker_end: String = str(options.get("envelope_end", ""))
	if marker_start.is_empty() != marker_end.is_empty():
		push_error("[ChatWsService] envelope_start and envelope_end must be given together")
		return ERR_INVALID_PARAMETER
	if not marker_start.is_empty():
		headers["X-Ab-RpcEnvelopeStart"] = marker_start
		headers["X-Ab-RpcEnvelopeEnd"] = marker_end
	var chat_session: String = str(options.get("session_id", ""))
	if not chat_session.is_empty():
		headers["X-Ab-ChatSessionID"] = chat_session
	_codec = AccelByteWsJsonRpcCodec.new(marker_start, marker_end)
	return _ws.connect_to_url(url, _codec, headers, str(options.get("access_token", "")))


## Disconnect from the service.
func disconnect_service() -> void:
	_ws.disconnect_service()


# =============================================================================
# Request methods — one typed method per request definition
# =============================================================================
## actionRefreshToken
func refresh_token_request(token: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["token"] = token
	_ws.send_request("actionRefreshToken", fields, callback)


## actionGetUserConfig
func get_user_config_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("actionGetUserConfig", fields, callback)


## actionSetUserConfig
func set_user_config_request(config: Dictionary, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["config"] = config
	_ws.send_request("actionSetUserConfig", fields, callback)


## actionCreateTopic
func create_topic_request(
	namespace_param: String,
	type_param: String,
	members: Array,
	name_param: String = "",
	admins: Array = [],
	is_joinable: bool = false,
	is_channel: bool = false,
	shard_limit: int = -1,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["namespace"] = namespace_param
	fields["type"] = type_param
	fields["members"] = members
	if not name_param.is_empty():
		fields["name"] = name_param
	if not admins.is_empty():
		fields["admins"] = admins
	fields["isJoinable"] = is_joinable
	fields["isChannel"] = is_channel
	fields["shardLimit"] = shard_limit
	_ws.send_request("actionCreateTopic", fields, callback)


## actionJoinTopic
func join_topic_request(topic_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	_ws.send_request("actionJoinTopic", fields, callback)


## actionQuitTopic
func quit_topic_request(topic_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	_ws.send_request("actionQuitTopic", fields, callback)


## actionDeleteTopic
func delete_topic_request(topic_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	_ws.send_request("actionDeleteTopic", fields, callback)


## actionQueryGroupTopic
func query_group_topic_request(
	namespace_param: String,
	keyword: String = "",
	offset: int = -1,
	limit: int = -1,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["namespace"] = namespace_param
	if not keyword.is_empty():
		fields["keyword"] = keyword
	fields["offset"] = offset
	fields["limit"] = limit
	_ws.send_request("actionQueryGroupTopic", fields, callback)


## actionQueryPersonalTopic
func query_personal_topic_request(
	namespace_param: String,
	keyword: String = "",
	offset: int = -1,
	limit: int = -1,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["namespace"] = namespace_param
	if not keyword.is_empty():
		fields["keyword"] = keyword
	fields["offset"] = offset
	fields["limit"] = limit
	_ws.send_request("actionQueryPersonalTopic", fields, callback)


## actionQueryTopic
func query_topic_request(
	namespace_param: String,
	keyword: String = "",
	offset: int = -1,
	limit: int = -1,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["namespace"] = namespace_param
	if not keyword.is_empty():
		fields["keyword"] = keyword
	fields["offset"] = offset
	fields["limit"] = limit
	_ws.send_request("actionQueryTopic", fields, callback)


## actionQueryTopicById
func query_topic_by_id_request(topic_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	_ws.send_request("actionQueryTopicById", fields, callback)


## sendChat
func send_chat_request(
	topic_id: String, message: String, metadata: Dictionary = {}, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	fields["message"] = message
	if not metadata.is_empty():
		fields["metadata"] = metadata
	_ws.send_request("sendChat", fields, callback)


## queryChat
func query_chat_request(
	topic_id: String,
	limit: int = -1,
	last_chat_created_at: int = -1,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	fields["limit"] = limit
	fields["lastChatCreatedAt"] = last_chat_created_at
	_ws.send_request("queryChat", fields, callback)


## readChat
func read_chat_request(chat_ids: Array, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["chatIds"] = chat_ids
	_ws.send_request("readChat", fields, callback)


## actionBlockUser
func block_user_request(user_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["userId"] = user_id
	_ws.send_request("actionBlockUser", fields, callback)


## actionUnblockUser
func unblock_user_request(user_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["userId"] = user_id
	_ws.send_request("actionUnblockUser", fields, callback)


## actionQuerySystemMessage
func query_system_message_request(
	unread_only: bool = false,
	start_created_at: int = -1,
	end_created_at: int = -1,
	category: String = "",
	offset: int = -1,
	limit: int = -1,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["unreadOnly"] = unread_only
	fields["startCreatedAt"] = start_created_at
	fields["endCreatedAt"] = end_created_at
	if not category.is_empty():
		fields["category"] = category
	fields["offset"] = offset
	fields["limit"] = limit
	_ws.send_request("actionQuerySystemMessage", fields, callback)


## actionUpdateSystemMessages
func update_system_messages_request(data: Array, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["data"] = data
	_ws.send_request("actionUpdateSystemMessages", fields, callback)


## actionDeleteSystemMessages
func delete_system_messages_request(message_ids: Array, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["messageIds"] = message_ids
	_ws.send_request("actionDeleteSystemMessages", fields, callback)


## actionGetSystemMessageStats
func get_system_message_stats_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("actionGetSystemMessageStats", fields, callback)


## actionUpdateTopic
func update_topic_request(
	topic_id: String,
	name_param: String = "",
	is_joinable: bool = false,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	if not name_param.is_empty():
		fields["name"] = name_param
	fields["isJoinable"] = is_joinable
	_ws.send_request("actionUpdateTopic", fields, callback)


## actionAddUserToTopic
func add_user_to_topic_request(
	topic_id: String, user_id: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	fields["userId"] = user_id
	_ws.send_request("actionAddUserToTopic", fields, callback)


## actionRemoveUserFromTopic
func remove_user_from_topic_request(
	topic_id: String, user_id: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	fields["topicId"] = topic_id
	fields["userId"] = user_id
	_ws.send_request("actionRemoveUserFromTopic", fields, callback)


## actionQueryPublicGroupTopic
func query_public_group_topic_request(
	namespace_param: String = "",
	keyword: String = "",
	offset: int = -1,
	limit: int = -1,
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not namespace_param.is_empty():
		fields["namespace"] = namespace_param
	if not keyword.is_empty():
		fields["keyword"] = keyword
	fields["offset"] = offset
	fields["limit"] = limit
	_ws.send_request("actionQueryPublicGroupTopic", fields, callback)


## actionSyncSystemMessage
func sync_system_message_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("actionSyncSystemMessage", fields, callback)


## actionDisconnect
func disconnect_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("actionDisconnect", fields, callback)


# =============================================================================
# Internal — message router
# =============================================================================


func _on_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary) -> void:
	# A JSON-RPC message with an id answers a request; one without is a server event.
	if msg_id >= 0:
		if code != 0:
			var error: Dictionary = fields.get("error", {})
			error_received.emit(msg_type, msg_id, code, _as_string(error.get("message"), ""))
			return
		match msg_type:
			"actionRefreshToken":
				refresh_token_response.emit(_as_int(fields.get("code"), -1))
				return
			"actionGetUserConfig":
				get_user_config_response.emit(
					_as_int(fields.get("processed"), -1), fields.get("config", {})
				)
				return
			"actionSetUserConfig":
				set_user_config_response.emit(_as_int(fields.get("processed"), -1))
				return
			"actionCreateTopic":
				create_topic_response.emit(
					_as_int(fields.get("processed"), -1), _as_string(fields.get("topicId"), "")
				)
				return
			"actionJoinTopic":
				join_topic_response.emit(
					_as_int(fields.get("processed"), -1), _as_string(fields.get("topicId"), "")
				)
				return
			"actionQuitTopic":
				quit_topic_response.emit(
					_as_int(fields.get("processed"), -1), _as_string(fields.get("topicId"), "")
				)
				return
			"actionDeleteTopic":
				delete_topic_response.emit(
					_as_int(fields.get("processed"), -1), _as_string(fields.get("topicId"), "")
				)
				return
			"actionQueryGroupTopic":
				query_group_topic_response.emit(
					_as_int(fields.get("processed"), -1), fields.get("data", [])
				)
				return
			"actionQueryPersonalTopic":
				query_personal_topic_response.emit(
					_as_int(fields.get("processed"), -1), fields.get("data", [])
				)
				return
			"actionQueryTopic":
				query_topic_response.emit(
					_as_int(fields.get("processed"), -1), fields.get("data", [])
				)
				return
			"actionQueryTopicById":
				query_topic_by_id_response.emit(
					_as_int(fields.get("processed"), -1), fields.get("data", {})
				)
				return
			"sendChat":
				send_chat_response.emit(
					_as_int(fields.get("processed"), -1),
					_as_string(fields.get("topicId"), ""),
					_as_string(fields.get("chatId"), ""),
					fields.get("metadata", {})
				)
				return
			"queryChat":
				query_chat_response.emit(
					_as_int(fields.get("processed"), -1), fields.get("data", [])
				)
				return
			"readChat":
				read_chat_response.emit(_as_int(fields.get("processed"), -1))
				return
			"actionBlockUser":
				block_user_response.emit(
					_as_int(fields.get("processed"), -1), _as_string(fields.get("userId"), "")
				)
				return
			"actionUnblockUser":
				unblock_user_response.emit(
					_as_int(fields.get("processed"), -1), _as_string(fields.get("userId"), "")
				)
				return
			"actionQuerySystemMessage":
				query_system_message_response.emit(fields.get("data", []))
				return
			"actionUpdateSystemMessages":
				update_system_messages_response.emit(_as_int(fields.get("processed"), -1))
				return
			"actionDeleteSystemMessages":
				delete_system_messages_response.emit(_as_int(fields.get("processed"), -1))
				return
			"actionGetSystemMessageStats":
				get_system_message_stats_response.emit(
					_as_int(fields.get("oldestUnread"), -1), _as_int(fields.get("unread"), -1)
				)
				return
			"actionUpdateTopic":
				update_topic_response.emit(
					_as_int(fields.get("processed"), -1), _as_string(fields.get("topicId"), "")
				)
				return
			"actionAddUserToTopic":
				add_user_to_topic_response.emit(
					_as_int(fields.get("processed"), -1),
					_as_string(fields.get("topicId"), ""),
					_as_string(fields.get("userId"), "")
				)
				return
			"actionRemoveUserFromTopic":
				remove_user_from_topic_response.emit(
					_as_int(fields.get("processed"), -1),
					_as_string(fields.get("topicId"), ""),
					_as_string(fields.get("userId"), "")
				)
				return
			"actionQueryPublicGroupTopic":
				query_public_group_topic_response.emit(
					_as_int(fields.get("processed"), -1), fields.get("data", [])
				)
				return
			"actionSyncSystemMessage":
				sync_system_message_response.emit(_as_int(fields.get("processed"), -1))
				return
			"actionDisconnect":
				disconnect_response.emit()
				return
		unclassified_message_received.emit(msg_type, msg_id, code, fields)
		return
	match msg_type:
		"eventConnected":
			connected_notif.emit(_as_string(fields.get("sessionId"), ""))
		"eventDisconnected":
			disconnected_notif.emit()
		"eventAddedToTopic":
			added_to_topic_notif.emit(
				_as_string(fields.get("type"), ""),
				_as_string(fields.get("name"), ""),
				_as_string(fields.get("topicId"), ""),
				_as_string(fields.get("senderId"), ""),
				fields.get("isChannel", false)
			)
		"eventRemovedFromTopic":
			removed_from_topic_notif.emit(
				_as_string(fields.get("type"), ""),
				_as_string(fields.get("name"), ""),
				_as_string(fields.get("topicId"), ""),
				_as_string(fields.get("senderId"), ""),
				fields.get("isChannel", false)
			)
		"eventTopicDeleted":
			topic_deleted_notif.emit(
				_as_string(fields.get("name"), ""),
				_as_string(fields.get("topicId"), ""),
				_as_string(fields.get("senderId"), "")
			)
		"eventNewChat":
			new_chat_notif.emit(
				_as_string(fields.get("chatId"), ""),
				_as_string(fields.get("message"), ""),
				_as_string(fields.get("topicId"), ""),
				_as_string(fields.get("from"), ""),
				_as_int(fields.get("createdAt"), -1)
			)
		"eventReadChat":
			read_chat_notif.emit(fields.get("readChat", []))
		"eventBanChat":
			ban_chat_notif.emit(
				_as_string(fields.get("userId"), ""),
				_as_string(fields.get("namespace"), ""),
				_as_string(fields.get("ban"), ""),
				_as_string(fields.get("endDate"), ""),
				_as_string(fields.get("reason"), ""),
				fields.get("enable", false)
			)
		"eventUnbanChat":
			unban_chat_notif.emit(
				_as_string(fields.get("userId"), ""),
				_as_string(fields.get("namespace"), ""),
				_as_string(fields.get("ban"), ""),
				_as_string(fields.get("endDate"), ""),
				_as_string(fields.get("reason"), ""),
				fields.get("enable", false)
			)
		"eventTopicBanChat":
			topic_ban_chat_notif.emit(
				_as_string(fields.get("userId"), ""),
				_as_string(fields.get("topicId"), ""),
				fields.get("enable", false)
			)
		"eventTopicUnbanChat":
			topic_unban_chat_notif.emit(
				_as_string(fields.get("userId"), ""),
				_as_string(fields.get("topicId"), ""),
				fields.get("enable", false)
			)
		"eventTopicUpdated":
			topic_updated_notif.emit(
				_as_string(fields.get("name"), ""),
				_as_string(fields.get("topicId"), ""),
				_as_string(fields.get("senderId"), "")
			)
		"eventUserMuted":
			user_muted_notif.emit(
				_as_string(fields.get("topicId"), ""),
				_as_int(fields.get("remainingTime"), -1),
				_as_int(fields.get("expiredAt"), -1)
			)
		"eventUserUnmuted":
			user_unmuted_notif.emit(_as_string(fields.get("topicId"), ""))
		"eventNewSystemMessage":
			new_system_message_notif.emit(
				_as_string(fields.get("messageId"), ""),
				_as_string(fields.get("category"), ""),
				_as_string(fields.get("message"), ""),
				_as_int(fields.get("createdAt"), -1),
				_as_int(fields.get("expiredAt"), -1)
			)
		"eventServerShutdown":
			server_shutdown_notif.emit()
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
