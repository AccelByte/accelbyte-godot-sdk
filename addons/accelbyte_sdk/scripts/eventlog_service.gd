## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## eventlog_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-event-log-service
## Version: 
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(EventlogService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name EventlogService
extends RefCounted

## Shared HTTP client (owned by AccelByteSDK, passed via initialize)
var _http: AccelbyteHttp

## Service configuration
var _base_url: String = ""
## Service URL — defaults to _base_url. Override for Extend apps:
##   svc.set_service_url(sdk.get_base_url() + "/your-extend-app-name")
var _service_url: String = ""
var _namespace: String = ""
var _auth_token: String = ""
var _client_id: String = ""

## Token lifecycle callbacks (set by AccelByteSDK)
var _token_callback: Callable
var _revoke_callback: Callable


## Initialize with shared HTTP client.
func initialize(http: AccelbyteHttp) -> void:
	_http = http


func set_base_url(url: String) -> void:
	_base_url = url
	if _base_url.ends_with("/"):
		_base_url = _base_url.substr(0, _base_url.length() - 1)
	if _service_url.is_empty():
		_service_url = _base_url


func set_service_url(url: String) -> void:
	_service_url = url
	if _service_url.ends_with("/"):
		_service_url = _service_url.substr(0, _service_url.length() - 1)


func set_namespace(ns: String) -> void:
	_namespace = ns


func set_auth_token(token: String) -> void:
	_auth_token = token


func set_client_id(id: String) -> void:
	_client_id = id




func set_token_callback(cb: Callable) -> void:
	_token_callback = cb


func set_revoke_callback(cb: Callable) -> void:
	_revoke_callback = cb


# =============================================================================
# API Methods
# =============================================================================

## Get list of agent type and the descriptions
## GET /event/descriptions/agentType
## @deprecated
func agent_type_description_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/agentType"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get specific list of agent type and the descriptions by comma...
## GET /event/descriptions/agentType/listByAgentTypes
## @deprecated
func specific_agent_type_description_handler(
	agent_types: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/agentType/listByAgentTypes"
	# Build query parameters
	var query_params: Dictionary = {}
	if not agent_types.is_empty():
		query_params["agentTypes"] = agent_types
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of eventID and the descriptions
## GET /event/descriptions/eventId
## @deprecated
func event_id_description_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/eventId"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get specific list of eventID and the descriptions by comma...
## GET /event/descriptions/eventId/listByEventIds
## @deprecated
func specific_event_id_description_handler(
	event_ids: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/eventId/listByEventIds"
	# Build query parameters
	var query_params: Dictionary = {}
	if not event_ids.is_empty():
		query_params["eventIds"] = event_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of event level and the descriptions
## GET /event/descriptions/eventLevel
## @deprecated
func event_level_description_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/eventLevel"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get specific list of event level and the descriptions by comma...
## GET /event/descriptions/eventLevel/listByEventLevels
## @deprecated
func specific_event_level_description_handler(
	event_levels: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/eventLevel/listByEventLevels"
	# Build query parameters
	var query_params: Dictionary = {}
	if not event_levels.is_empty():
		query_params["eventLevels"] = event_levels
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of event type and the descriptions
## GET /event/descriptions/eventType
## @deprecated
func event_type_description_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/eventType"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get specific list of event type and the descriptions by comma...
## GET /event/descriptions/eventType/listByEventTypes
## @deprecated
func specific_event_type_description_handler(
	event_types: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/eventType/listByEventTypes"
	# Build query parameters
	var query_params: Dictionary = {}
	if not event_types.is_empty():
		query_params["eventTypes"] = event_types
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of ux name and the descriptions
## GET /event/descriptions/ux
## @deprecated
func ux_name_description_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/ux"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get specific list of UX and the descriptions by comma separated value of UX
## GET /event/descriptions/ux/listByUx
## @deprecated
func specific_ux_description_handler(
	ux: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/descriptions/ux/listByUx"
	# Build query parameters
	var query_params: Dictionary = {}
	if not ux.is_empty():
		query_params["ux"] = ux
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get events from all users in a namespace
## GET /event/namespaces/{namespace}
## @deprecated
func get_event_by_namespace_handler(
	namespace_param: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Post an activity log
## POST /event/namespaces/{namespace}
## @deprecated
func post_event_handler(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get events from all users in a namespace with specific eventID
## GET /event/namespaces/{namespace}/eventId/{eventId}
## @deprecated
func get_event_by_event_id_handler(
	event_id: float,
	namespace_param: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", str(event_id).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get events from all users in a namespace with specific eventType
## GET /event/namespaces/{namespace}/eventType/{eventType}
## @deprecated
func get_event_by_event_type_handler(
	event_type: float,
	namespace_param: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/eventType/{eventType}"
	url_path = url_path.replace("{" + "eventType" + "}", str(event_type).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get events from all users in a namespace with specific eventID and...
## GET /event/namespaces/{namespace}/eventType/{eventType}/eventId/{eventId}
## @deprecated
func get_event_by_event_type_and_event_id_handler(
	event_id: float,
	event_type: float,
	namespace_param: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/eventType/{eventType}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", str(event_id).uri_encode())
	url_path = url_path.replace("{" + "eventType" + "}", str(event_type).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get events from specific user
## GET /event/namespaces/{namespace}/users/{userId}
## @deprecated
func get_event_by_user_id_handler(
	namespace_param: String,
	user_id: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all user's activities
## GET /event/namespaces/{namespace}/users/{userId}/activities
## @deprecated
func get_user_activities_handler(
	namespace_param: String,
	user_id: String,
	page_size: int,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/activities"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete all user's activities
## DELETE /event/namespaces/{namespace}/users/{userId}/activities
## @deprecated
func delete_user_activities_handler(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/activities"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get events from specific user with specific eventID
## GET /event/namespaces/{namespace}/users/{userId}/eventId/{eventId}
## @deprecated
func get_event_by_user_id_and_event_id_handler(
	event_id: float,
	namespace_param: String,
	user_id: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", str(event_id).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get events from specific user with specific eventType
## GET /event/namespaces/{namespace}/users/{userId}/eventType/{eventType}
## @deprecated
func get_event_by_user_id_and_event_type_handler(
	event_type: float,
	namespace_param: String,
	user_id: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/eventType/{eventType}"
	url_path = url_path.replace("{" + "eventType" + "}", str(event_type).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get events from specific user with specific eventID and eventType
## GET /event/namespaces/{namespace}/users/{userId}/eventType/{eventType}/eventId/{eventId}
## @deprecated
func get_event_by_user_event_id_and_event_type_handler(
	event_id: float,
	event_type: float,
	namespace_param: String,
	user_id: String,
	end_date: String,
	page_size: int,
	start_date: String,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/eventType/{eventType}/eventId/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", str(event_id).uri_encode())
	url_path = url_path.replace("{" + "eventType" + "}", str(event_type).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get last activity time of a user in a namespace
## GET /event/namespaces/{namespace}/users/{userId}/lastActivityTime
## @deprecated
func last_user_activity_time_handler(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/namespaces/{namespace}/users/{userId}/lastActivityTime"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get registered events in the Event Registry
## GET /event/registry/eventIds
## @deprecated
func get_registered_events_handler() -> Dictionary:
	# Build URL path
	var url_path: String = "/event/registry/eventIds"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Register an eventID to the Event Registry
## POST /event/registry/eventIds
## @deprecated
func register_event_handler(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/registry/eventIds"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get registered eventID data from the Event Registry
## GET /event/registry/eventIds/{eventId}
## @deprecated
func get_registered_event_id_handler(
	event_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/registry/eventIds/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", event_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update an eventID data in the Event Registry
## POST /event/registry/eventIds/{eventId}
## @deprecated
func update_event_registry_handler(
	event_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/registry/eventIds/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", event_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Unregister eventID from the Event Registry
## DELETE /event/registry/eventIds/{eventId}
## @deprecated
func unregister_event_id_handler(
	event_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/registry/eventIds/{eventId}"
	url_path = url_path.replace("{" + "eventId" + "}", event_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get registered eventID data from the Event Registry based on the event type
## GET /event/registry/eventTypes/{eventType}
## @deprecated
func get_registered_events_by_event_type_handler(
	event_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/registry/eventTypes/{eventType}"
	url_path = url_path.replace("{" + "eventType" + "}", event_type.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## A generic query to get a set of events based on the provided filters
## POST /event/v2/admin/namespaces/{namespace}/query
func query_event_stream_handler(
	namespace_param: String,
	end_date: String = "",
	offset: int = -1,
	page_size: int = -1,
	start_date: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/v2/admin/namespaces/{namespace}/query"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if offset >= 0:
		query_params["offset"] = offset
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get events from a specific user
## GET /event/v2/admin/namespaces/{namespace}/users/{userId}/event
func get_event_specific_user_v2_handler(
	namespace_param: String,
	user_id: String,
	end_date: String = "",
	event_name: String = "",
	offset: int = -1,
	page_size: int = -1,
	start_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/v2/admin/namespaces/{namespace}/users/{userId}/event"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not event_name.is_empty():
		query_params["eventName"] = event_name
	if offset >= 0:
		query_params["offset"] = offset
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a user edit history based on the provided type
## GET /event/v2/public/namespaces/{namespace}/users/{userId}/edithistory
func get_public_edit_history(
	namespace_param: String,
	user_id: String,
	end_date: String = "",
	offset: int = -1,
	page_size: int = -1,
	start_date: String = "",
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/v2/public/namespaces/{namespace}/users/{userId}/edithistory"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if offset >= 0:
		query_params["offset"] = offset
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get events from a specific user
## GET /event/v2/public/namespaces/{namespace}/users/{userId}/event
func get_user_events_v2_public(
	namespace_param: String,
	user_id: String,
	end_date: String = "",
	event_name: String = "",
	offset: int = -1,
	page_size: int = -1,
	start_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/event/v2/public/namespaces/{namespace}/users/{userId}/event"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not event_name.is_empty():
		query_params["eventName"] = event_name
	if offset >= 0:
		query_params["offset"] = offset
	if page_size >= 0:
		query_params["pageSize"] = page_size
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
