## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## audit_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-audit-log-service
## Version: 1.9.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = AuditServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name AuditServiceWeb
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
	print("  [AuditServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [AuditServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## GetHealthcheckInfoV1
## GET /audit/healthz
func get_healthcheck_info_v1() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/healthz"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Find all category and action names
## GET /audit/v1/admin/config/categories
func admin_get_category_v1() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/config/categories"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query category and action names
## GET /audit/v1/admin/config/categories/query
## @deprecated
func admin_query_category_v1(end_date: float = 0.0,namespace_param: String = "",start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/config/categories/query"

	# Build query parameters
	var query_params: Dictionary = {}
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get valid time range for query
## GET /audit/v1/admin/config/time-range
func admin_get_time_range_config_v1() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/config/time-range"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query audit logs
## GET /audit/v1/admin/logs
func admin_query_audit_log_v1(action: String = "",actor: String = "",actor_type: String = "",category: String = "",client_id: String = "",end_date: float = 0.0,has_comment_only: bool = false,limit: int = 0,namespace_param: String = "",object_id: String = "",object_type: String = "",offset: int = 0,sort: String = "",start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/logs"

	# Build query parameters
	var query_params: Dictionary = {}
	if not action.is_empty():
		query_params["action"] = action
	if not actor.is_empty():
		query_params["actor"] = actor
	if not actor_type.is_empty():
		query_params["actorType"] = actor_type
	if not category.is_empty():
		query_params["category"] = category
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if end_date != 0.0:
		query_params["endDate"] = end_date
	query_params["hasCommentOnly"] = has_comment_only
	if limit != 0:
		query_params["limit"] = limit
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not object_id.is_empty():
		query_params["objectId"] = object_id
	if not object_type.is_empty():
		query_params["objectType"] = object_type
	if offset != 0:
		query_params["offset"] = offset
	if not sort.is_empty():
		query_params["sort"] = sort
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Export audit logs
## GET /audit/v1/admin/logs/export
func admin_export_audit_log_v1(action: String = "",actor: String = "",actor_type: String = "",category: String = "",client_id: String = "",end_date: float = 0.0,namespace_param: String = "",object_id: String = "",object_type: String = "",sort: String = "",start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/logs/export"

	# Build query parameters
	var query_params: Dictionary = {}
	if not action.is_empty():
		query_params["action"] = action
	if not actor.is_empty():
		query_params["actor"] = actor
	if not actor_type.is_empty():
		query_params["actorType"] = actor_type
	if not category.is_empty():
		query_params["category"] = category
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not object_id.is_empty():
		query_params["objectId"] = object_id
	if not object_type.is_empty():
		query_params["objectType"] = object_type
	if not sort.is_empty():
		query_params["sort"] = sort
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get audit details by id
## GET /audit/v1/admin/namespace/{namespace}/logs/{logId}
func admin_get_audit_log_v1(log_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespace/{namespace}/logs/{logId}"
	url_path = url_path.replace("{" + "logId" + "}", _url_encode(log_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Delete User Account History
## DELETE /audit/v1/admin/namespace/{namespace}/users/{userId}/account/histories
func admin_delete_user_account_history_v1(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespace/{namespace}/users/{userId}/account/histories"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Query User Account History
## GET /audit/v1/admin/namespace/{namespace}/users/{userId}/account/histories
func admin_query_account_history_v1(namespace_param: String,user_id: String,end_date: float = 0.0,limit: int = 0,offset: int = 0,order: String = "",property: String = "",property_type: String = "",start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespace/{namespace}/users/{userId}/account/histories"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not property.is_empty():
		query_params["property"] = property
	if not property_type.is_empty():
		query_params["propertyType"] = property_type
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query User Account Critical Events
## GET /audit/v1/admin/namespace/{namespace}/users/{userId}/events/critical
func admin_query_account_events_v1(namespace_param: String,user_id: String,action: String = "",category: String = "",end_date: float = 0.0,limit: int = 0,offset: int = 0,order: String = "",property: String = "",start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespace/{namespace}/users/{userId}/events/critical"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not action.is_empty():
		query_params["action"] = action
	if not category.is_empty():
		query_params["category"] = category
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not property.is_empty():
		query_params["property"] = property
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query User Account Critical Events Categories
## GET /audit/v1/admin/namespace/{namespace}/users/{userId}/events/critical/categories
func admin_query_account_event_categories_v1(namespace_param: String,user_id: String,end_date: float = 0.0,start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespace/{namespace}/users/{userId}/events/critical/categories"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query Audit Log Comments
## GET /audit/v1/admin/namespaces/{namespace}/comments
func admin_query_audit_comments_v1(namespace_param: String,log_id: String,limit: int = 0,offset: int = 0,order: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/comments"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not log_id.is_empty():
		query_params["logId"] = log_id
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if order != 0:
		query_params["order"] = order

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create Audit Log Comment
## POST /audit/v1/admin/namespaces/{namespace}/comments
func admin_create_audit_comment_v1(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/comments"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete Audit Log Comment By Id
## DELETE /audit/v1/admin/namespaces/{namespace}/comments/{commentId}
func admin_delete_audit_comment_v1(comment_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/comments/{commentId}"
	url_path = url_path.replace("{" + "commentId" + "}", _url_encode(comment_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Update Audit Log Comment By Id
## PATCH /audit/v1/admin/namespaces/{namespace}/comments/{commentId}
func admin_update_audit_comment_v1(comment_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/comments/{commentId}"
	url_path = url_path.replace("{" + "commentId" + "}", _url_encode(comment_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Masks all comments made by a specific user identified by their user ID.
## DELETE /audit/v1/admin/namespaces/{namespace}/users/{userId}/comments
func admin_mask_audit_comments_by_user_id_v1(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/users/{userId}/comments"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Query User Comments
## GET /audit/v1/admin/namespaces/{namespace}/users/{userId}/comments
func admin_query_user_comments_v1(namespace_param: String,user_id: String,actor_user_id: String = "",limit: int = 0,offset: int = 0,order: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/users/{userId}/comments"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not actor_user_id.is_empty():
		query_params["actorUserId"] = actor_user_id
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if order != 0:
		query_params["order"] = order

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create User Comment
## POST /audit/v1/admin/namespaces/{namespace}/users/{userId}/comments
func admin_create_user_comment_v1(namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/users/{userId}/comments"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Find All Actor User Comments
## GET /audit/v1/admin/namespaces/{namespace}/users/{userId}/comments/actors
func admin_find_all_actor_user_comments_v1(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/users/{userId}/comments/actors"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Delete User Comment
## DELETE /audit/v1/admin/namespaces/{namespace}/users/{userId}/comments/{commentId}
func admin_delete_user_comment_v1(comment_id: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/users/{userId}/comments/{commentId}"
	url_path = url_path.replace("{" + "commentId" + "}", _url_encode(comment_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Update User Comment
## PATCH /audit/v1/admin/namespaces/{namespace}/users/{userId}/comments/{commentId}
func admin_update_user_comment_v1(comment_id: String,namespace_param: String,user_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/namespaces/{namespace}/users/{userId}/comments/{commentId}"
	url_path = url_path.replace("{" + "commentId" + "}", _url_encode(comment_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Query Admin Own Account History
## GET /audit/v1/admin/users/me/account/histories
func admin_query_my_account_history_v1(end_date: float = 0.0,limit: int = 0,offset: int = 0,property: String = "",start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/admin/users/me/account/histories"

	# Build query parameters
	var query_params: Dictionary = {}
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not property.is_empty():
		query_params["property"] = property
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query User Account History
## GET /audit/v1/public/users/me/account/histories
func public_query_my_account_history_v1(end_date: float = 0.0,limit: int = 0,offset: int = 0,property: String = "",start_date: float = 0.0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/v1/public/users/me/account/histories"

	# Build query parameters
	var query_params: Dictionary = {}
	if end_date != 0.0:
		query_params["endDate"] = end_date
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	if not property.is_empty():
		query_params["property"] = property
	if start_date != 0.0:
		query_params["startDate"] = start_date

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## showVersionHandler
## GET /audit/version
func show_version_handler() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/audit/version"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## GetHealthcheckInfo
## GET /healthz
func get_healthcheck_info() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/healthz"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
