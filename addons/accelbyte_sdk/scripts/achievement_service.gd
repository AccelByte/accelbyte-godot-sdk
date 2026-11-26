## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## achievement_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-achievement-service
## Version: 2.31.2
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


## Lists achievements
## GET /achievement/v1/admin/namespaces/{namespace}/achievements
##
## Lists achievements in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - global: Filter by global achievement flag
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `listOrder:asc`. Valid values: `listOrder`, `listOrder:asc`, `listOrder:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`.
## - tags: Tags used to filter achievements.
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


## Creates a new achievement
## POST /achievement/v1/admin/namespaces/{namespace}/achievements
##
## Creates an achievement in the namespace. The request defines the achievement code, localized name and description, progression settings, icons, and related metadata.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_new_achievement(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/achievements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Exports achievement configuration
## GET /achievement/v1/admin/namespaces/{namespace}/achievements/export
##
## Exports achievement configuration for the namespace as a JSON file. The response includes a `content-disposition` header with the filename `achievement__config.json`.
##
## Parameters:
## - namespace_param: Game namespace
## - tags: Tags used to filter exported achievements.
func export_achievements(namespace_param: String, tags: Array = []) -> Dictionary:
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


## Imports achievement configuration
## POST /achievement/v1/admin/namespaces/{namespace}/achievements/import
##
## Imports achievement configuration from a file and merges it with existing achievements in the namespace. Use `leaveOut` to keep existing achievements with matching keys, or `replace` to overwrite them with the imported configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - file: Achievement configuration file to import.
## - strategy: Strategy for import
func import_achievements(
	namespace_param: String, file: String = "", strategy: String = ""
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


## Retrieves an achievement
## GET /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
##
## Retrieves an achievement from the namespace.
##
## Parameters:
## - achievement_code: Achievement code to retrieve.
## - namespace_param: Game namespace
func admin_get_achievement(achievement_code: String, namespace_param: String) -> Dictionary:
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


## Updates an achievement
## PUT /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
##
## Updates an existing achievement in the namespace.
##
## Parameters:
## - achievement_code: Achievement code to update.
## - namespace_param: Game namespace
func admin_update_achievement(
	achievement_code: String, namespace_param: String, body: Dictionary = {}
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


## Deletes an achievement
## DELETE /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
##
## Deletes an achievement from the namespace.
##
## Parameters:
## - achievement_code: Achievement code to delete.
## - namespace_param: Game namespace
func admin_delete_achievement(achievement_code: String, namespace_param: String) -> Dictionary:
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


## Updates achievement list order
## PATCH /achievement/v1/admin/namespaces/{namespace}/achievements/{achievementCode}
##
## Updates the list order for an achievement in the namespace.
##
## Parameters:
## - achievement_code: Achievement code to update.
## - namespace_param: Game namespace
func admin_update_achievement_list_order(
	achievement_code: String, namespace_param: String, body: Dictionary = {}
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


## Lists global achievements
## GET /achievement/v1/admin/namespaces/{namespace}/global/achievements
##
## Lists global achievements in the namespace, including achievements that are in progress or unlocked. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - achievement_codes: Comma-separated achievement codes to filter by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Valid values: `achievedAt`, `achievedAt:asc`, `achievedAt:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`.
## - status: Filter by achievement status. Valid values: `in_progress`, `unlocked`.
## - tags: Tags used to filter global achievements.
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


## Lists global achievement contributors
## GET /achievement/v1/admin/namespaces/{namespace}/global/achievements/{achievementCode}/contributors
##
## Lists contributors for a global achievement in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - achievement_code: Achievement code to list contributors for.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `contributedValue:desc`. Valid values: `contributedValue`, `contributedValue:asc`, `contributedValue:desc`.
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


## Resets a global achievement
## DELETE /achievement/v1/admin/namespaces/{namespace}/global/achievements/{achievementCode}/reset
##
## [TEST FACILITY ONLY] Resets progress for the global achievement in the namespace.
##
## Parameters:
## - achievement_code: Achievement code to reset.
## - namespace_param: Game namespace
func reset_global_achievement(achievement_code: String, namespace_param: String) -> Dictionary:
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


## Creates PSN UDS events
## POST /achievement/v1/admin/namespaces/{namespace}/platforms/psn/bulk
##
## Creates PSN UDS events for the namespace. Players must sign in to IAM with a PlayStation token before AccelByte processes these events.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_create_psn_event(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/platforms/psn/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists tags
## GET /achievement/v1/admin/namespaces/{namespace}/tags
##
## Lists achievement tags in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Tag name filter.
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `name:asc`. Valid values: `name`, `name:asc`, `name:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`.
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


## Lists user achievements
## GET /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements
##
## Lists achievements for the user in the namespace, including achievements that are in progress or unlocked. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - prefer_unlocked: Prefer to query achieved
## - sort_by: Sort field and direction. Valid values: `achievedAt`, `achievedAt:asc`, `achievedAt:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`.
## - tags: Tags used to filter user achievements.
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


## Batch Query user achievements
## POST /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/batchQuery
##
## Required permission
## `ADMIN:NAMESPACE:{namespace}:USER:{userId}:ACHIEVEMENT [READ]` and scope `social`
##
##
##
##
## Note:
##
##
##
##
## User Achievement status value mean: `status = 1 (in progress)` and `status = 2 (unlocked)`
##
##
##
##
## `achievedAt` value will return default value: `0001-01-01T00:00:00Z` for user achievement that locked or in progress
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: user id
func admin_batch_query_user_achievements(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/batchQuery"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Unlocks achievements in bulk
## PUT /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/bulkUnlock
##
## Unlocks achievements for the user in the namespace in a single request.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_unlock_achievement(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Resets an achievement
## DELETE /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/reset
##
## [TEST FACILITY ONLY] Resets the user's progress for the achievement in the namespace.
##
## Parameters:
## - achievement_code: Achievement code to reset.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_reset_achievement(
	achievement_code: String, namespace_param: String, user_id: String
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


## Unlocks an achievement
## PUT /achievement/v1/admin/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/unlock
##
## Unlocks the achievement for the user in the namespace.
##
## Parameters:
## - achievement_code: Achievement code to unlock.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_unlock_achievement(
	achievement_code: String, namespace_param: String, user_id: String
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


## Deletes user achievement data
## DELETE /achievement/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/achievements
##
## Deletes the user's achievement data for privacy workflows.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_anonymize_user_achievement(namespace_param: String, user_id: String) -> Dictionary:
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


## Lists user global achievement contributions
## GET /achievement/v1/admin/namespaces/{namespace}/users/{userId}/global/achievements
##
## Lists global achievements that the user has contributed to in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - achievement_codes: Comma-separated achievement codes to filter by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `contributedValue:desc`. Valid values: `contributedValue`, `contributedValue:asc`, `contributedValue:desc`.
## - tags: Tags used to filter contributed global achievements.
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


## Lists achievements
## GET /achievement/v1/public/namespaces/{namespace}/achievements
##
## Lists achievements in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - global: Filter by global achievement flag
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `listOrder:asc`. Valid values: `listOrder`, `listOrder:asc`, `listOrder:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`.
## - tags: Tags used to filter achievements.
## - language: Language to use for localized achievement fields. Falls back to the default language when unavailable.
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


## Retrieves an achievement
## GET /achievement/v1/public/namespaces/{namespace}/achievements/{achievementCode}
##
## Retrieves an achievement from the namespace.
##
## Parameters:
## - achievement_code: Achievement code to retrieve.
## - namespace_param: Game namespace
## - language: Language to use for localized achievement fields. Falls back to the default language when unavailable.
func public_get_achievement(
	achievement_code: String, namespace_param: String, language: String
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


## Lists global achievements
## GET /achievement/v1/public/namespaces/{namespace}/global/achievements
##
## Lists global achievements in the namespace, including achievements that are in progress or unlocked. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - achievement_codes: Comma-separated achievement codes to filter by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Valid values: `achievedAt`, `achievedAt:asc`, `achievedAt:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`.
## - status: Filter by achievement status. Valid values: `in_progress`, `unlocked`.
## - tags: Tags used to filter global achievements.
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


## Lists global achievement contributors
## GET /achievement/v1/public/namespaces/{namespace}/global/achievements/{achievementCode}/contributors
##
## Lists contributors for a global achievement in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - achievement_code: Achievement code to list contributors for.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `contributedValue:desc`. Valid values: `contributedValue`, `contributedValue:asc`, `contributedValue:desc`.
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


## Lists tags
## GET /achievement/v1/public/namespaces/{namespace}/tags
##
## Lists achievement tags in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Tag name filter.
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `name:asc`. Valid values: `name`, `name:asc`, `name:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`.
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


## Lists user achievements
## GET /achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements
##
## Lists achievements for the user in the namespace, including achievements that are in progress or unlocked. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - prefer_unlocked: Prefer to query achieved
## - sort_by: Sort field and direction. Valid values: `achievedAt`, `achievedAt:asc`, `achievedAt:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`.
## - tags: Tags used to filter user achievements.
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


## Unlocks achievements in bulk
## PUT /achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements/bulkUnlock
##
## Unlocks achievements for the user in the namespace in a single request.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_bulk_unlock_achievement(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Unlocks an achievement
## PUT /achievement/v1/public/namespaces/{namespace}/users/{userId}/achievements/{achievementCode}/unlock
##
## Unlocks the achievement for the user in the namespace.
##
## Parameters:
## - achievement_code: Achievement code to unlock.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_unlock_achievement(
	achievement_code: String, namespace_param: String, user_id: String
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


## Lists user global achievement contributions
## GET /achievement/v1/public/namespaces/{namespace}/users/{userId}/global/achievements
##
## Lists global achievements that the user has contributed to in the namespace. Supports offset-based pagination with the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - achievement_codes: Comma-separated achievement codes to filter by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort field and direction. Default: `contributedValue:desc`. Valid values: `contributedValue`, `contributedValue:asc`, `contributedValue:desc`.
## - tags: Tags used to filter contributed global achievements.
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


## Claims a global achievement reward
## POST /achievement/v1/public/namespaces/{namespace}/users/{userId}/global/achievements/{achievementCode}/claim
##
## Claims the reward for a global achievement. The user must unlock the achievement first and must be one of its contributors.
##
## Parameters:
## - achievement_code: Achievement code to claim the reward for.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func claim_global_achievement_reward(
	achievement_code: String, namespace_param: String, user_id: String
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
