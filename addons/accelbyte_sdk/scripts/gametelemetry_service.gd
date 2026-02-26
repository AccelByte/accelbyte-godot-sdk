## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## gametelemetry_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: Analytics Game Telemetry
## Version: 1.31.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(GametelemetryService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name GametelemetryService
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

## Get Namespaces
## GET /game-telemetry/v1/admin/namespaces
func get_namespaces_game_telemetry_v1_admin_namespaces_get() -> Dictionary:
	# Build URL path
	var url_path: String = "/game-telemetry/v1/admin/namespaces"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Events
## GET /game-telemetry/v1/admin/namespaces/{namespace}/events
func get_events_game_telemetry_v1_admin_namespaces_namespace_events_get(
	namespace_param: String,
	device_type: String = "",
	end_time: String = "",
	event_id: String = "",
	event_name: String = "",
	event_payload: String = "",
	flight_id: String = "",
	limit: int = -1,
	offset: int = -1,
	start_time: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/game-telemetry/v1/admin/namespaces/{namespace}/events"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not device_type.is_empty():
		query_params["deviceType"] = device_type
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if not event_id.is_empty():
		query_params["eventId"] = event_id
	if not event_name.is_empty():
		query_params["eventName"] = event_name
	if not event_payload.is_empty():
		query_params["eventPayload"] = event_payload
	if not flight_id.is_empty():
		query_params["flightId"] = flight_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Protected Save Events
## POST /game-telemetry/v1/protected/events
func protected_save_events_game_telemetry_v1_protected_events_post(
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/game-telemetry/v1/protected/events"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Protected Get Playtime
## GET /game-telemetry/v1/protected/steamIds/{steamId}/playtime
func protected_get_playtime_game_telemetry_v1_protected_steam_ids_steam_id_playtime_get(
	steam_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/game-telemetry/v1/protected/steamIds/{steamId}/playtime"
	url_path = url_path.replace("{" + "steamId" + "}", steam_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Protected Update Playtime
## PUT /game-telemetry/v1/protected/steamIds/{steamId}/playtime/{playtime}
func protected_update_playtime_game_telemetry_v1_protected_steam_ids_steam_id_playtime_playtime_put(
	playtime: String,
	steam_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/game-telemetry/v1/protected/steamIds/{steamId}/playtime/{playtime}"
	url_path = url_path.replace("{" + "playtime" + "}", playtime.uri_encode())
	url_path = url_path.replace("{" + "steamId" + "}", steam_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)
