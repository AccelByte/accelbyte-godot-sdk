## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## social_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-statistics-service
## Version: 4.5.4
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(SocialService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name SocialService
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


## Lists global stat items
## GET /social/v1/admin/namespaces/{namespace}/globalstatitems
##
## Lists global stat items by pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - stat_codes: Comma separated stat codes
func get_global_stat_items(
	namespace_param: String, limit: int = -1, offset: int = -1, stat_codes: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/globalstatitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a global stat item by stat code
## GET /social/v1/admin/namespaces/{namespace}/globalstatitems/{statCode}
##
## Retrieves a global stat item by its stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The unique code identifying the global stat item.
func get_global_stat_item_by_stat_code(namespace_param: String, stat_code: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/globalstatitems/{statCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists stat cycles
## GET /social/v1/admin/namespaces/{namespace}/statCycles
##
## Lists stat cycles by pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - cycle_type: Filters results by cycle type.
## - limit: Number of results to return
## - name_param: Filters results by the stat cycle name.
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results. Allowed values: `start`, `start:asc`, `start:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`. Sort fields combine with commas, e.g. `start:asc,createdAt:desc`. Defaults to unsorted.
## - status: Filters results by cycle status.
func get_stat_cycles(
	namespace_param: String,
	cycle_type: String = "",
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not cycle_type.is_empty():
		query_params["cycleType"] = cycle_type
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a stat cycle
## POST /social/v1/admin/namespaces/{namespace}/statCycles
##
## Creates a stat cycle. The `id` field accepts alphanumeric characters up to 32 characters; if omitted, the system generates one automatically. The `name` field must not exceed 128 characters. The `resetTime` field must be in HH:mm 24-hour format. The `resetDay` field follows ISO-8601 day numbering (1=Monday, 7=Sunday); `WEEKLY` cycles require it. The `resetDate` field (1â31) is mandatory for `MONTHLY` and `ANNUALLY` cycles. The `resetMonth` field (1â12) is mandatory for `ANNUALLY` cycles. The `seasonPeriod` field specifies the period in days (at least 1); `SEASONAL` cycles require it. The `start` and `end` fields must be RFC 3339 timestamps; `start` must be present.
##
## Parameters:
## - namespace_param: Game namespace
func create_stat_cycle(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves stat cycles in bulk
## POST /social/v1/admin/namespaces/{namespace}/statCycles/bulk
##
## Retrieves stat cycles by their IDs.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_get_stat_cycle(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Exports all stat cycle configurations
## GET /social/v1/admin/namespaces/{namespace}/statCycles/export
##
## Exports all stat cycle configurations for the namespace to a file. The operation supports only JSON format.
##
## Parameters:
## - namespace_param: Game namespace
func export_stat_cycle(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Imports stat cycle configurations
## POST /social/v1/admin/namespaces/{namespace}/statCycles/import
##
## Imports stat cycle configurations for the namespace from a file. The operation supports only JSON format.
##
## Parameters:
## - namespace_param: Game namespace
## - replace_existing: Whether to replace existing stat cycles with the same ID. Defaults to false.
## - file: JSON file containing stat cycle configurations to import.
func import_stat_cycle(
	namespace_param: String, replace_existing: bool = false, file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["replaceExisting"] = replace_existing
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a stat cycle
## GET /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}
##
## Retrieves a stat cycle by its ID.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle.
## - namespace_param: Game namespace
func get_stat_cycle(cycle_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a stat cycle
## PUT /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}
##
## Updates the configuration of an existing stat cycle.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle to update.
## - namespace_param: Game namespace
func update_stat_cycle(
	cycle_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes stat cycle
## DELETE /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}
##
## Deletes the stat cycle.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle.
## - namespace_param: Game namespace
func delete_stat_cycle(cycle_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Reset stat cycle
## POST /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/reset
##
## Reset stat cycle.
## Other detail info:
##
## * This endpoint will reset the cycle immediately
##
## Parameters:
## - cycle_id: cycle id
## - namespace_param: namespace
func reset_stat_cycle(cycle_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/reset"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Adds a stat cycle to stats in bulk
## POST /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stats/add/bulk
##
## Adds a stat cycle to stats in bulk.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle.
## - namespace_param: Game namespace
func bulk_add_stats(cycle_id: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stats/add/bulk"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Stops a stat cycle
## PUT /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stop
##
## Stops the stat cycle, transitioning it to a stopped state.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle to stop.
## - namespace_param: Game namespace
func stop_stat_cycle(cycle_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stop"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves stat item values for users in bulk
## GET /social/v1/admin/namespaces/{namespace}/statitems/bulk
##
## Retrieves stat item values for users by stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code to filter results by.
## - user_ids: Comma separated user Ids
func bulk_fetch_stat_items(
	namespace_param: String, stat_code: String, user_ids: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if not user_ids.is_empty():
		query_params["userIds"] = user_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Replaces stat item values for users in bulk
## PUT /social/v1/admin/namespaces/{namespace}/statitems/value/bulk
##
## Replaces stat item values for users in bulk.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_inc_user_stat_item(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates stat item values for users in bulk
## PATCH /social/v1/admin/namespaces/{namespace}/statitems/value/bulk
##
## Updates stat item values for users in bulk.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_inc_user_stat_item_value(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves stat item values for users, returning defaults for missing items
## GET /social/v1/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault
##
## Retrieves stat item values for users by stat code. Returns the default value for any user who does not have a stat item for the specified stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code to retrieve values for.
## - user_ids: The list of user IDs to retrieve stat item values for.
func bulk_fetch_or_default_stat_items(
	namespace_param: String, stat_code: String, user_ids: Array
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if user_ids.size() > 0:
		query_params["userIds"] = user_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Resets stat item values to defaults for users in bulk
## PUT /social/v1/admin/namespaces/{namespace}/statitems/value/reset/bulk
##
## Resets stat item values for users to the default value defined in the stat configuration.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_reset_user_stat_item(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/reset/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists stats
## GET /social/v1/admin/namespaces/{namespace}/stats
##
## Lists stats by pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - cycle_ids: Comma separated cycleId
## - is_global: Flag to filter global statcode
## - is_public: Flag to filter public/private statcode
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_stats(
	namespace_param: String,
	cycle_ids: String = "",
	is_global: bool = false,
	is_public: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not cycle_ids.is_empty():
		query_params["cycleIds"] = cycle_ids
	query_params["isGlobal"] = is_global
	query_params["isPublic"] = is_public
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


## Creates a stat
## POST /social/v1/admin/namespaces/{namespace}/stats
##
## Creates a stat configuration. The lower bound defaults to 0 and the upper bound to the float64 ceiling. The `globalAggregationMethod` field has no effect when `setAsGlobal` is false.
##
## Parameters:
## - namespace_param: Game namespace
func create_stat(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Exports all stat configurations
## GET /social/v1/admin/namespaces/{namespace}/stats/export
##
## Exports all stat configurations for the namespace to a file. The operation supports only JSON format.
##
## Parameters:
## - namespace_param: Game namespace
func export_stats(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Imports stat configurations
## POST /social/v1/admin/namespaces/{namespace}/stats/import
##
## Imports stat configurations for the namespace from a file. The operation supports only JSON format.
##
## Parameters:
## - namespace_param: Game namespace
## - replace_existing: Whether to replace existing stats with the same code. Defaults to false.
## - file: JSON file containing stat configurations to import.
func import_stats(
	namespace_param: String, replace_existing: bool = false, file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["replaceExisting"] = replace_existing
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Searches stats by keyword
## GET /social/v1/admin/namespaces/{namespace}/stats/search
##
## Searches stats by keyword, returning paginated results. Use `limit` and `offset` to navigate pages.
##
## Parameters:
## - namespace_param: Game namespace
## - is_global: Flag to filter global statcode
## - is_public: Flag to filter public/private statecode
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - keyword: The keyword to search for in stat codes and names.
func query_stats(
	namespace_param: String,
	keyword: String,
	is_global: bool = false,
	is_public: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isGlobal"] = is_global
	query_params["isPublic"] = is_public
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a stat by stat code
## GET /social/v1/admin/namespaces/{namespace}/stats/{statCode}
##
## Retrieves a stat configuration by its stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The unique code identifying the stat.
func get_stat(namespace_param: String, stat_code: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes stat
## DELETE /social/v1/admin/namespaces/{namespace}/stats/{statCode}
##
## Deletes the stat configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code of the stat to delete.
func delete_stat(namespace_param: String, stat_code: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a stat
## PATCH /social/v1/admin/namespaces/{namespace}/stats/{statCode}
##
## Updates a stat configuration. Updating a TIED stat affects existing user data; changes take effect in the next evaluation. The `globalAggregationMethod` field has no effect when the stat is not set as global.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code of the stat to update.
func update_stat(namespace_param: String, stat_code: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves stat item values for users by stat code
## GET /social/v1/admin/namespaces/{namespace}/stats/{statCode}/statitems
##
## Retrieves stat item values for all users by stat code, returning paginated results. Use `limit` and `offset` to navigate pages.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code to retrieve values for.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Default is value:desc, allowed values: [value, value:asc, value:desc]
func get_stat_items(
	namespace_param: String,
	stat_code: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}/statitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
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


## Deletes tied stat
## DELETE /social/v1/admin/namespaces/{namespace}/stats/{statCode}/tied
##
## Deletes stat template.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code of the tied stat to delete.
func delete_tied_stat(namespace_param: String, stat_code: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}/tied"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists a user's stat cycle items for a stat cycle
## GET /social/v1/admin/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems
##
## Lists a user's stat cycle items for the specified stat cycle, returning paginated results. Use `limit` and `offset` to navigate pages.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - is_public: Filters results by visibility. When omitted, returns all stat items. Set to `false` to return only private stat items; set to `true` to return only public stat items.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results. Allowed values: `statCode`, `statCode:asc`, `statCode:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`. Sort fields combine with commas. Defaults to unsorted.
## - stat_codes: Comma separated stat codes
func get_user_stat_cycle_items(
	cycle_id: String,
	namespace_param: String,
	user_id: String,
	is_public: bool = false,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	stat_codes: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isPublic"] = is_public
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists a user's stat items
## GET /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems
##
## Lists a user's stat items, returning paginated results. Use `limit` and `offset` to navigate pages.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - is_public: Filters results by visibility. When omitted, returns all stat items. Set to `false` to return only private stat items; set to `true` to return only public stat items.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Default is updatedAt:asc, allow values: [statCode, statCode:asc, statCode:desc, createdAt, createdAt:asc, createdAt:desc, updatedAt, updatedAt:asc, updatedAt:desc],and support sort group, eg: sortBy=statCode:asc,createdAt:desc.
## - stat_codes: Comma-separated stat codes to filter results by.
## - tags: Comma-separated tags to filter results by.
func get_user_stat_items(
	namespace_param: String,
	user_id: String,
	is_public: bool = false,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	stat_codes: String = "",
	tags: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isPublic"] = is_public
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not tags.is_empty():
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates stat items for a user in bulk
## POST /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/bulk
##
## Creates stat items for a user in bulk.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_create_user_stat_items(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Replaces a user's stat item values in bulk
## PUT /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Replaces a user's stat item values in bulk.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_inc_user_stat_item_1(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates a user's stat item values in bulk
## PATCH /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Updates a user's stat item values in bulk.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_inc_user_stat_item_value_1(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Resets a user's stat item values to defaults in bulk
## PUT /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk
##
## Resets a user's stat item values to their defaults in bulk.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_reset_user_stat_item_1(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates a stat item for a user
## POST /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
##
## Creates a stat item for a user with the specified stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code of the stat to create a stat item for.
## - user_id: AccelByte user ID
func create_user_stat_item(
	namespace_param: String, stat_code: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes a user's stat items
## DELETE /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
##
## Intended for testing. Use this operation for test cleanup only. Deletes a user's stat items for the specified stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code of the stat items to delete.
## - user_id: AccelByte user ID
func delete_user_stat_items(
	namespace_param: String, stat_code: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a user's stat item value
## PATCH /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
##
## Updates a user's stat item value for the specified stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code of the stat item to update.
## - user_id: AccelByte user ID
func inc_user_stat_item_value(
	namespace_param: String, stat_code: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Resets a user's stat item value to its default
## PUT /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset
##
## Resets a user's stat item value to the default value defined in the stat configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code of the stat item to reset.
## - user_id: AccelByte user ID
## - additional_key: An optional secondary key for identifying a specific stat item variant to reset.
func reset_user_stat_item_value(
	namespace_param: String,
	stat_code: String,
	user_id: String,
	additional_key: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists global stat items
## GET /social/v1/public/namespaces/{namespace}/globalstatitems
##
## Lists global stat items by pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - stat_codes: Comma separated stat codes
func get_global_stat_items_1(
	namespace_param: String, limit: int = -1, offset: int = -1, stat_codes: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/globalstatitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a global stat item by stat code
## GET /social/v1/public/namespaces/{namespace}/globalstatitems/{statCode}
##
## Retrieves a global stat item by its stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The unique code identifying the global stat item.
func get_global_stat_item_by_stat_code_1(namespace_param: String, stat_code: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/globalstatitems/{statCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists stat cycles
## GET /social/v1/public/namespaces/{namespace}/statCycles
##
## Lists stat cycles by pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - cycle_type: Filters results by cycle type.
## - limit: Number of results to return
## - name_param: Filters results by the stat cycle name.
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results. Allowed values: `start`, `start:asc`, `start:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`. Sort fields combine with commas. Defaults to unsorted.
## - status: Filters results by cycle status.
func get_stat_cycles_1(
	namespace_param: String,
	cycle_type: String = "",
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statCycles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not cycle_type.is_empty():
		query_params["cycleType"] = cycle_type
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves stat cycles in bulk
## POST /social/v1/public/namespaces/{namespace}/statCycles/bulk
##
## Retrieves stat cycles by their IDs.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_get_stat_cycle_1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statCycles/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a stat cycle
## GET /social/v1/public/namespaces/{namespace}/statCycles/{cycleId}
##
## Retrieves a stat cycle by its ID.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle.
## - namespace_param: Game namespace
func get_stat_cycle_1(cycle_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves stat item values for users in bulk
## GET /social/v1/public/namespaces/{namespace}/statitems/bulk
##
## Retrieves stat item values for users in a namespace, filtered by a stat code.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: Stat code identifying the stat items to retrieve.
## - user_ids: Comma separated user Ids
func bulk_fetch_stat_items_1(
	namespace_param: String, stat_code: String, user_ids: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if not user_ids.is_empty():
		query_params["userIds"] = user_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Replaces stat item values for users in bulk
## PUT /social/v1/public/namespaces/{namespace}/statitems/value/bulk
##
## Replaces stat item values for users in bulk. Each entry specifies the user and the exact stat code value to set.
##
## Parameters:
## - namespace_param: Game namespace
func public_bulk_inc_user_stat_item(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates stat item values for users in bulk
## PATCH /social/v1/public/namespaces/{namespace}/statitems/value/bulk
##
## Updates stat item values for users in bulk. Each entry specifies the user and the stat code value to apply.
##
## Parameters:
## - namespace_param: Game namespace
func public_bulk_inc_user_stat_item_value(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Resets stat item values for users in bulk
## PUT /social/v1/public/namespaces/{namespace}/statitems/value/reset/bulk
##
## Resets stat item values for users in bulk. Each stat item is reset to its default value as defined in the statistic configuration.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_reset_user_stat_item_2(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/value/reset/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates a stat
## POST /social/v1/public/namespaces/{namespace}/stats
##
## Creates a stat template in the specified namespace. The lower bound defaults to 0 and the upper bound to the float ceiling. The `globalAggregationMethod` field has no effect when `setAsGlobal` is false.
##
## Parameters:
## - namespace_param: Game namespace
func create_stat_1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/stats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists the current user's stat cycle items for a cycle
## GET /social/v1/public/namespaces/{namespace}/users/me/statCycles/{cycleId}/statCycleitems
##
## Lists stat cycle items for the current user in the specified cycle. Supports pagination, filtering by stat code, and sorting.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results. Allowed values: `statCode`, `statCode:asc`, `statCode:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`. Sort fields combine with commas. Defaults to unsorted.
## - stat_codes: Filters results to the specified stat codes.
func public_list_my_stat_cycle_items(
	cycle_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	stat_codes: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/me/statCycles/{cycleId}/statCycleitems"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
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
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists the current user's stat items
## GET /social/v1/public/namespaces/{namespace}/users/me/statitems
##
## Public list all statItems by pagination. Other detail info: Returns: stat items
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results. Allowed values: `statCode`, `statCode:asc`, `statCode:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`. Sort fields combine with commas. Defaults to unsorted.
## - stat_codes: Filters results to the specified stat codes.
## - tags: Filters results by the specified tags.
func public_list_my_stat_items(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	stat_codes: Array = [],
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/me/statitems"
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
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists the current user's stat item values in bulk
## GET /social/v1/public/namespaces/{namespace}/users/me/statitems/value/bulk
##
## Lists all stat item values for the current user. Unrecognised stat codes are silently ignored. Stat items not yet initialized return their default value.
##
## Parameters:
## - namespace_param: Game namespace
## - additional_key: Secondary identifier for scoping stat item lookups.
## - stat_codes: Filters results to the specified stat codes.
## - tags: Filters results by the specified tags.
func public_list_all_my_stat_items(
	namespace_param: String, additional_key: String = "", stat_codes: Array = [], tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/me/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists a user's stat cycle items for a cycle
## GET /social/v1/public/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems
##
## Lists stat cycle items for the specified user in the specified cycle. Supports pagination, filtering by stat code, and sorting.
##
## Parameters:
## - cycle_id: The unique identifier of the stat cycle.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results. Allowed values: `statCode`, `statCode:asc`, `statCode:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`. Sort fields combine with commas. Defaults to unsorted.
## - stat_codes: Comma separated stat codes
func get_user_stat_cycle_items_1(
	cycle_id: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	stat_codes: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems"
	url_path = url_path.replace("{" + "cycleId" + "}", cycle_id.uri_encode())
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists a user's stat items
## GET /social/v1/public/namespaces/{namespace}/users/{userId}/statitems
##
## Public list all statItems by pagination. Other detail info: Returns: stat items
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results. Allowed values: `statCode`, `statCode:asc`, `statCode:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, `updatedAt:desc`. Sort fields combine with commas. Defaults to unsorted.
## - stat_codes: Filters results to the specified stat codes.
## - tags: Filters results by the specified tags.
func public_query_user_stat_items_1(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	stat_codes: String = "",
	tags: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not tags.is_empty():
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates stat items for a user in bulk
## POST /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/bulk
##
## Bulk create statItems. Other detail info: Returns: bulk created result
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_bulk_create_user_stat_items(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists a user's stat item values in bulk
## GET /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Lists all stat item values for the specified user. Unrecognised stat codes are silently ignored. Stat items not yet initialized return their default value.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping stat item lookups.
## - stat_codes: Filters results to the specified stat codes.
## - tags: Filters results by the specified tags.
func public_query_user_stat_items(
	namespace_param: String,
	user_id: String,
	additional_key: String = "",
	stat_codes: Array = [],
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Replaces a user's stat item values in bulk
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Public bulk update user's statitems value. Other detail info: Returns: bulk updated result
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_bulk_inc_user_stat_item_1(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates a user's stat item values in bulk
## PATCH /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Public bulk update user's statitems value. Other detail info: Returns: bulk updated result
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_inc_user_stat_item_value_2(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Resets a user's stat item values to defaults in bulk
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk
##
## Public bulk reset user's statitems value for given namespace and user.
## Other detail info:
## + *Returns*: bulk updated result
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_reset_user_stat_item_3(
	namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates a stat item for a user
## POST /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
##
## Create user's statItem. Other detail info: Returns: created user's statItem
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code identifying the stat item to create.
## - user_id: AccelByte user ID
func public_create_user_stat_item(
	namespace_param: String, stat_code: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes a user's stat item
## DELETE /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
##
## Delete user's statItems given stat code. Other detail info: Returns: no content
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code identifying the stat item to delete.
## - user_id: AccelByte user ID
func delete_user_stat_items_1(
	namespace_param: String, stat_code: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Replaces a user's stat item value
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
##
## Public update user's statitem value. Other detail info: Returns: updated user's statItem
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: Stat code identifying which stat item to replace.
## - user_id: AccelByte user ID
func public_inc_user_stat_item(
	namespace_param: String, stat_code: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates a user's stat item value
## PATCH /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
##
## Public update user's statitem value. Other detail info: Returns: updated user's statItem
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: Stat code identifying which stat item to update.
## - user_id: AccelByte user ID
func public_inc_user_stat_item_value(
	namespace_param: String, stat_code: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Resets a user's stat item to its default value
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset
##
## Reset user's statitem value for a given namespace and user.
## User's statitem value will be reset to the default value defined in the statistic configuration.
##
## Other detail info:
## + *Returns*: updated user's statItem
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code identifying the stat item to reset.
## - user_id: AccelByte user ID
func reset_user_stat_item_value_1(
	namespace_param: String, stat_code: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates stat item values for users in bulk
## PUT /social/v2/admin/namespaces/{namespace}/statitems/value/bulk
##
## Updates stat item values for users in bulk using a specified update strategy. Supported strategies: `OVERRIDE` (set to new value), `INCREMENT` (add the value), `MAX` (set if larger), `MIN` (set if smaller). Each userId + statCode combination in the request must be unique to avoid race conditions; do not include duplicate entries for the same user and stat code with different strategies in the same request.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_update_user_stat_item_v2(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves stat item values for users in bulk by stat code
## GET /social/v2/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault
##
## Retrieves stat item values for users in a namespace, filtered by a stat code. Returns the default value for users who have not yet initialised the stat item.
##
## Parameters:
## - namespace_param: Game namespace
## - additional_key: Secondary identifier for scoping stat item queries.
## - stat_code: Identifies the stat item to retrieve values for.
## - user_ids: List of user IDs whose stat item values to retrieve.
func bulk_fetch_or_default_stat_items_1(
	namespace_param: String, stat_code: String, user_ids: Array, additional_key: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if user_ids.size() > 0:
		query_params["userIds"] = user_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists a user's stat item values (legacy)
## GET /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Lists all stat item values for the specified user. Deprecated â use the POST getOrDefault operation instead. Unrecognised stat codes are silently ignored. Stat items not yet initialized return their default value.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping stat item queries.
## - stat_codes: Filters results to the specified stat codes.
## - tags: Filters results by the specified tags.
func admin_list_users_stat_items(
	namespace_param: String,
	user_id: String,
	additional_key: String = "",
	stat_codes: Array = [],
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a user's stat item values in bulk
## PUT /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Updates a user's stat item values in bulk using a specified update strategy. Supported strategies: `OVERRIDE` (set to new value), `INCREMENT` (add the value), `MAX` (set if larger), `MIN` (set if smaller). When you specify `additionalKey`, stat items use the key `userId_additionalKey`, enabling character-level stat tracking. Avoid duplicate `statCode` entries with different strategies in the same request.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping stat item updates. When specified, the system stores stat items under the key `userId_additionalKey`.
func bulk_update_user_stat_item(
	namespace_param: String, user_id: String, additional_key: String = "", body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves a user's stat item values in bulk by stat code
## POST /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk/getOrDefault
##
## Retrieves stat item values for a user by stat code. Returns the default value for stats that the user has not yet initialised. Accepts up to 20 stat codes per request.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping stat item queries.
func bulk_get_or_default_by_user_id(
	namespace_param: String, user_id: String, additional_key: String = "", body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk/getOrDefault"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Resets a user's stat item values to defaults in bulk
## PUT /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk
##
## Bulk reset user's statitem values for given namespace and user.
## Other detail info:
## + *Returns*: bulk updated result
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping stat item resets.
func bulk_reset_user_stat_item_values(
	namespace_param: String, user_id: String, additional_key: String = "", body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes stat items for a user
## DELETE /social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
##
## Deletes stat items for a user with the given stat code. When you specify `additionalKey`, the system deletes only stat items matching that key; otherwise it deletes all stat items for the user.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code identifying the stat items to delete.
## - user_id: AccelByte user ID
## - additional_key: Scopes deletion to stat items matching this key. If omitted, the operation deletes all stat items for the user under the given stat code.
func delete_user_stat_items_2(
	namespace_param: String, stat_code: String, user_id: String, additional_key: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a user's stat item value
## PUT /social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
##
## Updates a stat item value for a user using a specified update strategy. Supported strategies: `OVERRIDE` (set to new value), `INCREMENT` (add the value), `MAX` (set if larger), `MIN` (set if smaller). When you specify `additionalKey`, the stat item uses the key `userId_additionalKey`.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code identifying the stat item to update.
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping the stat item update. When specified, the stat item uses the key `userId_additionalKey`.
func update_user_stat_item_value(
	namespace_param: String,
	stat_code: String,
	user_id: String,
	additional_key: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates stat item values for users in bulk
## PUT /social/v2/public/namespaces/{namespace}/statitems/value/bulk
##
## Updates stat item values for users in bulk using a specified update strategy. Supported strategies: `OVERRIDE` (set to new value), `INCREMENT` (add the value), `MAX` (set if larger), `MIN` (set if smaller). Each userId + statCode combination in the request must be unique to avoid race conditions; do not include duplicate entries for the same user and stat code with different strategies in the same request.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_update_user_stat_item_1(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists a user's stat item values in bulk
## GET /social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Lists all stat item values for the specified user. Unrecognised stat codes are silently ignored. Stat items not yet initialized return their default value.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping stat item queries.
## - stat_codes: Filters results to the specified stat codes.
## - tags: Filters results by the specified tags.
func public_query_user_stat_items_2(
	namespace_param: String,
	user_id: String,
	additional_key: String = "",
	stat_codes: Array = [],
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a user's stat item values in bulk
## PUT /social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
##
## Updates a user's stat item values in bulk using a specified update strategy. Supported strategies: `OVERRIDE` (set to new value), `INCREMENT` (add the value), `MAX` (set if larger), `MIN` (set if smaller). When you specify `additionalKey`, stat items use the key `userId_additionalKey`, enabling character-level stat tracking.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping stat item updates. When specified, the system stores stat items under the key `userId_additionalKey`.
func bulk_update_user_stat_item_2(
	namespace_param: String, user_id: String, additional_key: String = "", body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates a user's stat item value
## PUT /social/v2/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
##
## Updates a stat item value for a user using a specified update strategy. Supported strategies: `OVERRIDE` (set to new value), `INCREMENT` (add the value), `MAX` (set if larger), `MIN` (set if smaller). When you specify `additionalKey`, the stat item uses the key `userId_additionalKey`.
##
## Parameters:
## - namespace_param: Game namespace
## - stat_code: The stat code identifying the stat item to update.
## - user_id: AccelByte user ID
## - additional_key: Secondary identifier for scoping the stat item update. When specified, the stat item uses the key `userId_additionalKey`.
func update_user_stat_item_value_1(
	namespace_param: String,
	stat_code: String,
	user_id: String,
	additional_key: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "statCode" + "}", stat_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)
