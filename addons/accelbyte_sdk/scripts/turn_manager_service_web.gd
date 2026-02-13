## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## turn_manager_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: Justice TURN Manager Service
## Version: 2.13.2
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = TurnManagerServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name TurnManagerServiceWeb
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
	print("  [TurnManagerServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [TurnManagerServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Query auto scaling config
## GET /turnmanager/admin/configs/autoscale
func query_auto_scale_config() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Add new cluster for turn server
## POST /turnmanager/admin/configs/autoscale
func create_new_cluster(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get auto scaling config by region
## GET /turnmanager/admin/configs/autoscale/{region}
func get_auto_scale_config(region: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale/{region}"
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Modify auto scaling config
## PUT /turnmanager/admin/configs/autoscale/{region}
func save_auto_scale_config(region: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale/{region}"
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Estimate cost of the turn server
## POST /turnmanager/admin/namespace/{namespace}/prices/estimate
func price_estimate_namespace(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/namespace/{namespace}/prices/estimate"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get network usage
## GET /turnmanager/admin/networkusage
func get_network_usage_by_date_range(date_end: String = "",date_start: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/networkusage"

	# Build query parameters
	var query_params: Dictionary = {}
	if not date_end.is_empty():
		query_params["dateEnd"] = date_end
	if not date_start.is_empty():
		query_params["dateStart"] = date_start

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update prices
## PATCH /turnmanager/admin/prices
func price_update(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/prices"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Estimate cost of the turn server
## POST /turnmanager/admin/prices/estimate
func price_estimate(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/prices/estimate"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get price regions list
## GET /turnmanager/admin/prices/regions
func list_pricing_regions() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/prices/regions"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get price list by region
## GET /turnmanager/admin/prices/regions/{region}
func list_price_by_region(region: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/prices/regions/{region}"
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Test the p2p connection for available turn server
## GET /turnmanager/admin/servers/testp2p
func p2_pconnection_test() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/servers/testp2p"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Mark the turn server as inactive
## DELETE /turnmanager/admin/servers/{region}/{ip}/{port}
func delete_server(ip: String,port: String,region: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/servers/{region}/{ip}/{port}"
	url_path = url_path.replace("{" + "ip" + "}", _url_encode(ip))
	url_path = url_path.replace("{" + "port" + "}", _url_encode(port))
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## [Deprecated] Modify a server service's region alias
## POST /turnmanager/admin/servers/{region}/{ip}/{port}/alias
## @deprecated
func set_server_alias(ip: String,port: String,region: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/servers/{region}/{ip}/{port}/alias"
	url_path = url_path.replace("{" + "ip" + "}", _url_encode(ip))
	url_path = url_path.replace("{" + "port" + "}", _url_encode(port))
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Configure public TURN servers
## POST /turnmanager/admin/turn/public
func add_public_turn_server(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/admin/turn/public"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## For metric purpose only
## POST /turnmanager/metrics/namespaces/{namespace}/connected
func p2_pconnected(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/metrics/namespaces/{namespace}/connected"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## For metric purpose only (disconnected)
## POST /turnmanager/metrics/namespaces/{namespace}/disconnected
func p2_pdisconnected(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/metrics/namespaces/{namespace}/disconnected"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get current time
## GET /turnmanager/public/time
func get_current_time() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/public/time"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## [Deprecated] Get list of TURN services
## GET /turnmanager/public/turn
## @deprecated
func list_server_deprecated() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/public/turn"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Send heartbeat
## POST /turnmanager/servers/heartbeat
func heartbeat(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/servers/heartbeat"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get the public IP
## GET /turnmanager/servers/ip
func public_ip() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/servers/ip"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Store Turn secret
## POST /turnmanager/servers/secret
func secret(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/servers/secret"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete secret for the turn server
## DELETE /turnmanager/servers/secret/{region}/{ip}/{port}
func delete_secret(ip: String,port: String,region: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/servers/secret/{region}/{ip}/{port}"
	url_path = url_path.replace("{" + "ip" + "}", _url_encode(ip))
	url_path = url_path.replace("{" + "port" + "}", _url_encode(port))
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get list of TURN services
## GET /turnmanager/turn
func list_server(all: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/turn"

	# Build query parameters
	var query_params: Dictionary = {}
	if not all.is_empty():
		query_params["all"] = all

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get generated username password
## GET /turnmanager/turn/secret/{region}/{ip}/{port}
func generate_username_password(ip: String,port: String,region: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/turnmanager/turn/secret/{region}/{ip}/{port}"
	url_path = url_path.replace("{" + "ip" + "}", _url_encode(ip))
	url_path = url_path.replace("{" + "port" + "}", _url_encode(port))
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
