## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## dsupload_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-ds-upload-service
## Version: 2.9.2
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = DsuploadServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name DsuploadServiceWeb
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
	print("  [DsuploadServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [DsuploadServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Healthcheck endpoint
## GET /dsupload/healthz
func check() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/healthz"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Inform Ds Upload Failed endpoint
## POST /dsupload/v1/ds-creation-failed
func inform_failed_ds_creation(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/ds-creation-failed"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Inform DS Size endpoint
## POST /dsupload/v1/ds-size
func inform_dssize(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/ds-size"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Create Builder Config
## POST /dsupload/v1/namespaces/{namespace}/builder/{unique_key}/configs
func create_builder_config(namespace_param: String,unique_key: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/builder/{unique_key}/configs"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "unique_key" + "}", _url_encode(unique_key))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	var _result: Dictionary = await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)
	# Auto-handle token grant: store tokens in SDK
	if _result.get("success", false) and _sdk:
		var _token_data = _result.get("data", {})
		if _token_data is Dictionary and _token_data.has("access_token"):
			_sdk.set_auth_tokens(
				_token_data.get("access_token", ""),
				_token_data.get("refresh_token", ""),
				_token_data.get("user_id", ""),
				_token_data.get("expires_in", 3600)
			)
	return _result

## Create STS Config
## POST /dsupload/v1/namespaces/{namespace}/configs
func create_stsconfig(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/configs"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	var _result: Dictionary = await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)
	# Auto-handle token grant: store tokens in SDK
	if _result.get("success", false) and _sdk:
		var _token_data = _result.get("data", {})
		if _token_data is Dictionary and _token_data.has("access_token"):
			_sdk.set_auth_tokens(
				_token_data.get("access_token", ""),
				_token_data.get("refresh_token", ""),
				_token_data.get("user_id", ""),
				_token_data.get("expires_in", 3600)
			)
	return _result

## List DS Status
## GET /dsupload/v1/namespaces/{namespace}/images
func list_dsstatus(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create Image
## POST /dsupload/v1/namespaces/{namespace}/images
func create_image(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get Bucket Name
## GET /dsupload/v1/namespaces/{namespace}/images/buckets
func get_bucket_name(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/buckets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get last version of image
## GET /dsupload/v1/namespaces/{namespace}/images/last-version
func latest_dsversion(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/last-version"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query Image Status
## GET /dsupload/v1/namespaces/{namespace}/images/{unique_key}/status
func get_image_status(namespace_param: String,unique_key: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/{unique_key}/status"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "unique_key" + "}", _url_encode(unique_key))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update Image Status
## PUT /dsupload/v1/namespaces/{namespace}/images/{unique_key}/status
func update_image_status(namespace_param: String,unique_key: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/{unique_key}/status"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "unique_key" + "}", _url_encode(unique_key))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete DS State
## DELETE /dsupload/v1/namespaces/{namespace}/images/{version}
func delete_dsstatus(namespace_param: String,version: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/{version}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "version" + "}", _url_encode(version))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Delete game manifest & checksum files
## DELETE /dsupload/v1/namespaces/{namespace}/images/{version}/patches/{patchVersion}
func delete_manifest_checksum(namespace_param: String,patch_version: String,version: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/{version}/patches/{patchVersion}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "patchVersion" + "}", _url_encode(patch_version))
	url_path = url_path.replace("{" + "version" + "}", _url_encode(version))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get checksum files of image
## GET /dsupload/v1/namespaces/{namespace}/images/{version}/patches/{patchVersion}/checksum-files
func get_checksum_files(namespace_param: String,patch_version: String,version: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/{version}/patches/{patchVersion}/checksum-files"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "patchVersion" + "}", _url_encode(patch_version))
	url_path = url_path.replace("{" + "version" + "}", _url_encode(version))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Download game manifest log
## GET /dsupload/v1/namespaces/{namespace}/images/{version}/patches/{patchVersion}/download
func download_game_manifest(namespace_param: String,patch_version: String,version: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/namespaces/{namespace}/images/{version}/patches/{patchVersion}/download"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "patchVersion" + "}", _url_encode(patch_version))
	url_path = url_path.replace("{" + "version" + "}", _url_encode(version))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get Resource Tag
## GET /dsupload/v1/resource-tag
func get_resource_tag() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/v1/resource-tag"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Version endpoint
## GET /dsupload/version
func get_version() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/dsupload/version"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
