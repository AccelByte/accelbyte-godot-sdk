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


## Returns a filtered chat message with profanity analysis
## POST /chat/admin/namespaces/{namespace}/chat/filter
##
## For testing purpose, doesn't send any message to the topic. Always do filter regardless of enableProfanityFilter configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - detail: Includes filter driver details in the response when set to true.
func admin_filter_chat_message(
	namespace_param: String, detail: bool = false, body: Dictionary = {}
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


## Retrieves chat message history across all topics in a namespace
## GET /chat/admin/namespaces/{namespace}/chats
##
## Retrieves the message history across all topics in a namespace. Supports offset/limit pagination; use the `next` and `previous` cursor fields in the response to navigate pages.
##
## Parameters:
## - namespace_param: Game namespace
## - chat_id: Filters results to messages with the specified chat IDs.
## - end_created_at: End date
## - keyword: Keyword containing in message
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order: Sort order for results. Valid values: createdAt:asc, createdAt:desc.
## - sender_user_id: Filters results to messages sent by this user.
## - shard_id: Filters results to messages from the specified shard.
## - start_created_at: Start date
## - topic: Topic ID that receives the chat
## - unfiltered: Unfiltered chat messages
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


## Creates a namespace group topic
## POST /chat/admin/namespaces/{namespace}/namespace-topic
##
## Create new namespace group topic in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_namespace_topic(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/namespace-topic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists chat topics in a namespace
## GET /chat/admin/namespaces/{namespace}/topic
##
## Lists chat topics in a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - topic_type: PERSONAL or GROUP
func admin_topic_list(
	namespace_param: String, limit: int = -1, offset: int = -1, topic_type: String = ""
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


## Creates a group chat topic
## POST /chat/admin/namespaces/{namespace}/topic
##
## Create new group topic in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_topic(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists channel chat topics in a namespace
## GET /chat/admin/namespaces/{namespace}/topic/channel
##
## Lists channel-type chat topics in a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - topic_name: Filters results to topics whose name contains this string.
func admin_channel_topic_list(
	namespace_param: String, limit: int = -1, offset: int = -1, topic_name: String = ""
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


## Retrieves a summary of channel topics in a namespace
## GET /chat/admin/namespaces/{namespace}/topic/channel/summary
##
## Returns aggregated statistics and metadata for channel topics in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_channel_topic_summary(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/admin/namespaces/{namespace}/topic/channel/summary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Queries the topic activity log for a namespace
## GET /chat/admin/namespaces/{namespace}/topic/log
##
## Queries the topic activity log for a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - end_created_at: End date
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sender_user_id: User ID of the message sender to filter results by.
## - start_created_at: Start date
## - topic_id: Filters results to the specified topic.
## - topic_ids: Filters results to the specified topics.
## - user_id: AccelByte user ID
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


## Updates group topic information
## PUT /chat/admin/namespaces/{namespace}/topic/{topic}
##
## Update group topic in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that receives the chat
func admin_update_topic(
	namespace_param: String, topic: String, body: Dictionary = {}
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


## Deletes a group chat topic
## DELETE /chat/admin/namespaces/{namespace}/topic/{topic}
##
## Delete topic in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that receives the chat
func admin_delete_topic(namespace_param: String, topic: String) -> Dictionary:
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


## Bans users from a group topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/ban-members
##
## Ban users in some topic. banned user not assigned to shard for channel topic, and cannot send and query chat.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that receives the chat
func admin_ban_topic_members(
	namespace_param: String, topic: String, body: Dictionary = {}
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


## Retrieves details of a channel topic
## GET /chat/admin/namespaces/{namespace}/topic/{topic}/channel
##
## Returns configuration and metadata for the specified channel topic, including its settings and current state.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
func admin_channel_topic_info(namespace_param: String, topic: String) -> Dictionary:
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


## Sends a system message to a group topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/chats
##
## Send message to chat topic as system.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that receives the chat
func admin_send_chat(namespace_param: String, topic: String, body: Dictionary = {}) -> Dictionary:
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


## Deletes a chat message from a topic
## DELETE /chat/admin/namespaces/{namespace}/topic/{topic}/chats/{chatId}
##
## Delete chat.
##
## Parameters:
## - chat_id: Chat ID od the chat
## - namespace_param: Game namespace
## - topic: Topic ID of the chat
func admin_delete_chat(chat_id: String, namespace_param: String, topic: String) -> Dictionary:
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


## Lists members of a topic
## GET /chat/admin/namespaces/{namespace}/topic/{topic}/members
##
## Lists members of a topic. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
## - is_banned: Only show banned member
## - is_moderator: Only show moderator member
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - shard_id: Filters results to members on the specified shard.
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


## Lists shards for a topic
## GET /chat/admin/namespaces/{namespace}/topic/{topic}/shards
##
## Get shard list from topic.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
func admin_topic_shards(namespace_param: String, topic: String) -> Dictionary:
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


## Unbans users from a group topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/unban-members
##
## Unban users in some topic.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that receives the chat
func admin_unban_topic_members(
	namespace_param: String, topic: String, body: Dictionary = {}
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


## Adds a user to a topic
## POST /chat/admin/namespaces/{namespace}/topic/{topic}/user/{userId}
##
## Add new member for topic in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that will added user to
## - user_id: AccelByte user ID
func admin_add_topic_member(
	namespace_param: String, topic: String, user_id: String, body: Dictionary = {}
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


## Removes a user from a topic
## DELETE /chat/admin/namespaces/{namespace}/topic/{topic}/user/{userId}
##
## Remove member from topic in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that will removed user from
## - user_id: AccelByte user ID
func admin_remove_topic_member(
	namespace_param: String, topic: String, user_id: String
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


## Lists topics in a namespace
## GET /chat/admin/namespaces/{namespace}/topics
##
## Lists topics in a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - include_members: Include topic's members
## - include_past_members: Include past members (user that had left topic)
## - include_past_topics: Includes soft-deleted topics in the results.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - topic: Filters results to the specified topic ID.
## - topic_sub_type: Filters results to topics with the specified sub-type.
## - topic_type: Filters results to topics with the specified type.
## - user_id: AccelByte user ID
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


## Lists topics a user belongs to
## GET /chat/admin/namespaces/{namespace}/users/{userId}/topics
##
## Lists topics a user belongs to in a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - include_past_topics: When true will include topics that user already left
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - topic_sub_type: Filters results to topics with the specified sub-type.
## - topic_type: Filters results to topics with the specified type.
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


## Retrieves topics where the current user is muted
## GET /chat/public/namespaces/{namespace}/muted
##
## Get chat muted topics in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_muted_topics(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/public/namespaces/{namespace}/muted"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists chat topics in a namespace
## GET /chat/public/namespaces/{namespace}/topic
##
## Lists chat topics in a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - topic_type: PERSONAL or GROUP
func public_topic_list(
	namespace_param: String, limit: int = -1, offset: int = -1, topic_type: String = ""
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


## Bans members from a group topic
## POST /chat/public/namespaces/{namespace}/topic/{topic}/ban-members
##
## Ban topic members in a group topic.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
func public_ban_topic_members(
	namespace_param: String, topic: String, body: Dictionary = {}
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


## Retrieves chat message history for a topic
## GET /chat/public/namespaces/{namespace}/topic/{topic}/chats
##
## Get chat history in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic ID that receives the chat
## - limit: Number of results to return
## - order: Sort order for results. Valid values: createdAt:asc, createdAt:desc.
## - start_created_at: Filters results to messages created at or after this Unix timestamp (milliseconds).
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


## Deletes a chat message
## DELETE /chat/public/namespaces/{namespace}/topic/{topic}/chats/{chatId}
##
## Delete chat.
##
## Parameters:
## - chat_id: Chat ID od the chat
## - namespace_param: Game namespace
## - topic: Topic ID of the chat
func public_delete_chat(chat_id: String, namespace_param: String, topic: String) -> Dictionary:
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


## Mutes a topic member for the given duration
## PUT /chat/public/namespaces/{namespace}/topic/{topic}/mute
##
## Mute user.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
func public_mute_user(namespace_param: String, topic: String, body: Dictionary = {}) -> Dictionary:
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


## Unbans members from a group topic
## POST /chat/public/namespaces/{namespace}/topic/{topic}/unban-members
##
## Unban topic members in a group topic.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
func public_unban_topic_members(
	namespace_param: String, topic: String, body: Dictionary = {}
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


## Removes the mute from a topic member
## PUT /chat/public/namespaces/{namespace}/topic/{topic}/unmute
##
## Unmute user.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
func public_unmute_user(
	namespace_param: String, topic: String, body: Dictionary = {}
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


## Retrieves configuration for all namespaces
## GET /chat/v1/admin/config
##
## Get chat config of all namespaces.
func admin_get_all_config_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the log configuration
## GET /chat/v1/admin/config/log
##
## Returns the current log configuration for the chat service, including log levels, socket logging, and database query logging settings.
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the log configuration
## PATCH /chat/v1/admin/config/log
##
## Updates the log configuration for the chat service. Omit fields to perform a partial update.
func admin_patch_update_log_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves the chat configuration for a namespace
## GET /chat/v1/admin/config/namespaces/{namespace}
##
## Get chat config of a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_config_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the chat configuration for a namespace
## PUT /chat/v1/admin/config/namespaces/{namespace}
##
## Update chat config of a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_config_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Exports the chat configuration to a JSON file
## GET /chat/v1/admin/config/namespaces/{namespace}/export
##
## Exports the chat configuration for a namespace as a JSON file. The exported file can be re-imported using the import operation.
##
## Parameters:
## - namespace_param: Game namespace
func export_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Imports chat configuration from a JSON file
## POST /chat/v1/admin/config/namespaces/{namespace}/import
##
## Imports chat configuration from a JSON file, replacing the existing configuration. Use the export operation to download a file in the correct format.
##
## Parameters:
## - namespace_param: Game namespace
## - file: The JSON configuration file to import.
func import_config(namespace_param: String, file: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/config/namespaces/{namespace}/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves inbox categories for a namespace
## GET /chat/v1/admin/inbox/namespaces/{namespace}/categories
##
## Returns all inbox message categories configured for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_inbox_categories(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/categories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Adds an inbox category
## POST /chat/v1/admin/inbox/namespaces/{namespace}/categories
##
## Add inbox category.
##
## Parameters:
## - namespace_param: Game namespace
func admin_add_inbox_category(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/categories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes an inbox category
## DELETE /chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}
##
## Permanently removes the specified inbox category from the namespace.
##
## Parameters:
## - category: Name of the category to delete.
## - namespace_param: Game namespace
func admin_delete_inbox_category(category: String, namespace_param: String) -> Dictionary:
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


## Updates an inbox category
## PATCH /chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}
##
## Update inbox category
##
## Parameters:
## - category: Name of the category to update.
## - namespace_param: Game namespace
func admin_update_inbox_category(
	category: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves the schema for an inbox category
## GET /chat/v1/admin/inbox/namespaces/{namespace}/categories/{category}/schema.json
##
## Get category schema.
##
## Parameters:
## - category: Name of the category.
## - namespace_param: Game namespace
func admin_get_category_schema(category: String, namespace_param: String) -> Dictionary:
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


## Lists Kafka topics for inbox notifications
## GET /chat/v1/admin/inbox/namespaces/{namespace}/list/topic/kafka
##
## Get list kafka topic. example result chat,sessionNotification
##
## Parameters:
## - namespace_param: Game namespace
func admin_list_kafka_topic(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/list/topic/kafka"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes an inbox message
## DELETE /chat/v1/admin/inbox/namespaces/{namespace}/message/{messageId}
##
## Delete inbox message
##
## Parameters:
## - message_id: Unique identifier of the inbox message.
## - namespace_param: Game namespace
## - force: Only for testing purposes, to force delete data
func admin_delete_inbox_message(
	message_id: String, namespace_param: String, force: bool = false
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


## Lists inbox messages for a namespace
## GET /chat/v1/admin/inbox/namespaces/{namespace}/messages
##
## Lists inbox messages for a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: When true, returns only active messages.
## - end_created_at: Upper bound for the message creation timestamp (Unix epoch).
## - limit: Number of results to return
## - message_id: Filters results to the specified message IDs.
## - offset: Number of results to skip for pagination
## - order: Sort order for results. Valid values: createdAt:asc, createdAt:desc.
## - scope: Message scope
## - start_created_at: Lower bound for the message creation timestamp (Unix epoch).
## - status: Message status
## - transient: Transient message filter
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


## Creates an inbox message
## POST /chat/v1/admin/inbox/namespaces/{namespace}/messages
##
## Save inbox message
##
## Parameters:
## - namespace_param: Game namespace
func admin_save_inbox_message(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/inbox/namespaces/{namespace}/messages"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retracts an inbox message from specified recipients
## POST /chat/v1/admin/inbox/namespaces/{namespace}/messages/{inbox}/unsend
##
## Unsend inbox message
##
## Parameters:
## - inbox: Message
## - namespace_param: Game namespace
func admin_unsend_inbox_message(
	inbox: String, namespace_param: String, body: Dictionary = {}
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


## Lists users who received an inbox message
## GET /chat/v1/admin/inbox/namespaces/{namespace}/messages/{inbox}/users
##
## Lists users who received an inbox message. Supports offset/limit pagination.
##
## Parameters:
## - inbox: Message id
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Message status
## - user_id: AccelByte user ID
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


## Updates an inbox message
## PATCH /chat/v1/admin/inbox/namespaces/{namespace}/messages/{messageId}
##
## Update inbox message
##
## Parameters:
## - message_id: Unique identifier of the inbox message.
## - namespace_param: Game namespace
func admin_update_inbox_message(
	message_id: String, namespace_param: String, body: Dictionary = {}
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


## Sends an inbox message to its recipients
## POST /chat/v1/admin/inbox/namespaces/{namespace}/messages/{messageId}/send
##
## Send inbox message
##
## Parameters:
## - message_id: Unique identifier of the inbox message to send.
## - namespace_param: Game namespace
func admin_send_inbox_message(
	message_id: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves inbox statistics for specified messages
## GET /chat/v1/admin/inbox/namespaces/{namespace}/stats
##
## Get inbox stats
##
## Parameters:
## - namespace_param: Game namespace
## - message_id: Filters stats to the specified message IDs.
func admin_get_inbox_stats(namespace_param: String, message_id: Array = []) -> Dictionary:
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


## Retrieves a chat snapshot
## GET /chat/v1/admin/namespaces/{namespace}/snapshot/{chatId}
##
## Get the chat snapshot
##
## Parameters:
## - chat_id: Unique identifier of the chat.
## - namespace_param: Game namespace
func admin_get_chat_snapshot(chat_id: String, namespace_param: String) -> Dictionary:
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


## Deletes a chat snapshot
## DELETE /chat/v1/admin/namespaces/{namespace}/snapshot/{chatId}
##
## Delete the chat snapshot
##
## Parameters:
## - chat_id: Unique identifier of the chat.
## - namespace_param: Game namespace
func admin_delete_chat_snapshot(chat_id: String, namespace_param: String) -> Dictionary:
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


## Queries the profanity word dictionary
## GET /chat/v1/admin/profanity/namespaces/{namespace}/dictionary
##
## Queries the profanity word dictionary for a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - filter_mask: Glob pattern to filter words by.
## - include_children: Include false positives and false negatives
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - parent_id: Parent ID of the word
## - start_with: Word start with
## - word_type: The word classification. Valid values: PROFANITY, FALSEPOSITIVE, FALSENEGATIVE.
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


## Adds a profanity word to the namespace dictionary
## POST /chat/v1/admin/profanity/namespaces/{namespace}/dictionary
##
## Insert new word for profanity censor
##
## Parameters:
## - namespace_param: Game namespace
func admin_profanity_create(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Adds profanity words to the namespace dictionary in bulk
## POST /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/bulk
##
## Bulk insert new word for profanity censor
##
## Parameters:
## - namespace_param: Game namespace
func admin_profanity_create_bulk(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Exports profanity words from the dictionary
## GET /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/export
##
## Export profanity words
##
## Parameters:
## - namespace_param: Game namespace
func admin_profanity_export(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/admin/profanity/namespaces/{namespace}/dictionary/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists profanity word groups
## GET /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/group
##
## Lists profanity word groups for a namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_profanity_group(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Imports profanity words from a file
## POST /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/import
##
## Import profanity words
##
## Parameters:
## - namespace_param: Game namespace
## - action: Conflict resolution strategy for duplicate words. Valid values: REPLACE (update existing), FULLREPLACE (replace all and remove non-imported), LEAVEOUT (skip duplicates).
## - show_result: When true, returns the list of imported words in the response.
## - file: The profanity word list file to import.
func admin_profanity_import(
	namespace_param: String, file: String, action: String = "", show_result: bool = false
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


## Updates a profanity word in the dictionary
## PUT /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/{id}
##
## Update profanity word
##
## Parameters:
## - id: Id of the dictionary
## - namespace_param: Game namespace
func admin_profanity_update(
	id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a profanity word from the dictionary
## DELETE /chat/v1/admin/profanity/namespaces/{namespace}/dictionary/{id}
##
## Delete profanity words.
##
## Parameters:
## - id: Id of the dictionary
## - namespace_param: Game namespace
func admin_profanity_delete(id: String, namespace_param: String) -> Dictionary:
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


## Retrieves service-level messages
## GET /chat/v1/messages
##
## Get the list of messages.
func public_get_messages() -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/messages"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the public chat configuration for a namespace
## GET /chat/v1/public/config/namespaces/{namespace}
##
## Get chat config of a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_config_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/chat/v1/public/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a chat snapshot
## GET /chat/v1/public/namespaces/{namespace}/topic/{topic}/snapshot/{chatId}
##
## Get the chat snapshot
##
## Parameters:
## - chat_id: Unique identifier of the chat.
## - namespace_param: Game namespace
## - topic: Unique identifier of the topic.
func public_get_chat_snapshot(
	chat_id: String, namespace_param: String, topic: String
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
