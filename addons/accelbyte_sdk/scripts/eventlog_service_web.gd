## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## eventlog_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-event-log-service
## Version: 
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = EventlogServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name EventlogServiceWeb
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
	print("  [EventlogServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [EventlogServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Get list of agent type and the descriptions
## GET /event/descriptions/agentType
## @deprecated
func agent_type_description_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/agentType"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get specific list of agent type and the descriptions by comma...
## GET /event/descriptions/agentType/listByAgentTypes
## @deprecated
func specific_agent_type_description_handler(agent_types: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/agentType/listByAgentTypes"

	# Build query parameters
	var query_params: Dictionary = {}
	if not agent_types.is_empty():
		query_params["agentTypes"] = agent_types

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get list of eventID and the descriptions
## GET /event/descriptions/eventId
## @deprecated
func event_iddescription_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/eventId"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get specific list of eventID and the descriptions by comma...
## GET /event/descriptions/eventId/listByEventIds
## @deprecated
func specific_event_iddescription_handler(event_ids: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/eventId/listByEventIds"

	# Build query parameters
	var query_params: Dictionary = {}
	if not event_ids.is_empty():
		query_params["eventIds"] = event_ids

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get list of event level and the descriptions
## GET /event/descriptions/eventLevel
## @deprecated
func event_level_description_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/eventLevel"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get specific list of event level and the descriptions by comma...
## GET /event/descriptions/eventLevel/listByEventLevels
## @deprecated
func specific_event_level_description_handler(event_levels: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/eventLevel/listByEventLevels"

	# Build query parameters
	var query_params: Dictionary = {}
	if not event_levels.is_empty():
		query_params["eventLevels"] = event_levels

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get list of event type and the descriptions
## GET /event/descriptions/eventType
## @deprecated
func event_type_description_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/eventType"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get specific list of event type and the descriptions by comma...
## GET /event/descriptions/eventType/listByEventTypes
## @deprecated
func specific_event_type_description_handler(event_types: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/eventType/listByEventTypes"

	# Build query parameters
	var query_params: Dictionary = {}
	if not event_types.is_empty():
		query_params["eventTypes"] = event_types

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get list of ux name and the descriptions
## GET /event/descriptions/ux
## @deprecated
func uxname_description_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/ux"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get specific list of UX and the descriptions by comma separated value of UX
## GET /event/descriptions/ux/listByUx
## @deprecated
func specific_uxdescription_handler(ux: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/descriptions/ux/listByUx"

	# Build query parameters
	var query_params: Dictionary = {}
	if not ux.is_empty():
		query_params["ux"] = ux

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from all users in a namespace
## GET /event/namespaces/{namespace}
## @deprecated
func get_event_by_namespace_handler(namespace_param: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Post an activity log
## POST /event/namespaces/{namespace}
## @deprecated
func post_event_handler(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get events from all users in a namespace with specific eventID
## GET /event/namespaces/{namespace}/eventId/{eventId}
## @deprecated
func get_event_by_event_idhandler(event_id: float,namespace_param: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", _url_encode(str(event_id)))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from all users in a namespace with specific eventType
## GET /event/namespaces/{namespace}/eventType/{eventType}
## @deprecated
func get_event_by_event_type_handler(event_type: float,namespace_param: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/eventType/{eventType}"
	url_path = url_path.replace("{" + "eventType" + "}", _url_encode(str(event_type)))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from all users in a namespace with specific eventID and...
## GET /event/namespaces/{namespace}/eventType/{eventType}/eventId/{eventId}
## @deprecated
func get_event_by_event_type_and_event_idhandler(event_id: float,event_type: float,namespace_param: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/eventType/{eventType}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", _url_encode(str(event_id)))
	url_path = url_path.replace("{" + "eventType" + "}", _url_encode(str(event_type)))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from specific user
## GET /event/namespaces/{namespace}/users/{userId}
## @deprecated
func get_event_by_user_idhandler(namespace_param: String,user_id: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Delete all user's activities
## DELETE /event/namespaces/{namespace}/users/{userId}/activities
## @deprecated
func delete_user_activities_handler(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/activities"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get all user's activities
## GET /event/namespaces/{namespace}/users/{userId}/activities
## @deprecated
func get_user_activities_handler(namespace_param: String,user_id: String,page_size: int,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/activities"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if page_size != 0:
		query_params["pageSize"] = page_size
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from specific user with specific eventID
## GET /event/namespaces/{namespace}/users/{userId}/eventId/{eventId}
## @deprecated
func get_event_by_user_idand_event_idhandler(event_id: float,namespace_param: String,user_id: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", _url_encode(str(event_id)))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from specific user with specific eventType
## GET /event/namespaces/{namespace}/users/{userId}/eventType/{eventType}
## @deprecated
func get_event_by_user_idand_event_type_handler(event_type: float,namespace_param: String,user_id: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/eventType/{eventType}"
	url_path = url_path.replace("{" + "eventType" + "}", _url_encode(str(event_type)))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from specific user with specific eventID and eventType
## GET /event/namespaces/{namespace}/users/{userId}/eventType/{eventType}/eventId/{eventId}
## @deprecated
func get_event_by_user_event_idand_event_type_handler(event_id: float,event_type: float,namespace_param: String,user_id: String,end_date: String,page_size: int,start_date: String,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/eventType/{eventType}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", _url_encode(str(event_id)))
	url_path = url_path.replace("{" + "eventType" + "}", _url_encode(str(event_type)))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get last activity time of a user in a namespace
## GET /event/namespaces/{namespace}/users/{userId}/lastActivityTime
## @deprecated
func last_user_activity_time_handler(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/lastActivityTime"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get registered events in the Event Registry
## GET /event/registry/eventIds
## @deprecated
func get_registered_events_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/registry/eventIds"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Register an eventID to the Event Registry
## POST /event/registry/eventIds
## @deprecated
func register_event_handler(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/registry/eventIds"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Unregister eventID from the Event Registry
## DELETE /event/registry/eventIds/{eventId}
## @deprecated
func unregister_event_idhandler(event_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/registry/eventIds/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", _url_encode(event_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get registered eventID data from the Event Registry
## GET /event/registry/eventIds/{eventId}
## @deprecated
func get_registered_event_idhandler(event_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/registry/eventIds/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", _url_encode(event_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update an eventID data in the Event Registry
## POST /event/registry/eventIds/{eventId}
## @deprecated
func update_event_registry_handler(event_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/registry/eventIds/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", _url_encode(event_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get registered eventID data from the Event Registry based on the event type
## GET /event/registry/eventTypes/{eventType}
## @deprecated
func get_registered_events_by_event_type_handler(event_type: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/registry/eventTypes/{eventType}"
	url_path = url_path.replace("{" + "eventType" + "}", _url_encode(event_type))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## A generic query to get a set of events based on the provided filters
## POST /event/v2/admin/namespaces/{namespace}/query
func query_event_stream_handler(namespace_param: String,end_date: String = "",offset: int = 0,page_size: int = 0,start_date: String = "",
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/v2/admin/namespaces/{namespace}/query"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if offset != 0:
		query_params["offset"] = offset
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Get events from a specific user
## GET /event/v2/admin/namespaces/{namespace}/users/{userId}/event
func get_event_specific_user_v2_handler(namespace_param: String,user_id: String,end_date: String = "",event_name: String = "",offset: int = 0,page_size: int = 0,start_date: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/v2/admin/namespaces/{namespace}/users/{userId}/event"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not event_name.is_empty():
		query_params["eventName"] = event_name
	if offset != 0:
		query_params["offset"] = offset
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get a user edit history based on the provided type
## GET /event/v2/public/namespaces/{namespace}/users/{userId}/edithistory
func get_public_edit_history(namespace_param: String,user_id: String,end_date: String = "",offset: int = 0,page_size: int = 0,start_date: String = "",type_param: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/v2/public/namespaces/{namespace}/users/{userId}/edithistory"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if offset != 0:
		query_params["offset"] = offset
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not type_param.is_empty():
		query_params["type"] = type_param

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get events from a specific user
## GET /event/v2/public/namespaces/{namespace}/users/{userId}/event
func get_user_events_v2_public(namespace_param: String,user_id: String,end_date: String = "",event_name: String = "",offset: int = 0,page_size: int = 0,start_date: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/event/v2/public/namespaces/{namespace}/users/{userId}/event"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not event_name.is_empty():
		query_params["eventName"] = event_name
	if offset != 0:
		query_params["offset"] = offset
	if page_size != 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
