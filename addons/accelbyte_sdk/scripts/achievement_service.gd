## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## achievement_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-achievement-service
## Version: 2.27.2
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(AchievementService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name AchievementService
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

## Query achievements
## GET /achievement/v1/admin/namespaces/{namespace}/achievements
func admin_list_achievements(
	namespace_param: String,
	global: bool = false,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["global"] = global
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create new achievement
## POST /achievement/v1/admin/namespaces/{namespace}/achievements
func admin_create_new_achievement(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Export achievements configuration into a json file
## GET /achievement/v1/admin/namespaces/{namespace}/achievements/export
func export_achievements(
	namespace_param: String,
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Import achievements from file
## POST /achievement/v1/admin/namespaces/{namespace}/achievements/import
func import_achievements(
	namespace_param: String,
	file: String = "",
	strategy: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get an achievement
## GET /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
func admin_get_achievement(
	achievement_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update an achievement
## PUT /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
func admin_update_achievement(
	achievement_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete an achievement
## DELETE /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
func admin_delete_achievement(
	achievement_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update achievements listOrder
## PATCH /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
func admin_update_achievement_list_order(
	achievement_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Admin query global achievements [include achieved and in-progress]
## GET /achievement/v1/admin/namespaces/{namespace}/global/achievements
func admin_list_global_achievements(
	namespace_param: String,
	achievement_codes: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/global/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not achievement_codes.is_empty():
		query_params["achievementCodes"] = achievement_codes
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin list contributors of global achievement
## GET /achievement/v1/admin/namespaces/{namespace}/global/achievements/{achievementCode}/contributors
func admin_list_global_achievement_contributors(
	achievement_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/global/achievements/{achievementCode}/contributors"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Reset global achievement
## DELETE /achievement/v1/admin/namespaces/{namespace}/global/achievements/{achievementCode}/reset
func reset_global_achievement(
	achievement_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/global/achievements/{achievementCode}/reset"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Create PSN UDS events
## POST /achievement/v1/admin/namespaces/{namespace}/platforms/psn/bulk
func bulk_create_psn_event(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/platforms/psn/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query tags
## GET /achievement/v1/admin/namespaces/{namespace}/tags
func admin_list_tags(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query user achievements [include achieved and in-progress]
## GET /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements
func admin_list_user_achievements(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	prefer_unlocked: bool = false,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements"
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
	query_params["preferUnlocked"] = prefer_unlocked
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk unlock achievements
## PUT /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/bulkUnlock
func admin_bulk_unlock_achievement(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/bulkUnlock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Reset an achievement
## DELETE /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/reset
func admin_reset_achievement(
	achievement_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/reset"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Unlock an achievement
## PUT /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/unlock
func admin_unlock_achievement(
	achievement_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/unlock"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Anonymize user's achievement
## DELETE /achievement/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/achievements
func admin_anonymize_user_achievement(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin list of global achievements that has been contributed by the user
## GET /achievement/v1/admin/namespaces/{namespace}/users/{userId}/global/achievements
func admin_list_user_contributions(
	namespace_param: String,
	user_id: String,
	achievement_codes: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/users/{userId}/global/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not achievement_codes.is_empty():
		query_params["achievementCodes"] = achievement_codes
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query achievements
## GET /achievement/v1/public/namespaces/{namespace}/achievements
func public_list_achievements(
	namespace_param: String,
	language: String,
	global: bool = false,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["global"] = global
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not language.is_empty():
		query_params["language"] = language
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get an achievement
## GET /achievement/v1/public/namespaces/{namespace}/achievements/{achievementCode}
func public_get_achievement(
	achievement_code: String,
	namespace_param: String,
	language: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/achievements/{achievementCode}"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query global achievements [include achieved and in-progress]
## GET /achievement/v1/public/namespaces/{namespace}/global/achievements
func public_list_global_achievements(
	namespace_param: String,
	achievement_codes: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/global/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not achievement_codes.is_empty():
		query_params["achievementCodes"] = achievement_codes
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List contributors of global achievement
## GET /achievement/v1/public/namespaces/{namespace}/global/achievements/{achievementCode}/contributors
func list_global_achievement_contributors(
	achievement_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/global/achievements/{achievementCode}/contributors"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query tags
## GET /achievement/v1/public/namespaces/{namespace}/tags
func public_list_tags(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query user achievements [include achieved and in-progress]
## GET /achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements
func public_list_user_achievements(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	prefer_unlocked: bool = false,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements"
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
	query_params["preferUnlocked"] = prefer_unlocked
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk Unlock achievements
## PUT /achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements/bulkUnlock
func public_bulk_unlock_achievement(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements/bulkUnlock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Unlock an achievement
## PUT /achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/unlock
func public_unlock_achievement(
	achievement_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/unlock"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## List of global achievements that has been contributed by the user
## GET /achievement/v1/public/namespaces/{namespace}/users/{userId}/global/achievements
func list_user_contributions(
	namespace_param: String,
	user_id: String,
	achievement_codes: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/users/{userId}/global/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not achievement_codes.is_empty():
		query_params["achievementCodes"] = achievement_codes
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Claim global achievement reward
## POST /achievement/v1/public/namespaces/{namespace}/users/{userId}/global/achievements/{achievementCode}/claim
func claim_global_achievement_reward(
	achievement_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/public/namespaces/{namespace}/users/{userId}/global/achievements/{achievementCode}/claim"
	url_path = url_path.replace("{" + "achievementCode" + "}", achievement_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
