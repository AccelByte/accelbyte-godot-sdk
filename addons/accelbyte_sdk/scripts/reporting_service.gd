## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## reporting_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-reporting-service
## Version: 0.1.46
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(ReportingService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name ReportingService
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

## Find Auto Moderation Action List
## GET /reporting/v1/admin/extensionActions
func admin_find_action_list() -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/extensionActions"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Auto Moderation Action data
## POST /reporting/v1/admin/extensionActions
func admin_create_mod_action(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/extensionActions"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Find Extension Category List
## GET /reporting/v1/admin/extensionCategories
func admin_find_extension_category_list(
	order: String = "",
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/extensionCategories"
	# Build query parameters
	var query_params: Dictionary = {}
	if not order.is_empty():
		query_params["order"] = order
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Extension Category
## POST /reporting/v1/admin/extensionCategories
func admin_create_extension_category(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/extensionCategories"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get configuration
## GET /reporting/v1/admin/namespaces/{namespace}/configurations
func get_configurations(
	namespace_param: String,
	category: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not category.is_empty():
		query_params["category"] = category
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create/Update configuration
## POST /reporting/v1/admin/namespaces/{namespace}/configurations
func upsert(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List reason groups under a namespace
## GET /reporting/v1/admin/namespaces/{namespace}/reasonGroups
func admin_list_reason_groups(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasonGroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a reason group
## POST /reporting/v1/admin/namespaces/{namespace}/reasonGroups
func create_reason_group(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasonGroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get reason group
## GET /reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}
func get_reason_group(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete a reason group
## DELETE /reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}
func delete_reason_group(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update a reason group
## PATCH /reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}
func update_reason_group(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get list of reasons
## GET /reporting/v1/admin/namespaces/{namespace}/reasons
func admin_get_reasons(
	namespace_param: String,
	group: String = "",
	limit: int = -1,
	offset: int = -1,
	title: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not group.is_empty():
		query_params["group"] = group
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not title.is_empty():
		query_params["title"] = title
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a report reason
## POST /reporting/v1/admin/namespaces/{namespace}/reasons
func create_reason(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get all reasons
## GET /reporting/v1/admin/namespaces/{namespace}/reasons/all
func admin_get_all_reasons(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons/all"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of reasons that not used by moderation rules
## GET /reporting/v1/admin/namespaces/{namespace}/reasons/unused
func admin_get_unused_reasons(
	namespace_param: String,
	category: String,
	extension_category: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons/unused"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not extension_category.is_empty():
		query_params["extensionCategory"] = extension_category
	if not category.is_empty():
		query_params["category"] = category
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a single reason
## GET /reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}
func admin_get_reason(
	namespace_param: String,
	reason_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "reasonId" + "}", reason_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete a report reason
## DELETE /reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}
func delete_reason(
	namespace_param: String,
	reason_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "reasonId" + "}", reason_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update a report reason
## PATCH /reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}
func update_reason(
	namespace_param: String,
	reason_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "reasonId" + "}", reason_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## List reports
## GET /reporting/v1/admin/namespaces/{namespace}/reports
func list_reports(
	namespace_param: String,
	category: String = "",
	limit: int = -1,
	offset: int = -1,
	reported_user_id: String = "",
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reports"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not category.is_empty():
		query_params["category"] = category
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not reported_user_id.is_empty():
		query_params["reportedUserId"] = reported_user_id
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Submit a report by admin
## POST /reporting/v1/admin/namespaces/{namespace}/reports
func admin_submit_report(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reports"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create auto moderation rule
## POST /reporting/v1/admin/namespaces/{namespace}/rule
func create_moderation_rule(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/rule"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update auto moderation rule
## PUT /reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}
func update_moderation_rule(
	namespace_param: String,
	rule_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ruleId" + "}", rule_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete auto moderation rule
## DELETE /reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}
func delete_moderation_rule(
	namespace_param: String,
	rule_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ruleId" + "}", rule_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Enable/Disable auto moderation rule
## PUT /reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}/status
func update_moderation_rule_status(
	namespace_param: String,
	rule_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ruleId" + "}", rule_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get auto moderation rules
## GET /reporting/v1/admin/namespaces/{namespace}/rules
func get_moderation_rules(
	namespace_param: String,
	category: String = "",
	extension_category: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/rules"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not category.is_empty():
		query_params["category"] = category
	if not extension_category.is_empty():
		query_params["extensionCategory"] = extension_category
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get auto moderation rule
## GET /reporting/v1/admin/namespaces/{namespace}/rules/{ruleId}
func get_moderation_rule_details(
	namespace_param: String,
	rule_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/rules/{ruleId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ruleId" + "}", rule_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List report tickets
## GET /reporting/v1/admin/namespaces/{namespace}/tickets
func list_tickets(
	namespace_param: String,
	category: String = "",
	extension_category: String = "",
	limit: int = -1,
	offset: int = -1,
	order: String = "",
	reported_user_id: String = "",
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/tickets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not category.is_empty():
		query_params["category"] = category
	if not extension_category.is_empty():
		query_params["extensionCategory"] = extension_category
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not reported_user_id.is_empty():
		query_params["reportedUserId"] = reported_user_id
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Ticket statistic
## GET /reporting/v1/admin/namespaces/{namespace}/tickets/statistic
func ticket_statistic(
	namespace_param: String,
	category: String,
	extension_category: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/tickets/statistic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not extension_category.is_empty():
		query_params["extensionCategory"] = extension_category
	if not category.is_empty():
		query_params["category"] = category
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get single ticket
## GET /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}
func get_ticket_detail(
	namespace_param: String,
	ticket_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketId" + "}", ticket_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete single ticket
## DELETE /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}
func delete_ticket(
	namespace_param: String,
	ticket_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketId" + "}", ticket_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get reports by ticket ID
## GET /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}/reports
func get_reports_by_ticket(
	namespace_param: String,
	ticket_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}/reports"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketId" + "}", ticket_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update ticket resolution to a given status
## POST /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}/resolutions
func update_ticket_resolutions(
	namespace_param: String,
	ticket_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}/resolutions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "ticketId" + "}", ticket_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List reason groups under a namespace
## GET /reporting/v1/public/namespaces/{namespace}/reasonGroups
func public_list_reason_groups(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/public/namespaces/{namespace}/reasonGroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of reasons
## GET /reporting/v1/public/namespaces/{namespace}/reasons
func public_get_reasons(
	namespace_param: String,
	group: String = "",
	limit: int = -1,
	offset: int = -1,
	title: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/public/namespaces/{namespace}/reasons"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not group.is_empty():
		query_params["group"] = group
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not title.is_empty():
		query_params["title"] = title
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Submit a report
## POST /reporting/v1/public/namespaces/{namespace}/reports
func submit_report(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/public/namespaces/{namespace}/reports"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
