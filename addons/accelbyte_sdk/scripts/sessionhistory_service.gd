## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## sessionhistory_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-session-history-service
## Version: 1.14.6
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(SessionhistoryService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name SessionhistoryService
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

## postgresStatsHandler
## GET /sessionhistory/admin/internal/db-pg-stats
func postgres_stats_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/admin/internal/db-pg-stats"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## redisStatsHandler
## GET /sessionhistory/admin/internal/db-redis-stats
func redis_stats_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/admin/internal/db-redis-stats"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## GetHealthcheckInfoV1
## GET /sessionhistory/healthz
func get_healthcheck_info_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Runtime Environment Variable Configuration
## GET /sessionhistory/v1/admin/config/env
func admin_get_env_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/env"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Patch Update Runtime Environment Variable Configuration
## PATCH /sessionhistory/v1/admin/config/env
func admin_patch_update_env_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/env"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get Log Configuration
## GET /sessionhistory/v1/admin/config/log
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Patch Update Log Configuration
## PATCH /sessionhistory/v1/admin/config/log
func admin_patch_update_log_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get all game sessions history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/gamesessions
func admin_query_game_session_detail(
	namespace_param: String,
	completed_only: String = "",
	configuration_name: String = "",
	ds_pod_name: String = "",
	end_date: String = "",
	game_session_id: String = "",
	is_persistent: String = "",
	joinability: String = "",
	limit: int = -1,
	match_pool: String = "",
	offset: int = -1,
	order: String = "",
	order_by: String = "",
	start_date: String = "",
	status_v2: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not completed_only.is_empty():
		query_params["completedOnly"] = completed_only
	if not configuration_name.is_empty():
		query_params["configurationName"] = configuration_name
	if not ds_pod_name.is_empty():
		query_params["dsPodName"] = ds_pod_name
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not game_session_id.is_empty():
		query_params["gameSessionID"] = game_session_id
	if not is_persistent.is_empty():
		query_params["isPersistent"] = is_persistent
	if not joinability.is_empty():
		query_params["joinability"] = joinability
	if limit >= 0:
		query_params["limit"] = limit
	if not match_pool.is_empty():
		query_params["matchPool"] = match_pool
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not status_v2.is_empty():
		query_params["statusV2"] = status_v2
	if not user_id.is_empty():
		query_params["userID"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get game session detail.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}
func get_game_session_detail(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all matchmaking history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/matchmaking
func admin_query_matchmaking_detail(
	namespace_param: String,
	game_session_id: String = "",
	limit: int = -1,
	offset: int = -1,
	order: String = "",
	order_by: String = "",
	ticket_id: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/matchmaking"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not game_session_id.is_empty():
		query_params["gameSessionID"] = game_session_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not ticket_id.is_empty():
		query_params["ticketID"] = ticket_id
	if not user_id.is_empty():
		query_params["userID"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get detail matchmaking history by session ID.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/session/{sessionId}
func admin_get_matchmaking_detail_by_session_id(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/session/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get detail matchmaking history by ticket ID.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/ticket/{ticketId}
func admin_get_matchmaking_detail_by_ticket_id(
	namespace_param: String,
	ticket_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/ticket/{ticketId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketId" + "}", ticket_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all parties history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/parties
func admin_query_party_detail(
	namespace_param: String,
	configuration_name: String = "",
	end_date: String = "",
	joinability: String = "",
	leader_id: String = "",
	limit: int = -1,
	offset: int = -1,
	order: String = "",
	order_by: String = "",
	party_id: String = "",
	start_date: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/parties"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not configuration_name.is_empty():
		query_params["configurationName"] = configuration_name
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not joinability.is_empty():
		query_params["joinability"] = joinability
	if not leader_id.is_empty():
		query_params["leaderID"] = leader_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not user_id.is_empty():
		query_params["userID"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get party detail.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/parties/{sessionId}
func get_party_detail(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/parties/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all matchmaking ticket history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/tickets
func admin_query_ticket_detail(
	namespace_param: String,
	end_date: String = "",
	game_mode: String = "",
	limit: int = -1,
	offset: int = -1,
	order: String = "",
	party_id: String = "",
	region: String = "",
	start_date: String = "",
	user_i_ds: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/tickets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not game_mode.is_empty():
		query_params["gameMode"] = game_mode
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not region.is_empty():
		query_params["region"] = region
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not user_i_ds.is_empty():
		query_params["userIDs"] = user_i_ds
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get detail matchmaking ticket history by ticket ID.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/tickets/{ticketId}
func admin_ticket_detail_get_by_ticket_id(
	namespace_param: String,
	ticket_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/tickets/{ticketId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketId" + "}", ticket_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all game sessions history for current user.
## GET /sessionhistory/v1/public/namespaces/{namespace}/users/me/gamesessions
func public_query_game_session_me(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	order: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v1/public/namespaces/{namespace}/users/me/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query xray match pool
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}
func query_xray_match_pool(
	namespace_param: String,
	pool_name: Array,
	end_date: String,
	start_date: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "poolName" + "}", ",".join(pool_name).uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query xray match pool ticks
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks
func query_detail_tick_match_pool(
	namespace_param: String,
	pod_name: String,
	pool_name: String,
	end_date: String,
	start_date: String,
	all: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "podName" + "}", pod_name.uri_encode())
	url_path = url_path.replace("{" + "poolName" + "}", pool_name.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["all"] = all
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query xray match pool tick matches by tick id
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/matches
func query_detail_tick_match_pool_matches(
	namespace_param: String,
	pod_name: String,
	pool_name: String,
	tick_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/matches"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "podName" + "}", pod_name.uri_encode())
	url_path = url_path.replace("{" + "poolName" + "}", pool_name.uri_encode())
	url_path = url_path.replace("{" + "tickId" + "}", tick_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query xray match pool tick tickets by tick id
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/tickets
func query_detail_tick_match_pool_ticket(
	namespace_param: String,
	pod_name: String,
	pool_name: String,
	tick_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/tickets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "podName" + "}", pod_name.uri_encode())
	url_path = url_path.replace("{" + "poolName" + "}", pool_name.uri_encode())
	url_path = url_path.replace("{" + "tickId" + "}", tick_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query xray match histories
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/histories
func query_match_histories(
	match_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/histories"
	url_path = url_path.replace("{" + "matchId" + "}", match_id.uri_encode())
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

## Query xray match ticket histories
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/ticket-histories
func query_match_ticket_histories(
	match_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/ticket-histories"
	url_path = url_path.replace("{" + "matchId" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query xray timeline by matchID
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/tickets
func query_xray_match(
	match_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/tickets"
	url_path = url_path.replace("{" + "matchId" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total success and failed claim DS
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds
func query_acquiring_ds(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query acquiring ds wait time average
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds-wait-time-avg
func query_acquiring_ds_wait_time_avg(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds-wait-time-avg"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query match length duration avg
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-avg
func query_match_length_durationp_avg(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-avg"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query match length duration p99
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-p99
func query_match_length_durationp99(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-p99"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total active session
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-active-session
func query_total_active_session(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = [],
	region: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-active-session"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not region.is_empty():
		query_params["region"] = region
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total match
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-match
func query_total_matchmaking_match(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-match"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total player persession average
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-player-persession-avg
func query_total_player_persession(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-player-persession-avg"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total ticket canceled
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-canceled
func query_total_matchmaking_canceled(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-canceled"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total ticket created
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-created
func query_total_matchmaking_created(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-created"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total ticket expired
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-expired
func query_total_matchmaking_expired(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-expired"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query total ticket match
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-match
func query_total_matchmaking_match_ticket(
	namespace_param: String,
	end_date: String,
	start_date: String,
	match_pool: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-match"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create ticket observability request
## POST /sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets
func create_xray_ticket_observability(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create bulk ticket observability request
## POST /sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/bulk
func create_xray_bulk_ticket_observability(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query xray timeline
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/{ticketId}
func query_xray_timeline_by_ticket_id(
	namespace_param: String,
	ticket_id: String,
	end_date: String,
	start_date: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/{ticketId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketId" + "}", ticket_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query xray timeline
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/users/{userId}/tickets
func query_xray_timeline_by_user_id(
	namespace_param: String,
	user_id: String,
	end_date: String,
	start_date: String,
	limit: int = -1,
	offset: int = -1,
	order: String = "",
	order_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/users/{userId}/tickets"
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
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
