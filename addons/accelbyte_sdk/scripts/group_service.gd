## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## group_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-group-service
## Version: 2.22.1
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(GroupService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name GroupService
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

## List Group Configuration
## GET /group/v1/admin/namespaces/{namespace}/configuration
func list_group_configuration_admin_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration"
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

## create new configuration
## POST /group/v1/admin/namespaces/{namespace}/configuration
func create_group_configuration_admin_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## initiate configuration
## POST /group/v1/admin/namespaces/{namespace}/configuration/initiate
func initiate_group_configuration_admin_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration/initiate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get existing configuration
## GET /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}
func get_group_configuration_admin_v1(
	configuration_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}"
	url_path = url_path.replace("{" + "configurationCode" + "}", configuration_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete group configuration
## DELETE /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}
func delete_group_configuration_v1(
	configuration_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}"
	url_path = url_path.replace("{" + "configurationCode" + "}", configuration_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## update existing configuration
## PATCH /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}
func update_group_configuration_admin_v1(
	configuration_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}"
	url_path = url_path.replace("{" + "configurationCode" + "}", configuration_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## update existing configuration global rule
## PUT /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}/rules/{allowedAction}
func update_group_configuration_global_rule_admin_v1(
	allowed_action: String,
	configuration_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}/rules/{allowedAction}"
	url_path = url_path.replace("{" + "allowedAction" + "}", allowed_action.uri_encode())
	url_path = url_path.replace("{" + "configurationCode" + "}", configuration_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete existing configuration global rule based on allowed action
## DELETE /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}/rules/{allowedAction}
func delete_group_configuration_global_rule_admin_v1(
	allowed_action: String,
	configuration_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}/rules/{allowedAction}"
	url_path = url_path.replace("{" + "allowedAction" + "}", allowed_action.uri_encode())
	url_path = url_path.replace("{" + "configurationCode" + "}", configuration_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get list of groups
## GET /group/v1/admin/namespaces/{namespace}/groups
func get_group_list_admin_v1(
	namespace_param: String,
	configuration_code: String = "",
	group_name: String = "",
	group_region: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not configuration_code.is_empty():
		query_params["configurationCode"] = configuration_code
	if not group_name.is_empty():
		query_params["groupName"] = group_name
	if not group_region.is_empty():
		query_params["groupRegion"] = group_region
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

## get single group
## GET /group/v1/admin/namespaces/{namespace}/groups/{groupId}
func get_single_group_admin_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete existing group
## DELETE /group/v1/admin/namespaces/{namespace}/groups/{groupId}
func delete_group_admin_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get list of group members
## GET /group/v1/admin/namespaces/{namespace}/groups/{groupId}/members
func get_group_members_list_admin_v1(
	group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	order: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/groups/{groupId}/members"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get all list of member roles
## GET /group/v1/admin/namespaces/{namespace}/roles
func get_member_roles_list_admin_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/roles"
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

## create new member role
## POST /group/v1/admin/namespaces/{namespace}/roles
func create_member_role_admin_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get member role
## GET /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}
func get_single_member_role_admin_v1(
	member_role_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}"
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## delete member role
## DELETE /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}
func delete_member_role_admin_v1(
	member_role_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}"
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## update member role
## PATCH /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}
func update_member_role_admin_v1(
	member_role_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}"
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## update member role permission
## PUT /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}/permissions
func update_member_role_permission_admin_v1(
	member_role_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}/permissions"
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## get list of groups
## GET /group/v1/public/namespaces/{namespace}/groups
func get_group_list_public_v1(
	namespace_param: String,
	group_name: String = "",
	group_region: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not group_name.is_empty():
		query_params["groupName"] = group_name
	if not group_region.is_empty():
		query_params["groupRegion"] = group_region
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

## create new group
## POST /group/v1/public/namespaces/{namespace}/groups
func create_new_group_public_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get single group
## GET /group/v1/public/namespaces/{namespace}/groups/{groupId}
func get_single_group_public_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update existing group
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}
func update_single_group_v1(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete existing group
## DELETE /group/v1/public/namespaces/{namespace}/groups/{groupId}
func delete_group_public_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## update existing group
## PATCH /group/v1/public/namespaces/{namespace}/groups/{groupId}
func update_patch_single_group_public_v1(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update group custom attributes
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}/attributes/custom
func update_group_custom_attributes_public_v1(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/attributes/custom"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Accept Group Invitation
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/invite/accept
func accept_group_invitation_public_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/invite/accept"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Reject Group Invitation
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/invite/reject
func reject_group_invitation_public_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/invite/reject"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Join to group
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/join
func join_group_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/join"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Cancel request to join group
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/join/cancel
func cancel_group_join_request_v1(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/join/cancel"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Group Join Request List
## GET /group/v1/public/namespaces/{namespace}/groups/{groupId}/join/request
func get_group_join_request_public_v1(
	group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/join/request"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
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

## Get list of group members
## GET /group/v1/public/namespaces/{namespace}/groups/{groupId}/members
func get_group_members_list_public_v1(
	group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	order: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/members"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update group custom rule
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/custom
func update_group_custom_rule_public_v1(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/custom"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## update predefined group rule
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
func update_group_predefined_rule_public_v1(
	allowed_action: String,
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}"
	url_path = url_path.replace("{" + "allowedAction" + "}", allowed_action.uri_encode())
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete group predefined rule
## DELETE /group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
func delete_group_predefined_rule_public_v1(
	allowed_action: String,
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}"
	url_path = url_path.replace("{" + "allowedAction" + "}", allowed_action.uri_encode())
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Leave group
## POST /group/v1/public/namespaces/{namespace}/leave
func leave_group_public_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/leave"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get all list of member roles
## GET /group/v1/public/namespaces/{namespace}/roles
func get_member_roles_list_public_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/roles"
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

## Assign role to group member
## POST /group/v1/public/namespaces/{namespace}/roles/{memberRoleId}/members
func update_member_role_public_v1(
	member_role_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/roles/{memberRoleId}/members"
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove role from group member
## DELETE /group/v1/public/namespaces/{namespace}/roles/{memberRoleId}/members
func delete_member_role_public_v1(
	member_role_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/roles/{memberRoleId}/members"
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Group Invitation Request List
## GET /group/v1/public/namespaces/{namespace}/users/me/invite/request
func get_group_invitation_request_public_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/users/me/invite/request"
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

## Get User Group Information
## GET /group/v1/public/namespaces/{namespace}/users/{userId}
func get_user_group_information_public_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Invite user to group
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/invite
func invite_group_public_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/users/{userId}/invite"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Accept Group Join Request
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/join/accept
func accept_group_join_request_public_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/users/{userId}/join/accept"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Reject Group Join Request
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/join/reject
func reject_group_join_request_public_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/users/{userId}/join/reject"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Kick Group Member
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/kick
func kick_group_member_public_v1(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/users/{userId}/kick"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get list of groups by group Ids
## POST /group/v2/admin/namespaces/{namespace}/groups/bulk
func get_list_group_by_i_ds_admin_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/admin/namespaces/{namespace}/groups/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get User Joined Group Information
## GET /group/v2/admin/namespaces/{namespace}/users/{userId}/groups
func get_user_joined_group_information_public_v2(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/admin/namespaces/{namespace}/users/{userId}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
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

## User Group Status Information
## GET /group/v2/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/status
func admin_get_user_group_status_information_v2(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/status"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## create new group
## POST /group/v2/public/namespaces/{namespace}/groups
func create_new_group_public_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get list of groups by group Ids
## POST /group/v2/public/namespaces/{namespace}/groups/bulk
func get_list_group_by_i_ds_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## update existing group
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}
func update_put_single_group_public_v2(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete existing group
## DELETE /group/v2/public/namespaces/{namespace}/groups/{groupId}
func delete_group_public_v2(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## update existing group
## PATCH /group/v2/public/namespaces/{namespace}/groups/{groupId}
func update_patch_single_group_public_v2(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update group custom attributes
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}/attributes/custom
func update_group_custom_attributes_public_v2(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/attributes/custom"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Accept Group Invitation
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/accept
func accept_group_invitation_public_v2(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/accept"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Reject Group Invitation
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/reject
func reject_group_invitation_public_v2(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/reject"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Group Invite Request List
## GET /group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/request
func get_group_invite_request_public_v2(
	group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/request"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
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

## Join to group
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/join
func join_group_v2(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/join"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Group Join Request List
## GET /group/v2/public/namespaces/{namespace}/groups/{groupId}/join/request
func get_group_join_request_public_v2(
	group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/join/request"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
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

## Leave group
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/leave
func leave_group_public_v2(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/leave"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## update group custom rule
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/custom
func update_group_custom_rule_public_v2(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/custom"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## update predefined group rule
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
func update_group_predefined_rule_public_v2(
	allowed_action: String,
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}"
	url_path = url_path.replace("{" + "allowedAction" + "}", allowed_action.uri_encode())
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete group predefined rule
## DELETE /group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
func delete_group_predefined_rule_public_v2(
	allowed_action: String,
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}"
	url_path = url_path.replace("{" + "allowedAction" + "}", allowed_action.uri_encode())
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get all list of member roles
## GET /group/v2/public/namespaces/{namespace}/roles
func get_member_roles_list_public_v2(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/roles"
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

## Assign role to group member
## POST /group/v2/public/namespaces/{namespace}/roles/{memberRoleId}/groups/{groupId}/members
func update_member_role_public_v2(
	group_id: String,
	member_role_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/roles/{memberRoleId}/groups/{groupId}/members"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove role from group member
## DELETE /group/v2/public/namespaces/{namespace}/roles/{memberRoleId}/groups/{groupId}/members
func delete_member_role_public_v2(
	group_id: String,
	member_role_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/roles/{memberRoleId}/groups/{groupId}/members"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	url_path = url_path.replace("{" + "memberRoleId" + "}", member_role_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get User Joined Group Information
## GET /group/v2/public/namespaces/{namespace}/users/me/groups
func get_user_group_information_public_v2(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/me/groups"
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

## Get My Join Request To The Groups
## GET /group/v2/public/namespaces/{namespace}/users/me/join/request
func get_my_group_join_request_v2(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/me/join/request"
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

## Invite user to group
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/invite
func invite_group_public_v2(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/invite"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Cancel Invitation Group Member
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/invite/cancel
func cancel_invitation_group_member_v2(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/invite/cancel"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Accept Group Join Request
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/join/accept
func accept_group_join_request_public_v2(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/join/accept"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Reject Group Join Request
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/join/reject
func reject_group_join_request_public_v2(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/join/reject"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Kick Group Member
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/kick
func kick_group_member_public_v2(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/kick"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## User Group Status Information
## GET /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/status
func get_user_group_status_information_v2(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/status"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
