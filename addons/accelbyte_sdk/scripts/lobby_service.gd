## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## lobby_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-lobby-server
## Version: 3.45.2
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


## Lists friends in the current user's namespace
## GET /friends/namespaces/{namespace}/me
##
## Lists friends in the current user's namespace. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_friends_updated(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists incoming friend requests for the current user
## GET /friends/namespaces/{namespace}/me/incoming
##
## Lists pending incoming friend requests for the current user in the namespace. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_incoming_friends(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists incoming friend requests with timestamp data for the current user
## GET /friends/namespaces/{namespace}/me/incoming-time
##
## Lists pending incoming friend requests for the current user, including the timestamp when the sender submitted each request. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_incoming_friends_with_time(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists outgoing friend requests sent by the current user
## GET /friends/namespaces/{namespace}/me/outgoing
##
## Lists pending outgoing friend requests sent by the current user. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_outgoing_friends(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists outgoing friend requests with timestamp data for the current user
## GET /friends/namespaces/{namespace}/me/outgoing-time
##
## Lists pending outgoing friend requests the current user sent, including the timestamp when each request was submitted. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_outgoing_friends_with_time(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists friends with linked platform account data for the current user
## GET /friends/namespaces/{namespace}/me/platforms
##
## Lists the current user's friends along with their linked third-party platform accounts. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_friends_with_platform(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Sends a friend request to another user
## POST /friends/namespaces/{namespace}/me/request
##
## Sends a friend request to the specified user. Provide either `friendID` or `friendPublicID`; if both are present, `friendID` takes precedence. The request remains pending until accepted or rejected. Optionally include metadata, which is delivered in the friend request notification.
##
## Parameters:
## - namespace_param: Game namespace
func user_request_friend(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Accepts a pending incoming friend request
## POST /friends/namespaces/{namespace}/me/request/accept
##
## Accepts a pending incoming friend request from another user.
##
## Parameters:
## - namespace_param: Game namespace
func user_accept_friend_request(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request/accept"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Cancels an outgoing friend request
## POST /friends/namespaces/{namespace}/me/request/cancel
##
## Cancels a previously sent outgoing friend request.
##
## Parameters:
## - namespace_param: Game namespace
func user_cancel_friend_request(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Rejects an incoming friend request
## POST /friends/namespaces/{namespace}/me/request/reject
##
## Rejects a pending incoming friend request from another user.
##
## Parameters:
## - namespace_param: Game namespace
func user_reject_friend_request(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/request/reject"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the friendship status with a specified user
## GET /friends/namespaces/{namespace}/me/status/{friendId}
##
## Returns the friendship status between the current user and the specified user.
##
## Status codes:
## - `0` â not friends
## - `1` â outgoing request sent
## - `2` â incoming request received
## - `3` â friends
##
## Parameters:
## - friend_id: AccelByte user ID of the friend whose relationship status to retrieve.
## - namespace_param: Game namespace
func user_get_friendship_status(friend_id: String, namespace_param: String) -> Dictionary:
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


## Removes a user from the current user's friend list
## POST /friends/namespaces/{namespace}/me/unfriend
##
## Removes the specified user from the current user's friend list.
##
## Parameters:
## - namespace_param: Game namespace
func user_unfriend_request(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/namespaces/{namespace}/me/unfriend"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Adds users as friends in bulk without requiring confirmation
## POST /friends/namespaces/{namespace}/users/{userId}/add/bulk
##
## Adds one or more users as friends in bulk without requiring confirmation from the target users.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func add_friends_without_confirmation(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes friends and removes related friend requests in bulk
## POST /friends/namespaces/{namespace}/users/{userId}/delete/bulk
##
## Removes one or more users from the friend list and deletes any related pending friend requests in bulk.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_delete_friends(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs the current user's friend list with linked native first-party platform accounts
## PATCH /friends/sync/namespaces/{namespace}/me
##
## Syncs the current user's friend list with their linked native first-party platform accounts. Supported platforms: steam (uses a binary platform ticket), ps4, ps5, and pspc (use an authorization code from Sony OAuth).
##
## Parameters:
## - namespace_param: Game namespace
func sync_native_friends(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/friends/sync/namespaces/{namespace}/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Syncs the current user's blocked list with linked native first-party platform accounts
## PATCH /lobby/sync/namespaces/{namespace}/me/block
##
## Sync blocked user using server to server call to native first party server.
## Supported platforms:
## ps5, ps4 and pspc : the default environment would be sp-int, can be override using psnEnv.
## psnEnv consist of sp-int (default), prod-qa, np
##
## Parameters:
## - namespace_param: Game namespace
func sync_native_blocked_user(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/sync/namespaces/{namespace}/me/block"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves configuration for all namespaces
## GET /lobby/v1/admin/config
##
## Get lobby config of all namespaces. default MaxDSWaitTime is 120 (second)
func admin_get_all_config_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the current log configuration
## GET /lobby/v1/admin/config/log
##
## Get Log Configuration
## logLevel use for logging in service, the value can use is trace|debug|info|warning|error|fatal|panic
## socketLogEnabled is use for enable socket log
## logLevelDB use for logging in DB, the value can use is trace|debug|info|warning|error|fatal|panic
## slowQueryThreshold use for logging slow threshold in time measure is nano second
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the log configuration
## PATCH /lobby/v1/admin/config/log
##
## Update Log Configuration
## logLevel use for logging in service, the value can use is trace|debug|info|warning|error|fatal|panic
## socketLogEnabled is use for enable socket log
## logLevelDB use for logging in DB, the value can use is trace|debug|info|warning|error|fatal|panic
## slowQueryThreshold use for logging slow threshold in time measure is nano second
func admin_patch_update_log_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves the configuration for a specified namespace
## GET /lobby/v1/admin/config/namespaces/{namespace}
##
## Get lobby config of a namespace. default MaxDSWaitTime is 120 (second)
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_config_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the configuration for a specified namespace
## PUT /lobby/v1/admin/config/namespaces/{namespace}
##
## Updates the lobby configuration for a namespace. MaxDSWaitTime must not be less than 1; if null, it defaults to 120 seconds.
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_config_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Exports the lobby configuration to a JSON file
## GET /lobby/v1/admin/config/namespaces/{namespace}/export
##
## Exports the lobby configuration for the namespace to a JSON file. The exported file can be re-imported using the import operation.
##
## Parameters:
## - namespace_param: Game namespace
func admin_export_config_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Imports lobby configuration from a JSON file
## POST /lobby/v1/admin/config/namespaces/{namespace}/import
##
## Imports lobby configuration from a JSON file, replacing the existing configuration. Use the export operation to generate the import file. The `MaxDSWaitTime` value must be at least 1; if omitted, it defaults to 120 seconds.
##
## Parameters:
## - namespace_param: Game namespace
## - file: Configuration JSON file to import.
func admin_import_config_v1(namespace_param: String, file: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/config/namespaces/{namespace}/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists friends for a specified user
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}
##
## Lists friends for the specified user in the namespace. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - friend_id: Friend userId
## - friend_ids: Friend userIds
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Lists incoming friend requests for a specified user
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/incoming
##
## Lists pending incoming friend requests for the specified user. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - friend_id: Friend userId
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Lists friends and friends of friends for a specified user
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/of-friends
##
## Lists the friends and friends-of-friends for the specified user in the namespace. Supports offset/limit pagination. The `subjectId` in the response may differ from the requested `userId` when the user is not a direct friend.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - friend_id: Friend userId to check if the user is friend of friend
## - limit: Number of results to return
## - nopaging: No paging for faster performance, next will always empty regardless of the data
## - offset: Number of results to skip for pagination
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


## Lists outgoing friend requests for a specified user
## GET /lobby/v1/admin/friend/namespaces/{namespace}/users/{userId}/outgoing
##
## Lists pending outgoing friend requests for the specified user. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_outgoing_friend_requests(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Sends a freeform notification to a list of users
## POST /lobby/v1/admin/notification/namespaces/{namespace}/bulkUsers/freeform/notify
##
## Sends a freeform notification to a list of users in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func send_multiple_users_freeform_notification_v1_admin(
	namespace_param: String, body: Dictionary = {}
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


## Sends a freeform notification to all connected users
## POST /lobby/v1/admin/notification/namespaces/{namespace}/freeform/notify
##
## Sends a freeform notification to all currently connected users in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func send_users_freeform_notification_v1_admin(
	namespace_param: String, body: Dictionary = {}
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


## Lists all notification templates in the namespace
## GET /lobby/v1/admin/notification/namespaces/{namespace}/templates
##
## Lists all notification templates in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func get_all_notification_templates_v1_admin(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/notification/namespaces/{namespace}/templates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a new notification template
## POST /lobby/v1/admin/notification/namespaces/{namespace}/templates
##
## Creates a new notification template. Use `{{key}}` placeholders in the template body for values to substitute when sending. A slug and language uniquely identify each template; creating a duplicate slug/language combination is not allowed.
##
## Parameters:
## - namespace_param: Game namespace
func create_notification_template_v1_admin(
	namespace_param: String, body: Dictionary = {}
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


## Sends a templated notification to all connected users
## POST /lobby/v1/admin/notification/namespaces/{namespace}/templates/notify
##
## Sends a notification to all connected users using a predefined template. Specify the template slug and language in the request. Use the context map to provide values for each template variable defined in the template. Publish the template before use.
##
## Parameters:
## - namespace_param: Game namespace
func send_users_templated_notification_v1_admin(
	namespace_param: String, body: Dictionary = {}
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


## Lists all localisations for a notification template
## GET /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}
##
## Lists all language localisations for the specified notification template.
##
## Parameters:
## - namespace_param: Game namespace
## - template_slug: Identifier of the notification template to retrieve localisations for.
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
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


## Deletes a notification template and all its localisations
## DELETE /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}
##
## Deletes the specified notification template and all associated language localisations.
##
## Parameters:
## - namespace_param: Game namespace
## - template_slug: Identifier of the notification template to delete.
func delete_notification_template_slug_v1_admin(
	namespace_param: String, template_slug: String
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


## Retrieves a notification template localisation
## GET /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
##
## Retrieves the specified language localisation for a notification template.
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Template language, follows IETF BCP 47 standard
## - template_slug: Template slug. Accepts only alphabetical characters and hyphens.
func get_single_template_localization_v1_admin(
	namespace_param: String, template_language: String, template_slug: String
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


## Updates a notification template localisation
## PUT /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
##
## Updates the specified language localisation for a notification template.
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Template language, follows IETF BCP 47 standard
## - template_slug: Template slug. Accepts only alphabetical characters and hyphens.
func update_template_localization_v1_admin(
	namespace_param: String, template_language: String, template_slug: String, body: Dictionary = {}
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


## Deletes a notification template localisation
## DELETE /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
##
## Deletes the specified language localisation from a notification template.
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Template language, follows IETF BCP 47 standard
## - template_slug: Template slug. Accepts only alphabetical characters and hyphens.
func delete_template_localization_v1_admin(
	namespace_param: String, template_language: String, template_slug: String
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


## Publishes a notification template localisation draft
## POST /lobby/v1/admin/notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}/publish
##
## Publishes the notification template localisation draft. An empty draft will fail to publish.
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Template language, follows IETF BCP 47 standard
## - template_slug: Template slug. Accepts only alphabetical characters and hyphens.
func publish_template_localization_v1_admin(
	namespace_param: String, template_language: String, template_slug: String
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


## Lists notification topics in the namespace
## GET /lobby/v1/admin/notification/namespaces/{namespace}/topics
##
## Lists notification topics in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
func get_all_notification_topics_v1_admin(
	namespace_param: String, after: String = "", before: String = "", limit: int = -1
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


## Creates a new notification topic
## POST /lobby/v1/admin/notification/namespaces/{namespace}/topics
##
## Creates a new notification topic. Topic names must consist of uppercase letters and underscores only (e.g., `TOPIC_TEST`). Creating a duplicate topic name is not allowed.
##
## Parameters:
## - namespace_param: Game namespace
func create_notification_topic_v1_admin(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves information about a notification topic
## GET /lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}
##
## Retrieves information about the specified notification topic.
##
## Parameters:
## - namespace_param: Game namespace
## - topic_name: Name of the notification topic to retrieve.
func get_notification_topic_v1_admin(namespace_param: String, topic_name: String) -> Dictionary:
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


## Updates information for a notification topic
## PUT /lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}
##
## Updates information for the specified notification topic. Topic names must consist of uppercase letters and underscores only.
##
## Parameters:
## - namespace_param: Name of the notification topic to update.
## - topic_name: Name of the topic to update. Must consist of uppercase letters and underscores only.
func update_notification_topic_v1_admin(
	namespace_param: String, topic_name: String, body: Dictionary = {}
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


## Deletes a notification topic
## DELETE /lobby/v1/admin/notification/namespaces/{namespace}/topics/{topicName}
##
## Deletes the specified notification topic. Topic names must consist of uppercase letters and underscores only.
##
## Parameters:
## - namespace_param: Game namespace
## - topic_name: Name of the notification topic to delete.
func delete_notification_topic_v1_admin(namespace_param: String, topic_name: String) -> Dictionary:
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


## Sends a freeform notification to a specific user
## POST /lobby/v1/admin/notification/namespaces/{namespace}/users/{userId}/freeform/notify
##
## Sends a freeform notification to the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func send_specific_user_freeform_notification_v1_admin(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Sends a templated notification to a specific user
## POST /lobby/v1/admin/notification/namespaces/{namespace}/users/{userId}/templates/notify
##
## Sends a notification to the specified user using a predefined template. Specify the template slug and language in the request. Use the context map to provide values for each template variable. Publish the template before use.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func send_specific_user_templated_notification_v1_admin(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves the number of players currently connected to the lobby
## GET /lobby/v1/admin/player/namespaces/{namespace}/ccu
##
## Get the number of players connected to the Lobby in the given namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_lobby_ccu(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/admin/player/namespaces/{namespace}/ccu"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves blocked players for a list of users
## POST /lobby/v1/admin/player/namespaces/{namespace}/users/bulk/blocked
##
## Get blocked players data by bulk user ids in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_bulk_player_blocked_players_v1(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves blocked players for a specified user
## GET /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/blocked
##
## Get blocked players data by user id in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_blocked_players_v1(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves players who have blocked a specified user
## GET /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/blocked-by
##
## Load get players who blocked this player in a namespace based on user id
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_blocked_by_players_v1(namespace_param: String, user_id: String) -> Dictionary:
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


## Blocks players in bulk for a specified user
## POST /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/bulk/block
##
## Bulk block player in a namespace by list of user id
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_block_players_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Removes blocked players in bulk for a specified user
## DELETE /lobby/v1/admin/player/namespaces/{namespace}/users/{userId}/bulk/unblock
##
## Bulk unblock player in a namespace by list of user id
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_unblock_players_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves service messages
## GET /lobby/v1/messages
##
## Get the list of messages.
func public_get_messages() -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/messages"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Blocks a player by user ID
## POST /lobby/v1/public/player/namespaces/{namespace}/users/me/block
##
## Required valid user authorization
## add blocked players in a namespace based on user id
##
## Parameters:
## - namespace_param: Game namespace
func public_player_block_players_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/block"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists players blocked by the current user
## GET /lobby/v1/public/player/namespaces/{namespace}/users/me/blocked
##
## Lists players blocked by the current user in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_player_blocked_players_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/blocked"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists players who have blocked the current user
## GET /lobby/v1/public/player/namespaces/{namespace}/users/me/blocked-by
##
## Lists players who have blocked the current user in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_player_blocked_by_players_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/blocked-by"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Removes the block on a player by user ID
## POST /lobby/v1/public/player/namespaces/{namespace}/users/me/unblock
##
## Required valid user authorization
## unblock player in a namespace based on user id
##
## Parameters:
## - namespace_param: Game namespace
func public_unblock_player_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/lobby/v1/public/player/namespaces/{namespace}/users/me/unblock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Queries presence status for a list of users
## GET /lobby/v1/public/presence/namespaces/{namespace}/users/presence
##
## Query users presence with given namespace and userIds.
##
## Parameters:
## - namespace_param: Game namespace
## - count_only: Return only number of players for each availability status
## - user_ids: Comma separated value of userIds
func users_presence_handler_v1(
	namespace_param: String, user_ids: String, count_only: bool = false
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


## Queries presence status for a list of users
## POST /lobby/v1/public/presence/namespaces/{namespace}/users/presence
##
## Query users presence with given namespace and userIds.
##
## Parameters:
## - namespace_param: Game namespace
## - count_only: Return only number of players for each availability status
func users_presence_handler_v2(
	namespace_param: String, count_only: bool = false, body: Dictionary = {}
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


## Sends a freeform notification to a user
## POST /notification/namespaces/{namespace}/freeform
##
## Sends notification to all connected users in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func free_form_notification(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/freeform"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists notifications for the current user
## GET /notification/namespaces/{namespace}/me
##
## Lists notifications in the current user's namespace. Use the `startTime` and `endTime` query parameters to filter by time range; both accept the `sequenceID` value (epoch timestamp) from a previous notification result. Supports offset/limit pagination via the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - end_time: Filter data until a certain end time (sequenceID) value in the notification
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - start_time: Filter data starting from a certain start time (sequenceID) value in the notification
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


## Lists offline notifications for the current user
## GET /notification/namespaces/{namespace}/notification/offline/me
##
## Get list of user's offline notifications in a namespace.
##
## Parameters:
## - namespace_param: Game namespace
func get_my_offline_notifications(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/notification/offline/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Sends a templated notification to a user
## POST /notification/namespaces/{namespace}/templated
##
## Sends a notification to a user using a predefined template. Specify the template slug and language in the request. Use the context map to provide values for each template variable. Publish the template before use.
##
## Parameters:
## - namespace_param: Game namespace
func notification_with_template(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templated"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists all notification templates in the namespace
## GET /notification/namespaces/{namespace}/templates
##
## Get all templates in a namespace
##
## Parameters:
## - namespace_param: Game namespace
func get_game_template(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a new notification template
## POST /notification/namespaces/{namespace}/templates
##
## Creates a new notification template. Use `{{key}}` placeholders in the template body for values to substitute when sending. A slug and language uniquely identify each template; creating a duplicate slug/language combination is not allowed.
##
## Parameters:
## - namespace_param: Game namespace
func create_template(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/templates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists all localisations for a notification template
## GET /notification/namespaces/{namespace}/templates/{templateSlug}
##
## Get all templates in a namespace
##
## Parameters:
## - namespace_param: Game namespace
## - template_slug: Identifier of the notification template to retrieve localisations for.
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
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


## Deletes a notification template
## DELETE /notification/namespaces/{namespace}/templates/{templateSlug}
##
## Delete localization template
##
## Parameters:
## - namespace_param: Game namespace
## - template_slug: Identifier of the notification template to delete.
func delete_template_slug(namespace_param: String, template_slug: String) -> Dictionary:
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


## Retrieves a notification template localisation
## GET /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
##
## Get a template localization
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Language of the localisation to retrieve.
## - template_slug: Identifier of the notification template.
func get_localization_template(
	namespace_param: String, template_language: String, template_slug: String
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


## Updates a notification template draft
## PUT /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
##
## Modifies the draft for the specified notification template localisation.
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Language of the draft to update.
## - template_slug: Identifier of the notification template.
func update_localization_template(
	namespace_param: String, template_language: String, template_slug: String, body: Dictionary = {}
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


## Deletes a notification template localisation
## DELETE /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}
##
## Deletes the localisation for the specified template slug and language.
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Language of the localisation to delete.
## - template_slug: Identifier of the notification template.
func delete_template_localization(
	namespace_param: String, template_language: String, template_slug: String
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


## Publishes a notification template draft
## POST /notification/namespaces/{namespace}/templates/{templateSlug}/languages/{templateLanguage}/publish
##
## Publishes the notification template localisation draft. An empty draft will fail to publish.
##
## Parameters:
## - namespace_param: Game namespace
## - template_language: Language of the draft to publish.
## - template_slug: Identifier of the notification template.
func publish_template(
	namespace_param: String, template_language: String, template_slug: String
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


## Lists notification topics in the namespace
## GET /notification/namespaces/{namespace}/topics
##
## Get topic by namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
func get_topic_by_namespace(
	namespace_param: String, after: String = "", before: String = "", limit: int = -1
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


## Creates a new notification topic
## POST /notification/namespaces/{namespace}/topics
##
## Creates a new notification topic. Topic names must consist of uppercase letters and underscores only (e.g., `TOPIC_TEST`). Creating a duplicate topic name is not allowed.
##
## Parameters:
## - namespace_param: Game namespace
func create_topic(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/notification/namespaces/{namespace}/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves information about a notification topic
## GET /notification/namespaces/{namespace}/topics/{topic}
##
## Get topic information by topic name.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic name
func get_topic_by_topic_name(namespace_param: String, topic: String) -> Dictionary:
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


## Updates information for a notification topic
## PUT /notification/namespaces/{namespace}/topics/{topic}
##
## Updates information for the specified notification topic. Topic names must consist of uppercase letters and underscores only.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic name
func update_topic_by_topic_name(
	namespace_param: String, topic: String, body: Dictionary = {}
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


## Deletes a notification topic
## DELETE /notification/namespaces/{namespace}/topics/{topic}
##
## Deletes the specified notification topic. Topic names must consist of uppercase letters and underscores only.
##
## Parameters:
## - namespace_param: Game namespace
## - topic: Topic name
func delete_topic_by_topic_name(namespace_param: String, topic: String) -> Dictionary:
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


## Sends a freeform notification to a user
## POST /notification/namespaces/{namespace}/users/{userId}/freeform
##
## Sends notification to a user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func free_form_notification_by_user_id(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Sends a templated notification to a user
## POST /notification/namespaces/{namespace}/users/{userId}/templated
##
## Sends a notification to a user using a predefined template. Specify the template slug and language in the request. Use the context map to provide values for each template variable. Publish the template before use.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func notification_with_template_by_user_id(
	namespace_param: String, user_id: String, body: Dictionary = {}
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
