## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## match2_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: Justice Match Service v2
## Version: 2.38.2
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(Match2Service)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name Match2Service
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

## GetHealthcheckInfo
## GET /healthz
func get_healthcheck_info() -> Dictionary:
	# Build URL path
	var url_path: String = "/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## GetHealthcheckInfoV1
## GET /match2/healthz
func get_healthcheck_info_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Log Configuration
## GET /match2/v1/admin/config/log
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Patch Update Log Configuration
## PATCH /match2/v1/admin/config/log
func admin_patch_update_log_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## admin Play Feature Flag
## GET /match2/v1/admin/namespaces/{namespace}/playfeatureflag
func admin_get_play_feature_flag(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/playfeatureflag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin Upsert Play Feature Flag
## POST /match2/v1/admin/namespaces/{namespace}/playfeatureflag
func admin_upsert_play_feature_flag(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/playfeatureflag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin Delete Play Feature Flag
## DELETE /match2/v1/admin/namespaces/{namespace}/playfeatureflag
func admin_delete_play_feature_flag(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/playfeatureflag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin get XRay config
## GET /match2/v1/admin/namespaces/{namespace}/xray/config
func admin_get_x_ray_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/xray/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin update XRay config
## POST /match2/v1/admin/namespaces/{namespace}/xray/config
func admin_update_x_ray_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/xray/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## admin get all namespaces config
## GET /match2/v1/config
func admin_get_all_config_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/config"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin get namespace config
## GET /match2/v1/config/namespaces/{namespace}
func admin_get_config_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## admin patch update namespace config
## PATCH /match2/v1/config/namespaces/{namespace}
func admin_patch_config_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## List environment variables
## GET /match2/v1/environment-variables
func environment_variable_list() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/environment-variables"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Query backfill ticket 
## GET /match2/v1/namespaces/{namespace}/backfill
func admin_query_backfill(
	namespace_param: String,
	from_time: String = "",
	is_active: bool = false,
	limit: int = -1,
	match_pool: String = "",
	offset: int = -1,
	player_id: String = "",
	region: String = "",
	session_id: String = "",
	to_time: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not from_time.is_empty():
		query_params["fromTime"] = from_time
	query_params["isActive"] = is_active
	if limit >= 0:
		query_params["limit"] = limit
	if not match_pool.is_empty():
		query_params["matchPool"] = match_pool
	if offset >= 0:
		query_params["offset"] = offset
	if not player_id.is_empty():
		query_params["playerID"] = player_id
	if not region.is_empty():
		query_params["region"] = region
	if not session_id.is_empty():
		query_params["sessionID"] = session_id
	if not to_time.is_empty():
		query_params["toTime"] = to_time
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a backfill ticket
## POST /match2/v1/namespaces/{namespace}/backfill
func create_backfill(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get backfill proposal
## GET /match2/v1/namespaces/{namespace}/backfill/proposal
func get_backfill_proposal(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill/proposal"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not session_id.is_empty():
		query_params["sessionID"] = session_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a backfill ticket
## GET /match2/v1/namespaces/{namespace}/backfill/{backfillID}
func get_backfill(
	backfill_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill/{backfillID}"
	url_path = url_path.replace("{" + "backfillID" + "}", backfill_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete a backfill ticket
## DELETE /match2/v1/namespaces/{namespace}/backfill/{backfillID}
func delete_backfill(
	backfill_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill/{backfillID}"
	url_path = url_path.replace("{" + "backfillID" + "}", backfill_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Accept a backfill proposal
## PUT /match2/v1/namespaces/{namespace}/backfill/{backfillID}/proposal/accept
func accept_backfill(
	backfill_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill/{backfillID}/proposal/accept"
	url_path = url_path.replace("{" + "backfillID" + "}", backfill_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Reject a backfill proposal
## PUT /match2/v1/namespaces/{namespace}/backfill/{backfillID}/proposal/reject
func reject_backfill(
	backfill_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill/{backfillID}/proposal/reject"
	url_path = url_path.replace("{" + "backfillID" + "}", backfill_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## List existing match functions
## GET /match2/v1/namespaces/{namespace}/match-functions
func match_function_list(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-functions"
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

## Create a match function
## POST /match2/v1/namespaces/{namespace}/match-functions
func create_match_function(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-functions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get custom match function by name
## GET /match2/v1/namespaces/{namespace}/match-functions/{name}
func match_function_get(
	name_param: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-functions/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a match function
## PUT /match2/v1/namespaces/{namespace}/match-functions/{name}
func update_match_function(
	name_param: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-functions/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a match function
## DELETE /match2/v1/namespaces/{namespace}/match-functions/{name}
func delete_match_function(
	name_param: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-functions/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List match pools
## GET /match2/v1/namespaces/{namespace}/match-pools
func match_pool_list(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools"
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
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a match pool
## POST /match2/v1/namespaces/{namespace}/match-pools
func create_match_pool(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get details for a specific match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}
func match_pool_details(
	namespace_param: String,
	pool: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools/{pool}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a match pool
## PUT /match2/v1/namespaces/{namespace}/match-pools/{pool}
func update_match_pool(
	namespace_param: String,
	pool: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools/{pool}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a match pool
## DELETE /match2/v1/namespaces/{namespace}/match-pools/{pool}
func delete_match_pool(
	namespace_param: String,
	pool: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools/{pool}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get metrics for a specific match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics
func match_pool_metric(
	namespace_param: String,
	pool: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Post metrics for external flow failure in a specific match pool
## POST /match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics/external-failure
func post_match_error_metric(
	namespace_param: String,
	pool: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics/external-failure"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get metrics player for a specific match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics/player
func get_player_metric(
	namespace_param: String,
	pool: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics/player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get tickets in queue for a specific match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}/tickets
func admin_get_match_pool_tickets(
	namespace_param: String,
	pool: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools/{pool}/tickets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
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

## Create a matchmaking ticket
## POST /match2/v1/namespaces/{namespace}/match-tickets
func create_match_ticket(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-tickets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get my match tickets
## GET /match2/v1/namespaces/{namespace}/match-tickets/me
func get_my_match_tickets(
	namespace_param: String,
	limit: int = -1,
	match_pool: String = "",
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-tickets/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not match_pool.is_empty():
		query_params["matchPool"] = match_pool
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get details for a specific match ticket
## GET /match2/v1/namespaces/{namespace}/match-tickets/{ticketid}
func match_ticket_details(
	namespace_param: String,
	ticketid: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-tickets/{ticketid}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketid" + "}", ticketid.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete a match ticket
## DELETE /match2/v1/namespaces/{namespace}/match-tickets/{ticketid}
func delete_match_ticket(
	namespace_param: String,
	ticketid: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-tickets/{ticketid}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketid" + "}", ticketid.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List existing rule sets
## GET /match2/v1/namespaces/{namespace}/rulesets
func rule_set_list(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/rulesets"
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
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a match rule set
## POST /match2/v1/namespaces/{namespace}/rulesets
func create_rule_set(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/rulesets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get details for a specific rule set
## GET /match2/v1/namespaces/{namespace}/rulesets/{ruleset}
func rule_set_details(
	namespace_param: String,
	ruleset: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/rulesets/{ruleset}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ruleset" + "}", ruleset.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a match rule set
## PUT /match2/v1/namespaces/{namespace}/rulesets/{ruleset}
func update_rule_set(
	namespace_param: String,
	ruleset: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/rulesets/{ruleset}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ruleset" + "}", ruleset.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a rule set
## DELETE /match2/v1/namespaces/{namespace}/rulesets/{ruleset}
func delete_rule_set(
	namespace_param: String,
	ruleset: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/rulesets/{ruleset}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ruleset" + "}", ruleset.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get metrics player for a specific match pool
## GET /match2/v1/public/namespaces/{namespace}/match-pools/{pool}/metrics/player
func public_get_player_metric(
	namespace_param: String,
	pool: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/public/namespaces/{namespace}/match-pools/{pool}/metrics/player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "pool" + "}", pool.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## versionCheckHandler
## GET /match2/version
func version_check_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/version"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
