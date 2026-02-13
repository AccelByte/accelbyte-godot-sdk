## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## sessionhistory_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-session-history-service
## Version: 0.1.0-dev
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = SessionhistoryServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name SessionhistoryServiceWeb
extends RefCounted

## Reference to the main SDK (for accessing tokens and settings)
var _sdk: AccelByteSDK
var _base_url: String = ""
var _auth_token: String = ""
var _namespace: String = ""
var _scene_root: Node = null

## Initialize with SDK reference
func initialize(sdk: AccelByteSDK, scene_root: Node = null) -> void:
	_sdk = sdk
	_scene_root = scene_root
	if _sdk:
		_base_url = _sdk.get_server_url()
		_namespace = _sdk.get_namespace()


## Update auth token (call after login)
func update_auth_token() -> void:
	if _sdk:
		_auth_token = _sdk.get_access_token()


func set_base_url(url: String) -> void:
	_base_url = url
	if _base_url.ends_with("/"):
		_base_url = _base_url.substr(0, _base_url.length() - 1)


func set_auth_token(token: String) -> void:
	_auth_token = token


func set_namespace(ns: String) -> void:
	_namespace = ns


## Check if running on web platform
func _is_web() -> bool:
	return OS.has_feature("web")


## Get parent node for HTTPRequest (needed on web)
func _get_parent_node() -> Node:
	if _scene_root:
		return _scene_root
	# Try to get scene tree root
	var tree = Engine.get_main_loop()
	if tree is SceneTree:
		return tree.root
	return null


## HTTP method enum to string
func _method_to_string(method: int) -> String:
	match method:
		HTTPClient.METHOD_GET: return "GET"
		HTTPClient.METHOD_POST: return "POST"
		HTTPClient.METHOD_PUT: return "PUT"
		HTTPClient.METHOD_DELETE: return "DELETE"
		HTTPClient.METHOD_PATCH: return "PATCH"
		_: return "UNKNOWN"


