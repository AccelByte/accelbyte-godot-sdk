## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## gdpr_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-gdpr-service
## Version: 2.22.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = GdprServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name GdprServiceWeb
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
	print("  [GdprServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [GdprServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Retrieve all user's account deletion requests in specified date
## GET /gdpr/admin/namespaces/{namespace}/deletions
func admin_get_list_deletion_data_request(namespace_param: String,after: String = "",before: String = "",limit: int = 0,offset: int = 0,request_date: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/deletions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not request_date.is_empty():
		query_params["requestDate"] = request_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Delete admin emails configurations
## DELETE /gdpr/admin/namespaces/{namespace}/emails/configurations
func delete_admin_email_configuration(namespace_param: String,emails: Array
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if emails.size() > 0:
		query_params["emails"] = emails

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get admin email addresses configuration
## GET /gdpr/admin/namespaces/{namespace}/emails/configurations
func get_admin_email_configuration(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Add admin email address configuration
## POST /gdpr/admin/namespaces/{namespace}/emails/configurations
func save_admin_email_configuration(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Update admin email address configuration
## PUT /gdpr/admin/namespaces/{namespace}/emails/configurations
func update_admin_email_configuration(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Get Platform Account Closure Configs
## GET /gdpr/admin/namespaces/{namespace}/platforms/closure/clients
func admin_get_platform_account_closure_clients(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/closure/clients"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Validate Xbox BP cert file
## POST /gdpr/admin/namespaces/{namespace}/platforms/xbox/closure/cert/validation
func admin_validate_xbox_bpcert_file(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/xbox/closure/cert/validation"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete Platform Account Closure Client
## DELETE /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
func admin_delete_platform_account_closure_client(namespace_param: String,platform: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "platform" + "}", _url_encode(platform))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get Platform Account Closure Config
## GET /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
func admin_get_platform_account_closure_client(namespace_param: String,platform: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "platform" + "}", _url_encode(platform))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update Platform Account Closure Client
## POST /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
func admin_update_platform_account_closure_client(namespace_param: String,platform: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "platform" + "}", _url_encode(platform))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Mock Platform Account Closure Data
## POST /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/mock
func admin_mock_platform_account_closure_data(namespace_param: String,platform: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/mock"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "platform" + "}", _url_encode(platform))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get list personal data requests
## GET /gdpr/admin/namespaces/{namespace}/requests
func admin_get_list_personal_data_request(namespace_param: String,limit: int = 0,offset: int = 0,request_date: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/requests"
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
	if not request_date.is_empty():
		query_params["requestDate"] = request_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get Registered Services Configuration
## GET /gdpr/admin/namespaces/{namespace}/services/configurations
func admin_get_services_configuration(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update Registered Services Configuration
## PUT /gdpr/admin/namespaces/{namespace}/services/configurations
func admin_update_services_configuration(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Reset Registered Services Configuration
## DELETE /gdpr/admin/namespaces/{namespace}/services/configurations/reset
func admin_reset_services_configuration(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations/reset"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Reset Registered Platform Account Closure Services Configuration
## DELETE /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
func admin_reset_platform_account_closure_services_configuration(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/platforms/closure/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get Registered Platform Account Closure Services Configuration
## GET /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
func admin_get_platform_account_closure_services_configuration(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/platforms/closure/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update Registered Platform Account Closure Services Configuration
## PUT /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
func admin_update_platform_account_closure_services_configuration(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/platforms/closure/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Get User's Platform Account Closure Histories
## GET /gdpr/admin/namespaces/{namespace}/users/platforms/closure/histories
func admin_get_user_platform_account_closure_histories(namespace_param: String,limit: int = 0,offset: int = 0,platform: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/platforms/closure/histories"
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
	if not platform.is_empty():
		query_params["platform"] = platform
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Cancel user's account deletion request
## DELETE /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
func admin_cancel_user_account_deletion_request(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/deletions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Retrieve specific user's account deletion request
## GET /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
func admin_get_user_account_deletion_request(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/deletions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Submit user's account deletion request
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
func admin_submit_user_account_deletion_request(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/deletions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get user's personal data requests
## GET /gdpr/admin/namespaces/{namespace}/users/{userId}/requests
func admin_get_user_personal_data_requests(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests"
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

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Submit user personal data retrieval request
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/requests
func admin_request_data_retrieval(namespace_param: String,user_id: String,password: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path

	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = _build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Cancel user's personal data requests
## DELETE /gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}
func admin_cancel_user_personal_data_request(namespace_param: String,request_date: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "requestDate" + "}", _url_encode(request_date))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Generate personal data download url
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
func admin_generate_personal_data_url(namespace_param: String,request_date: String,user_id: String,password: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "requestDate" + "}", _url_encode(request_date))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path

	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = _build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Cancel user's account deletion request
## DELETE /gdpr/public/namespaces/{namespace}/users/{userId}/deletions
func public_cancel_user_account_deletion_request(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/deletions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Submit user's account deletion request
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/deletions
func public_submit_user_account_deletion_request(password: String,namespace_param: String,user_id: String,language_tag: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/deletions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path

	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	var request_body: String = _build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve specific user's account deletion status
## GET /gdpr/public/namespaces/{namespace}/users/{userId}/deletions/status
func public_get_user_account_deletion_status(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/deletions/status"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get user's personal data requests
## GET /gdpr/public/namespaces/{namespace}/users/{userId}/requests
func public_get_user_personal_data_requests(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests"
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

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Submit personal data retrieval request
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests
func public_request_data_retrieval(password: String,namespace_param: String,user_id: String,language_tag: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path

	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	var request_body: String = _build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Cancel user's personal data requests
## DELETE /gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}
func public_cancel_user_personal_data_request(namespace_param: String,request_date: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "requestDate" + "}", _url_encode(request_date))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Generate personal data download url
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
func public_generate_personal_data_url(password: String,namespace_param: String,request_date: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "requestDate" + "}", _url_encode(request_date))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path

	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = _build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Cancel my account deletion request
## DELETE /gdpr/public/users/me/deletions
func public_cancel_my_account_deletion_request() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Submit my account deletion requests.
## POST /gdpr/public/users/me/deletions
func public_submit_my_account_deletion_request(platform_id: String,platform_token: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions"

	var url: String = _base_url + url_path

	# Build form body
	var form_data: Dictionary = {}
	if not platform_id.is_empty():
		form_data["platformId"] = platform_id
	if not platform_token.is_empty():
		form_data["platformToken"] = platform_token
	var request_body: String = _build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve my account deletion status
## GET /gdpr/public/users/me/deletions/status
func public_get_my_account_deletion_status() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions/status"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get list of finished account deletion requests
## GET /gdpr/s2s/namespaces/{namespace}/deletions/finished
func s2_sget_list_finished_account_deletion_request(namespace_param: String,end: String,start: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/deletions/finished"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end.is_empty():
		query_params["end"] = end
	if not start.is_empty():
		query_params["start"] = start

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get list of finished personal data requests
## GET /gdpr/s2s/namespaces/{namespace}/requests/finished
func s2_sget_list_finished_personal_data_request(namespace_param: String,end: String,start: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/requests/finished"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end.is_empty():
		query_params["end"] = end
	if not start.is_empty():
		query_params["start"] = start

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get Personal Data Request by Request Id
## GET /gdpr/s2s/namespaces/{namespace}/requests/{requestId}
func s2_sget_data_request_by_request_id(namespace_param: String,request_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/requests/{requestId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "requestId" + "}", _url_encode(request_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Submit user's account deletion request
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/deletions
func s2_ssubmit_user_account_deletion_request(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/users/{userId}/deletions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Submit user personal data retrieval request
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/requests
func s2_srequest_data_retrieval(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/users/{userId}/requests"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Generate personal data download url
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
func s2_sgenerate_personal_data_url(namespace_param: String,request_date: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "requestDate" + "}", _url_encode(request_date))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)
