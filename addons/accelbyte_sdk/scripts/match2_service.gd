## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## match2_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: Justice Match Service v2
## Version: 2.42.1
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


## Checks service health
## GET /healthz
##
## Checks whether the Match2 service is running and reachable. Returns a 200 response with no body when healthy.
func get_healthcheck_info() -> Dictionary:
	# Build URL path
	var url_path: String = "/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Checks service health
## GET /match2/healthz
##
## Checks whether the Match2 service is running and reachable. Returns a 200 response with no body when healthy.
func get_healthcheck_info_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the log configuration
## GET /match2/v1/admin/config/log
##
## Returns the log configuration for the service.
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the log configuration
## PATCH /match2/v1/admin/config/log
##
## Updates the log configuration for the service.
func admin_patch_update_log_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves the play feature flag for the namespace
## GET /match2/v1/admin/namespaces/{namespace}/playfeatureflag
##
## Returns the matchmaking play feature flag for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_play_feature_flag(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/playfeatureflag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates or updates the play feature flag for the namespace
## POST /match2/v1/admin/namespaces/{namespace}/playfeatureflag
##
## Creates or updates the play feature flag configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_upsert_play_feature_flag(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/playfeatureflag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes the play feature flag for the namespace
## DELETE /match2/v1/admin/namespaces/{namespace}/playfeatureflag
##
## Delete matchmaking Play Feature Flag.
## Deleting the current namespace's custom config only removes it from the database, the system will then use the environment variable defined in the ConfigMap instead.
##
## Parameters:
## - namespace_param: Game namespace
func admin_delete_play_feature_flag(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/playfeatureflag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the X-Ray configuration for the namespace
## GET /match2/v1/admin/namespaces/{namespace}/xray/config
##
## Retrieves the X-Ray analytics configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_x_ray_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/xray/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the X-Ray configuration for the namespace
## POST /match2/v1/admin/namespaces/{namespace}/xray/config
##
## Updates the X-Ray analytics configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_x_ray_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/admin/namespaces/{namespace}/xray/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists matchmaking configurations for all namespaces
## GET /match2/v1/config
##
## Lists matchmaking configurations across all namespaces. Only includes namespaces with a custom configuration applied.
func admin_get_all_config_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/config"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the matchmaking configuration for the namespace
## GET /match2/v1/config/namespaces/{namespace}
##
## Returns the matchmaking configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_config_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the matchmaking configuration for the namespace
## PATCH /match2/v1/config/namespaces/{namespace}
##
## Partially updates the matchmaking configuration for the namespace. Only fields included in the update take effect; omitted fields are left unchanged.
##
## Parameters:
## - namespace_param: Game namespace
func admin_patch_config_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/config/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists environment variables
## GET /match2/v1/environment-variables
##
## Lists all environment variables available to the service.
func environment_variable_list() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/environment-variables"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Queries backfill tickets in the namespace
## GET /match2/v1/namespaces/{namespace}/backfill
##
## Queries backfill tickets in the namespace. Supports filtering by active status, match pool, time range, session ID, player ID, and region. Pagination is offset-based using the limit and offset parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - from_time: Beginning of backfill ticket creation time range in RFC 3339 format e.g. 2022-10-21T07:20:50Z
## - is_active: Whether to filter to only active backfill tickets. Omit to return both active and inactive.
## - limit: Number of results to return
## - match_pool: Name of the match pool to filter backfill tickets by.
## - offset: Number of results to skip for pagination
## - player_id: Player ID of the backfilled session (WARNING: slow)
## - region: Preferred region of the backfilled session (WARNING: slow)
## - session_id: Unique identifier of the backfill session to filter by.
## - to_time: End of backfill ticket creation time range in RFC 3339 format e.g. 2022-10-21T07:20:50Z
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


## Creates a backfill ticket
## POST /match2/v1/namespaces/{namespace}/backfill
##
## Creates a backfill ticket for the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func create_backfill(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/backfill"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a backfill proposal for the session
## GET /match2/v1/namespaces/{namespace}/backfill/proposal
##
## Returns the current backfill proposal for the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Unique identifier of the game session to retrieve a backfill proposal for.
func get_backfill_proposal(namespace_param: String, session_id: String) -> Dictionary:
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


## Retrieves a backfill ticket by ID
## GET /match2/v1/namespaces/{namespace}/backfill/{backfillID}
##
## Returns a backfill ticket by its ID.
##
## Parameters:
## - backfill_id: Unique identifier of the backfill ticket to retrieve.
## - namespace_param: Game namespace
func get_backfill(backfill_id: String, namespace_param: String) -> Dictionary:
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


## Deletes a backfill ticket
## DELETE /match2/v1/namespaces/{namespace}/backfill/{backfillID}
##
## Deletes an existing backfill ticket.
##
## Parameters:
## - backfill_id: Unique identifier of the backfill ticket to delete.
## - namespace_param: Game namespace
func delete_backfill(backfill_id: String, namespace_param: String) -> Dictionary:
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


## Accepts a backfill proposal
## PUT /match2/v1/namespaces/{namespace}/backfill/{backfillID}/proposal/accept
##
## Accepts a backfill proposal for the specified backfill ticket. Use **acceptedTicketIds** to selectively accept specific tickets; the matchmaker rejects and reactivates any unlisted tickets for future proposals. Omit **acceptedTicketIds** or leave it nil to accept all tickets in the proposal.
##
## Parameters:
## - backfill_id: Unique identifier of the backfill ticket whose proposal to accept.
## - namespace_param: Game namespace
func accept_backfill(
	backfill_id: String, namespace_param: String, body: Dictionary = {}
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


## Rejects a backfill proposal
## PUT /match2/v1/namespaces/{namespace}/backfill/{backfillID}/proposal/reject
##
## Rejects the current backfill proposal for the specified namespace.
##
## Parameters:
## - backfill_id: Unique identifier of the backfill ticket whose proposal to reject.
## - namespace_param: Game namespace
func reject_backfill(
	backfill_id: String, namespace_param: String, body: Dictionary = {}
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


## Lists match functions in the namespace
## GET /match2/v1/namespaces/{namespace}/match-functions
##
## Lists match functions registered in the namespace. Pagination is offset-based using the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func match_function_list(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Creates a match function
## POST /match2/v1/namespaces/{namespace}/match-functions
##
## Creates a new matchmaking function.
##
## Parameters:
## - namespace_param: Game namespace
func create_match_function(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-functions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a match function by name
## GET /match2/v1/namespaces/{namespace}/match-functions/{name}
##
## Returns a custom match function by its name.
##
## Parameters:
## - name_param: Name of the custom match function
## - namespace_param: Game namespace
func match_function_get(name_param: String, namespace_param: String) -> Dictionary:
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


## Updates a match function
## PUT /match2/v1/namespaces/{namespace}/match-functions/{name}
##
## Updates an existing matchmaking function.
##
## Parameters:
## - name_param: Name of the match function
## - namespace_param: Game namespace
func update_match_function(
	name_param: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a match function
## DELETE /match2/v1/namespaces/{namespace}/match-functions/{name}
##
## Deletes an existing match function.
##
## Parameters:
## - name_param: Name of the match function
## - namespace_param: Game namespace
func delete_match_function(name_param: String, namespace_param: String) -> Dictionary:
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


## Lists match pools in the namespace
## GET /match2/v1/namespaces/{namespace}/match-pools
##
## Lists matchmaking pools in the namespace. Pagination is offset-based using the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Match Pool name
## - offset: Number of results to skip for pagination
func match_pool_list(
	namespace_param: String, limit: int = -1, name_param: String = "", offset: int = -1
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


## Creates a match pool
## POST /match2/v1/namespaces/{namespace}/match-pools
##
## Creates a new matchmaking pool.
##
## A pool operates independently of other pools â tickets only match with other tickets in the same pool. Each pool has its own matchmaking rules and logic.
##
## `ticket_expiration_seconds` and `backfill_ticket_expiration_seconds` default to 300 seconds (5 minutes) if not provided.
##
## Match Function specifies the name of the match logic server that matchmaking refers to. By default, "default" and "basic" are available. Match Function serves as the reference value for Match Function Overrides when not explicitly set.
##
## To use the matchmaking service default match logic, specify it in match_function_overrides. Example:
## {
## "match_function": "custom",
## "match_function_overrides": {
## "validation": ["default","custom"],
## "make_matches": "default"
## }
## }
##
## Parameters:
## - namespace_param: Game namespace
func create_match_pool(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-pools"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves details for a match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}
##
## Returns configuration and details for the specified match pool.
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
func match_pool_details(namespace_param: String, pool: String) -> Dictionary:
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


## Updates a match pool
## PUT /match2/v1/namespaces/{namespace}/match-pools/{pool}
##
## Updates an existing matchmaking pool.
##
## ticket_expiration_seconds and backfill_ticket_expiration_seconds default to 300 seconds (5 minutes) if not provided.
##
## Match Function specifies the name of the match logic server that matchmaking refers to. By default, "default" and "basic" are available. Match Function serves as the reference value for Match Function Overrides when not explicitly set.
##
## To use the matchmaking service default match logic, specify it in match_function_overrides. Example:
## {
## "match_function": "custom",
## "match_function_overrides": {
## "validation": ["default","custom"],
## "make_matches": "default"
## }
## }
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
func update_match_pool(namespace_param: String, pool: String, body: Dictionary = {}) -> Dictionary:
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


## Deletes a match pool
## DELETE /match2/v1/namespaces/{namespace}/match-pools/{pool}
##
## Deletes an existing matchmaking pool.
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
func delete_match_pool(namespace_param: String, pool: String) -> Dictionary:
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


## Retrieves metrics for a match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics
##
## Returns metrics for the specified match pool. The result includes queueTime in seconds.
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
func match_pool_metric(namespace_param: String, pool: String) -> Dictionary:
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


## Records an external flow failure metric for a match pool
## POST /match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics/external-failure
##
## Records metrics for an external flow failure in the specified match pool.
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
func post_match_error_metric(
	namespace_param: String, pool: String, body: Dictionary = {}
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


## Retrieves player metrics for a match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}/metrics/player
##
## Returns player metrics for the specified match pool.
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
func get_player_metric(namespace_param: String, pool: String) -> Dictionary:
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


## Retrieves tickets in the queue for a match pool
## GET /match2/v1/namespaces/{namespace}/match-pools/{pool}/tickets
##
## Retrieves the current tickets in the matchmaking queue for a match pool. Returns the count and details for each queued ticket. Pagination is offset-based using the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_match_pool_tickets(
	namespace_param: String, pool: String, limit: int = -1, offset: int = -1
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


## Creates a matchmaking ticket
## POST /match2/v1/namespaces/{namespace}/match-tickets
##
## Creates a new request for matchmaking.
##
## Cross Platform: Allow player to play game with "all" registered platforms.
## 1. You can enable Cross Platform through session service or create match ticket.
## a. via ticket: specify several cross_platform on create match ticket attributes. **[DEPRECATED]** client should not send from attribute; the backend populates `cross_platform` automatically.
## This value will override player attributes in session service. e.g. cross_platform:[xbox,psn,steam]
## b. via session service: set player/party cross_platform attributes.
## c. Enable match options ruleset with name cross_platform and type "all".
## ```
## {
## "name": "co-op",
## "data": {
## "alliance": {
## "min_number": 1,
## "max_number": 1,
## "player_min_number": 1,
## "player_max_number": 4
## },
## "match_options": {
## "options": [
## {"name": "cross_platform", "type": "all"}
## ]
## }
## }
## }
## ```
## 2. Cross Platform can be disabled from the matchpool configuration `crossplay_disabled=true`
## 3. When matchpool `crossplay_disabled=false`
## * request attribute cross_platform is empty **[Recommended]**:
## * Matchmaking will consider Party leader `crossplayEnabled` preference or Session attribute `crossplayEnabled` preference.
## * When `crossplayEnabled=true` matchmaking populates `cross_platforms` attributes from [active login methods](/iam/apidocs/#/Third%20Party%20Credential/RetrieveAllActiveThirdPartyLoginPlatformCredentialPublicV3), otherwise it sets them to the leader's current platform.
## * When `crossplayEnabled=false` matchmaking sets `cross_platforms` attributes to the user's currentPlatform.
## * request attribute cross_platform is not empty **[Not Recommended]**:
## * Cross Platform can be disabled with specify only ONE cross_platform. Current matchmaking use this behavior. e.g. cross_platform:[xbox]
## * Multiple cross_platform values is considered to be crossplay enabled
## 4. This behavior only works for Default Matchmaker. Custom matchmaker (custom gRPC matchmaker) need to consider this on its own implementation.
##
## ExcludedSessions: allow player to list out game sessions that they want to avoid matching, for example a match that they've recently left or get kicked out from.
##
## Parameters:
## - namespace_param: Game namespace
func create_match_ticket(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/match-tickets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves match tickets for the current user
## GET /match2/v1/namespaces/{namespace}/match-tickets/me
##
## Retrieves matchmaking tickets belonging to the current user. Pagination is offset-based using the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - match_pool: Name of the match pool to filter tickets by.
## - offset: Number of results to skip for pagination
func get_my_match_tickets(
	namespace_param: String, limit: int = -1, match_pool: String = "", offset: int = -1
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


## Retrieves details for a match ticket
## GET /match2/v1/namespaces/{namespace}/match-tickets/{ticketid}
##
## Returns the details of the specified matchmaking ticket.
##
## Parameters:
## - namespace_param: Game namespace
## - ticketid: Id of the ticket to get the status of
func match_ticket_details(namespace_param: String, ticketid: String) -> Dictionary:
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


## Deletes a matchmaking ticket
## DELETE /match2/v1/namespaces/{namespace}/match-tickets/{ticketid}
##
## Deletes an existing matchmaking ticket.
##
## Parameters:
## - namespace_param: Game namespace
## - ticketid: ID of the match ticket
func delete_match_ticket(namespace_param: String, ticketid: String) -> Dictionary:
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


## Lists rule sets in the namespace
## GET /match2/v1/namespaces/{namespace}/rulesets
##
## Lists rule sets registered in the namespace. Pagination is offset-based using the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Rule Set name
## - offset: Number of results to skip for pagination
func rule_set_list(
	namespace_param: String, limit: int = -1, name_param: String = "", offset: int = -1
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


## Creates a match rule set
## POST /match2/v1/namespaces/{namespace}/rulesets
##
## Creates a new rule set.
##
## A rule set has a name and contains arbitrary data meaningful to one or more match functions. A match pool uses the name to select the rule set data to send to the match function when matchmaking in that pool.
##
## To use a custom rule set, set enable_custom_match_function=true. Default: false.
##
## When enable_custom_match_function=true, the rule set only checks whether the rule is valid JSON.
##
## Parameters:
## - namespace_param: Game namespace
func create_rule_set(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/v1/namespaces/{namespace}/rulesets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves details for a rule set
## GET /match2/v1/namespaces/{namespace}/rulesets/{ruleset}
##
## Returns the configuration and details for the specified rule set.
##
## Parameters:
## - namespace_param: Game namespace
## - ruleset: Name of the rule set
func rule_set_details(namespace_param: String, ruleset: String) -> Dictionary:
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


## Updates a match rule set
## PUT /match2/v1/namespaces/{namespace}/rulesets/{ruleset}
##
## Updates an existing matchmaking rule set.
##
## To use a custom rule set, set enable_custom_match_function=true. Default: false.
##
## When enable_custom_match_function=true, the rule set only checks whether the rule is valid JSON.
##
## Parameters:
## - namespace_param: Game namespace
## - ruleset: Name of the match rule set
func update_rule_set(namespace_param: String, ruleset: String, body: Dictionary = {}) -> Dictionary:
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


## Deletes a rule set
## DELETE /match2/v1/namespaces/{namespace}/rulesets/{ruleset}
##
## Deletes an existing rule set.
##
## Parameters:
## - namespace_param: Game namespace
## - ruleset: Name of the rule set
func delete_rule_set(namespace_param: String, ruleset: String) -> Dictionary:
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


## Retrieves player metrics for a match pool
## GET /match2/v1/public/namespaces/{namespace}/match-pools/{pool}/metrics/player
##
## Returns player metrics for the specified match pool.
##
## Parameters:
## - namespace_param: Game namespace
## - pool: Name of the match pool
func public_get_player_metric(namespace_param: String, pool: String) -> Dictionary:
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


## Checks the service version
## GET /match2/version
##
## Returns the current version of the Match2 service.
func version_check_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/match2/version"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