## Generic HTTP request (web platform)
func _http_request(url: String, method: int, headers: PackedStringArray, body: String = "") -> Dictionary:
	print("  [SessionhistoryServiceWeb] %s %s" % [_method_to_string(method), url])

	var parent = _get_parent_node()
	if not parent:
		return {"success": false, "error": "No parent node for HTTPRequest", "status_code": 0}

	var http_request = HTTPRequest.new()
	parent.add_child(http_request)

	var error = http_request.request(url, headers, method, body)
	if error != OK:
		http_request.queue_free()
		return {"success": false, "error": "Failed to start HTTP request: %d" % error, "status_code": 0}

	var response = await http_request.request_completed
	var result_code: int = response[0]
	var response_code: int = response[1]
	var http_response_body: PackedByteArray = response[3]

	http_request.queue_free()

	var result: Dictionary = {"status_code": response_code}

	if result_code != HTTPRequest.RESULT_SUCCESS:
		result["success"] = false
		result["error"] = "HTTP request failed with result: %d" % result_code
		return result

	var body_string = http_response_body.get_string_from_utf8()
	result["body"] = body_string

	if not body_string.is_empty():
		var json = JSON.new()
		if json.parse(body_string) == OK:
			result["data"] = json.data
		else:
			result["data"] = body_string

	result["success"] = (response_code >= 200 and response_code < 300)

	if not result["success"] and result.has("data") and result["data"] is Dictionary:
		var err_data = result["data"]
		if err_data.has("errorMessage"):
			result["error"] = err_data["errorMessage"]
		elif err_data.has("error_description"):
			result["error"] = err_data["error_description"]

	print("  [SessionhistoryServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
	return result


## Get bearer auth headers
func _get_bearer_headers() -> PackedStringArray:
	var headers = PackedStringArray()
	headers.push_back("Content-Type: application/json")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return headers


## Get form-urlencoded headers
func _get_form_headers() -> PackedStringArray:
	var headers = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return headers


## URL encode a string
func _url_encode(value: String) -> String:
	return value.uri_encode()


## Build query string from dictionary
func _build_query_string(params: Dictionary) -> String:
	var parts: Array[String] = []
	for key in params.keys():
		var value = params[key]
		if value is Array:
			for item in value:
				parts.append("%s=%s" % [_url_encode(str(key)), _url_encode(str(item))])
		else:
			parts.append("%s=%s" % [_url_encode(str(key)), _url_encode(str(value))])
	return "&".join(parts)


## Build form body from dictionary
func _build_form_body(params: Dictionary) -> String:
	return _build_query_string(params)


# =============================================================================
# API Methods
# =============================================================================

## GetHealthcheckInfo
## GET /healthz
func get_healthcheck_info() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/healthz"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## postgresStatsHandler
## GET /sessionhistory/admin/internal/db-pg-stats
func postgres_stats_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/admin/internal/db-pg-stats"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## redisStatsHandler
## GET /sessionhistory/admin/internal/db-redis-stats
func redis_stats_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/admin/internal/db-redis-stats"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## GetHealthcheckInfoV1
## GET /sessionhistory/healthz
func get_healthcheck_info_v1() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/healthz"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get Runtime Environment Variable Configuration
## GET /sessionhistory/v1/admin/config/env
func admin_get_env_config() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/env"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Patch Update Runtime Environment Variable Configuration
## PATCH /sessionhistory/v1/admin/config/env
func admin_patch_update_env_config(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/env"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Get Log Configuration
## GET /sessionhistory/v1/admin/config/log
func admin_get_log_config() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/log"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Patch Update Log Configuration
## PATCH /sessionhistory/v1/admin/config/log
func admin_patch_update_log_config(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/config/log"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Get all game sessions history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/gamesessions
func admin_query_game_session_detail(namespace_param: String,completed_only: String = "",configuration_name: String = "",ds_pod_name: String = "",end_date: String = "",game_session_id: String = "",is_persistent: String = "",joinability: String = "",limit: int = 0,match_pool: String = "",offset: int = 0,order: String = "",order_by: String = "",start_date: String = "",status_v2: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/gamesessions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

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
	if limit != 0:
		query_params["limit"] = limit
	if not match_pool.is_empty():
		query_params["matchPool"] = match_pool
	if offset != 0:
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
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get game session detail.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}
func get_game_session_detail(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionId" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get all matchmaking history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/matchmaking
func admin_query_matchmaking_detail(namespace_param: String,game_session_id: String = "",limit: int = 0,offset: int = 0,order: String = "",order_by: String = "",ticket_id: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/matchmaking"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not game_session_id.is_empty():
		query_params["gameSessionID"] = game_session_id
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
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
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get detail matchmaking history by session ID.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/session/{sessionId}
func admin_get_matchmaking_detail_by_session_id(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/session/{sessionId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionId" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get detail matchmaking history by ticket ID.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/ticket/{ticketId}
func admin_get_matchmaking_detail_by_ticket_id(namespace_param: String,ticket_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/matchmaking/ticket/{ticketId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "ticketId" + "}", _url_encode(ticket_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get all parties history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/parties
func admin_query_party_detail(namespace_param: String,configuration_name: String = "",end_date: String = "",joinability: String = "",leader_id: String = "",limit: int = 0,offset: int = 0,order: String = "",order_by: String = "",party_id: String = "",start_date: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/parties"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

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
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
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
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get party detail.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/parties/{sessionId}
func get_party_detail(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/parties/{sessionId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionId" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get all matchmaking ticket history.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/tickets
func admin_query_ticket_detail(namespace_param: String,end_date: String = "",game_mode: String = "",limit: int = 0,offset: int = 0,order: String = "",party_id: String = "",region: String = "",start_date: String = "",user_ids: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/tickets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not game_mode.is_empty():
		query_params["gameMode"] = game_mode
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not region.is_empty():
		query_params["region"] = region
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not user_ids.is_empty():
		query_params["userIDs"] = user_ids

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get detail matchmaking ticket history by ticket ID.
## GET /sessionhistory/v1/admin/namespaces/{namespace}/tickets/{ticketId}
func admin_ticket_detail_get_by_ticket_id(namespace_param: String,ticket_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/admin/namespaces/{namespace}/tickets/{ticketId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "ticketId" + "}", _url_encode(ticket_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get all game sessions history for current user.
## GET /sessionhistory/v1/public/namespaces/{namespace}/users/me/gamesessions
func public_query_game_session_me(namespace_param: String,limit: int = 0,offset: int = 0,order: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v1/public/namespaces/{namespace}/users/me/gamesessions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray match pool
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}
func query_xray_match_pool(namespace_param: String,pool_name: Array,end_date: String,start_date: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "poolName" + "}", _url_encode(",".join(pool_name)))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray match pool ticks
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks
func query_detail_tick_match_pool(namespace_param: String,pod_name: String,pool_name: String,end_date: String,start_date: String,all: bool = false,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "podName" + "}", _url_encode(pod_name))
	url_path = url_path.replace("{" + "poolName" + "}", _url_encode(pool_name))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	query_params["all"] = all
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray match pool tick matches by tick id
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/matches
func query_detail_tick_match_pool_matches(namespace_param: String,pod_name: String,pool_name: String,tick_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/matches"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "podName" + "}", _url_encode(pod_name))
	url_path = url_path.replace("{" + "poolName" + "}", _url_encode(pool_name))
	url_path = url_path.replace("{" + "tickId" + "}", _url_encode(tick_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray match pool tick tickets by tick id
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/tickets
func query_detail_tick_match_pool_ticket(namespace_param: String,pod_name: String,pool_name: String,tick_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/match-pools/{poolName}/pods/{podName}/ticks/{tickId}/tickets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "podName" + "}", _url_encode(pod_name))
	url_path = url_path.replace("{" + "poolName" + "}", _url_encode(pool_name))
	url_path = url_path.replace("{" + "tickId" + "}", _url_encode(tick_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray match histories
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/histories
func query_match_histories(match_id: String,namespace_param: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/histories"
	url_path = url_path.replace("{" + "matchId" + "}", _url_encode(match_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray match ticket histories
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/ticket-histories
func query_match_ticket_histories(match_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/ticket-histories"
	url_path = url_path.replace("{" + "matchId" + "}", _url_encode(match_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray timeline by matchID
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/tickets
func query_xray_match(match_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/matches/{matchId}/tickets"
	url_path = url_path.replace("{" + "matchId" + "}", _url_encode(match_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total success and failed claim DS
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds
func query_acquiring_ds(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query acquiring ds wait time average
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds-wait-time-avg
func query_acquiring_dswait_time_avg(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/acquiring-ds-wait-time-avg"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query match length duration avg
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-avg
func query_match_length_durationp_avg(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-avg"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query match length duration p99
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-p99
func query_match_length_durationp99(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/match-length-duration-p99"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total active session
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-active-session
func query_total_active_session(namespace_param: String,end_date: String,start_date: String,match_pool: Array = [],region: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-active-session"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool
	if not region.is_empty():
		query_params["region"] = region

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total match
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-match
func query_total_matchmaking_match(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-match"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total player persession average
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-player-persession-avg
func query_total_player_persession(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-player-persession-avg"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total ticket canceled
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-canceled
func query_total_matchmaking_canceled(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-canceled"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total ticket created
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-created
func query_total_matchmaking_created(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-created"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total ticket expired
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-expired
func query_total_matchmaking_expired(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-expired"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query total ticket match
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-match
func query_total_matchmaking_match_ticket(namespace_param: String,end_date: String,start_date: String,match_pool: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/metrics/total-ticket-match"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if match_pool.size() > 0:
		query_params["matchPool"] = match_pool

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create ticket observability request
## POST /sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets
func create_xray_ticket_observability(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create bulk ticket observability request
## POST /sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/bulk
func create_xray_bulk_ticket_observability(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Query xray timeline
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/{ticketId}
func query_xray_timeline_by_ticket_id(namespace_param: String,ticket_id: String,end_date: String,start_date: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/tickets/{ticketId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "ticketId" + "}", _url_encode(ticket_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query xray timeline
## GET /sessionhistory/v2/admin/namespaces/{namespace}/xray/users/{userId}/tickets
func query_xray_timeline_by_user_id(namespace_param: String,user_id: String,end_date: String,start_date: String,limit: int = 0,offset: int = 0,order: String = "",order_by: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionhistory/v2/admin/namespaces/{namespace}/xray/users/{userId}/tickets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
