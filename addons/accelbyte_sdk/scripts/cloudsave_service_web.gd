## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## cloudsave_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-cloudsave-service
## Version: 3.30.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = CloudsaveServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name CloudsaveServiceWeb
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
	print("  [CloudsaveServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [CloudsaveServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## List key of admin game record
## GET /cloudsave/v1/admin/namespaces/{namespace}/adminrecords
func admin_list_admin_game_record_v1(namespace_param: String,limit: int = 0,offset: int = 0,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk get admin game records
## POST /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/bulk
func admin_bulk_get_admin_game_record_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete admin game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_delete_admin_game_record_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get admin game record
## GET /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_get_admin_game_record_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append admin game record
## POST /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_post_admin_game_record_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace admin game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_put_admin_game_record_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete admin game record TTL config
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}/ttl
func delete_admin_game_record_ttlconfig(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}/ttl"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Query game binary records
## GET /cloudsave/v1/admin/namespaces/{namespace}/binaries
func admin_list_game_binary_records_v1(namespace_param: String,limit: int = 0,offset: int = 0,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create game binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/binaries
func admin_post_game_binary_record_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete game binary record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
func admin_delete_game_binary_record_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get game binary record
## GET /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
func admin_get_game_binary_record_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update game binary record file
## PUT /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
func admin_put_game_binary_record_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Update game binary record metadata
## PUT /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/metadata
func admin_put_game_binary_recor_metadata_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/metadata"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Request presigned URL for upload game binary records
## POST /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/presigned
func admin_post_game_binary_presigned_urlv1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete game binary record TTL config
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/ttl
func delete_game_binary_record_ttlconfig(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/ttl"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Create or replace admin game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/concurrent/adminrecords/{key}
func admin_put_admin_game_record_concurrent_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/concurrent/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/concurrent/records/{key}
func admin_put_game_record_concurrent_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete plugin configuration
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/plugins
func delete_plugin_config(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get plugin configuration
## GET /cloudsave/v1/admin/namespaces/{namespace}/plugins
func get_plugin_config(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update plugin configuration
## PATCH /cloudsave/v1/admin/namespaces/{namespace}/plugins
func update_plugin_config(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Create plugin configuration
## POST /cloudsave/v1/admin/namespaces/{namespace}/plugins
func create_plugin_config(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Query game records
## GET /cloudsave/v1/admin/namespaces/{namespace}/records
func list_game_records_handler_v1(namespace_param: String,limit: int,offset: int,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Delete game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_delete_game_record_handler_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get game record
## GET /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_get_game_record_handler_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append game record
## POST /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_post_game_record_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_put_game_record_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete game record TTL config
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/records/{key}/ttl
func delete_game_record_ttlconfig(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}/ttl"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## List tags
## GET /cloudsave/v1/admin/namespaces/{namespace}/tags
func admin_list_tags_handler_v1(namespace_param: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/tags"
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

## Create a tag
## POST /cloudsave/v1/admin/namespaces/{namespace}/tags
func admin_post_tag_handler_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/tags"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete a tag
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/tags/{tag}
func admin_delete_tag_handler_v1(namespace_param: String,tag: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/tags/{tag}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "tag" + "}", _url_encode(tag))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Bulk get admin player record by multiple user ID
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/adminrecords/{key}/bulk
func bulk_get_admin_player_record_by_user_ids_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/adminrecords/{key}/bulk"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk get player records size
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/bulk/records/size
func bulk_get_player_record_size_handler_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/bulk/records/size"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve list of public player records
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/records
## @deprecated
func list_player_record_handler_v1(namespace_param: String,limit: int = 0,offset: int = 0,query: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/records"
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
	if not query.is_empty():
		query_params["query"] = query

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk get player records by multiple user ids
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk
func admin_bulk_get_player_records_by_user_ids_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk update player records by key
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk
func admin_bulk_put_player_records_by_key_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## List key of admin player record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords
func admin_list_admin_user_records_v1(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk get admin player records
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/bulk
func admin_bulk_get_admin_player_record_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete admin player record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_delete_admin_player_record_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get admin player record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_get_admin_player_record_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append admin player record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_post_player_admin_record_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace admin player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_put_admin_player_record_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Query player binary records
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries
func admin_list_player_binary_records_v1(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create player binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries
func admin_post_player_binary_record_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete player binary record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
func admin_delete_player_binary_record_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get player binary record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
func admin_get_player_binary_record_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update player binary record file
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
func admin_put_player_binary_record_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Update player binary record metadata
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata
func admin_put_player_binary_recor_metadata_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Request presigned URL for upload player binary records
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned
func admin_post_player_binary_presigned_urlv1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace admin player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/adminrecords/{key}
func admin_put_admin_player_record_concurrent_handler_v1(key: String,namespace_param: String,user_id: String,response_body: bool = false,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Create or replace player private record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}
func admin_put_player_record_concurrent_handler_v1(key: String,namespace_param: String,user_id: String,response_body: bool = false,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public
func admin_put_player_public_record_concurrent_handler_v1(key: String,namespace_param: String,user_id: String,response_body: bool = false,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Query player records
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records
func admin_retrieve_player_records(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk get player records by multiple record keys
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk
func admin_get_player_records_handler_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk update player records
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk
func admin_put_player_records_handler_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete player record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_delete_player_record_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get player record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_get_player_record_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append player record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_post_player_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_put_player_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete player public record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_delete_player_public_record_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get player public record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_get_player_public_record_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append player public record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_post_player_public_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_put_player_public_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Get player record size
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/size
func admin_get_player_record_size_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/size"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query game binary records
## GET /cloudsave/v1/namespaces/{namespace}/binaries
func list_game_binary_records_v1(namespace_param: String,limit: int = 0,offset: int = 0,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create game binary record
## POST /cloudsave/v1/namespaces/{namespace}/binaries
func post_game_binary_record_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk get game binary records
## POST /cloudsave/v1/namespaces/{namespace}/binaries/bulk
func bulk_get_game_binary_record_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete game binary record
## DELETE /cloudsave/v1/namespaces/{namespace}/binaries/{key}
func delete_game_binary_record_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get game binary record
## GET /cloudsave/v1/namespaces/{namespace}/binaries/{key}
func get_game_binary_record_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update game binary record file
## PUT /cloudsave/v1/namespaces/{namespace}/binaries/{key}
func put_game_binary_record_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Request presigned URL for upload game binary records
## POST /cloudsave/v1/namespaces/{namespace}/binaries/{key}/presigned
func post_game_binary_presigned_urlv1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/namespaces/{namespace}/concurrent/records/{key}
func put_game_record_concurrent_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Bulk get game records
## POST /cloudsave/v1/namespaces/{namespace}/records/bulk
func get_game_records_bulk(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete game record
## DELETE /cloudsave/v1/namespaces/{namespace}/records/{key}
func delete_game_record_handler_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get game record
## GET /cloudsave/v1/namespaces/{namespace}/records/{key}
func get_game_record_handler_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append game record
## POST /cloudsave/v1/namespaces/{namespace}/records/{key}
func post_game_record_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/namespaces/{namespace}/records/{key}
func put_game_record_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## List tags
## GET /cloudsave/v1/namespaces/{namespace}/tags
func public_list_tags_handler_v1(namespace_param: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/tags"
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

## Bulk get player public records
## POST /cloudsave/v1/namespaces/{namespace}/users/bulk/binaries/{key}/public
func bulk_get_player_public_binary_records_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/bulk/binaries/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk get player public records
## POST /cloudsave/v1/namespaces/{namespace}/users/bulk/records/{key}/public
func bulk_get_player_public_record_handler_v1(key: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/bulk/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Query my binary records
## GET /cloudsave/v1/namespaces/{namespace}/users/me/binaries
func list_my_binary_records_v1(namespace_param: String,limit: int = 0,offset: int = 0,query: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/binaries"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get player records bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/me/binaries/bulk
func bulk_get_my_binary_record_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/binaries/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Query player records key
## GET /cloudsave/v1/namespaces/{namespace}/users/me/records
func retrieve_player_records(namespace_param: String,limit: int = 0,offset: int = 0,tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/records"
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
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get player records bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/me/records/bulk
func get_player_records_bulk_handler_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/records/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete player public record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/me/records/{key}/public
func public_delete_player_public_record_handler_v1(key: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Create player binary record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries
func post_player_binary_record_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Query other player public binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public
func list_other_player_public_binary_records_v1(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0,tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk get other player public binary record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public/bulk
func bulk_get_other_player_public_binary_records_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete player binary record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
func delete_player_binary_record_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get player binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
func get_player_binary_record_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update player binary record file
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
func put_player_binary_record_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Update player binary record metadata
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata
func put_player_binary_recor_metadata_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Request presigned URL for upload player binary records
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned
func post_player_binary_presigned_urlv1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get player public binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/public
func get_player_public_binary_records_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or replace player private record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}
func put_player_record_concurrent_handler_v1(key: String,namespace_param: String,user_id: String,response_body: bool = false,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public
func put_player_public_record_concurrent_handler_v1(key: String,namespace_param: String,user_id: String,response_body: bool = false,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Query other player public record key
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public
func get_other_player_public_record_key_handler_v1(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0,tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get other player public record bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public/bulk
func get_other_player_public_record_handler_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete player record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func delete_player_record_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get player record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func get_player_record_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append player record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func post_player_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace player record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func put_player_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Get player public record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
func get_player_public_record_handler_v1(key: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create or append player public record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
func post_player_public_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
func put_player_public_record_handler_v1(key: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", _url_encode(key))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)
