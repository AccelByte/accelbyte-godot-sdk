## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## leaderboard_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-leaderboard-service
## Version: 2.34.1
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(LeaderboardService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name LeaderboardService
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

## list all leaderboards by given namespace
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards
func get_leaderboard_configurations_admin_v1(
	namespace_param: String,
	is_archived: bool = false,
	is_deleted: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isArchived"] = is_archived
	query_params["isDeleted"] = is_deleted
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

## create new leaderboard
## POST /leaderboard/v1/admin/namespaces/{namespace}/leaderboards
func create_leaderboard_configuration_admin_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Get signed url for archive all time leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/archived
func admin_get_archived_leaderboard_ranking_data_v1_handler(
	namespace_param: String,
	leaderboard_codes: String,
	slug: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/archived"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not slug.is_empty():
		query_params["slug"] = slug
	if not leaderboard_codes.is_empty():
		query_params["leaderboardCodes"] = leaderboard_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Archive a leadeboard data ranking
## POST /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/archived
func create_archived_leaderboard_ranking_data_v1_handler(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/archived"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## delete bulk leaderboards. response body will contains failed...
## POST /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/delete
func delete_bulk_leaderboard_configuration_admin_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/delete"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get leaderboard by leaderboardCode
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
func get_leaderboard_configuration_admin_v1(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update leaderboard by leaderboardCode
## PUT /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
func update_leaderboard_configuration_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete leaderboard by leaderboardCode
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
func delete_leaderboard_configuration_admin_v1(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get all time leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
func get_all_time_leaderboard_ranking_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
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

## hard delete leaderboard config and data by leaderboard code
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/hard
func hard_delete_leaderboard_admin_v1(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/hard"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get current month leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/month
func get_current_month_leaderboard_ranking_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/month"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## delete all user ranking by leaderboard code
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/reset
func delete_user_ranking_by_leaderboard_code_admin_v1(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/reset"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get current season leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/season
func get_current_season_leaderboard_ranking_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/season"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get today leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/today
func get_today_leaderboard_ranking_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/today"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user ranking
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func get_user_ranking_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update user point
## PUT /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func update_user_point_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete user ranking
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func delete_user_ranking_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get current week leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/week
func get_current_week_leaderboard_ranking_admin_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/week"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete user ranking across leaderboard(s)
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/users/{userId}
func delete_user_rankings_admin_v1(
	namespace_param: String,
	user_id: String,
	leaderboard_code: Array
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if leaderboard_code.size() > 0:
		query_params["leaderboardCode"] = leaderboard_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Anonymize user's leaderboard
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/leaderboards
func admin_anonymize_user_leaderboard_admin_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get user rankings
## GET /leaderboard/v1/admin/namespaces/{namespace}/users/{userId}/leaderboards
func get_user_leaderboard_rankings_admin_v1(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/admin/namespaces/{namespace}/users/{userId}/leaderboards"
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
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## list all leaderboards by given namespace
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards
func get_leaderboard_configurations_public_v1(
	namespace_param: String,
	is_archived: bool = false,
	is_deleted: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isArchived"] = is_archived
	query_params["isDeleted"] = is_deleted
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

## create new leaderboard
## POST /leaderboard/v1/public/namespaces/{namespace}/leaderboards
func create_leaderboard_configuration_public_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get all time leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
func get_all_time_leaderboard_ranking_public_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
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

## Get signed url for archive all time leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/archived
func get_archived_leaderboard_ranking_data_v1_handler(
	leaderboard_code: String,
	namespace_param: String,
	leaderboard_codes: String,
	slug: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/archived"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not slug.is_empty():
		query_params["slug"] = slug
	if not leaderboard_codes.is_empty():
		query_params["leaderboardCodes"] = leaderboard_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get current month leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/month
func get_current_month_leaderboard_ranking_public_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/month"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get current season leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/season
func get_current_season_leaderboard_ranking_public_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/season"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get today leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/today
func get_today_leaderboard_ranking_public_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/today"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user ranking
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func get_user_ranking_public_v1(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete user ranking
## DELETE /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func delete_user_ranking_public_v1(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get current week leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/week
func get_current_week_leaderboard_ranking_public_v1(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/week"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get hidden users on a leaderboard
## GET /leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/hidden
func get_hidden_users_v2(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/hidden"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
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

## Get user visibility status
## GET /leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
func get_user_visibility_status_v2(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Set user visibility status on a specific leaderboard code
## PUT /leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
func set_user_leaderboard_visibility_status_v2(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Set user visibility status on a all current leaderboard
## PUT /leaderboard/v2/admin/namespaces/{namespace}/users/{userId}/visibility
func set_user_visibility_status_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v2/admin/namespaces/{namespace}/users/{userId}/visibility"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## list all leaderboards by given namespace
## GET /leaderboard/v2/public/namespaces/{namespace}/leaderboards
func get_leaderboard_configurations_public_v2(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v2/public/namespaces/{namespace}/leaderboards"
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

## Get all time leaderboard ranking data
## GET /leaderboard/v2/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
func get_all_time_leaderboard_ranking_public_v2(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v2/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
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

## list all leaderboards by given namespace
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards
func get_leaderboard_configurations_admin_v3(
	namespace_param: String,
	is_deleted: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isDeleted"] = is_deleted
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

## create new leaderboard
## POST /leaderboard/v3/admin/namespaces/{namespace}/leaderboards
func create_leaderboard_configuration_admin_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## delete bulk leaderboards. response body will contains failed...
## POST /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/delete
func delete_bulk_leaderboard_configuration_admin_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/delete"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get leaderboard by leaderboardCode
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
func get_leaderboard_configuration_admin_v3(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update leaderboard by leaderboardCode
## PUT /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
func update_leaderboard_configuration_admin_v3(
	leaderboard_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete leaderboard by leaderboardCode
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
func delete_leaderboard_configuration_admin_v3(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get all time leaderboard ranking data
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
func get_all_time_leaderboard_ranking_admin_v3(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
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

## Get cycle leaderboard ranking data
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}
func get_current_cycle_leaderboard_ranking_admin_v3(
	cycle_id: String,
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## delete all user ranking by cycle id
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}/reset
func delete_all_user_ranking_by_cycle_id_admin_v3(
	cycle_id: String,
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}/reset"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete user ranking by cycle id
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}/users/{userId}
func delete_user_ranking_by_cycle_id_admin_v3(
	cycle_id: String,
	leaderboard_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}/users/{userId}"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## hard delete leaderboard config and data by leaderboard code
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/hard
func hard_delete_leaderboard_admin_v3(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/hard"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## delete all user ranking by leaderboard code
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/reset
func delete_user_ranking_by_leaderboard_code_admin_v3(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/reset"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get hidden users on a leaderboard
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/hidden
func get_hidden_users_v3(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/hidden"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
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

## Get user ranking
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func get_user_ranking_admin_v3(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete user ranking
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func delete_user_ranking_admin_v3(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get user visibility status
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
func get_user_visibility_status_v3(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Set user visibility status on a specific leaderboard code
## PUT /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
func set_user_leaderboard_visibility_v3(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete user ranking across leaderboard(s)
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/users/{userId}
func delete_user_rankings_admin_v3(
	namespace_param: String,
	user_id: String,
	leaderboard_code: Array
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if leaderboard_code.size() > 0:
		query_params["leaderboardCode"] = leaderboard_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get user rankings
## GET /leaderboard/v3/admin/namespaces/{namespace}/users/{userId}/leaderboards
func get_user_leaderboard_rankings_admin_v3(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/users/{userId}/leaderboards"
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
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Set user visibility status on a all current leaderboard
## PUT /leaderboard/v3/admin/namespaces/{namespace}/users/{userId}/visibility
func set_user_visibility_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/admin/namespaces/{namespace}/users/{userId}/visibility"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## list all leaderboards by given namespace
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards
func get_leaderboard_configurations_public_v3(
	namespace_param: String,
	is_deleted: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/public/namespaces/{namespace}/leaderboards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isDeleted"] = is_deleted
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

## get leaderboard by leaderboardCode
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}
func get_leaderboard_configuration_public_v3(
	leaderboard_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all time leaderboard ranking data
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
func get_all_time_leaderboard_ranking_public_v3(
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
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

## Get cycle leaderboard ranking data
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}
func get_current_cycle_leaderboard_ranking_public_v3(
	cycle_id: String,
	leaderboard_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get users ranking
## POST /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/bulk
func bulk_get_users_ranking_public_v3(
	leaderboard_code: String,
	namespace_param: String,
	previous_version: int = -1,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/bulk"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user ranking
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
func get_user_ranking_public_v3(
	leaderboard_code: String,
	namespace_param: String,
	user_id: String,
	previous_version: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}"
	url_path = url_path.replace("{" + "leaderboardCode" + "}", leaderboard_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if previous_version >= 0:
		query_params["previousVersion"] = previous_version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
