## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## leaderboard_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-leaderboard-service
## Version: 2.37.1
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


## Lists all leaderboard configurations in a namespace
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards
##
## Lists all leaderboard configurations in the specified namespace. Use the `limit` and `offset` parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - is_archived: Filter for archived leaderboard
## - is_deleted: Filter for deleted leaderboard config
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Creates a new leaderboard configuration
## POST /leaderboard/v1/admin/namespaces/{namespace}/leaderboards
##
## Creates a new leaderboard configuration in the specified namespace. The leaderboard code must be lowercase, up to 48 characters, and the name must not exceed 128 characters. Start time must follow RFC 3339 format (for example, `2020-10-02T15:00:00.05Z`). The stat code must reference a valid statistic in the Statistics service. To enable seasonal tracking, set a season period greater than 31 days and configure the reset date (1â31), reset day (0 = Sunday through 6 = Saturday), and reset time in 24-hour HH:MM format (for example, `00:00`).
##
## Parameters:
## - namespace_param: Game namespace
func create_leaderboard_configuration_admin_v1(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves signed download URLs for archived all-time leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/archived
##
## Retrieves signed download URLs for archived all-time leaderboard ranking data. Accepts leaderboard codes as a comma-separated list.
##
## Parameters:
## - namespace_param: Game namespace
## - slug: Slug variant of the leaderboard to retrieve archived data for.
## - leaderboard_codes: List of leaderboard codes split by comma
func admin_get_archived_leaderboard_ranking_data_v1_handler(
	namespace_param: String, leaderboard_codes: String, slug: String = ""
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


## Creates ranking data archives for the specified leaderboards
## POST /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/archived
##
## Archives ranking data for the specified leaderboard codes. This is a bulk operation that removes all leaderboard data for each slug, removes the leaderboard code from stat mapping, and removes the leaderboard from the reset queue.
##
## Parameters:
## - namespace_param: Game namespace
func create_archived_leaderboard_ranking_data_v1_handler(
	namespace_param: String, body: Dictionary = {}
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


## Deletes leaderboard configurations in bulk
## POST /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/delete
##
## Deletes leaderboard configurations in a single request. The response lists any configurations that failed to delete along with the reason for each failure.
##
## Parameters:
## - namespace_param: Game namespace
func delete_bulk_leaderboard_configuration_admin_v1(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves a leaderboard configuration by its code
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
##
## Retrieves the leaderboard configuration identified by the specified code.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func get_leaderboard_configuration_admin_v1(
	leaderboard_code: String, namespace_param: String
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


## Updates a leaderboard configuration by its code
## PUT /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
##
## Updates the leaderboard configuration identified by the specified code. The name must not exceed 128 characters. Start time must follow RFC 3339 format (for example, `2020-10-02T15:00:00.05Z`). To enable seasonal tracking, set a season period greater than 31 days and configure the reset date (1â31), reset day (0 = Sunday through 6 = Saturday), and reset time in 24-hour HH:MM format (for example, `00:00`).
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func update_leaderboard_configuration_admin_v1(
	leaderboard_code: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a leaderboard configuration by its code
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
##
## Deletes the leaderboard configuration identified by the specified code.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func delete_leaderboard_configuration_admin_v1(
	leaderboard_code: String, namespace_param: String
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


## Retrieves all-time leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
##
## Retrieves rankings from the all-time leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_all_time_leaderboard_ranking_admin_v1(
	leaderboard_code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Deletes a leaderboard configuration and all its data permanently
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/hard
##
## [Test Facility Only] Permanently deletes the leaderboard configuration and all associated data. Only available in development environments; use the archive operation instead for production use.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func hard_delete_leaderboard_admin_v1(
	leaderboard_code: String, namespace_param: String
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


## Retrieves current-month leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/month
##
## Retrieves rankings from the current-month leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Deletes all user rankings for a leaderboard
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/reset
##
## Deletes all user rankings for the specified leaderboard code. Warning: This action permanently deletes all ranking data. Make sure to back up anything important before continuing.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func delete_user_ranking_by_leaderboard_code_admin_v1(
	leaderboard_code: String, namespace_param: String
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


## Retrieves current-season leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/season
##
## Retrieves rankings from the current-season leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves today's leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/today
##
## Retrieves rankings from today's leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves a user's ranking in a leaderboard
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Returns the user's current rank, score, and position within the specified leaderboard.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
func get_user_ranking_admin_v1(
	leaderboard_code: String, namespace_param: String, user_id: String, previous_version: int = -1
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


## Updates a user's point total in a leaderboard
## PUT /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Updates a user's point total in a leaderboard. Intended for test utility use only.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_user_point_admin_v1(
	leaderboard_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a user's ranking from a leaderboard
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Removes a user's ranking entry from the specified leaderboard. Returns 204 regardless of whether the user had an existing entry.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_user_ranking_admin_v1(
	leaderboard_code: String, namespace_param: String, user_id: String
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


## Retrieves current-week leaderboard ranking data
## GET /leaderboard/v1/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/week
##
## Retrieves rankings from the current-week leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Deletes a user's rankings across all leaderboards
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/users/{userId}
##
## Removes the specified user's ranking entries from all leaderboards in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
func delete_user_rankings_admin_v1(
	namespace_param: String, user_id: String, leaderboard_code: Array
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


## Removes all identifying information from a user's leaderboard data
## DELETE /leaderboard/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/leaderboards
##
## Anonymizes all leaderboard data for the specified user, replacing identifying information with anonymous values.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_anonymize_user_leaderboard_admin_v1(
	namespace_param: String, user_id: String
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


## Retrieves a user's rankings across leaderboards
## GET /leaderboard/v1/admin/namespaces/{namespace}/users/{userId}/leaderboards
##
## Retrieves a user's rankings across all leaderboards in the namespace. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back. Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Lists all leaderboard configurations in a namespace
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards
##
## Lists all leaderboard configurations in the specified namespace. Use the `limit` and `offset` parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - is_archived: Filter for archived leaderboard
## - is_deleted: Filter for deleted leaderboard config
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Creates a new leaderboard configuration
## POST /leaderboard/v1/public/namespaces/{namespace}/leaderboards
##
## Creates a new leaderboard configuration in the specified namespace. The leaderboard code must be lowercase, up to 48 characters, and the name must not exceed 128 characters. Start time must follow RFC 3339 format (for example, `2020-10-02T15:00:00.05Z`). The stat code must reference a valid statistic in the Statistics service. To enable seasonal tracking, set a season period greater than 31 days and configure the reset date (1â31), reset day (0 = Sunday through 6 = Saturday), and reset time in 24-hour HH:MM format (for example, `00:00`).
##
## Parameters:
## - namespace_param: Game namespace
func create_leaderboard_configuration_public_v1(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves all-time leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
##
## Retrieves rankings from the all-time leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_all_time_leaderboard_ranking_public_v1(
	leaderboard_code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves signed download URLs for archived all-time leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/archived
##
## Retrieves signed download URLs for archived all-time leaderboard ranking data. Accepts leaderboard codes as a comma-separated list.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - slug: Slug variant of the leaderboard to retrieve archived data for.
## - leaderboard_codes: List of leaderboard codes split by comma
func get_archived_leaderboard_ranking_data_v1_handler(
	leaderboard_code: String, namespace_param: String, leaderboard_codes: String, slug: String = ""
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


## Retrieves current-month leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/month
##
## Retrieves rankings from the current-month leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves current-season leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/season
##
## Retrieves rankings from the current-season leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves today's leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/today
##
## Retrieves rankings from today's leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves a user's ranking in a leaderboard
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Returns the user's current rank, score, and position within the specified leaderboard.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
func get_user_ranking_public_v1(
	leaderboard_code: String, namespace_param: String, user_id: String, previous_version: int = -1
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


## Deletes a user's ranking from a leaderboard
## DELETE /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Removes a user's ranking entry from the specified leaderboard. Returns 204 regardless of whether the user had an existing entry.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_user_ranking_public_v1(
	leaderboard_code: String, namespace_param: String, user_id: String
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


## Retrieves current-week leaderboard ranking data
## GET /leaderboard/v1/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/week
##
## Retrieves rankings from the current-week leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves hidden users on a leaderboard
## GET /leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/hidden
##
## Retrieves users with hidden entries on the specified leaderboard. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_hidden_users_v2(
	leaderboard_code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves a user's visibility status on a leaderboard
## GET /leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
##
## Returns the user's current visibility status on the leaderboard. When visibility is false, the user's entry has the hidden attribute set to true.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_visibility_status_v2(
	leaderboard_code: String, namespace_param: String, user_id: String
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


## Sets a user's visibility status on a specific leaderboard
## PUT /leaderboard/v2/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
##
## Sets the user's visibility status on the specified leaderboard. When set to false, the user's entry has the hidden attribute set to true.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func set_user_leaderboard_visibility_status_v2(
	leaderboard_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Sets a user's visibility status across all leaderboards
## PUT /leaderboard/v2/admin/namespaces/{namespace}/users/{userId}/visibility
##
## Sets the user's visibility status across all leaderboards. When set to false, the user's entries have the hidden attribute set to true.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func set_user_visibility_status_v2(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists all leaderboard configurations in a namespace
## GET /leaderboard/v2/public/namespaces/{namespace}/leaderboards
##
## Lists all leaderboard configurations in the specified namespace. Use the `limit` and `offset` parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_leaderboard_configurations_public_v2(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves all-time leaderboard ranking data
## GET /leaderboard/v2/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
##
## Retrieves rankings from the all-time leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_all_time_leaderboard_ranking_public_v2(
	leaderboard_code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists all leaderboard configurations in a namespace
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards
##
## Lists all leaderboard configurations in the specified namespace. Use the `limit` and `offset` parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - is_deleted: Filter for deleted leaderboard config
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_leaderboard_configurations_admin_v3(
	namespace_param: String, is_deleted: bool = false, limit: int = -1, offset: int = -1
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


## Creates a new leaderboard configuration
## POST /leaderboard/v3/admin/namespaces/{namespace}/leaderboards
##
## Creates a new leaderboard configuration in the specified namespace. The leaderboard code must be lowercase, up to 48 characters. Requires a name (up to 128 characters); description is optional (up to 2048 characters). Set `allTime` to true to enable all-time rankings, and `descending` to control sort order. The `statCode` must reference a valid statistic in the Statistics service, and `cycleIds` specifies the statistic cycle IDs to track.
##
## Parameters:
## - namespace_param: Game namespace
func create_leaderboard_configuration_admin_v3(
	namespace_param: String, body: Dictionary = {}
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


## Deletes leaderboard configurations in bulk
## POST /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/delete
##
## Deletes leaderboard configurations in a single request. The response lists any configurations that failed to delete along with the reason for each failure.
##
## Parameters:
## - namespace_param: Game namespace
func delete_bulk_leaderboard_configuration_admin_v3(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves a leaderboard configuration by its code
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
##
## Retrieves the leaderboard configuration identified by the specified code.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func get_leaderboard_configuration_admin_v3(
	leaderboard_code: String, namespace_param: String
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


## Updates a leaderboard configuration by its code
## PUT /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
##
## Updates the leaderboard configuration identified by the specified code. Requires a name (up to 128 characters); description is optional (up to 2048 characters). Set `allTime` to true to enable all-time rankings, and `descending` to control sort order. The `statCode` must reference a valid statistic in the Statistics service, and `cycleIds` specifies the statistic cycle IDs to track.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func update_leaderboard_configuration_admin_v3(
	leaderboard_code: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a leaderboard configuration by its code
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}
##
## Deletes the leaderboard configuration identified by the specified code.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func delete_leaderboard_configuration_admin_v3(
	leaderboard_code: String, namespace_param: String
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


## Retrieves all-time leaderboard ranking data
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
##
## Retrieves rankings from the all-time leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - include_hidden_users: Whether to include hidden users in ranking list. Omit to follow leaderboard config enableServerHiddenFilter, true to always include, false to always exclude.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_all_time_leaderboard_ranking_admin_v3(
	leaderboard_code: String,
	namespace_param: String,
	include_hidden_users: bool = false,
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
	query_params["includeHiddenUsers"] = include_hidden_users
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


## Retrieves ranking data for a leaderboard cycle
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}
##
## Retrieves rankings for the specified leaderboard cycle. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - cycle_id: Unique identifier of the leaderboard cycle.
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - include_hidden_users: Whether to include hidden users in ranking list. Omit to follow leaderboard config enableServerHiddenFilter, true to always include, false to always exclude.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
func get_current_cycle_leaderboard_ranking_admin_v3(
	cycle_id: String,
	leaderboard_code: String,
	namespace_param: String,
	include_hidden_users: bool = false,
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
	query_params["includeHiddenUsers"] = include_hidden_users
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


## Deletes all user rankings for a leaderboard cycle
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}/reset
##
## Deletes all user rankings for the specified leaderboard cycle. Warning: This action permanently deletes all ranking data. Make sure to back up anything important before continuing.
##
## Parameters:
## - cycle_id: human readable unique code to identify cycles.
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func delete_all_user_ranking_by_cycle_id_admin_v3(
	cycle_id: String, leaderboard_code: String, namespace_param: String
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


## Deletes a user's ranking for a leaderboard cycle
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}/users/{userId}
##
## Removes a user's ranking entry from the specified leaderboard cycle. Returns 204 regardless of whether the user had an existing entry.
##
## Parameters:
## - cycle_id: human readable unique code to identify cycles.
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_user_ranking_by_cycle_id_admin_v3(
	cycle_id: String, leaderboard_code: String, namespace_param: String, user_id: String
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


## Deletes a leaderboard configuration and all its data permanently
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/hard
##
## [Test Facility Only] Permanently deletes the leaderboard configuration and all associated data. Only available in development environments; use the archive operation instead for production use.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func hard_delete_leaderboard_admin_v3(
	leaderboard_code: String, namespace_param: String
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


## Deletes all user rankings for a leaderboard
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/reset
##
## Deletes all user rankings for the specified leaderboard code. Warning: This action permanently deletes all ranking data. Make sure to back up anything important before continuing.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func delete_user_ranking_by_leaderboard_code_admin_v3(
	leaderboard_code: String, namespace_param: String
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


## Retrieves hidden users on a leaderboard
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/hidden
##
## Retrieves users with hidden entries on the specified leaderboard. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_hidden_users_v3(
	leaderboard_code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves a user's ranking in a leaderboard
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Returns the user's current rank, score, and position within the specified leaderboard.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
func get_user_ranking_admin_v3(
	leaderboard_code: String, namespace_param: String, user_id: String, previous_version: int = -1
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


## Deletes a user's ranking from a leaderboard
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Removes a user's ranking entry from the specified leaderboard. Returns 204 regardless of whether the user had an existing entry.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_user_ranking_admin_v3(
	leaderboard_code: String, namespace_param: String, user_id: String
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


## Retrieves a user's visibility status on a leaderboard
## GET /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
##
## Returns the user's current visibility status on the leaderboard. When visibility is false, the user's entry has the hidden attribute set to true.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_visibility_status_v3(
	leaderboard_code: String, namespace_param: String, user_id: String
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


## Sets a user's visibility status on a specific leaderboard
## PUT /leaderboard/v3/admin/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}/visibility
##
## Sets the user's visibility status on the specified leaderboard. When set to false, the user's entry has the hidden attribute set to true.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func set_user_leaderboard_visibility_v3(
	leaderboard_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a user's rankings across all leaderboards
## DELETE /leaderboard/v3/admin/namespaces/{namespace}/users/{userId}
##
## Removes the specified user's ranking entries from all leaderboards in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
func delete_user_rankings_admin_v3(
	namespace_param: String, user_id: String, leaderboard_code: Array
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


## Retrieves a user's rankings across leaderboards
## GET /leaderboard/v3/admin/namespaces/{namespace}/users/{userId}/leaderboards
##
## Retrieves a user's rankings across all leaderboards in the namespace. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Sets a user's visibility status across all leaderboards
## PUT /leaderboard/v3/admin/namespaces/{namespace}/users/{userId}/visibility
##
## Sets the user's visibility status across all leaderboards. When set to false, the user's entries have the hidden attribute set to true.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func set_user_visibility_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists all leaderboard configurations in a namespace
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards
##
## Lists all leaderboard configurations in the specified namespace. Use the `limit` and `offset` parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - is_deleted: Filter for deleted leaderboard config
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_leaderboard_configurations_public_v3(
	namespace_param: String, is_deleted: bool = false, limit: int = -1, offset: int = -1
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


## Retrieves a leaderboard configuration by its code
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}
##
## Retrieves the leaderboard configuration identified by the specified code.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
func get_leaderboard_configuration_public_v3(
	leaderboard_code: String, namespace_param: String
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


## Retrieves all-time leaderboard ranking data
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/alltime
##
## Retrieves rankings from the all-time leaderboard for the specified code. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_all_time_leaderboard_ranking_public_v3(
	leaderboard_code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves ranking data for a leaderboard cycle
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/cycles/{cycleId}
##
## Retrieves rankings for the specified leaderboard cycle. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - cycle_id: Unique identifier of the leaderboard cycle.
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves rankings for a set of users in a leaderboard
## POST /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/bulk
##
## Bulk get users ranking in leaderboard, max allowed 20 userIDs at a time.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
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


## Retrieves a user's ranking in a leaderboard
## GET /leaderboard/v3/public/namespaces/{namespace}/leaderboards/{leaderboardCode}/users/{userId}
##
## Returns the user's current rank, score, and position within the specified leaderboard.
##
## Parameters:
## - leaderboard_code: Human-readable unique code identifying the leaderboard. Must be lowercase, up to 48 characters.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - previous_version: Version of leaderboard data to retrieve. When greater than 0, returns historical data that many versions back (for example, `1` returns the previous version). Currently supports up to 1 previous version. Defaults to `0` for the active leaderboard.
func get_user_ranking_public_v3(
	leaderboard_code: String, namespace_param: String, user_id: String, previous_version: int = -1
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
