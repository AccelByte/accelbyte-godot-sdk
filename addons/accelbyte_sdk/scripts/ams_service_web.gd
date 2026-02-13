## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## ams_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: fleet-commander
## Version: 1.43.1-dev
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = AmsServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name AmsServiceWeb
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
	print("  [AmsServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [AmsServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## checks if fleet commander can auth with AMS
## GET /ams/auth
func auth_check() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/auth"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Health check
## GET /ams/healthz
func portal_health_check() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/healthz"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get the account associated with the namespace
## GET /ams/v1/admin/namespaces/{namespace}/account
func admin_account_get(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## create a new AMS account
## POST /ams/v1/admin/namespaces/{namespace}/account
func admin_account_create(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## get a link to account token
## GET /ams/v1/admin/namespaces/{namespace}/account/link
func admin_account_link_token_get(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account/link"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## link an account to a namespace
## POST /ams/v1/admin/namespaces/{namespace}/account/link
func admin_account_link(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account/link"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## delete artifacts that match criteria in bulk. all artifacts...
## DELETE /ams/v1/admin/namespaces/{namespace}/artifacts
func artifact_bulk_delete(namespace_param: String,artifact_type: String = "",fleet_id: String = "",uploaded_before: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not artifact_type.is_empty():
		query_params["artifactType"] = artifact_type
	if not fleet_id.is_empty():
		query_params["fleetId"] = fleet_id
	if not uploaded_before.is_empty():
		query_params["uploadedBefore"] = uploaded_before

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## get all artifacts matching the provided criteria
## GET /ams/v1/admin/namespaces/{namespace}/artifacts
func artifact_get(namespace_param: String,artifact_type: String = "",count: int = 0,end_date: String = "",fleet_id: String = "",image_id: String = "",max_size: int = 0,min_size: int = 0,offset: int = 0,region: String = "",server_id: String = "",sort_by: String = "",sort_direction: String = "",start_date: String = "",status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not artifact_type.is_empty():
		query_params["artifactType"] = artifact_type
	if count != 0:
		query_params["count"] = count
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not fleet_id.is_empty():
		query_params["fleetID"] = fleet_id
	if not image_id.is_empty():
		query_params["imageID"] = image_id
	if max_size != 0:
		query_params["maxSize"] = max_size
	if min_size != 0:
		query_params["minSize"] = min_size
	if offset != 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not server_id.is_empty():
		query_params["serverId"] = server_id
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not status.is_empty():
		query_params["status"] = status

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## retrieve artifact storage usage for the namespace
## GET /ams/v1/admin/namespaces/{namespace}/artifacts/usage
func artifact_usage_get(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts/usage"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## delete a specified artifact
## DELETE /ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}
func artifact_delete(artifact_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}"
	url_path = url_path.replace("{" + "artifactID" + "}", _url_encode(artifact_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## get a signed URL for a specific artifact
## GET /ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}/url
func artifact_get_url(artifact_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}/url"
	url_path = url_path.replace("{" + "artifactID" + "}", _url_encode(artifact_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## lists development server configurations with pagination
## GET /ams/v1/admin/namespaces/{namespace}/development/server-configurations
func development_server_configuration_list(namespace_param: String,count: int = 0,image_id: String = "",name_param: String = "",offset: int = 0,sort_by: String = "",sort_direction: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if count != 0:
		query_params["count"] = count
	if not image_id.is_empty():
		query_params["imageId"] = image_id
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## create a new development server configuration
## POST /ams/v1/admin/namespaces/{namespace}/development/server-configurations
func development_server_configuration_create(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## delete a development server configuration
## DELETE /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
func development_server_configuration_delete(development_server_config_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace("{" + "developmentServerConfigID" + "}", _url_encode(development_server_config_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## get a development server configuration
## GET /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
func development_server_configuration_get(development_server_config_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace("{" + "developmentServerConfigID" + "}", _url_encode(development_server_config_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## patch a development server configuration
## PATCH /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
func development_server_configuration_patch(development_server_config_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace("{" + "developmentServerConfigID" + "}", _url_encode(development_server_config_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## delete one or more fleets. maximum of 1000 fleets allowed
## DELETE /ams/v1/admin/namespaces/{namespace}/fleets
func bulk_fleet_delete(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## list all fleets in a namespace
## GET /ams/v1/admin/namespaces/{namespace}/fleets
func fleet_list(namespace_param: String,active: bool = false,count: int = 0,name_param: String = "",offset: int = 0,region: String = "",sort_by: String = "",sort_direction: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["active"] = active
	if count != 0:
		query_params["count"] = count
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset != 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## create a fleet
## POST /ams/v1/admin/namespaces/{namespace}/fleets
func fleet_create(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## delete a fleet
## DELETE /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
func fleet_delete(fleet_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## get a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
func fleet_get(fleet_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## update a fleet -– overrides current data
## PUT /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
func fleet_update(fleet_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## get the sampling rules for a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules
func fleet_artifact_sampling_rules_get(fleet_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## set sampling rules for a fleet
## PUT /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules
func fleet_artifact_sampling_rules_set(fleet_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## get server details & counts for a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers
func fleet_servers(fleet_id: String,namespace_param: String,count: int = 0,offset: int = 0,region: String = "",server_id: String = "",sort_by: String = "",sort_direction: String = "",status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if count != 0:
		query_params["count"] = count
	if offset != 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not server_id.is_empty():
		query_params["serverId"] = server_id
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not status.is_empty():
		query_params["status"] = status

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get history records of a dedicated server in a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers/history
func fleet_server_history(fleet_id: String,namespace_param: String,count: int = 0,offset: int = 0,reason: String = "",region: String = "",server_id: String = "",sort_direction: String = "",status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers/history"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if count != 0:
		query_params["count"] = count
	if offset != 0:
		query_params["offset"] = offset
	if not reason.is_empty():
		query_params["reason"] = reason
	if not region.is_empty():
		query_params["region"] = region
	if not server_id.is_empty():
		query_params["serverId"] = server_id
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not status.is_empty():
		query_params["status"] = status

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get a list of existing images
## GET /ams/v1/admin/namespaces/{namespace}/images
func image_list(namespace_param: String,count: int = 0,in_use: String = "",is_protected: bool = false,name_param: String = "",offset: int = 0,sort_by: String = "",sort_direction: String = "",status: String = "",tag: String = "",target_architecture: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if count != 0:
		query_params["count"] = count
	if not in_use.is_empty():
		query_params["inUse"] = in_use
	query_params["isProtected"] = is_protected
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not status.is_empty():
		query_params["status"] = status
	if not tag.is_empty():
		query_params["tag"] = tag
	if not target_architecture.is_empty():
		query_params["targetArchitecture"] = target_architecture

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get current usage for images storage
## GET /ams/v1/admin/namespaces/{namespace}/images-storage
func images_storage(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images-storage"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## mark the image for deletion
## DELETE /ams/v1/admin/namespaces/{namespace}/images/{imageID}
func image_mark_for_deletion(image_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}"
	url_path = url_path.replace("{" + "imageID" + "}", _url_encode(image_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## get image details.
## GET /ams/v1/admin/namespaces/{namespace}/images/{imageID}
func image_get(image_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}"
	url_path = url_path.replace("{" + "imageID" + "}", _url_encode(image_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## edit the image
## PATCH /ams/v1/admin/namespaces/{namespace}/images/{imageID}
func image_patch(image_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}"
	url_path = url_path.replace("{" + "imageID" + "}", _url_encode(image_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## unmarks the image for deletion
## POST /ams/v1/admin/namespaces/{namespace}/images/{imageID}/restore
func image_unmark_for_deletion(image_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}/restore"
	url_path = url_path.replace("{" + "imageID" + "}", _url_encode(image_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## get a list of available AMS QoS regions
## GET /ams/v1/admin/namespaces/{namespace}/qos
func qo_sregions_get(namespace_param: String,status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/qos"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not status.is_empty():
		query_params["status"] = status

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## update the status of a QoS region
## PATCH /ams/v1/admin/namespaces/{namespace}/qos/{region}
func qo_sregions_update(namespace_param: String,region: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/qos/{region}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "region" + "}", _url_encode(region))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## get a list of the available AMS regions
## GET /ams/v1/admin/namespaces/{namespace}/regions
func info_regions(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/regions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get information about a dedicated server
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}
func fleet_server_info(namespace_param: String,server_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/servers/{serverID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "serverID" + "}", _url_encode(server_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get connection info for a dedicated server
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}/connectioninfo
func fleet_server_connection_info(namespace_param: String,server_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/servers/{serverID}/connectioninfo"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "serverID" + "}", _url_encode(server_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get history records of a dedicated server
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}/history
func server_history(namespace_param: String,server_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/servers/{serverID}/history"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "serverID" + "}", _url_encode(server_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get a list of available instance types for the current account
## GET /ams/v1/admin/namespaces/{namespace}/supported-instances
func info_supported_instances(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/supported-instances"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get the account associated with the namespace
## GET /ams/v1/namespaces/{namespace}/account
func account_get(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/account"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## claim a dedicated server from a fleet
## PUT /ams/v1/namespaces/{namespace}/fleets/{fleetID}/claim
func fleet_claim_by_id(fleet_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/fleets/{fleetID}/claim"
	url_path = url_path.replace("{" + "fleetID" + "}", _url_encode(fleet_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## connect a local watchdog
## GET /ams/v1/namespaces/{namespace}/local/{watchdogID}/connect
func local_watchdog_connect(namespace_param: String,watchdog_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/local/{watchdogID}/connect"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "watchdogID" + "}", _url_encode(watchdog_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## claim a dedicated server
## PUT /ams/v1/namespaces/{namespace}/servers/claim
func fleet_claim_by_keys(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/servers/claim"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## connect a watchdog
## GET /ams/v1/namespaces/{namespace}/watchdogs/{watchdogID}/connect
func watchdog_connect(namespace_param: String,watchdog_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/watchdogs/{watchdogID}/connect"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "watchdogID" + "}", _url_encode(watchdog_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## get an URL for uploading an image
## GET /ams/v1/upload-url
func upload_urlget() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/v1/upload-url"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Version info
## GET /ams/version
func func1() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/ams/version"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Health check
## GET /healthz
func basic_health_check() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/healthz"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
