## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## chat_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-chat-service
## Version: staging
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(ChatService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name ChatService
extends RefCounted

## Shared HTTP client (owned by AccelByteSDK, passed via initialize)
var _http: AccelbyteHttp

## Service configuration
var _base_url: String = ""
## Service URL — defaults to _base_url. Override for Extend apps:
##   svc.set_service_url(sdk.get_base_url() + "/your-extend-app-name")
var _service_url: String = ""
var _namespace: String = ""
var _auth_token: String = ""
var _client_id: String = ""

## Token lifecycle callbacks (set by AccelByteSDK)
var _token_callback: Callable
var _revoke_callback: Callable


## Initialize with shared HTTP client.
func initialize(http: AccelbyteHttp) -> void:
	_http = http


func set_base_url(url: String) -> void:
	_base_url = url
	if _base_url.ends_with("/"):
		_base_url = _base_url.substr(0, _base_url.length() - 1)
	if _service_url.is_empty():
		_service_url = _base_url


func set_service_url(url: String) -> void:
	_service_url = url
	if _service_url.ends_with("/"):
		_service_url = _service_url.substr(0, _service_url.length() - 1)


func set_namespace(ns: String) -> void:
	_namespace = ns


func set_auth_token(token: String) -> void:
	_auth_token = token


func set_client_id(id: String) -> void:
	_client_id = id




func set_token_callback(cb: Callable) -> void:
	_token_callback = cb


func set_revoke_callback(cb: Callable) -> void:
	_revoke_callback = cb


# =============================================================================
# API Methods
# =============================================================================

## Return filtered chat message
## POST /chat/admin/namespaces/{namespace}/chat/filter
func admin_filter_chat_message(
	namespace_param: String,
	detail: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/chat/filter"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["detail"] = detail
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get chat history
## GET /chat/admin/namespaces/{namespace}/chats
func admin_chat_history(
	namespace_param: String,
	chat_id: Array = [],
	end_created_at: int = -1,
	keyword: String = "",
	limit: int = -1,
	offset: int = -1,
	order: String = "",
	sender_user_id: String = "",
	shard_id: String = "",
	start_created_at: int = -1,
	topic: Array = [],
	unfiltered: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/chats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if chat_id.size() > 0:
		query_params["chatId"] = chat_id
	if end_created_at >= 0:
		query_params["endCreatedAt"] = end_created_at
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not sender_user_id.is_empty():
		query_params["senderUserId"] = sender_user_id
	if not shard_id.is_empty():
		query_params["shardId"] = shard_id
	if start_created_at >= 0:
		query_params["startCreatedAt"] = start_created_at
	if topic.size() > 0:
		query_params["topic"] = topic
	query_params["unfiltered"] = unfiltered
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Use to create namespace group. Message that send to this group...
## POST /chat/admin/namespaces/{namespace}/namespace-topic
func admin_create_namespace_topic(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/namespace-topic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get list of topic
## GET /chat/admin/namespaces/{namespace}/topic
func admin_topic_list(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	topic_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not topic_type.is_empty():
		query_params["topicType"] = topic_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Use to create group. Only group admin can use this operation
## POST /chat/admin/namespaces/{namespace}/topic
func admin_create_topic(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get list of channel topic
## GET /chat/admin/namespaces/{namespace}/topic/channel
func admin_channel_topic_list(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	topic_name: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/channel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not topic_name.is_empty():
		query_params["topicName"] = topic_name
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get channel topic summary
## GET /chat/admin/namespaces/{namespace}/topic/channel/summary
func admin_channel_topic_summary(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/channel/summary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin query topic log
## GET /chat/admin/namespaces/{namespace}/topic/log
func admin_query_topic_log(
	namespace_param: String,
	end_created_at: int = -1,
	limit: int = -1,
	offset: int = -1,
	sender_user_id: String = "",
	start_created_at: int = -1,
	topic_id: String = "",
	topic_ids: Array = [],
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/log"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if end_created_at >= 0:
		query_params["endCreatedAt"] = end_created_at
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sender_user_id.is_empty():
		query_params["senderUserId"] = sender_user_id
	if start_created_at >= 0:
		query_params["startCreatedAt"] = start_created_at
	if not topic_id.is_empty():
		query_params["topicId"] = topic_id
	if topic_ids.size() > 0:
		query_params["topicIds"] = topic_ids
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Use to update group information. Only group admin can use this operation
## PUT /chat/admin/namespaces/{namespace}/topic/{topic}
func admin_update_topic(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Use to delete group. Only group admin can use this operation
## DELETE /chat/admin/namespaces/{namespace}/topic/{topic}
func admin_delete_topic(
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## admins ban user in group topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/ban-members
func admin_ban_topic_members(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/ban-members"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get channel topic detail
## GET /chat/admin/namespaces/{namespace}/topic/{topic}/channel
func admin_channel_topic_info(
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/channel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get chat history
## GET /chat/admin/namespaces/{namespace}/topic/{topic}/chats
## @deprecated
func admin_topic_chat_history(
	namespace_param: String,
	topic: String,
	end_created_at: int = -1,
	keyword: String = "",
	limit: int = -1,
	offset: int = -1,
	order: String = "",
	sender_user_id: String = "",
	shard_id: String = "",
	start_created_at: int = -1,
	unfiltered: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/chats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if end_created_at >= 0:
		query_params["endCreatedAt"] = end_created_at
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not sender_user_id.is_empty():
		query_params["senderUserId"] = sender_user_id
	if not shard_id.is_empty():
		query_params["shardId"] = shard_id
	if start_created_at >= 0:
		query_params["startCreatedAt"] = start_created_at
	query_params["unfiltered"] = unfiltered
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admins send chat to group topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/chats
func admin_send_chat(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/chats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admins delete chat
## DELETE /chat/admin/namespaces/{namespace}/topic/{topic}/chats/{chatId}
func admin_delete_chat(
	chat_id: String,
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/chats/{chatId}"
	url_path = url_path.replace("{" + "chatId" + "}", chat_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## admin get topic member
## GET /chat/admin/namespaces/{namespace}/topic/{topic}/members
func admin_topic_members(
	namespace_param: String,
	topic: String,
	is_banned: bool = false,
	is_moderator: bool = false,
	limit: int = -1,
	offset: int = -1,
	shard_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/members"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isBanned"] = is_banned
	query_params["isModerator"] = is_moderator
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not shard_id.is_empty():
		query_params["shardId"] = shard_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get shard list of topic
## GET /chat/admin/namespaces/{namespace}/topic/{topic}/shards
func admin_topic_shards(
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/shards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admins unban user in group topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/unban-members
func admin_unban_topic_members(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/unban-members"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin add user to topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/user/{userId}
func admin_add_topic_member(
	namespace_param: String,
	topic: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/user/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin remove user from topic
## DELETE /chat/admin/namespaces/{namespace}/topic/{topic}/user/{userId}
func admin_remove_topic_member(
	namespace_param: String,
	topic: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/{topic}/user/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## admin query topics
## GET /chat/admin/namespaces/{namespace}/topics
func admin_query_topic(
	namespace_param: String,
	include_members: bool = false,
	include_past_members: bool = false,
	include_past_topics: bool = false,
	limit: int = -1,
	offset: int = -1,
	topic: Array = [],
	topic_sub_type: String = "",
	topic_type: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["includeMembers"] = include_members
	query_params["includePastMembers"] = include_past_members
	query_params["includePastTopics"] = include_past_topics
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if topic.size() > 0:
		query_params["topic"] = topic
	if not topic_sub_type.is_empty():
		query_params["topicSubType"] = topic_sub_type
	if not topic_type.is_empty():
		query_params["topicType"] = topic_type
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin query user's topics
## GET /chat/admin/namespaces/{namespace}/users/{userId}/topics
func admin_query_users_topic(
	namespace_param: String,
	user_id: String,
	include_past_topics: bool = false,
	limit: int = -1,
	offset: int = -1,
	topic_sub_type: String = "",
	topic_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/users/{userId}/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["includePastTopics"] = include_past_topics
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not topic_sub_type.is_empty():
		query_params["topicSubType"] = topic_sub_type
	if not topic_type.is_empty():
		query_params["topicType"] = topic_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## public get muted at topics
## GET /chat/public/namespaces/{namespace}/muted
func public_get_muted_topics(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/muted"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## public get list of topic
## GET /chat/public/namespaces/{namespace}/topic
func public_topic_list(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	topic_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/topic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not topic_type.is_empty():
		query_params["topicType"] = topic_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## public ban topic members in a group topic
## POST /chat/public/namespaces/{namespace}/topic/{topic}/ban-members
func public_ban_topic_members(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/topic/{topic}/ban-members"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## public get chat history
## GET /chat/public/namespaces/{namespace}/topic/{topic}/chats
func public_chat_history(
	namespace_param: String,
	topic: String,
	limit: int = -1,
	order: String = "",
	start_created_at: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/topic/{topic}/chats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not order.is_empty():
		query_params["order"] = order
	if start_created_at >= 0:
		query_params["startCreatedAt"] = start_created_at
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## public delete chat
## DELETE /chat/public/namespaces/{namespace}/topic/{topic}/chats/{chatId}
func public_delete_chat(
	chat_id: String,
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/topic/{topic}/chats/{chatId}"
	url_path = url_path.replace("{" + "chatId" + "}", chat_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## public mute user in a topic
## PUT /chat/public/namespaces/{namespace}/topic/{topic}/mute
func public_mute_user(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/topic/{topic}/mute"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## public unban topic members in a group topic
## POST /chat/public/namespaces/{namespace}/topic/{topic}/unban-members
func public_unban_topic_members(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/topic/{topic}/unban-members"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## public unmute user in a topic
## PUT /chat/public/namespaces/{namespace}/topic/{topic}/unmute
func public_unmute_user(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/topic/{topic}/unmute"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## admin get all namespaces config
## GET /chat/v1/admin/config
func admin_get_all_config_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Log Configuration
## GET /chat/v1/admin/config/log
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Patch Update Log Configuration
## PATCH /chat/v1/admin/config/log
func admin_patch_update_log_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## admin get namespace config
## GET /chat/v1/admin/config/namespaces/{namespace}
func admin_get_config_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin update namespace config
## PUT /chat/v1/admin/config/namespaces/{namespace}
func admin_update_config_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Export chat config to a json file.
## GET /chat/v1/admin/config/namespaces/{namespace}/export
func export_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Import chat config from a json file.
## POST /chat/v1/admin/config/namespaces/{namespace}/import
func import_config(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get inbox categories
## GET /chat/v1/admin/inbox/namespaces/{namespace}/categories
func admin_get_inbox_categories(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/categories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## add inbox category
## POST /chat/v1/admin/inbox/namespaces/{namespace}/categories
func admin_add_inbox_category(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/categories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin delete inbox category
## DELETE /chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}
func admin_delete_inbox_category(
	category: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}"
	url_path = url_path.replace("{" + "category" + "}", category.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## admin update inbox category
## PATCH /chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}
func admin_update_inbox_category(
	category: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}"
	url_path = url_path.replace("{" + "category" + "}", category.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## admin get category schema
## GET /chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}/schema.json
func admin_get_category_schema(
	category: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}/schema.json"
	url_path = url_path.replace("{" + "category" + "}", category.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get list kafka topic
## GET /chat/v1/admin/inbox/namespaces/{namespace}/list/topic/kafka
func admin_list_kafka_topic(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/list/topic/kafka"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin delete inbox message
## DELETE /chat/v1/admin/inbox/namespaces/{namespace}/message/{messageId}
func admin_delete_inbox_message(
	message_id: String,
	namespace_param: String,
	force: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/message/{messageId}"
	url_path = url_path.replace("{" + "messageId" + "}", message_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["force"] = force
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## admin get inbox messages
## GET /chat/v1/admin/inbox/namespaces/{namespace}/messages
func admin_get_inbox_messages(
	namespace_param: String,
	active_only: bool = false,
	end_created_at: int = -1,
	limit: int = -1,
	message_id: Array = [],
	offset: int = -1,
	order: String = "",
	scope: String = "",
	start_created_at: int = -1,
	status: String = "",
	transient: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/messages"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if end_created_at >= 0:
		query_params["endCreatedAt"] = end_created_at
	if limit >= 0:
		query_params["limit"] = limit
	if message_id.size() > 0:
		query_params["messageId"] = message_id
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not scope.is_empty():
		query_params["scope"] = scope
	if start_created_at >= 0:
		query_params["startCreatedAt"] = start_created_at
	if not status.is_empty():
		query_params["status"] = status
	query_params["transient"] = transient
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin save inbox message
## POST /chat/v1/admin/inbox/namespaces/{namespace}/messages
func admin_save_inbox_message(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/messages"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin unsend inbox message
## POST /chat/v1/admin/inbox/namespaces/{namespace}/messages/{inbox}/unsend
func admin_unsend_inbox_message(
	inbox: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/messages/{inbox}/unsend"
	url_path = url_path.replace("{" + "inbox" + "}", inbox.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get inbox users
## GET /chat/v1/admin/inbox/namespaces/{namespace}/messages/{inbox}/users
func admin_get_inbox_users(
	inbox: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	status: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/messages/{inbox}/users"
	url_path = url_path.replace("{" + "inbox" + "}", inbox.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not status.is_empty():
		query_params["status"] = status
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin update inbox message
## PATCH /chat/v1/admin/inbox/namespaces/{namespace}/messages/{messageId}
func admin_update_inbox_message(
	message_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/messages/{messageId}"
	url_path = url_path.replace("{" + "messageId" + "}", message_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## admin send inbox message
## POST /chat/v1/admin/inbox/namespaces/{namespace}/messages/{messageId}/send
func admin_send_inbox_message(
	message_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/messages/{messageId}/send"
	url_path = url_path.replace("{" + "messageId" + "}", message_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get inbox stats
## GET /chat/v1/admin/inbox/namespaces/{namespace}/stats
func admin_get_inbox_stats(
	namespace_param: String,
	message_id: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/stats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if message_id.size() > 0:
		query_params["messageId"] = message_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get chat snapshot
## GET /chat/v1/admin/namespaces/{namespace}/snapshot/{chatId}
func admin_get_chat_snapshot(
	chat_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/namespaces/{namespace}/snapshot/{chatId}"
	url_path = url_path.replace("{" + "chatId" + "}", chat_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin delete chat snapshot
## DELETE /chat/v1/admin/namespaces/{namespace}/snapshot/{chatId}
func admin_delete_chat_snapshot(
	chat_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/namespaces/{namespace}/snapshot/{chatId}"
	url_path = url_path.replace("{" + "chatId" + "}", chat_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## admin query profanity words
## GET /chat/v1/admin/profanity/namespaces/{namespace}/dictionary
func admin_profanity_query(
	namespace_param: String,
	filter_mask: String = "",
	include_children: bool = false,
	limit: int = -1,
	offset: int = -1,
	parent_id: String = "",
	start_with: String = "",
	word_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not filter_mask.is_empty():
		query_params["filterMask"] = filter_mask
	query_params["includeChildren"] = include_children
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not parent_id.is_empty():
		query_params["parentId"] = parent_id
	if not start_with.is_empty():
		query_params["startWith"] = start_with
	if not word_type.is_empty():
		query_params["wordType"] = word_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin insert new profanity words
## POST /chat/v1/admin/profanity/namespaces/{namespace}/dictionary
func admin_profanity_create(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin bulk insert new profanity words
## POST /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/bulk
func admin_profanity_create_bulk(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin export profanity words
## GET /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/export
func admin_profanity_export(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get profanity words group
## GET /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/group
func admin_profanity_group(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/group"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin import profanity words
## POST /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/import
func admin_profanity_import(
	namespace_param: String,
	file: String,
	action: String = "",
	show_result: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not action.is_empty():
		query_params["action"] = action
	query_params["showResult"] = show_result
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin update profanity word
## PUT /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/{id}
func admin_profanity_update(
	id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## admin delete profanity words
## DELETE /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/{id}
func admin_profanity_delete(
	id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get service messages
## GET /chat/v1/messages
func public_get_messages() -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/messages"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## public get namespace config
## GET /chat/v1/public/config/namespaces/{namespace}
func public_get_config_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/public/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## public get chat snapshot
## GET /chat/v1/public/namespaces/{namespace}/topic/{topic}/snapshot/{chatId}
func public_get_chat_snapshot(
	chat_id: String,
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/public/namespaces/{namespace}/topic/{topic}/snapshot/{chatId}"
	url_path = url_path.replace("{" + "chatId" + "}", chat_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
