## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## reporting_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-reporting-service
## Version: 0.1.53
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


## Retrieves all auto moderation actions
## GET /reporting/v1/admin/extensionActions
##
## Returns all auto moderation actions available in the system.
func admin_find_action_list() -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/extensionActions"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates an auto moderation action
## POST /reporting/v1/admin/extensionActions
##
## Creates a new auto moderation action in the system.
func admin_create_mod_action(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/extensionActions"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves all extension categories
## GET /reporting/v1/admin/extensionCategories
##
## Returns all extension categories, optionally filtered by name.
##
## Parameters:
## - order: Sort order for results. Valid values: asc or desc. Defaults to asc.
## - sort_by: Sort field for results. Valid values: extensionCategory or extensionCategoryName. Defaults to extensionCategory.
func admin_find_extension_category_list(order: String = "", sort_by: String = "") -> Dictionary:
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


## Creates an extension category
## POST /reporting/v1/admin/extensionCategories
##
## Creates a new extension category in the system.
func admin_create_extension_category(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/extensionCategories"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the reporting configuration for a namespace
## GET /reporting/v1/admin/namespaces/{namespace}/configurations
##
## Retrieves the reporting rate-limit configuration for the namespace. Time intervals use nanoseconds. Without a configuration, the response returns service default values.
##
## Parameters:
## - namespace_param: Game namespace
## - category: Configuration category flag. set this to 'all' to retrieve all category configurations set this to 'extension' to retrieve [EXTENSION] category configurations leave it blank to retrieve core categories [UGC,USER,CHAT] configurations
func get_configurations(namespace_param: String, category: String = "") -> Dictionary:
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


## Creates or updates the reporting configuration for a namespace
## POST /reporting/v1/admin/namespaces/{namespace}/configurations
##
## Creates or updates the reporting rate-limit configuration for the namespace. Time intervals use nanoseconds.
##
## Parameters:
## - namespace_param: Game namespace
func upsert(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists reason groups in a namespace
## GET /reporting/v1/admin/namespaces/{namespace}/reasonGroups
##
## Lists reason groups for a namespace, returning each group's ID and title. Supports offset/limit pagination. To retrieve the reasons within a group, call the get reason group operation.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_list_reason_groups(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Creates a reason group
## POST /reporting/v1/admin/namespaces/{namespace}/reasonGroups
##
## Creates a reason group to make querying reasons easier. Reasons can then be queried by specifying the group title. Group titles are case-insensitive â you cannot create a group titled **reason** if one already exists titled **Reason**.
##
## Parameters:
## - namespace_param: Game namespace
func create_reason_group(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasonGroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a reason group by ID
## GET /reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}
##
## Retrieves a reason group and its associated reasons by ID.
##
## Parameters:
## - group_id: Reason group ID
## - namespace_param: Game namespace
func get_reason_group(group_id: String, namespace_param: String) -> Dictionary:
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


## Deletes a reason group
## DELETE /reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}
##
## Deletes the reason group with the specified ID from the namespace.
##
## Parameters:
## - group_id: Reason group ID
## - namespace_param: Game namespace
func delete_reason_group(group_id: String, namespace_param: String) -> Dictionary:
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


## Updates a reason group
## PATCH /reporting/v1/admin/namespaces/{namespace}/reasonGroups/{groupId}
##
## Reason group titles are case-insensitive: you cannot create a group titled 'reason' if one titled 'Reason' already exists. When updating without reason IDs, the group retains its current reasons.
##
## Parameters:
## - group_id: Reason group ID
## - namespace_param: Game namespace
func update_reason_group(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Lists reasons in a namespace
## GET /reporting/v1/admin/namespaces/{namespace}/reasons
##
## Lists reasons for a namespace with offset/limit pagination. Filter results by reason group title or reason title.
##
## Parameters:
## - namespace_param: Game namespace
## - group: Query reasons under specified reason group
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - title: Query reason(s) by title
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


## Creates a report reason
## POST /reporting/v1/admin/namespaces/{namespace}/reasons
##
## Creates a report reason that users can select when submitting a report.
##
## Parameters:
## - namespace_param: Game namespace
func create_reason(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves all reasons without pagination
## GET /reporting/v1/admin/namespaces/{namespace}/reasons/all
##
## Returns all reasons in the namespace in a single response, without pagination.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_all_reasons(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reasons/all"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists reasons not used by any moderation rule
## GET /reporting/v1/admin/namespaces/{namespace}/reasons/unused
##
## Lists reasons in the namespace that are not assigned to any moderation rule.
##
## Parameters:
## - namespace_param: Game namespace
## - extension_category: Extension category to further filter unused reasons.
## - category: Report category to filter unused reasons for.
func admin_get_unused_reasons(
	namespace_param: String, category: String, extension_category: String = ""
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


## Retrieves a single report reason
## GET /reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}
##
## Retrieves the report reason with the specified ID.
##
## Parameters:
## - namespace_param: Game namespace
## - reason_id: Report reason ID.
func admin_get_reason(namespace_param: String, reason_id: String) -> Dictionary:
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


## Deletes a report reason
## DELETE /reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}
##
## Deletes the report reason with the specified ID from the namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - reason_id: Report reason ID.
func delete_reason(namespace_param: String, reason_id: String) -> Dictionary:
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


## Updates a report reason
## PATCH /reporting/v1/admin/namespaces/{namespace}/reasons/{reasonId}
##
## Updates the report reason with the specified ID.
##
## Parameters:
## - namespace_param: Game namespace
## - reason_id: Report reason ID.
func update_reason(namespace_param: String, reason_id: String, body: Dictionary = {}) -> Dictionary:
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


## Lists submitted reports for a namespace
## GET /reporting/v1/admin/namespaces/{namespace}/reports
##
## Lists submitted reports for a namespace with offset/limit pagination. Supports sorting by createdAt or updatedAt.
##
## Parameters:
## - namespace_param: Game namespace
## - category: Filter reports by category
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - reported_user_id: Filter reports by reportedUserId
## - sort_by: Sort field and direction. Valid values: createdAt:asc, createdAt:desc, updatedAt:asc, updatedAt:desc. Defaults to createdAt:desc.
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


## Submits a report as an admin
## POST /reporting/v1/admin/namespaces/{namespace}/reports
##
## Submits a report for the specified user or content object and returns the associated ticket. Creates a new ticket if no open ticket exists for the reported object (matched by object ID and type) in the namespace. An admin can submit only one report per distinct user or object per open ticket; reporting the same target on the same open ticket returns a 409 conflict. Set the reason field to a reason title. Supported categories: UGC, USER, CHAT, EXTENSION.
##
## Parameters:
## - namespace_param: Game namespace
func admin_submit_report(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/reports"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Creates an auto moderation rule
## POST /reporting/v1/admin/namespaces/{namespace}/rule
##
## Creates an auto moderation rule for the namespace. Supported categories: UGC, USER, CHAT, EXTENSION. Supported actions: `hideContent` (hides the content), banAccount (bans the user account), deleteChat (deletes the chat). The action field (deprecated) â use the actions field instead.
##
## Parameters:
## - namespace_param: Game namespace
func create_moderation_rule(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/admin/namespaces/{namespace}/rule"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates an auto moderation rule
## PUT /reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}
##
## Updates an auto moderation rule for the namespace. Supported categories: UGC, USER, CHAT, EXTENSION. Supported actions: `hideContent` (hides the content), banAccount (bans the user account), deleteChat (deletes the chat). The action field (deprecated) â use the actions field instead.
##
## Parameters:
## - namespace_param: Game namespace
## - rule_id: Auto moderation rule ID.
func update_moderation_rule(
	namespace_param: String, rule_id: String, body: Dictionary = {}
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


## Deletes an auto moderation rule
## DELETE /reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}
##
## Deletes the auto moderation rule with the specified ID.
##
## Parameters:
## - namespace_param: Game namespace
## - rule_id: Auto moderation rule ID.
func delete_moderation_rule(namespace_param: String, rule_id: String) -> Dictionary:
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


## Enables or disables an auto moderation rule
## PUT /reporting/v1/admin/namespaces/{namespace}/rule/{ruleId}/status
##
## Enables or disables the auto moderation rule with the specified ID.
##
## Parameters:
## - namespace_param: Game namespace
## - rule_id: Auto moderation rule ID.
func update_moderation_rule_status(
	namespace_param: String, rule_id: String, body: Dictionary = {}
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


## Lists auto moderation rules for a namespace
## GET /reporting/v1/admin/namespaces/{namespace}/rules
##
## Lists auto moderation rules for a namespace with offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - category: Filter rules by category
## - extension_category: Filter rules by extension category
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Retrieves an auto moderation rule
## GET /reporting/v1/admin/namespaces/{namespace}/rules/{ruleId}
##
## Retrieves the auto moderation rule with the specified ID.
##
## Parameters:
## - namespace_param: Game namespace
## - rule_id: Auto moderation rule ID.
func get_moderation_rule_details(namespace_param: String, rule_id: String) -> Dictionary:
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


## Lists report tickets for a namespace
## GET /reporting/v1/admin/namespaces/{namespace}/tickets
##
## Lists report tickets for a namespace with offset/limit pagination. Supports sorting by createdAt, reportsCount, or status.
##
## Parameters:
## - namespace_param: Game namespace
## - category: Filter tickets by category
## - extension_category: Filter tickets by extension category
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order: Sort order for results. Valid values: asc or desc. Defaults to desc.
## - reported_user_id: Filter reports by reportedUserId
## - sort_by: Sort key for results. Valid values: createdAt, reportsCount, status. Defaults to createdAt.
## - status: Filter tickets by status. Valid values: OPEN, AUTO_MODERATED, CLOSED.
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


## Retrieves ticket statistics
## GET /reporting/v1/admin/namespaces/{namespace}/tickets/statistic
##
## Retrieves ticket statistics for the namespace, filterable by category and extension category.
##
## Parameters:
## - namespace_param: Game namespace
## - extension_category: Filter statistic by extension category
## - category: Filter statistic by category
func ticket_statistic(
	namespace_param: String, category: String, extension_category: String = ""
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


## Retrieves a single report ticket
## GET /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}
##
## Retrieves the ticket details for the specified ticket ID.
##
## Parameters:
## - namespace_param: Game namespace
## - ticket_id: Ticket ID.
func get_ticket_detail(namespace_param: String, ticket_id: String) -> Dictionary:
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


## Deletes a report ticket
## DELETE /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}
##
## Deletes the ticket and all its associated reports.
##
## Parameters:
## - namespace_param: Game namespace
## - ticket_id: Ticket ID.
func delete_ticket(namespace_param: String, ticket_id: String) -> Dictionary:
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


## Lists reports for a ticket
## GET /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}/reports
##
## Lists reports for the specified ticket, ordered by createdAt descending. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - ticket_id: Ticket ID.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_reports_by_ticket(
	namespace_param: String, ticket_id: String, limit: int = -1, offset: int = -1
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


## Updates a ticket's resolution status
## POST /reporting/v1/admin/namespaces/{namespace}/tickets/{ticketId}/resolutions
##
## Updates the resolution status of the specified ticket to OPEN or CLOSED. You must include notes.
##
## Parameters:
## - namespace_param: Game namespace
## - ticket_id: Ticket ID.
func update_ticket_resolutions(
	namespace_param: String, ticket_id: String, body: Dictionary = {}
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


## Lists reason groups for a namespace
## GET /reporting/v1/public/namespaces/{namespace}/reasonGroups
##
## Lists reason groups by ID and title for the specified namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func public_list_reason_groups(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists reasons for a namespace
## GET /reporting/v1/public/namespaces/{namespace}/reasons
##
## Lists reasons for the specified namespace, optionally filtered by reason group or title. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - group: Query reasons under specified reason group
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - title: Query reason(s) by title
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


## Submits a report
## POST /reporting/v1/public/namespaces/{namespace}/reports
##
## Submit a report and will return ticket for reported object.
## The system creates a new ticket if no OPEN ticket exists for the reported object (based by `objectId` and `objectType`) in a namespace.
##
## User can only submit report once for each different user / object reported in the same OPEN ticket.
## Reporting the same user / object in the same OPEN ticket will return HTTP code 409 (conflict).
##
## Fill the 'reason' field with a 'reason title'
## Supported category: - UGC - USER - CHAT - EXTENSION
##
## Parameters:
## - namespace_param: Game namespace
func submit_report(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/reporting/v1/public/namespaces/{namespace}/reports"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
