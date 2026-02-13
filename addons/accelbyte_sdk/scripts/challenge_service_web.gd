## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## challenge_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-challenge-service
## Version: 1.0.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = ChallengeServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name ChallengeServiceWeb
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
	print("  [ChallengeServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [ChallengeServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## List Challenges
## GET /challenge/v1/admin/namespaces/{namespace}/challenges
func admin_get_challenges(namespace_param: String,keyword: String = "",limit: int = 0,offset: int = 0,sort_by: String = "",status: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create New Challenge
## POST /challenge/v1/admin/namespaces/{namespace}/challenges
func admin_create_challenge(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get challenge ecommerce item references
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/item/references
func admin_get_item_references(namespace_param: String,item_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/item/references"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not item_id.is_empty():
		query_params["itemId"] = item_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## List User's Active Challenges
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/users/{userId}
func admin_get_active_challenges(namespace_param: String,user_id: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/users/{userId}"
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

## Delete a Challenge
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
func admin_delete_challenge(challenge_code: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get a Challenge
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
func admin_get_challenge(challenge_code: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update a Challenge
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
func admin_update_challenge(challenge_code: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## List Goals of a Challenge
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals
func admin_get_goals(challenge_code: String,namespace_param: String,limit: int = 0,offset: int = 0,sort_by: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
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
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create New Goal
## POST /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals
func admin_create_goal(challenge_code: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete Goal
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
func admin_delete_goal(challenge_code: String,code: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "code" + "}", _url_encode(code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get Goal
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
func admin_get_goal(challenge_code: String,code: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "code" + "}", _url_encode(code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update Goal
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
func admin_update_goals(challenge_code: String,code: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "code" + "}", _url_encode(code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Get goal's schedules
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules
func admin_list_schedules_by_goal(challenge_code: String,code: String,namespace_param: String,limit: int = 0,offset: int = 0,user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "code" + "}", _url_encode(code))
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
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get Challenge's Periods
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/periods
func admin_get_periods(challenge_code: String,namespace_param: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/periods"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
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

## Randomize Goals of a Challenge
## POST /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/randomize
func admin_randomize_challenge(challenge_code: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/randomize"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get Challenge's schedules
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/schedules
func admin_list_schedules(challenge_code: String,namespace_param: String,date_time: String = "",limit: int = 0,offset: int = 0,user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not user_id.is_empty():
		query_params["userId"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Delete Tied Challenge
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied
func admin_delete_tied_challenge(challenge_code: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Update Tied Challenge Schedule
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied/schedule
func admin_update_tied_challenge_schedule(challenge_code: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied/schedule"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Delete assignment plugin
## DELETE /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_delete_assignment_plugin(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get assignment plugin
## GET /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_get_assignment_plugin(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create assignment plugin
## POST /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_create_assignment_plugin(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Update assignment plugin
## PUT /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_update_assignment_plugin(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Evaluate User's Progressions
## POST /challenge/v1/admin/namespaces/{namespace}/progress/evaluate
func admin_evaluate_progress(namespace_param: String,challenge_code: Array = [],
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/progress/evaluate"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if challenge_code.size() > 0:
		query_params["challengeCode"] = challenge_code

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Claim  rewards of multiple users
## POST /challenge/v1/admin/namespaces/{namespace}/users/rewards/claim
func admin_claim_users_rewards(namespace_param: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/rewards/claim"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Claim rewards of a single user by goal code
## POST /challenge/v1/admin/namespaces/{namespace}/users/{userId}/challenges/{challengeCode}/rewards/claim
func admin_claim_user_rewards_by_goal_code(challenge_code: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/challenges/{challengeCode}/rewards/claim"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## List User's Progressions
## GET /challenge/v1/admin/namespaces/{namespace}/users/{userId}/progress/{challengeCode}
func admin_get_user_progression(challenge_code: String,namespace_param: String,user_id: String,date_time: String = "",goal_code: String = "",limit: int = 0,offset: int = 0,tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/progress/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
	if not goal_code.is_empty():
		query_params["goalCode"] = goal_code
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

## List User's Rewards
## GET /challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards
func admin_get_user_rewards(namespace_param: String,user_id: String,challenge_code: String = "",goal_progression_id: String = "",limit: int = 0,offset: int = 0,sort_by: String = "",status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not challenge_code.is_empty():
		query_params["challengeCode"] = challenge_code
	if not goal_progression_id.is_empty():
		query_params["goalProgressionId"] = goal_progression_id
	if limit != 0:
		query_params["limit"] = limit
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

## Claim rewards of a single user
## POST /challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards/claim
func admin_claim_user_rewards(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards/claim"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## List Challenges
## GET /challenge/v1/public/namespaces/{namespace}/challenges
func get_challenges(namespace_param: String,keyword: String = "",limit: int = 0,offset: int = 0,sort_by: String = "",status: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## List Goals of a Challenge
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals
func public_get_scheduled_goals(challenge_code: String,namespace_param: String,limit: int = 0,offset: int = 0,sort_by: String = "",tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
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
	if tags.size() > 0:
		query_params["tags"] = tags

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get goal's schedules
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules
func public_list_schedules_by_goal(challenge_code: String,code: String,namespace_param: String,limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "code" + "}", _url_encode(code))
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

## Get Challenge's schedules
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/schedules
func public_list_schedules(challenge_code: String,namespace_param: String,date_time: String = "",limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
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

## Claim User's Rewards by Goal Code
## POST /challenge/v1/public/namespaces/{namespace}/users/me/challenges/{challengeCode}/rewards/claim
func public_claim_user_rewards_by_goal_code(challenge_code: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/challenges/{challengeCode}/rewards/claim"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Evaluate User's Challenge Progressions
## POST /challenge/v1/public/namespaces/{namespace}/users/me/progress/evaluate
func evaluate_my_progress(namespace_param: String,challenge_code: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/progress/evaluate"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if challenge_code.size() > 0:
		query_params["challengeCode"] = challenge_code

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## List User's Progressions
## GET /challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}
func public_get_user_progression(challenge_code: String,namespace_param: String,date_time: String = "",goal_code: String = "",limit: int = 0,offset: int = 0,tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
	if not goal_code.is_empty():
		query_params["goalCode"] = goal_code
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

## List User's Progressions in the previous rotation.
## GET /challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}/index/{index}
func public_get_past_user_progression(challenge_code: String,index: int,namespace_param: String,goal_code: String = "",limit: int = 0,offset: int = 0,tags: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}/index/{index}"
	url_path = url_path.replace("{" + "challengeCode" + "}", _url_encode(challenge_code))
	url_path = url_path.replace("{" + "index" + "}", _url_encode(str(index)))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not goal_code.is_empty():
		query_params["goalCode"] = goal_code
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

## List User's Rewards
## GET /challenge/v1/public/namespaces/{namespace}/users/me/rewards
func public_get_user_rewards(namespace_param: String,challenge_code: String = "",goal_progression_id: String = "",limit: int = 0,offset: int = 0,sort_by: String = "",status: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/rewards"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not challenge_code.is_empty():
		query_params["challengeCode"] = challenge_code
	if not goal_progression_id.is_empty():
		query_params["goalProgressionId"] = goal_progression_id
	if limit != 0:
		query_params["limit"] = limit
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

## Claim User's Rewards
## POST /challenge/v1/public/namespaces/{namespace}/users/me/rewards/claim
func public_claim_user_rewards(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/rewards/claim"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)
