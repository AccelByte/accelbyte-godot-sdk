## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## dslogmanager_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-ds-log-manager-service
## Version: 3.7.4
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = DslogmanagerServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name DslogmanagerServiceWeb
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
	print("  [DslogmanagerServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [DslogmanagerServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Queries server logs
## GET /dslogmanager/admin/namespaces/{namespace}/servers/{podName}/logs
func get_server_logs(namespace_param: String,pod_name: String,log_type: String = "",offset: int = 0,origin: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/admin/namespaces/{namespace}/servers/{podName}/logs"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "podName" + "}", _url_encode(pod_name))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not log_type.is_empty():
		query_params["logType"] = log_type
	if offset != 0:
		query_params["offset"] = offset
	if not origin.is_empty():
		query_params["origin"] = origin

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve All Terminated Servers
## GET /dslogmanager/namespaces/{namespace}/servers/search
func list_terminated_servers(namespace_param: String,deployment: String = "",end_date: String = "",game_mode: String = "",limit: int = 0,next: String = "",party_id: String = "",pod_name: String = "",previous: String = "",provider: String = "",region: String = "",session_id: String = "",source: String = "",start_date: String = "",status: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/namespaces/{namespace}/servers/search"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not deployment.is_empty():
		query_params["deployment"] = deployment
	if not end_date.is_empty():
		query_params["end_date"] = end_date
	if not game_mode.is_empty():
		query_params["game_mode"] = game_mode
	if limit != 0:
		query_params["limit"] = limit
	if not next.is_empty():
		query_params["next"] = next
	if not party_id.is_empty():
		query_params["party_id"] = party_id
	if not pod_name.is_empty():
		query_params["pod_name"] = pod_name
	if not previous.is_empty():
		query_params["previous"] = previous
	if not provider.is_empty():
		query_params["provider"] = provider
	if not region.is_empty():
		query_params["region"] = region
	if not session_id.is_empty():
		query_params["session_id"] = session_id
	if not source.is_empty():
		query_params["source"] = source
	if not start_date.is_empty():
		query_params["start_date"] = start_date
	if not status.is_empty():
		query_params["status"] = status
	if not user_id.is_empty():
		query_params["user_id"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Download dedicated server log files
## GET /dslogmanager/namespaces/{namespace}/servers/{podName}/logs/download
func download_server_logs(namespace_param: String,pod_name: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/namespaces/{namespace}/servers/{podName}/logs/download"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "podName" + "}", _url_encode(pod_name))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Check dedicated server log files existence
## GET /dslogmanager/namespaces/{namespace}/servers/{podName}/logs/exists
func check_server_logs(namespace_param: String,pod_name: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/namespaces/{namespace}/servers/{podName}/logs/exists"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "podName" + "}", _url_encode(pod_name))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Batch Download dedicated server log files
## POST /dslogmanager/servers/logs/download
func batch_download_server_logs(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/servers/logs/download"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve Metadata Servers
## POST /dslogmanager/servers/metadata
func list_metadata_servers(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/servers/metadata"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve All Terminated Servers
## GET /dslogmanager/servers/search
func list_all_terminated_servers(deployment: String = "",end_date: String = "",game_mode: String = "",limit: int = 0,namespace_param: String = "",next: String = "",party_id: String = "",pod_name: String = "",previous: String = "",provider: String = "",region: String = "",session_id: String = "",start_date: String = "",status: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/servers/search"

	# Build query parameters
	var query_params: Dictionary = {}
	if not deployment.is_empty():
		query_params["deployment"] = deployment
	if not end_date.is_empty():
		query_params["end_date"] = end_date
	if not game_mode.is_empty():
		query_params["game_mode"] = game_mode
	if limit != 0:
		query_params["limit"] = limit
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not next.is_empty():
		query_params["next"] = next
	if not party_id.is_empty():
		query_params["party_id"] = party_id
	if not pod_name.is_empty():
		query_params["pod_name"] = pod_name
	if not previous.is_empty():
		query_params["previous"] = previous
	if not provider.is_empty():
		query_params["provider"] = provider
	if not region.is_empty():
		query_params["region"] = region
	if not session_id.is_empty():
		query_params["session_id"] = session_id
	if not start_date.is_empty():
		query_params["start_date"] = start_date
	if not status.is_empty():
		query_params["status"] = status
	if not user_id.is_empty():
		query_params["user_id"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get service messages
## GET /dslogmanager/v1/messages
func public_get_messages() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dslogmanager/v1/messages"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
