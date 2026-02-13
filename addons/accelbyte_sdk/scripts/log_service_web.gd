## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## log_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-log-service
## Version: 1.15.2
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = LogServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name LogServiceWeb
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
	print("  [LogServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [LogServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Query Access Logs
## GET /log/v1/admin/accesslogs
## @deprecated
func admin_query_access_logs_v1(client_id: String = "",end_date: float = 0.0,limit: int = 0,namespace_param: String = "",offset: int = 0,path: String = "",referer: String = "",request_method: String = "",response_code: String = "",response_duration: String = "",service: String = "",source_ip: String = "",start_date: float = 0.0,trace_id: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/log/v1/admin/accesslogs"

	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if limit != 0:
		query_params["limit"] = limit
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if offset != 0:
		query_params["offset"] = offset
	if not path.is_empty():
		query_params["path"] = path
	if not referer.is_empty():
		query_params["referer"] = referer
	if not request_method.is_empty():
		query_params["requestMethod"] = request_method
	if not response_code.is_empty():
		query_params["responseCode"] = response_code
	if not response_duration.is_empty():
		query_params["responseDuration"] = response_duration
	if not service.is_empty():
		query_params["service"] = service
	if not source_ip.is_empty():
		query_params["sourceIp"] = source_ip
	if start_date != 0.0:
		query_params["startDate"] = start_date
	if not trace_id.is_empty():
		query_params["traceId"] = trace_id
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query Logs
## GET /log/v1/admin/logs
## @deprecated
func admin_query_logs_v1(client_id: String = "",close_code: String = "",connection_id: String = "",end_date: float = 0.0,exclude_internal_calls: bool = false,exclude_response_message: bool = false,message_id: String = "",message_type: String = "",namespace_param: String = "",path: String = "",referer: String = "",request_method: String = "",response_code: String = "",response_duration: String = "",service: String = "",session_id: String = "",source_ip: String = "",stage: String = "",start_date: float = 0.0,trace_id: String = "",type_param: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/log/v1/admin/logs"

	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not close_code.is_empty():
		query_params["closeCode"] = close_code
	if not connection_id.is_empty():
		query_params["connectionId"] = connection_id
	if end_date != 0.0:
		query_params["endDate"] = end_date
	query_params["excludeInternalCalls"] = exclude_internal_calls
	query_params["excludeResponseMessage"] = exclude_response_message
	if not message_id.is_empty():
		query_params["messageId"] = message_id
	if not message_type.is_empty():
		query_params["messageType"] = message_type
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not path.is_empty():
		query_params["path"] = path
	if not referer.is_empty():
		query_params["referer"] = referer
	if not request_method.is_empty():
		query_params["requestMethod"] = request_method
	if not response_code.is_empty():
		query_params["responseCode"] = response_code
	if not response_duration.is_empty():
		query_params["responseDuration"] = response_duration
	if not service.is_empty():
		query_params["service"] = service
	if not session_id.is_empty():
		query_params["sessionId"] = session_id
	if not source_ip.is_empty():
		query_params["sourceIp"] = source_ip
	if not stage.is_empty():
		query_params["stage"] = stage
	if start_date != 0.0:
		query_params["startDate"] = start_date
	if not trace_id.is_empty():
		query_params["traceId"] = trace_id
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query Access Logs
## GET /log/v2/admin/accesslogs
func admin_query_access_logs_v2(client_id: String = "",end_date: float = 0.0,flight_id: String = "",game_version: String = "",limit: int = 0,namespace_param: String = "",oss_version: String = "",path: String = "",referer: String = "",request_method: String = "",response_code: String = "",response_duration: String = "",sdk_version: String = "",service: String = "",source_ip: String = "",start_date: float = 0.0,trace_id: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/log/v2/admin/accesslogs"

	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if not flight_id.is_empty():
		query_params["flightId"] = flight_id
	if not game_version.is_empty():
		query_params["gameVersion"] = game_version
	if limit != 0:
		query_params["limit"] = limit
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not oss_version.is_empty():
		query_params["ossVersion"] = oss_version
	if not path.is_empty():
		query_params["path"] = path
	if not referer.is_empty():
		query_params["referer"] = referer
	if not request_method.is_empty():
		query_params["requestMethod"] = request_method
	if not response_code.is_empty():
		query_params["responseCode"] = response_code
	if not response_duration.is_empty():
		query_params["responseDuration"] = response_duration
	if not sdk_version.is_empty():
		query_params["sdkVersion"] = sdk_version
	if not service.is_empty():
		query_params["service"] = service
	if not source_ip.is_empty():
		query_params["sourceIp"] = source_ip
	if start_date != 0.0:
		query_params["startDate"] = start_date
	if not trace_id.is_empty():
		query_params["traceId"] = trace_id
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query Logs
## GET /log/v2/admin/logs
func admin_query_logs_v2(client_id: String = "",close_code: String = "",connection_id: String = "",end_date: float = 0.0,exclude_internal_calls: bool = false,exclude_response_message: bool = false,flight_id: String = "",game_version: String = "",limit: int = 0,message_id: String = "",message_type: String = "",namespace_param: String = "",oss_version: String = "",path: String = "",referer: String = "",request_method: String = "",response_code: String = "",response_duration: String = "",sdk_version: String = "",service: String = "",session_id: String = "",source_ip: String = "",stage: String = "",start_date: float = 0.0,trace_id: String = "",type_param: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/log/v2/admin/logs"

	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not close_code.is_empty():
		query_params["closeCode"] = close_code
	if not connection_id.is_empty():
		query_params["connectionId"] = connection_id
	if end_date != 0.0:
		query_params["endDate"] = end_date
	query_params["excludeInternalCalls"] = exclude_internal_calls
	query_params["excludeResponseMessage"] = exclude_response_message
	if not flight_id.is_empty():
		query_params["flightId"] = flight_id
	if not game_version.is_empty():
		query_params["gameVersion"] = game_version
	if limit != 0:
		query_params["limit"] = limit
	if not message_id.is_empty():
		query_params["messageId"] = message_id
	if not message_type.is_empty():
		query_params["messageType"] = message_type
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not oss_version.is_empty():
		query_params["ossVersion"] = oss_version
	if not path.is_empty():
		query_params["path"] = path
	if not referer.is_empty():
		query_params["referer"] = referer
	if not request_method.is_empty():
		query_params["requestMethod"] = request_method
	if not response_code.is_empty():
		query_params["responseCode"] = response_code
	if not response_duration.is_empty():
		query_params["responseDuration"] = response_duration
	if not sdk_version.is_empty():
		query_params["sdkVersion"] = sdk_version
	if not service.is_empty():
		query_params["service"] = service
	if not session_id.is_empty():
		query_params["sessionId"] = session_id
	if not source_ip.is_empty():
		query_params["sourceIp"] = source_ip
	if not stage.is_empty():
		query_params["stage"] = stage
	if start_date != 0.0:
		query_params["startDate"] = start_date
	if not trace_id.is_empty():
		query_params["traceId"] = trace_id
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get Log Field Values
## GET /log/v2/admin/logs/fields/{fieldName}/values
func admin_get_log_field_values_v2(field_name: String,end_date: float = 0.0,namespace_param: String = "",start_date: float = 0.0,type_param: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/log/v2/admin/logs/fields/{fieldName}/values"
	url_path = url_path.replace("{" + "fieldName" + "}", _url_encode(field_name))

	# Build query parameters
	var query_params: Dictionary = {}
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if start_date != 0.0:
		query_params["startDate"] = start_date
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
