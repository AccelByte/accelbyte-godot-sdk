## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## group_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-group-service
## Version: unknown
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


## Lists group configurations
## GET /group/v1/admin/namespaces/{namespace}/configuration
##
## Retrieves the group service configuration for the namespace. This configuration defines the main rules of the service, and each namespace has its own configuration. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func list_group_configuration_admin_v1(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Creates a new group configuration
## POST /group/v1/admin/namespaces/{namespace}/configuration
##
## Creates a new group service configuration for the namespace. Before creating the configuration, ensure that the member roles for admin and group member already exist.
##
## For each global rule, specify the rule detail with these fields:
##
## * **ruleAttribute**: attribute of the player to check
## * **ruleCriteria**: criteria for the value. Valid values: EQUAL, MINIMUM, MAXIMUM
## * **ruleValue**: value to check against
##
## Set allowedAction to any valid action in the Group Service. For this configuration, the only valid value is `createGroup`.
##
## Parameters:
## - namespace_param: Game namespace
func create_group_configuration_admin_v1(
	namespace_param: String, body: Dictionary = {}
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


## Initiates the default group service configuration for the namespace
## POST /group/v1/admin/namespaces/{namespace}/configuration/initiate
##
## Initiates a default group service configuration for the namespace. Automatically creates default configuration and member roles with default permissions.
##
## Default permissions for the admin role include:
## - Permission to invite users to a group
## - Permission to accept or reject join requests
## - Permission to kick group members
##
## The default maximum member count is 50 with no global rules configured.
##
## Parameters:
## - namespace_param: Game namespace
func initiate_group_configuration_admin_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/configuration/initiate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a group configuration
## GET /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}
##
## By its configuration code. This configuration defines the main rules of the service, and each namespace has its own configuration.
##
## Parameters:
## - configuration_code: Group Configuration Code
## - namespace_param: Game namespace
func get_group_configuration_admin_v1(
	configuration_code: String, namespace_param: String
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


## Deletes a group configuration
## DELETE /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}
##
## By its configuration code. This configuration defines the main rules of the service, and each namespace has its own configuration.
##
## Parameters:
## - configuration_code: Group Configuration Code
## - namespace_param: Game namespace
func delete_group_configuration_admin_v1(
	configuration_code: String, namespace_param: String
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


## Updates an existing group configuration
## PATCH /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}
##
## By its configuration code. The groupAdminRoleId and groupMemberRoleId fields are read-only; update the member role to change permissions instead.
##
## Parameters:
## - configuration_code: Group Configuration Code
## - namespace_param: Game namespace
func update_group_configuration_admin_v1(
	configuration_code: String, namespace_param: String, body: Dictionary = {}
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


## Updates a global rule in a group configuration
## PUT /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}/rules/{allowedAction}
##
## Based on the allowed action. Replaces the existing rule permissions with those provided in the request.
##
## Parameters:
## - allowed_action: Allowed Action. The value should be any actions in the service
## - configuration_code: Group Configuration Code
## - namespace_param: Game namespace
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


## Deletes a global rule from a group configuration
## DELETE /group/v1/admin/namespaces/{namespace}/configuration/{configurationCode}/rules/{allowedAction}
##
## Based on the allowed action. Returns success even if the specified allowed action does not exist in the global rules.
##
## Parameters:
## - allowed_action: Allowed Action. The value should be any actions in the service
## - configuration_code: Group Configuration Code
## - namespace_param: Game namespace
func delete_group_configuration_global_rule_admin_v1(
	allowed_action: String, configuration_code: String, namespace_param: String
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


## Lists groups in a namespace
## GET /group/v1/admin/namespaces/{namespace}/groups
##
## Lists all groups in the namespace across all configuration types. Supports filtering by configuration code, group name, and region. Use the limit and offset parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - configuration_code: Query Group Configuration Code
## - group_name: Query Group Name
## - group_region: Query Group Region
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Retrieves a group by ID
## GET /group/v1/admin/namespaces/{namespace}/groups/{groupId}
##
## Retrieves group information by its ID.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func get_single_group_admin_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Deletes an existing group
## DELETE /group/v1/admin/namespaces/{namespace}/groups/{groupId}
##
## Deletes a group by its ID. Returns 404 if the group does not exist.
##
## Parameters:
## - group_id: Unique identifier for the group to delete.
## - namespace_param: Game namespace
func delete_group_admin_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Lists members of a group
## GET /group/v1/admin/namespaces/{namespace}/groups/{groupId}/members
##
## Lists all members of a group. Supports pagination via the limit, offset, and order query parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order: Sort group members list by User ID with ascending as default order. Set it 'desc' for descending order
func get_group_members_list_admin_v1(
	group_id: String, namespace_param: String, limit: int = -1, offset: int = -1, order: String = ""
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


## Lists member roles
## GET /group/v1/admin/namespaces/{namespace}/roles
##
## Lists all member roles in the namespace. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_member_roles_list_admin_v1(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Creates a new member role
## POST /group/v1/admin/namespaces/{namespace}/roles
##
## With the specified permissions. For example, setting action 1 on GROUP:ROLE grants users with this role permission to create roles for group members.
##
## Parameters:
## - namespace_param: Game namespace
func create_member_role_admin_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/admin/namespaces/{namespace}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a member role
## GET /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}
##
## By its ID.
##
## Parameters:
## - member_role_id: Unique identifier for the member role.
## - namespace_param: Game namespace
func get_single_member_role_admin_v1(member_role_id: String, namespace_param: String) -> Dictionary:
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


## Deletes a member role
## DELETE /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}
##
## By its ID. Deletion fails if the role is currently assigned to a configuration as the admin or member role.
##
## Parameters:
## - member_role_id: Unique identifier for the member role to delete.
## - namespace_param: Game namespace
func delete_member_role_admin_v1(member_role_id: String, namespace_param: String) -> Dictionary:
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


## Updates a member role
## PATCH /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}
##
## 's name by its ID.
##
## Parameters:
## - member_role_id: Unique identifier for the member role to update.
## - namespace_param: Game namespace
func update_member_role_admin_v1(
	member_role_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates permissions for a member role
## PUT /group/v1/admin/namespaces/{namespace}/roles/{memberRoleId}/permissions
##
## Replaces all permissions for a member role. For example, setting action 2 on GROUP:ROLE grants users with this role permission to read the roles of other members.
##
## Parameters:
## - member_role_id: Unique identifier for the member role.
## - namespace_param: Game namespace
func update_member_role_permission_admin_v1(
	member_role_id: String, namespace_param: String, body: Dictionary = {}
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


## Lists public and open groups
## GET /group/v1/public/namespaces/{namespace}/groups
##
## Lists OPEN and PUBLIC groups in the namespace. Supports filtering by group name and region. Use the limit and offset parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - group_name: Query Group Name
## - group_region: Query Group Region
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Creates a new group
## POST /group/v1/public/namespaces/{namespace}/groups
##
## Specify **groupName** and **groupRegion** (required). Optionally include **groupDescription**, **groupIcon**, and **customAttributes**.
##
## Group rules (**groupRules**) can define custom rules and predefined rules scoped to this group:
##
## * **allowedAction**: available actions â joinGroup or createGroup
## * **ruleAttribute**: player attribute to check
## * **ruleCriteria**: comparison type â EQUAL, MINIMUM, or MAXIMUM
## * **ruleValue**: value to compare against
##
## Parameters:
## - namespace_param: Game namespace
func create_new_group_public_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves group information
## GET /group/v1/public/namespaces/{namespace}/groups/{groupId}
##
## By its ID.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func get_single_group_public_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Replaces an existing group
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}
##
## Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group to replace.
## - namespace_param: Game namespace
func update_put_single_group_public_v1(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a group
## DELETE /group/v1/public/namespaces/{namespace}/groups/{groupId}
##
## Requires the GROUP [DELETE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group to delete.
## - namespace_param: Game namespace
func delete_group_public_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Updates an existing group
## PATCH /group/v1/public/namespaces/{namespace}/groups/{groupId}
##
## Supports partial updates â only the provided fields change. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group to update.
## - namespace_param: Game namespace
func update_patch_single_group_public_v1(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Replaces custom attributes for a group
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}/attributes/custom
##
## Replaces all custom attributes for a group. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func update_group_custom_attributes_public_v1(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Accepts a group invitation
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/invite/accept
##
## Returns an error if the user has no pending invitation to the group or has already joined another group. Accepting the invitation removes all other pending invitations and join requests for the user. Existing members receive a notification when the new member joins.
##
## Parameters:
## - group_id: Unique identifier for the group whose invitation to accept.
## - namespace_param: Game namespace
func accept_group_invitation_public_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Rejects a group invitation
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/invite/reject
##
## Returns an error if the user has no pending invitation to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group whose invitation to reject.
## - namespace_param: Game namespace
func reject_group_invitation_public_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Joins a group or submits a join request
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/join
##
## Joins a group. The behavior depends on the group type:
##
## * OPEN â the user becomes a member immediately
## * PUBLIC â creates a join request that requires approval from a privileged member
## * PRIVATE â does not allow joining
##
## Returns a status of JOINED or REQUESTED.
##
## Parameters:
## - group_id: Unique identifier for the group to join.
## - namespace_param: Game namespace
func join_group_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Cancels a join request
## POST /group/v1/public/namespaces/{namespace}/groups/{groupId}/join/cancel
##
## Cancels a pending request to join a group.
##
## Parameters:
## - group_id: Unique identifier for the group to cancel the join request for.
## - namespace_param: Game namespace
func cancel_group_join_request_v1(group_id: String, namespace_param: String) -> Dictionary:
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


## Lists join requests for a group
## GET /group/v1/public/namespaces/{namespace}/groups/{groupId}/join/request
##
## Lists pending join requests for a group. Requires the GROUP:JOIN [READ] member role permission. The requesting user must also be a member of the group. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_group_join_request_public_v1(
	group_id: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists members of a group
## GET /group/v1/public/namespaces/{namespace}/groups/{groupId}/members
##
## Lists all members of a group. Supports pagination via the limit, offset, and order query parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order: Sort group members list by User ID with ascending as default order. Set it 'desc' for descending order
func get_group_members_list_public_v1(
	group_id: String, namespace_param: String, limit: int = -1, offset: int = -1, order: String = ""
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


## Updates custom rules for a group
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/custom
##
## Updates the custom rules for a group. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func update_group_custom_rule_public_v1(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates a predefined rule in a group
## PUT /group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
##
## For the specified allowed action. If the group does not yet define the action, the operation adds it. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - allowed_action: Allowed action, any available action in service
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func update_group_predefined_rule_public_v1(
	allowed_action: String, group_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a predefined rule from a group
## DELETE /group/v1/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
##
## Based on the allowed action. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - allowed_action: Allowed action, any available action in service
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func delete_group_predefined_rule_public_v1(
	allowed_action: String, group_id: String, namespace_param: String
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


## Leaves the current group
## POST /group/v1/public/namespaces/{namespace}/leave
##
## Leaves a group. Group admins cannot leave their group. Returns 404 if the user does not belong to any group.
##
## Parameters:
## - namespace_param: Game namespace
func leave_group_public_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v1/public/namespaces/{namespace}/leave"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists member roles
## GET /group/v1/public/namespaces/{namespace}/roles
##
## Lists all member roles in the namespace. Requires the GROUP:ROLE [READ] member role permission. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_member_roles_list_public_v1(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Assigns a role to a group member
## POST /group/v1/public/namespaces/{namespace}/roles/{memberRoleId}/members
##
## Assigns a member role to a group member. Requires the GROUP:ROLE [UPDATE] member role permission.
##
## Parameters:
## - member_role_id: Unique identifier for the member role to assign.
## - namespace_param: Game namespace
func update_member_role_public_v1(
	member_role_id: String, namespace_param: String, body: Dictionary = {}
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


## Removes a role from a group member
## DELETE /group/v1/public/namespaces/{namespace}/roles/{memberRoleId}/members
##
## Removes a member role from a group member. Requires the GROUP:ROLE [UPDATE] member role permission.
##
## Parameters:
## - member_role_id: Unique identifier for the member role to remove.
## - namespace_param: Game namespace
func delete_member_role_public_v1(
	member_role_id: String, namespace_param: String, body: Dictionary = {}
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


## Lists group invitations for the current user
## GET /group/v1/public/namespaces/{namespace}/users/me/invite/request
##
## Lists pending group invitations for the current user. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_group_invitation_request_public_v1(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves group membership information for a user
## GET /group/v1/public/namespaces/{namespace}/users/{userId}
##
## Returns 404 if the user does not belong to any group.
##
## Group member statuses:
##
## * JOIN â user has a pending join request
## * INVITE â user has a pending invitation
## * JOINED â user is an active member
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_group_information_public_v1(namespace_param: String, user_id: String) -> Dictionary:
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


## Invites a user to a group
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/invite
##
## Requires the GROUP:INVITE [CREATE] member role permission. Returns an error if the user already has a pending join request. The invited user receives a lobby notification. Invited users with action 1 on GROUP:INVITE can also invite others.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func invite_group_public_v1(namespace_param: String, user_id: String) -> Dictionary:
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


## Accepts a join request from a user
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/join/accept
##
## Requires the GROUP:JOIN [CREATE] member role permission. Returns an error if the user has not requested to join the group or has already joined another group.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func accept_group_join_request_public_v1(namespace_param: String, user_id: String) -> Dictionary:
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


## Rejects a join request from a user
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/join/reject
##
## Requires the GROUP:JOIN [CREATE] member role permission. Returns an error if the user has not requested to join the group or has already joined another group.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func reject_group_join_request_public_v1(namespace_param: String, user_id: String) -> Dictionary:
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


## Kicks a member from a group
## POST /group/v1/public/namespaces/{namespace}/users/{userId}/kick
##
## Removes a member from a group. Requires the GROUP:KICK [CREATE] member role permission.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func kick_group_member_public_v1(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves groups by IDs
## POST /group/v2/admin/namespaces/{namespace}/groups/bulk
##
## Retrieves a list of groups by their IDs.
##
## Parameters:
## - namespace_param: Game namespace
func get_list_group_by_i_ds_admin_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/admin/namespaces/{namespace}/groups/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists groups a user has joined
## GET /group/v2/admin/namespaces/{namespace}/users/{userId}/groups
##
## Lists groups that a user has joined. Returns a warning status if the user does not belong to any group. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_joined_group_information_public_v2(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Retrieves a user's group membership status
## GET /group/v2/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/status
##
## Retrieves the group membership status of a user for a specific group.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_group_status_information_v2(
	group_id: String, namespace_param: String, user_id: String
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


## Creates a new group
## POST /group/v2/public/namespaces/{namespace}/groups
##
## Required fields: **groupName** and **groupRegion**. Optional fields: **groupDescription**, **groupIcon**, and **customAttributes**.
##
## Group rules (**groupRules**) can define custom rules and predefined rules scoped to this group:
##
## * **allowedAction**: available actions â joinGroup or inviteGroup
## * **ruleAttribute**: player attribute to check
## * **ruleCriteria**: comparison type â EQUAL, MINIMUM, or MAXIMUM
## * **ruleValue**: value to compare against
##
## Parameters:
## - namespace_param: Game namespace
func create_new_group_public_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves groups by IDs
## POST /group/v2/public/namespaces/{namespace}/groups/bulk
##
## Retrieves a list of groups by their IDs.
##
## Parameters:
## - namespace_param: Game namespace
func get_list_group_by_i_ds_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/group/v2/public/namespaces/{namespace}/groups/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Replaces an existing group
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}
##
## Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group to replace.
## - namespace_param: Game namespace
func update_put_single_group_public_v2(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a group
## DELETE /group/v2/public/namespaces/{namespace}/groups/{groupId}
##
## Requires the GROUP [DELETE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group to delete.
## - namespace_param: Game namespace
func delete_group_public_v2(group_id: String, namespace_param: String) -> Dictionary:
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


## Updates an existing group
## PATCH /group/v2/public/namespaces/{namespace}/groups/{groupId}
##
## Supports partial updates â only provided fields take effect. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group to update.
## - namespace_param: Game namespace
func update_patch_single_group_public_v2(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Replaces custom attributes for a group
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}/attributes/custom
##
## Replaces all custom attributes for a group. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func update_group_custom_attributes_public_v2(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Accepts a group invitation
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/accept
##
## Returns an error if the user has no pending invitation for the group or has already joined another group. Accepting the invitation removes all other pending invitations and join requests for the user. Existing members receive a notification when the new member joins.
##
## Parameters:
## - group_id: Unique identifier for the group whose invitation to accept.
## - namespace_param: Game namespace
func accept_group_invitation_public_v2(group_id: String, namespace_param: String) -> Dictionary:
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


## Rejects a group invitation
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/reject
##
## Returns an error if the user has no pending invitation for the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group whose invitation to reject.
## - namespace_param: Game namespace
func reject_group_invitation_public_v2(group_id: String, namespace_param: String) -> Dictionary:
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


## Lists invite requests for a group
## GET /group/v2/public/namespaces/{namespace}/groups/{groupId}/invite/request
##
## Lists pending invite requests for a group. Requires the GROUP:JOIN [READ] member role permission. The requesting user must also be a member of the group. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_group_invite_request_public_v2(
	group_id: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Joins a group or submits a join request
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/join
##
## Joins a group. The behavior depends on the group type:
##
## * OPEN â the user becomes a member immediately
## * PUBLIC â creates a join request that requires approval from a privileged member
## * PRIVATE â the group does not allow joining
##
## Returns a status of JOINED or REQUESTED.
##
## Parameters:
## - group_id: Unique identifier for the group to join.
## - namespace_param: Game namespace
func join_group_v2(group_id: String, namespace_param: String) -> Dictionary:
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


## Lists join requests for a group
## GET /group/v2/public/namespaces/{namespace}/groups/{groupId}/join/request
##
## Lists pending join requests for a group. Requires the GROUP:JOIN [READ] member role permission. The requesting user must also be a member of the group. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_group_join_request_public_v2(
	group_id: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Leaves the current group
## POST /group/v2/public/namespaces/{namespace}/groups/{groupId}/leave
##
## Leaves a group. Group admins cannot leave their group. Returns 404 if the user does not belong to any group.
##
## Parameters:
## - group_id: Unique identifier for the group to leave.
## - namespace_param: Game namespace
func leave_group_public_v2(group_id: String, namespace_param: String) -> Dictionary:
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


## Updates custom rules for a group
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/custom
##
## Updates the custom rules for a group. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func update_group_custom_rule_public_v2(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates a predefined rule in a group
## PUT /group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
##
## For the specified allowed action. If the action is not yet defined in the group, the operation adds it. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - allowed_action: Allowed action, any available action in service
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func update_group_predefined_rule_public_v2(
	allowed_action: String, group_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a predefined rule from a group
## DELETE /group/v2/public/namespaces/{namespace}/groups/{groupId}/rules/defined/{allowedAction}
##
## Based on the allowed action. Requires the GROUP [UPDATE] member role permission. Verifies that the requesting user belongs to the specified group.
##
## Parameters:
## - allowed_action: Allowed action, any available action in service
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
func delete_group_predefined_rule_public_v2(
	allowed_action: String, group_id: String, namespace_param: String
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


## Lists member roles
## GET /group/v2/public/namespaces/{namespace}/roles
##
## Lists all member roles in the namespace. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_member_roles_list_public_v2(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Assigns a role to a group member
## POST /group/v2/public/namespaces/{namespace}/roles/{memberRoleId}/groups/{groupId}/members
##
## Assigns a member role to a group member. Requires the GROUP:ROLE [UPDATE] member role permission.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - member_role_id: Unique identifier for the member role to assign.
## - namespace_param: Game namespace
func update_member_role_public_v2(
	group_id: String, member_role_id: String, namespace_param: String, body: Dictionary = {}
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


## Removes a role from a group member
## DELETE /group/v2/public/namespaces/{namespace}/roles/{memberRoleId}/groups/{groupId}/members
##
## Removes a member role from a group member. Requires the GROUP:ROLE [UPDATE] member role permission.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - member_role_id: Unique identifier for the member role to remove.
## - namespace_param: Game namespace
func delete_member_role_public_v2(
	group_id: String, member_role_id: String, namespace_param: String, body: Dictionary = {}
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


## Lists groups the current user has joined
## GET /group/v2/public/namespaces/{namespace}/users/me/groups
##
## Returns a warning status if the user does not belong to any group. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_group_information_public_v2(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists the current user's join requests
## GET /group/v2/public/namespaces/{namespace}/users/me/join/request
##
## Lists pending join requests from the current user. Supports pagination via the limit and offset query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_my_group_join_request_v2(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Invites a user to a group
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/invite
##
## Requires the GROUP:INVITE [CREATE] member role permission. Returns an error if the user already has a pending join request. The invited user receives a lobby notification.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func invite_group_public_v2(
	group_id: String, namespace_param: String, user_id: String
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


## Cancels an invitation to a group member
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/invite/cancel
##
## Cancels an invitation sent to a user. Requires the GROUP:INVITE [DELETE] member role permission.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func cancel_invitation_group_member_v2(
	group_id: String, namespace_param: String, user_id: String
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


## Accepts a join request from a user
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/join/accept
##
## Requires the GROUP:JOIN [CREATE] member role permission. Returns an error if the user has not requested to join the group or has already joined another group.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func accept_group_join_request_public_v2(
	group_id: String, namespace_param: String, user_id: String
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


## Rejects a join request from a user
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/join/reject
##
## Returns an error if the requesting user has not asked to join the group or has already joined another group.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func reject_group_join_request_public_v2(
	group_id: String, namespace_param: String, user_id: String
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


## Kicks a member from the group
## POST /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/kick
##
## Removes the specified member from the group. Verifies the member's group membership and the caller's role permission before processing.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func kick_group_member_public_v2(
	group_id: String, namespace_param: String, user_id: String
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


## Retrieves the membership status of a user in a group
## GET /group/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/status
##
## Retrieves the current membership status for the specified user in the group. Verifies the member's group membership and the caller's role permission before returning the result.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_group_status_information_v2(
	group_id: String, namespace_param: String, user_id: String
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
