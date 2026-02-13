## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## social_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-statistics-service
## Version: 4.3.2
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = SocialServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name SocialServiceWeb
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
	print("  [SocialServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [SocialServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Deletes a namespace slot configuration
## DELETE /social/admin/namespaces/{namespace}/config
## @deprecated
func delete_namespace_slot_config(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Returns a namespace slot configuration
## GET /social/admin/namespaces/{namespace}/config
## @deprecated
func get_namespace_slot_config(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update a namespace slot configuration
## PUT /social/admin/namespaces/{namespace}/config
## @deprecated
func update_namespace_slot_config(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Deletes a user slot configuration
## DELETE /social/admin/namespaces/{namespace}/users/{userId}/config
## @deprecated
func delete_user_slot_config(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/users/{userId}/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Returns a user slot configuration
## GET /social/admin/namespaces/{namespace}/users/{userId}/config
## @deprecated
func get_user_slot_config(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/users/{userId}/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update a user slot configuration
## PUT /social/admin/namespaces/{namespace}/users/{userId}/config
## @deprecated
func update_user_slot_config(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/users/{userId}/config"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Returns all profiles' header for a user
## GET /social/admin/namespaces/{namespace}/users/{userId}/profiles
## @deprecated
func get_user_profiles(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/users/{userId}/profiles"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Returns profile for a user
## GET /social/admin/namespaces/{namespace}/users/{userId}/profiles/{profileId}
## @deprecated
func get_profile(namespace_param: String,profile_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/users/{userId}/profiles/{profileId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "profileId" + "}", _url_encode(profile_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Returns list of slots for given user
## GET /social/admin/namespaces/{namespace}/users/{userId}/slots
## @deprecated
func get_user_namespace_slots(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/users/{userId}/slots"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Returns slot data
## GET /social/admin/namespaces/{namespace}/users/{userId}/slots/{slotId}
## @deprecated
func get_slot_data(namespace_param: String,slot_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/admin/namespaces/{namespace}/users/{userId}/slots/{slotId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "slotId" + "}", _url_encode(slot_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Returns all profiles for specified users
## GET /social/public/namespaces/{namespace}/profiles
## @deprecated
func public_get_user_game_profiles(namespace_param: String,user_ids: Array
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/profiles"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if user_ids.size() > 0:
		query_params["userIds"] = user_ids

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Returns all profiles' header for a user
## GET /social/public/namespaces/{namespace}/users/{userId}/profiles
## @deprecated
func public_get_user_profiles(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/profiles"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create a new profile for user
## POST /social/public/namespaces/{namespace}/users/{userId}/profiles
## @deprecated
func public_create_profile(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/profiles"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Deletes game profile
## DELETE /social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}
## @deprecated
func public_delete_profile(namespace_param: String,profile_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "profileId" + "}", _url_encode(profile_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Returns profile for a user
## GET /social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}
## @deprecated
func public_get_profile(namespace_param: String,profile_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "profileId" + "}", _url_encode(profile_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Updates user game profile
## PUT /social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}
## @deprecated
func public_update_profile(namespace_param: String,profile_id: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "profileId" + "}", _url_encode(profile_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Returns game profile attribute
## GET /social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}/attributes/{attributeName}
## @deprecated
func public_get_profile_attribute(attribute_name: String,namespace_param: String,profile_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}/attributes/{attributeName}"
	url_path = url_path.replace("{" + "attributeName" + "}", _url_encode(attribute_name))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "profileId" + "}", _url_encode(profile_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Updates game profile attribute
## PUT /social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}/attributes/{attributeName}
## @deprecated
func public_update_attribute(attribute_name: String,namespace_param: String,profile_id: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/profiles/{profileId}/attributes/{attributeName}"
	url_path = url_path.replace("{" + "attributeName" + "}", _url_encode(attribute_name))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "profileId" + "}", _url_encode(profile_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Returns slots for given user
## GET /social/public/namespaces/{namespace}/users/{userId}/slots
## @deprecated
func public_get_user_namespace_slots(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/slots"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Creates a slot
## POST /social/public/namespaces/{namespace}/users/{userId}/slots
## @deprecated
func public_create_user_namespace_slot(namespace_param: String,user_id: String,checksum: String = "",custom_attribute: String = "",file: String = "",label: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/slots"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not label.is_empty():
		query_params["label"] = label
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Deletes the slot
## DELETE /social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}
## @deprecated
func public_delete_user_namespace_slot(namespace_param: String,slot_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "slotId" + "}", _url_encode(slot_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Returns slot data
## GET /social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}
## @deprecated
func public_get_slot_data(namespace_param: String,slot_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "slotId" + "}", _url_encode(slot_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Updates a slot
## PUT /social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}
## @deprecated
func public_update_user_namespace_slot(namespace_param: String,slot_id: String,user_id: String,checksum: String = "",custom_attribute: String = "",file: String = "",label: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "slotId" + "}", _url_encode(slot_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not label.is_empty():
		query_params["label"] = label
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Updates the slot metadata
## PUT /social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}/metadata
## @deprecated
func public_update_user_namespace_slot_metadata(namespace_param: String,slot_id: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/public/namespaces/{namespace}/users/{userId}/slots/{slotId}/metadata"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "slotId" + "}", _url_encode(slot_id))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## List global statItems
## GET /social/v1/admin/namespaces/{namespace}/globalstatitems
func get_global_stat_items(namespace_param: String,limit: int = 0,offset: int = 0,stat_codes: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/globalstatitems"
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
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get global statItem by stat code
## GET /social/v1/admin/namespaces/{namespace}/globalstatitems/{statCode}
func get_global_stat_item_by_stat_code(namespace_param: String,stat_code: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/globalstatitems/{statCode}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## List stat cycles
## GET /social/v1/admin/namespaces/{namespace}/statCycles
func get_stat_cycles(namespace_param: String,cycle_type: String = "",limit: int = 0,name_param: String = "",offset: int = 0,sort_by: String = "",status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not cycle_type.is_empty():
		query_params["cycleType"] = cycle_type
	if limit != 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create stat cycle
## POST /social/v1/admin/namespaces/{namespace}/statCycles
func create_stat_cycle(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk get stat cycle
## POST /social/v1/admin/namespaces/{namespace}/statCycles/bulk
func bulk_get_stat_cycle(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Export all stat cycle configurations
## GET /social/v1/admin/namespaces/{namespace}/statCycles/export
func export_stat_cycle(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/export"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Import stat cycle configurations
## POST /social/v1/admin/namespaces/{namespace}/statCycles/import
func import_stat_cycle(namespace_param: String,file: String = "",replace_existing: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/import"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["replaceExisting"] = replace_existing

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Deletes stat cycle
## DELETE /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}
func delete_stat_cycle(cycle_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get stat cycle
## GET /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}
func get_stat_cycle(cycle_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update stat cycle
## PUT /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}
func update_stat_cycle(cycle_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Reset stat cycle
## POST /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/reset
func reset_stat_cycle(cycle_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/reset"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk add stat cycle to stats
## POST /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stats/add/bulk
func bulk_add_stats(cycle_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stats/add/bulk"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Stop stat cycle
## PUT /social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stop
func stop_stat_cycle(cycle_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statCycles/{cycleId}/stop"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Bulk fetch statitems value
## GET /social/v1/admin/namespaces/{namespace}/statitems/bulk
func bulk_fetch_stat_items(namespace_param: String,stat_code: String,user_ids: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if not user_ids.is_empty():
		query_params["userIds"] = user_ids

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk update multiple user's statitems value
## PATCH /social/v1/admin/namespaces/{namespace}/statitems/value/bulk
func bulk_inc_user_stat_item_value(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Bulk update multiple user's statitems value
## PUT /social/v1/admin/namespaces/{namespace}/statitems/value/bulk
func bulk_inc_user_stat_item(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Bulk fetch user stat item values
## GET /social/v1/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault
func bulk_fetch_or_default_stat_items(namespace_param: String,stat_code: String,user_ids: Array
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if user_ids.size() > 0:
		query_params["userIds"] = user_ids

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk reset multiple user's statitems value
## PUT /social/v1/admin/namespaces/{namespace}/statitems/value/reset/bulk
func bulk_reset_user_stat_item(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/statitems/value/reset/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## List stats
## GET /social/v1/admin/namespaces/{namespace}/stats
func get_stats(namespace_param: String,cycle_ids: String = "",is_global: bool = false,is_public: bool = false,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not cycle_ids.is_empty():
		query_params["cycleIds"] = cycle_ids
	query_params["isGlobal"] = is_global
	query_params["isPublic"] = is_public
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

## Create stat
## POST /social/v1/admin/namespaces/{namespace}/stats
func create_stat(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Export all stat configurations
## GET /social/v1/admin/namespaces/{namespace}/stats/export
func export_stats(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/export"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Import stat configurations
## POST /social/v1/admin/namespaces/{namespace}/stats/import
func import_stats(namespace_param: String,file: String = "",replace_existing: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/import"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["replaceExisting"] = replace_existing

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Query stats by keyword
## GET /social/v1/admin/namespaces/{namespace}/stats/search
func query_stats(namespace_param: String,keyword: String,is_global: bool = false,is_public: bool = false,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/search"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	query_params["isGlobal"] = is_global
	query_params["isPublic"] = is_public
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

## Deletes stat
## DELETE /social/v1/admin/namespaces/{namespace}/stats/{statCode}
func delete_stat(namespace_param: String,stat_code: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get stat by statCode
## GET /social/v1/admin/namespaces/{namespace}/stats/{statCode}
func get_stat(namespace_param: String,stat_code: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update stat
## PATCH /social/v1/admin/namespaces/{namespace}/stats/{statCode}
func update_stat(namespace_param: String,stat_code: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Get users' stat item values by stat code
## GET /social/v1/admin/namespaces/{namespace}/stats/{statCode}/statitems
func get_stat_items(namespace_param: String,stat_code: String,limit: int = 0,offset: int = 0,sort_by: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}/statitems"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Deletes tied stat
## DELETE /social/v1/admin/namespaces/{namespace}/stats/{statCode}/tied
func delete_tied_stat(namespace_param: String,stat_code: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/stats/{statCode}/tied"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## List user's statCycleItems by statCycle
## GET /social/v1/admin/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems
func get_user_stat_cycle_items(cycle_id: String,namespace_param: String,user_id: String,is_public: bool = false,limit: int = 0,offset: int = 0,sort_by: String = "",stat_codes: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isPublic"] = is_public
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## List user's statItems
## GET /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems
func get_user_stat_items(namespace_param: String,user_id: String,is_public: bool = false,limit: int = 0,offset: int = 0,sort_by: String = "",stat_codes: String = "",tags: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isPublic"] = is_public
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not tags.is_empty():
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk create user's statItems
## POST /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/bulk
func bulk_create_user_stat_items(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk update user's statitems value
## PATCH /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func bulk_inc_user_stat_item_value_1(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Bulk update user's statitems value
## PUT /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func bulk_inc_user_stat_item_1(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Bulk reset user's statitems value
## PUT /social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk
func bulk_reset_user_stat_item_1(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete User's statItems
## DELETE /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
func delete_user_stat_items(namespace_param: String,stat_code: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Create user's statItem
## POST /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
func create_user_stat_item(namespace_param: String,stat_code: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Update user's statitem value
## PATCH /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
func inc_user_stat_item_value(namespace_param: String,stat_code: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Reset user's statitem value
## PUT /social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset
func reset_user_stat_item_value(namespace_param: String,stat_code: String,user_id: String,additional_key: String = "",
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## List global statItems
## GET /social/v1/public/namespaces/{namespace}/globalstatitems
func get_global_stat_items_1(namespace_param: String,limit: int = 0,offset: int = 0,stat_codes: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/globalstatitems"
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
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get global statItem by stat code
## GET /social/v1/public/namespaces/{namespace}/globalstatitems/{statCode}
func get_global_stat_item_by_stat_code_1(namespace_param: String,stat_code: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/globalstatitems/{statCode}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## List stat cycles
## GET /social/v1/public/namespaces/{namespace}/statCycles
func get_stat_cycles_1(namespace_param: String,cycle_type: String = "",limit: int = 0,name_param: String = "",offset: int = 0,sort_by: String = "",status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statCycles"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not cycle_type.is_empty():
		query_params["cycleType"] = cycle_type
	if limit != 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk get stat cycle
## POST /social/v1/public/namespaces/{namespace}/statCycles/bulk
func bulk_get_stat_cycle_1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statCycles/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get stat cycle
## GET /social/v1/public/namespaces/{namespace}/statCycles/{cycleId}
func get_stat_cycle_1(cycle_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statCycles/{cycleId}"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Public bulk fetch statitems value
## GET /social/v1/public/namespaces/{namespace}/statitems/bulk
func bulk_fetch_stat_items_1(namespace_param: String,stat_code: String,user_ids: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if not user_ids.is_empty():
		query_params["userIds"] = user_ids

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Public bulk update multiple user's statitems value
## PATCH /social/v1/public/namespaces/{namespace}/statitems/value/bulk
func public_bulk_inc_user_stat_item_value(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Public bulk update multiple user's statitems value
## PUT /social/v1/public/namespaces/{namespace}/statitems/value/bulk
func public_bulk_inc_user_stat_item(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Public bulk reset multiple user's statitems value
## PUT /social/v1/public/namespaces/{namespace}/statitems/value/reset/bulk
func bulk_reset_user_stat_item_2(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/statitems/value/reset/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Create stat
## POST /social/v1/public/namespaces/{namespace}/stats
func create_stat_1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/stats"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## List user's statCycleItems by statCycle
## GET /social/v1/public/namespaces/{namespace}/users/me/statCycles/{cycleId}/statCycleitems
func public_list_my_stat_cycle_items(cycle_id: String,namespace_param: String,limit: int = 0,offset: int = 0,sort_by: String = "",stat_codes: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/me/statCycles/{cycleId}/statCycleitems"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Public list user's statItems
## GET /social/v1/public/namespaces/{namespace}/users/me/statitems
func public_list_my_stat_items(namespace_param: String,limit: int = 0,offset: int = 0,sort_by: String = "",stat_codes: Array = [],tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/me/statitems"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Public list user's statItems
## GET /social/v1/public/namespaces/{namespace}/users/me/statitems/value/bulk
func public_list_all_my_stat_items(namespace_param: String,additional_key: String = "",stat_codes: Array = [],tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/me/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## List user's statCycleItems by statCycle
## GET /social/v1/public/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems
func get_user_stat_cycle_items_1(cycle_id: String,namespace_param: String,user_id: String,limit: int = 0,offset: int = 0,sort_by: String = "",stat_codes: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statCycles/{cycleId}/statCycleitems"
	url_path = url_path.replace("{" + "cycleId" + "}", _url_encode(cycle_id))
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Public list user's statItems
## GET /social/v1/public/namespaces/{namespace}/users/{userId}/statitems
func public_query_user_stat_items_1(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0,sort_by: String = "",stat_codes: String = "",tags: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not stat_codes.is_empty():
		query_params["statCodes"] = stat_codes
	if not tags.is_empty():
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk create user's statItems
## POST /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/bulk
func public_bulk_create_user_stat_items(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Public list user's statItems
## GET /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func public_query_user_stat_items(namespace_param: String,user_id: String,additional_key: String = "",stat_codes: Array = [],tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Public bulk update user's statitems value
## PATCH /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func bulk_inc_user_stat_item_value_2(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Public bulk update user's statitems value
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func public_bulk_inc_user_stat_item_1(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Public bulk reset user's statitems value
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk
func bulk_reset_user_stat_item_3(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete User's statItems
## DELETE /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
func delete_user_stat_items_1(namespace_param: String,stat_code: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Create user's statItem
## POST /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
func public_create_user_stat_item(namespace_param: String,stat_code: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Public update user's statitem value
## PATCH /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
func public_inc_user_stat_item_value(namespace_param: String,stat_code: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Public update user's statitem value
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
func public_inc_user_stat_item(namespace_param: String,stat_code: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Public reset user's statitem value
## PUT /social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset
func reset_user_stat_item_value_1(namespace_param: String,stat_code: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v1/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value/reset"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Bulk update multiple user's statitems value
## PUT /social/v2/admin/namespaces/{namespace}/statitems/value/bulk
func bulk_update_user_stat_item_v2(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Bulk fetch user stat item values
## GET /social/v2/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault
func bulk_fetch_or_default_stat_items_1(namespace_param: String,stat_code: String,user_ids: Array,additional_key: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/statitems/value/bulk/getOrDefault"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not stat_code.is_empty():
		query_params["statCode"] = stat_code
	if user_ids.size() > 0:
		query_params["userIds"] = user_ids
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## (Legacy) Admin list user's statItems
## GET /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func admin_list_users_stat_items(namespace_param: String,user_id: String,additional_key: String = "",stat_codes: Array = [],tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk update user's statitems value
## PUT /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func bulk_update_user_stat_item(namespace_param: String,user_id: String,additional_key: String = "",
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Bulk get user's statitems value by user id and multiple stat codes
## POST /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk/getOrDefault
func bulk_get_or_default_by_user_id(namespace_param: String,user_id: String,additional_key: String = "",
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/bulk/getOrDefault"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk reset user's statitem values
## PUT /social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk
func bulk_reset_user_stat_item_values(namespace_param: String,user_id: String,additional_key: String = "",
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/statitems/value/reset/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete User's statItems
## DELETE /social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems
func delete_user_stat_items_2(namespace_param: String,stat_code: String,user_id: String,additional_key: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Update user's statitem value
## PUT /social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
func update_user_stat_item_value(namespace_param: String,stat_code: String,user_id: String,additional_key: String = "",
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/admin/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Public bulk update multiple user's statitems value
## PUT /social/v2/public/namespaces/{namespace}/statitems/value/bulk
func bulk_update_user_stat_item_1(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Public list user's statItems
## GET /social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func public_query_user_stat_items_2(namespace_param: String,user_id: String,additional_key: String = "",stat_codes: Array = [],tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key
	if stat_codes.size() > 0:
		query_params["statCodes"] = stat_codes
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Public bulk update user's statitems value
## PUT /social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk
func bulk_update_user_stat_item_2(namespace_param: String,user_id: String,additional_key: String = "",
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/users/{userId}/statitems/value/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Public update user's statitem value
## PUT /social/v2/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value
func update_user_stat_item_value_1(namespace_param: String,stat_code: String,user_id: String,additional_key: String = "",
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/social/v2/public/namespaces/{namespace}/users/{userId}/stats/{statCode}/statitems/value"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "statCode" + "}", _url_encode(stat_code))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not additional_key.is_empty():
		query_params["additionalKey"] = additional_key

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)
