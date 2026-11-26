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


## A generic query to get a set of events based on the provided filters
## POST /event/v2/admin/namespaces/{namespace}/query
##
## This endpoint is using POST which is somewhat unfamiliar,
## but it's logical that we have to send/post a filter (search term) in order to get the data.
## This endpoint will not return anything if you give it an empty filters in the request body.
##
## Parameters:
## - namespace_param: Namespace
## - end_date: Ending date. e.g. 2015-03-20T12:27:06Z. Default : Current time in UTC
## - offset: Offset to query. Default : 0
## - page_size: Number of result in a page. Default : 100. Max : 500
## - start_date: Starting date. e.g. 2015-03-20T12:27:06Z. Default : 1970-01-01T00:00:00Z
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
##
## Get events from a specific user
##
## Parameters:
## - namespace_param: Namespace
## - user_id: User ID
## - end_date: Ending date. e.g. 2015-03-20T12:27:06Z. Default : Current time in UTC
## - event_name: Event Name to filter
## - offset: Offset to query. Default : 0
## - page_size: Number of result in a page. Default : 100. Max : 500
## - start_date: Starting date. e.g. 2015-03-20T12:27:06Z. Default : 1970-01-01T00:00:00Z
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
##
## Available Type:
## * email
## * password
## * displayname
## * dateofbirth
## * country
## * language
##
## Parameters:
## - namespace_param: Namespace
## - user_id: User ID
## - end_date: Ending date. e.g. 2015-03-20T12:27:06Z. Default : Current time in UTC
## - offset: Offset to query. Default : 0
## - page_size: Number of result in a page. Default : 100. Max : 500
## - start_date: Starting date. e.g. 2015-03-20T12:27:06Z. Default : 1970-01-01T00:00:00Z
## - type_param: Edit History type to fetch
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
##
## Requires valid user access token
##
## Parameters:
## - namespace_param: Namespace
## - user_id: User ID
## - end_date: Ending date. e.g. 2015-03-20T12:27:06Z. Default : Current time in UTC
## - event_name: Event Name to filter
## - offset: Offset to query. Default : 0
## - page_size: Number of result in a page. Default : 100. Max : 500
## - start_date: Starting date. e.g. 2015-03-20T12:27:06Z. Default : 1970-01-01T00:00:00Z
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
