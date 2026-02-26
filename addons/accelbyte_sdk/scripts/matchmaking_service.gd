## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## matchmaking_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: Justice Matchmaking Service
## Version: 2.30.7
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(MatchmakingService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name MatchmakingService
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

## handlerV3Healthz
## GET /matchmaking/healthz
func handler_v3_healthz() -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all channels
## GET /matchmaking/namespaces/{namespace}/channels
## @deprecated
func get_all_channels_handler(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/channels"
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

## Create a channel
## POST /matchmaking/namespaces/{namespace}/channels
## @deprecated
func create_channel_handler(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get metrics for a specific channel
## GET /matchmaking/namespaces/{namespace}/channels/{channelName}/metrics
## @deprecated
func get_match_pool_metric(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/channels/{channelName}/metrics"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete a channel
## DELETE /matchmaking/namespaces/{namespace}/channels/{channel}
## @deprecated
func delete_channel_handler(
	channel: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/channels/{channel}"
	url_path = url_path.replace("{" + "channel" + "}", channel.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Store match result
## POST /matchmaking/namespaces/{namespace}/matchresult
## @deprecated
func store_match_results(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/matchresult"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Rebalance Matchmaking based on MMR
## POST /matchmaking/namespaces/{namespace}/rebalance
## @deprecated
func rebalance(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/rebalance"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Queue joinable session
## POST /matchmaking/namespaces/{namespace}/sessions
## @deprecated
func queue_session_handler(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/sessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Dequeue joinable session
## POST /matchmaking/namespaces/{namespace}/sessions/dequeue
## @deprecated
func dequeue_session_handler(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/sessions/dequeue"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query joinable session status
## GET /matchmaking/namespaces/{namespace}/sessions/{matchID}/status
## @deprecated
func query_session_handler(
	match_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/namespaces/{namespace}/sessions/{matchID}/status"
	url_path = url_path.replace("{" + "matchID" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update player -- playtime connection weight
## PATCH /matchmaking/social/playtime/namespaces/{namespace}/weight
## @deprecated
func update_play_time_weight(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/social/playtime/namespaces/{namespace}/weight"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get all party in all channels
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/all/parties
## @deprecated
func get_all_party_in_all_channel(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/all/parties"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get sessions
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/all/sessions/bulk
## @deprecated
func bulk_get_sessions(
	namespace_param: String,
	match_i_ds: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/all/sessions/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not match_i_ds.is_empty():
		query_params["matchIDs"] = match_i_ds
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Export channels
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/export
## @deprecated
func export_channels(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Import channels
## POST /matchmaking/v1/admin/namespaces/{namespace}/channels/import
## @deprecated
func import_channels(
	namespace_param: String,
	file: String = "",
	strategy: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get single channel
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}
## @deprecated
func get_single_matchmaking_channel(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a channel
## PATCH /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}
## @deprecated
func update_matchmaking_channel(
	channel_name: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Delete all mock tickets and matches
## DELETE /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks
## @deprecated
func clean_all_mocks(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get all mock matches
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/matches
## @deprecated
func get_all_mock_matches(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/matches"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get mock matches after timestamp
## POST /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/matches
## @deprecated
func get_mock_matches_by_timestamp(
	channel_name: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/matches"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get all mock tickets
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets
## @deprecated
func get_all_mock_tickets(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create mock tickets
## POST /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets
## @deprecated
func create_mock_tickets(
	channel_name: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk create mock tickets
## POST /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets/bulk
## @deprecated
func bulk_create_mock_tickets(
	channel_name: String,
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets/bulk"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get mock tickets after timestamp
## POST /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets/query
## @deprecated
func get_mock_tickets_by_timestamp(
	channel_name: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/mocks/tickets/query"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get all party in a channel
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/parties
## @deprecated
func get_all_party_in_channel(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/parties"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all channel sessions
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions
## @deprecated
func get_all_sessions_in_channel(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add user into the session in a channel
## POST /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions/{matchID}
## @deprecated
func add_user_into_session_in_channel(
	channel_name: String,
	match_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions/{matchID}"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	url_path = url_path.replace("{" + "matchID" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete session in a channel
## DELETE /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions/{matchID}
## @deprecated
func delete_session_in_channel(
	channel_name: String,
	match_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions/{matchID}"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	url_path = url_path.replace("{" + "matchID" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete user from the session in a channel
## DELETE /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions/{matchID}/users/{userID}
## @deprecated
func delete_user_from_session_in_channel(
	channel_name: String,
	match_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/sessions/{matchID}/users/{userID}"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	url_path = url_path.replace("{" + "matchID" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userID" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get stats
## GET /matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/stats
## @deprecated
func get_stat_data(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/channels/{channelName}/stats"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Search sessions
## GET /matchmaking/v1/admin/namespaces/{namespace}/sessions/history/search
## @deprecated
func search_sessions(
	namespace_param: String,
	limit: int,
	offset: int,
	channel: String = "",
	deleted: bool = false,
	match_id: String = "",
	party_id: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/sessions/history/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not channel.is_empty():
		query_params["channel"] = channel
	query_params["deleted"] = deleted
	if not match_id.is_empty():
		query_params["matchID"] = match_id
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not user_id.is_empty():
		query_params["userID"] = user_id
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

## Get session history detailed
## GET /matchmaking/v1/admin/namespaces/{namespace}/sessions/{matchID}/history/detailed
## @deprecated
func get_session_history_detailed(
	match_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/admin/namespaces/{namespace}/sessions/{matchID}/history/detailed"
	url_path = url_path.replace("{" + "matchID" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get service messages
## GET /matchmaking/v1/messages
## @deprecated
func public_get_messages() -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/messages"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all channels
## GET /matchmaking/v1/public/namespaces/{namespace}/channels
## @deprecated
func public_get_all_matchmaking_channel(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/public/namespaces/{namespace}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get single channel
## GET /matchmaking/v1/public/namespaces/{namespace}/channels/{channelName}
## @deprecated
func public_get_single_matchmaking_channel(
	channel_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v1/public/namespaces/{namespace}/channels/{channelName}"
	url_path = url_path.replace("{" + "channelName" + "}", channel_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Search sessions
## GET /matchmaking/v2/admin/namespaces/{namespace}/sessions/history/search
## @deprecated
func search_sessions_v2(
	namespace_param: String,
	limit: int,
	offset: int,
	channel: String = "",
	deleted: bool = false,
	match_id: String = "",
	party_id: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/v2/admin/namespaces/{namespace}/sessions/history/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not channel.is_empty():
		query_params["channel"] = channel
	query_params["deleted"] = deleted
	if not match_id.is_empty():
		query_params["matchID"] = match_id
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not user_id.is_empty():
		query_params["userID"] = user_id
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

## versionCheckHandler
## GET /matchmaking/version
func version_check_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/matchmaking/version"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
