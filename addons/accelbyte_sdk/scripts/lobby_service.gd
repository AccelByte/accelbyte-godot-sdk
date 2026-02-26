## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## lobby_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-lobby-server
## Version: 3.41.1
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(LobbyService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name LobbyService
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

## get list of friends
## GET /friends/namespaces/{namespace}/me
func get_user_friends_updated(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me"
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

## get list of incoming friends
## GET /friends/namespaces/{namespace}/me/incoming
func get_user_incoming_friends(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/incoming"
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

## get list of incoming friends with requested time info
## GET /friends/namespaces/{namespace}/me/incoming-time
func get_user_incoming_friends_with_time(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/incoming-time"
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

## get list of outgoing friends
## GET /friends/namespaces/{namespace}/me/outgoing
func get_user_outgoing_friends(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/outgoing"
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

## get list of outgoing friends with requested time info
## GET /friends/namespaces/{namespace}/me/outgoing-time
func get_user_outgoing_friends_with_time(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/outgoing-time"
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

## get list of friends with platform data
## GET /friends/namespaces/{namespace}/me/platforms
func get_user_friends_with_platform(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/platforms"
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

## user add friend
## POST /friends/namespaces/{namespace}/me/request
func user_request_friend(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## user accept friend
## POST /friends/namespaces/{namespace}/me/request/accept
func user_accept_friend_request(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request/accept"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## user cancel a friend request
## POST /friends/namespaces/{namespace}/me/request/cancel
func user_cancel_friend_request(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## user reject a friend request
## POST /friends/namespaces/{namespace}/me/request/reject
func user_reject_friend_request(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request/reject"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## user get friendship status
## GET /friends/namespaces/{namespace}/me/status/{friendId}
func user_get_friendship_status(
	friend_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/status/{friendId}"
	url_path = url_path.replace("{" + "friendId" + "}", friend_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## user unfriend a friend
## POST /friends/namespaces/{namespace}/me/unfriend
func user_unfriend_request(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/unfriend"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Add friends without confirmation
## POST /friends/namespaces/{namespace}/users/{userId}/add/bulk
func add_friends_without_confirmation(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/users/{userId}/add/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete friends, and incoming/outgoing friend requests
## POST /friends/namespaces/{namespace}/users/{userId}/delete/bulk
func bulk_delete_friends(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/users/{userId}/delete/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## sync friends using server to server call to native first party server.
## PATCH /friends/sync/namespaces/{namespace}/me
func sync_native_friends(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/sync/namespaces/{namespace}/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## sync blocked user using server to server call to native first party server.
## PATCH /lobby/sync/namespaces/{namespace}/me/block
func sync_native_blocked_user(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/sync/namespaces/{namespace}/me/block"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## admin get all namespaces config
## GET /lobby/v1/admin/config
func admin_get_all_config_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Log Configuration
## GET /lobby/v1/admin/config/log
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Patch Update Log Configuration
## PATCH /lobby/v1/admin/config/log
func admin_patch_update_log_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## admin get namespace config
## GET /lobby/v1/admin/config/namespaces/{namespace}
func admin_get_config_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin update namespace config
## PUT /lobby/v1/admin/config/namespaces/{namespace}
func admin_update_config_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Export lobby config to a json file.
## GET /lobby/v1/admin/config/namespaces/{namespace}/export
func admin_export_config_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Import lobby config from a json file.
## POST /lobby/v1/admin/config/namespaces/{namespace}/import
func admin_import_config_v1(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get list of friends
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}
func get_list_of_friends(
	namespace_param: String,
	user_id: String,
	friend_id: String = "",
	friend_ids: Array = [],
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not friend_id.is_empty():
		query_params["friendId"] = friend_id
	if friend_ids.size() > 0:
		query_params["friendIds"] = friend_ids
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

## get incoming friend requests
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/incoming
func get_incoming_friend_requests(
	namespace_param: String,
	user_id: String,
	friend_id: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/incoming"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not friend_id.is_empty():
		query_params["friendId"] = friend_id
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

## Load list friends of friends
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/of-friends
func admin_list_friends_of_friends(
	namespace_param: String,
	user_id: String,
	friend_id: String = "",
	limit: int = -1,
	nopaging: bool = false,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/of-friends"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not friend_id.is_empty():
		query_params["friendId"] = friend_id
	if limit >= 0:
		query_params["limit"] = limit
	query_params["nopaging"] = nopaging
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get list of outgoing friend requests
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/outgoing
func get_outgoing_friend_requests(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/outgoing"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
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

## Record of global configuration dsmc.
## GET /lobby/v1/admin/global-configurations
## @deprecated
func admin_get_global_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Upsert global configuration data.
## PUT /lobby/v1/admin/global-configurations
## @deprecated
func admin_update_global_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete of global configuration data.
## DELETE /lobby/v1/admin/global-configurations
## @deprecated
func admin_delete_global_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## send freeform notification to multiple users
## POST /lobby/v1/admin/notification/namespaces/{namespace}/bulkUsers/freeform/notify
func send_multiple_users_freeform_notification_v1_admin(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/bulkUsers/freeform/notify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## send freeform notification to connected users
## POST /lobby/v1/admin/notification/namespaces/{namespace}/freeform/notify
func send_users_freeform_notification_v1_admin(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/freeform/notify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## send freeform notification to a party
## POST /lobby/v1/admin/notification/namespaces/{namespace}/parties/{partyId}/freeform/notify
## @deprecated
func send_party_freeform_notification_v1_admin(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/parties/{partyId}/freeform/notify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## send templated notification to a party
## POST /lobby/v1/admin/notification/namespaces/{namespace}/parties/{partyId}/templates/notify
## @deprecated
func send_party_templated_notification_v1_admin(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/parties/{partyId}/templates/notify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get all notification template in a namespace
## GET /lobby/v1/admin/notification/namespaces/{namespace}/templates
func get_all_notification_templates_v1_admin(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## create new notification template
## POST /lobby/v1/admin/notification/namespaces/{namespace}/templates
func create_notification_template_v1_admin(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## send notification to connected users with template
## POST /lobby/v1/admin/notification/namespaces/{namespace}/templates/notify
func send_users_templated_notification_v1_admin(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates/notify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get all notification template localization in a slug
## GET /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}
func get_template_slug_localizations_template_v1_admin(
	namespace_param: String,
	template_slug: String,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## delete template slug in notification template
## DELETE /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}
func delete_notification_template_slug_v1_admin(
	namespace_param: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get a template localization
## GET /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
func get_single_template_localization_v1_admin(
	namespace_param: String,
	template_language: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update template localization
## PUT /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
func update_template_localization_v1_admin(
	namespace_param: String,
	template_language: String,
	template_slug: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete template localization
## DELETE /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
func delete_template_localization_v1_admin(
	namespace_param: String,
	template_language: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## publish template localization draft
## POST /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}/publish
func publish_template_localization_v1_admin(
	namespace_param: String,
	template_language: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}/publish"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get topic by namespace
## GET /lobby/v1/admin/notification/namespaces/{namespace}/topics
func get_all_notification_topics_v1_admin(
	namespace_param: String,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## create new notification topic
## POST /lobby/v1/admin/notification/namespaces/{namespace}/topics
func create_notification_topic_v1_admin(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get topic information by topic name
## GET /lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}
func get_notification_topic_v1_admin(
	namespace_param: String,
	topic_name: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topicName" + "}", topic_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update topic information by topic name
## PUT /lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}
func update_notification_topic_v1_admin(
	namespace_param: String,
	topic_name: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topicName" + "}", topic_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete topic information by topic name
## DELETE /lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}
func delete_notification_topic_v1_admin(
	namespace_param: String,
	topic_name: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topicName" + "}", topic_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## send freeform notification to a user
## POST /lobby/v1/admin/notification/namespaces/{namespace}/users/{userId}/freeform/notify
func send_specific_user_freeform_notification_v1_admin(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/users/{userId}/freeform/notify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## send templated notification to specific user
## POST /lobby/v1/admin/notification/namespaces/{namespace}/users/{userId}/templates/notify
func send_specific_user_templated_notification_v1_admin(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/users/{userId}/templates/notify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get party data
## GET /lobby/v1/admin/party/namespaces/{namespace}/parties/{partyId}
## @deprecated
func admin_get_party_data_v1(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/party/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin update party attributes
## PUT /lobby/v1/admin/party/namespaces/{namespace}/parties/{partyId}/attributes
## @deprecated
func admin_update_party_attributes_v1(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/party/namespaces/{namespace}/parties/{partyId}/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## admin join a player into a party
## POST /lobby/v1/admin/party/namespaces/{namespace}/parties/{partyId}/join/{userId}
## @deprecated
func admin_join_party_v1(
	namespace_param: String,
	party_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/party/namespaces/{namespace}/parties/{partyId}/join/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get user party data
## GET /lobby/v1/admin/party/namespaces/{namespace}/users/{userId}/party
## @deprecated
func admin_get_user_party_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/party/namespaces/{namespace}/users/{userId}/party"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get number of players currently connected to the lobby.
## GET /lobby/v1/admin/player/namespaces/{namespace}/ccu
func admin_get_lobby_ccu(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/ccu"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get blocked players by bulk user ids
## POST /lobby/v1/admin/player/namespaces/{namespace}/users/bulk/blocked
func admin_get_bulk_player_blocked_players_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/bulk/blocked"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get all player's session attribute
## GET /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/attributes
## @deprecated
func admin_get_all_player_session_attribute(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin set player's session attribute
## PUT /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/attributes
## @deprecated
func admin_set_player_session_attribute(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## admin get player's session attribute
## GET /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/attributes/{attribute}
## @deprecated
func admin_get_player_session_attribute(
	attribute: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/attributes/{attribute}"
	url_path = url_path.replace("{" + "attribute" + "}", attribute.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get blocked players by user id
## GET /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/blocked
func admin_get_player_blocked_players_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/blocked"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get players who blocked this player by user id
## GET /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/blocked-by
func admin_get_player_blocked_by_players_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/blocked-by"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin bulk blocks player by list user id
## POST /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/bulk/block
func admin_bulk_block_players_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/bulk/block"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin bulk unblock players by list user id
## DELETE /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/bulk/unblock
func admin_bulk_unblock_players_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/bulk/unblock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get the list of filters that would modify the phrase
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/filters/debug
## @deprecated
func admin_debug_profanity_filters(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/filters/debug"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get the list of filters inside the list
## GET /lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters
## @deprecated
func admin_get_profanity_list_filters_v1(
	list: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters"
	url_path = url_path.replace("{" + "list" + "}", list.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## add a single filter into the list
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters
## @deprecated
func admin_add_profanity_filter_into_list(
	list: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters"
	url_path = url_path.replace("{" + "list" + "}", list.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## add multiple filters into the list
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters/bulk
## @deprecated
func admin_add_profanity_filters(
	list: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters/bulk"
	url_path = url_path.replace("{" + "list" + "}", list.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## import a file with filters
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters/bulk-file
## @deprecated
func admin_import_profanity_filters_from_file(
	list: String,
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters/bulk-file"
	url_path = url_path.replace("{" + "list" + "}", list.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## delete the filter from the list
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters/delete
## @deprecated
func admin_delete_profanity_filter(
	list: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/list/{list}/filters/delete"
	url_path = url_path.replace("{" + "list" + "}", list.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get lists
## GET /lobby/v1/admin/profanity/namespaces/{namespace}/lists
## @deprecated
func admin_get_profanity_lists(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/lists"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## create a new list
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/lists
## @deprecated
func admin_create_profanity_list(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/lists"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## update the list
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/lists/{list}
## @deprecated
func admin_update_profanity_list(
	list: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/lists/{list}"
	url_path = url_path.replace("{" + "list" + "}", list.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## delete a list include all filters inside of it
## DELETE /lobby/v1/admin/profanity/namespaces/{namespace}/lists/{list}
## @deprecated
func admin_delete_profanity_list(
	list: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/lists/{list}"
	url_path = url_path.replace("{" + "list" + "}", list.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get current profanity rule
## GET /lobby/v1/admin/profanity/namespaces/{namespace}/rule
## @deprecated
func admin_get_profanity_rule(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/rule"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## set current profanity rule
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/rule
## @deprecated
func admin_set_profanity_rule_for_namespace(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/rule"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## verify a message directly from the UI or other services
## POST /lobby/v1/admin/profanity/namespaces/{namespace}/verify
## @deprecated
func admin_verify_message_profanity_response(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/profanity/namespaces/{namespace}/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Third Party Steam Config
## GET /lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam
## @deprecated
func admin_get_third_party_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Third Party Steam Config
## PUT /lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam
## @deprecated
func admin_update_third_party_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create Third Party Steam Config
## POST /lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam
## @deprecated
func admin_create_third_party_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Third Party Steam Config
## DELETE /lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam
## @deprecated
func admin_delete_third_party_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/thirdparty/namespaces/{namespace}/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get service messages
## GET /lobby/v1/messages
func public_get_messages() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/messages"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get party data by party id
## GET /lobby/v1/public/party/namespaces/{namespace}/parties/{partyId}
## @deprecated
func public_get_party_data_v1(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/party/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update party attributes
## PUT /lobby/v1/public/party/namespaces/{namespace}/parties/{partyId}/attributes
## @deprecated
func public_update_party_attributes_v1(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/party/namespaces/{namespace}/parties/{partyId}/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## set party limit
## PUT /lobby/v1/public/party/namespaces/{namespace}/parties/{partyId}/limit
## @deprecated
func public_set_party_limit_v1(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/party/namespaces/{namespace}/parties/{partyId}/limit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## block player by user id
## POST /lobby/v1/public/player/namespaces/{namespace}/users/me/block
func public_player_block_players_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/block"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get blocked players by user id
## GET /lobby/v1/public/player/namespaces/{namespace}/users/me/blocked
func public_get_player_blocked_players_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/blocked"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get players who blocked this player by user id
## GET /lobby/v1/public/player/namespaces/{namespace}/users/me/blocked-by
func public_get_player_blocked_by_players_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/blocked-by"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## unblock player by user id
## POST /lobby/v1/public/player/namespaces/{namespace}/users/me/unblock
func public_unblock_player_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/unblock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query users presence
## GET /lobby/v1/public/presence/namespaces/{namespace}/users/presence
func users_presence_handler_v1(
	namespace_param: String,
	user_ids: String,
	count_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/presence/namespaces/{namespace}/users/presence"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["countOnly"] = count_only
	if not user_ids.is_empty():
		query_params["userIds"] = user_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query users presence
## POST /lobby/v1/public/presence/namespaces/{namespace}/users/presence
func users_presence_handler_v2(
	namespace_param: String,
	count_only: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/presence/namespaces/{namespace}/users/presence"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["countOnly"] = count_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## send freeform notification to a user
## POST /notification/namespaces/{namespace}/freeform
func free_form_notification(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/freeform"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get list of notifications
## GET /notification/namespaces/{namespace}/me
func get_my_notifications(
	namespace_param: String,
	end_time: int = -1,
	limit: int = -1,
	offset: int = -1,
	start_time: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if end_time >= 0:
		query_params["endTime"] = end_time
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if start_time >= 0:
		query_params["startTime"] = start_time
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of offline notifications
## GET /notification/namespaces/{namespace}/notification/offline/me
func get_my_offline_notifications(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/notification/offline/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## send notification to a user with template
## POST /notification/namespaces/{namespace}/templated
func notification_with_template(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templated"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get all notification template in a namespace
## GET /notification/namespaces/{namespace}/templates
func get_game_template(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## create new notification template
## POST /notification/namespaces/{namespace}/templates
func create_template(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get all notification template in a slug
## GET /notification/namespaces/{namespace}/templates/{templateSlug}
func get_slug_template(
	namespace_param: String,
	template_slug: String,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates/{templateSlug}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## delete template localization
## DELETE /notification/namespaces/{namespace}/templates/{templateSlug}
func delete_template_slug(
	namespace_param: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates/{templateSlug}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get a template localization
## GET /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
func get_localization_template(
	namespace_param: String,
	template_language: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update template draft
## PUT /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
func update_localization_template(
	namespace_param: String,
	template_language: String,
	template_slug: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete template localization
## DELETE /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
func delete_template_localization(
	namespace_param: String,
	template_language: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## publish draft template
## POST /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}/publish
func publish_template(
	namespace_param: String,
	template_language: String,
	template_slug: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}/publish"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "templateLanguage" + "}", template_language.uri_encode())
	url_path = url_path.replace("{" + "templateSlug" + "}", template_slug.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get topic by namespace
## GET /notification/namespaces/{namespace}/topics
func get_topic_by_namespace(
	namespace_param: String,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## create new notification topic
## POST /notification/namespaces/{namespace}/topics
func create_topic(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get topic information by topic name
## GET /notification/namespaces/{namespace}/topics/{topic}
func get_topic_by_topic_name(
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/topics/{topic}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update topic information by topic name
## PUT /notification/namespaces/{namespace}/topics/{topic}
func update_topic_by_topic_name(
	namespace_param: String,
	topic: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/topics/{topic}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete topic information by topic name
## DELETE /notification/namespaces/{namespace}/topics/{topic}
func delete_topic_by_topic_name(
	namespace_param: String,
	topic: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/topics/{topic}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topic" + "}", topic.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## send freeform notification to a user
## POST /notification/namespaces/{namespace}/users/{userId}/freeform
func free_form_notification_by_user_id(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/users/{userId}/freeform"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## send notification to a user with template
## POST /notification/namespaces/{namespace}/users/{userId}/templated
func notification_with_template_by_user_id(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/users/{userId}/templated"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
