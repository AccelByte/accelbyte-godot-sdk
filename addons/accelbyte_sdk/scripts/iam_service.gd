## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## iam_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-iam-service
## Version: 7.37.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(IamService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name IamService
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

## Get list of ban types
## GET /iam/bans
## @deprecated
func get_bans_type() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/bans"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of ban reasons
## GET /iam/bans/reasons
## @deprecated
func get_list_ban_reason() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/bans/reasons"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get All Clients
## GET /iam/clients
## @deprecated
func get_clients() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Client
## POST /iam/clients
## @deprecated
func create_client(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Client
## GET /iam/clients/{clientId}
## @deprecated
func get_client(
	client_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients/{clientId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Client
## PUT /iam/clients/{clientId}
## @deprecated
func update_client(
	client_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients/{clientId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Client
## DELETE /iam/clients/{clientId}
## @deprecated
func delete_client(
	client_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients/{clientId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Client Permissions
## POST /iam/clients/{clientId}/clientpermissions
## @deprecated
func update_client_permission(
	client_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients/{clientId}/clientpermissions"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Add Client Permission
## POST /iam/clients/{clientId}/clientpermissions/{resource}/{action}
## @deprecated
func add_client_permission(
	action: int,
	client_id: String,
	resource: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients/{clientId}/clientpermissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Client Permission
## DELETE /iam/clients/{clientId}/clientpermissions/{resource}/{action}
## @deprecated
func delete_client_permission(
	action: int,
	client_id: String,
	resource: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients/{clientId}/clientpermissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Client Secret
## PUT /iam/clients/{clientId}/secret
## @deprecated
func update_client_secret(
	client_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/clients/{clientId}/secret"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get clients by namespace
## GET /iam/namespaces/{namespace}/clients
## @deprecated
func get_clientsby_namespace(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Client
## POST /iam/namespaces/{namespace}/clients
## @deprecated
func create_client_by_namespace(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Client
## DELETE /iam/namespaces/{namespace}/clients/{clientId}
## @deprecated
func delete_client_by_namespace(
	client_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/clients/{clientId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Create User
## POST /iam/namespaces/{namespace}/users
## @deprecated
func create_user(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Admin Users By RoleId
## GET /iam/namespaces/{namespace}/users/admin
## @deprecated
func get_admin_users_by_role_id(
	namespace_param: String,
	after: int = -1,
	before: int = -1,
	limit: int = -1,
	role_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/admin"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if after >= 0:
		query_params["after"] = after
	if before >= 0:
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not role_id.is_empty():
		query_params["roleId"] = role_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User By Login Id
## GET /iam/namespaces/{namespace}/users/byLoginId
## @deprecated
func get_user_by_login_id(
	namespace_param: String,
	login_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/byLoginId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not login_id.is_empty():
		query_params["loginId"] = login_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User By Platform User ID
## GET /iam/namespaces/{namespace}/users/byPlatformUserID
## @deprecated
func get_user_by_platform_user_id(
	namespace_param: String,
	platform_id: String,
	platform_user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/byPlatformUserID"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not platform_id.is_empty():
		query_params["platformID"] = platform_id
	if not platform_user_id.is_empty():
		query_params["platformUserID"] = platform_user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Request Password Reset Code
## POST /iam/namespaces/{namespace}/users/forgotPassword
## @deprecated
func forgot_password(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/forgotPassword"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a List of Users By Their Login Id
## GET /iam/namespaces/{namespace}/users/listByLoginIds
## @deprecated
func get_users_by_login_ids(
	namespace_param: String,
	login_ids: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/listByLoginIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not login_ids.is_empty():
		query_params["loginIds"] = login_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Reset User Password
## POST /iam/namespaces/{namespace}/users/resetPassword
## @deprecated
func reset_password(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/resetPassword"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Search users
## GET /iam/namespaces/{namespace}/users/search
## @deprecated
func search_user(
	namespace_param: String,
	query: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not query.is_empty():
		query_params["query"] = query
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User By User Id
## GET /iam/namespaces/{namespace}/users/{userId}
## @deprecated
func get_user_by_user_id(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User
## PUT /iam/namespaces/{namespace}/users/{userId}
## @deprecated
func update_user(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete User
## DELETE /iam/namespaces/{namespace}/users/{userId}
## @deprecated
func delete_user(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Ban a single user
## POST /iam/namespaces/{namespace}/users/{userId}/ban
## @deprecated
func ban_user(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/ban"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user's bans history
## GET /iam/namespaces/{namespace}/users/{userId}/bans
## @deprecated
func get_user_ban_history(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Disable ban for a single user.
## PUT /iam/namespaces/{namespace}/users/{userId}/bans/{banId}/disable
## @deprecated
func disable_user_ban(
	ban_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/bans/{banId}/disable"
	url_path = url_path.replace("{" + "banId" + "}", ban_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Enable ban for a single user
## PUT /iam/namespaces/{namespace}/users/{userId}/bans/{banId}/enable
## @deprecated
func enable_user_ban(
	ban_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/bans/{banId}/enable"
	url_path = url_path.replace("{" + "banId" + "}", ban_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Links existing account with another account in different namespace. 
## POST /iam/namespaces/{namespace}/users/{userId}/crosslink
## @deprecated
func list_cross_namespace_account_link(
	namespace_param: String,
	user_id: String,
	linking_token: String,
	platform_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/crosslink"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not platform_id.is_empty():
		form_data["platformId"] = platform_id
	if not linking_token.is_empty():
		form_data["linkingToken"] = linking_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Disable a user
## PUT /iam/namespaces/{namespace}/users/{userId}/disable
## @deprecated
func disable_user(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Enable a user
## PUT /iam/namespaces/{namespace}/users/{userId}/enable
## @deprecated
func enable_user(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user's information
## GET /iam/namespaces/{namespace}/users/{userId}/information
## @deprecated
func get_user_information(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/information"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete user's information
## DELETE /iam/namespaces/{namespace}/users/{userId}/information
## @deprecated
func delete_user_information(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/information"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get User's Login Histories
## GET /iam/namespaces/{namespace}/users/{userId}/logins/histories
## @deprecated
func get_user_login_histories(
	namespace_param: String,
	user_id: String,
	after: float = -1.0,
	before: float = -1.0,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/logins/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if after >= 0.0:
		query_params["after"] = after
	if before >= 0.0:
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User Password
## PUT /iam/namespaces/{namespace}/users/{userId}/password
## @deprecated
func update_password(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Save User Permissions
## POST /iam/namespaces/{namespace}/users/{userId}/permissions
## @deprecated
func save_user_permission(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/permissions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Add User Permission
## POST /iam/namespaces/{namespace}/users/{userId}/permissions/{resource}/{action}
## @deprecated
func add_user_permission(
	action: int,
	namespace_param: String,
	resource: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete User Permission
## DELETE /iam/namespaces/{namespace}/users/{userId}/permissions/{resource}/{action}
## @deprecated
func delete_user_permission(
	action: int,
	namespace_param: String,
	resource: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get platform accounts linked to the user
## GET /iam/namespaces/{namespace}/users/{userId}/platforms
## @deprecated
func get_user_platform_accounts(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/platforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user mapping
## GET /iam/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}
## @deprecated
func get_user_mapping(
	namespace_param: String,
	target_namespace: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "targetNamespace" + "}", target_namespace.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get the Justice linked accounts on the designated namespace
## POST /iam/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}
## @deprecated
func get_user_justice_platform_account(
	namespace_param: String,
	target_namespace: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "targetNamespace" + "}", target_namespace.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Link user's account with platform
## POST /iam/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link
## @deprecated
func platform_link(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	ticket: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Unlink user's account with platform
## POST /iam/namespaces/{namespace}/users/{userId}/platforms/{platformId}/unlink
## @deprecated
func platform_unlink(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	platform_namespace: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/platforms/{platformId}/unlink"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not platform_namespace.is_empty():
		form_data["platform_namespace"] = platform_namespace
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Publisher User
## GET /iam/namespaces/{namespace}/users/{userId}/publisher
## @deprecated
func get_publisher_user(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/publisher"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Save User Roles
## POST /iam/namespaces/{namespace}/users/{userId}/roles
## @deprecated
func save_user_roles(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Add User Role
## POST /iam/namespaces/{namespace}/users/{userId}/roles/{roleId}
## @deprecated
func add_user_role(
	namespace_param: String,
	role_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/roles/{roleId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete User Role
## DELETE /iam/namespaces/{namespace}/users/{userId}/roles/{roleId}
## @deprecated
func delete_user_role(
	namespace_param: String,
	role_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/roles/{roleId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upgrade user account to full account (with email)
## POST /iam/namespaces/{namespace}/users/{userId}/upgradeHeadlessAccount
## @deprecated
func upgrade_headless_account(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/upgradeHeadlessAccount"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Upgrade headless account and automatically verified the email...
## POST /iam/namespaces/{namespace}/users/{userId}/upgradeHeadlessAccountWithVerificationCode
## @deprecated
func upgrade_headless_account_with_verification_code(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/upgradeHeadlessAccountWithVerificationCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Redeem verification code sent to user
## POST /iam/namespaces/{namespace}/users/{userId}/verification
## @deprecated
func user_verification(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/verification"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Send verification code to user
## POST /iam/namespaces/{namespace}/users/{userId}/verificationcode
## @deprecated
func send_verification_code(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/namespaces/{namespace}/users/{userId}/verificationcode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## OAuth2 authorize API
## POST /iam/oauth/authorize
## @deprecated
func authorization(
	client_id: String,
	redirect_uri: String,
	response_type: String,
	login: String = "",
	password: String = "",
	scope: String = "",
	state: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/authorize"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not login.is_empty():
		form_data["login"] = login
	if not password.is_empty():
		form_data["password"] = password
	if not scope.is_empty():
		form_data["scope"] = scope
	if not state.is_empty():
		form_data["state"] = state
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not redirect_uri.is_empty():
		form_data["redirect_uri"] = redirect_uri
	if not response_type.is_empty():
		form_data["response_type"] = response_type
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## JSON Web Key Set for verifying JWT
## GET /iam/oauth/jwks
## @deprecated
func get_jwks() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/jwks"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## OAuth2 access token generation specific to platform
## POST /iam/oauth/namespaces/{namespace}/platforms/{platformId}/token
## @deprecated
func platform_token_request_handler(
	namespace_param: String,
	platform_id: String,
	device_id: String = "",
	mac_address: String = "",
	platform_token: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/namespaces/{namespace}/platforms/{platformId}/token"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not device_id.is_empty():
		form_data["device_id"] = device_id
	if not mac_address.is_empty():
		form_data["macAddress"] = mac_address
	if not platform_token.is_empty():
		form_data["platform_token"] = platform_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Revokes user's tokens'
## POST /iam/oauth/namespaces/{namespace}/users/{userId}/revoke
## @deprecated
func revoke_user(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/namespaces/{namespace}/users/{userId}/revoke"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## OAuth2 revocation list API
## GET /iam/oauth/revocationlist
## @deprecated
func get_revocation_list() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/revocationlist"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## OAuth2 token revocation API
## POST /iam/oauth/revoke/token
## @deprecated
func revoke_token(
	token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/revoke/token"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not token.is_empty():
		form_data["token"] = token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## OAuth2 user revocation API
## POST /iam/oauth/revoke/user
## @deprecated
func revoke_a_user(
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/revoke/user"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not user_id.is_empty():
		form_data["userID"] = user_id
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## OAuth2 access token generation endpoint
## POST /iam/oauth/token
## @deprecated
func token_grant(
	grant_type: String,
	code: String = "",
	extend_exp: bool = false,
	namespace_param: String = "",
	password: String = "",
	redirect_uri: String = "",
	refresh_token: String = "",
	username: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/token"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not namespace_param.is_empty():
		form_data["namespace"] = namespace_param
	if not password.is_empty():
		form_data["password"] = password
	if not redirect_uri.is_empty():
		form_data["redirect_uri"] = redirect_uri
	if not refresh_token.is_empty():
		form_data["refresh_token"] = refresh_token
	if not username.is_empty():
		form_data["username"] = username
	if not grant_type.is_empty():
		form_data["grant_type"] = grant_type
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## OAuth2 token verification API
## POST /iam/oauth/verify
## @deprecated
func verify_token(
	token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/oauth/verify"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not token.is_empty():
		form_data["token"] = token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	# Request basic auth headers from HTTP layer (credentials not stored in service)
	var headers: PackedStringArray = _http.get_basic_auth_headers_for_oauth(_client_id)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Get Roles
## GET /iam/roles
## @deprecated
func get_roles(
	is_wildcard: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles"
	# Build query parameters
	var query_params: Dictionary = {}
	if not is_wildcard.is_empty():
		query_params["isWildcard"] = is_wildcard
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Role
## POST /iam/roles
## @deprecated
func create_role(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Role
## GET /iam/roles/{roleId}
## @deprecated
func get_role(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Role
## PUT /iam/roles/{roleId}
## @deprecated
func update_role(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Role
## DELETE /iam/roles/{roleId}
## @deprecated
func delete_role(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Role Admin Status
## GET /iam/roles/{roleId}/admin
## @deprecated
func get_role_admin_status(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Set Role as Admin Role
## POST /iam/roles/{roleId}/admin
## @deprecated
func set_role_as_admin(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove Role Admin Status
## DELETE /iam/roles/{roleId}/admin
## @deprecated
func remove_role_admin(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Role Managers
## GET /iam/roles/{roleId}/managers
## @deprecated
func get_role_managers(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add Role Managers
## POST /iam/roles/{roleId}/managers
## @deprecated
func add_role_managers(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove Role Managers
## DELETE /iam/roles/{roleId}/managers
## @deprecated
func remove_role_managers(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Role Members
## GET /iam/roles/{roleId}/members
## @deprecated
func get_role_members(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/members"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add Role Members
## POST /iam/roles/{roleId}/members
## @deprecated
func add_role_members(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/members"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove Role Members
## DELETE /iam/roles/{roleId}/members
## @deprecated
func remove_role_members(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/members"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Role Permissions
## POST /iam/roles/{roleId}/permissions
## @deprecated
func update_role_permissions(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Add Role Permission
## POST /iam/roles/{roleId}/permissions/{resource}/{action}
## @deprecated
func add_role_permission(
	action: int,
	resource: String,
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Role Permission
## DELETE /iam/roles/{roleId}/permissions/{resource}/{action}
## @deprecated
func delete_role_permission(
	action: int,
	resource: String,
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/roles/{roleId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get age restriction status
## GET /iam/v2/admin/namespaces/{namespace}/agerestrictions
## @deprecated
func admin_get_age_restriction_status_v2(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/agerestrictions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update age restriction config value
## PATCH /iam/v2/admin/namespaces/{namespace}/agerestrictions
## @deprecated
func admin_update_age_restriction_config_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/agerestrictions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get List Country age restriction
## GET /iam/v2/admin/namespaces/{namespace}/countries/agerestrictions
## @deprecated
func get_list_country_age_restriction(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/countries/agerestrictions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update country's age restriction
## PATCH /iam/v2/admin/namespaces/{namespace}/countries/{countryCode}
## @deprecated
func update_country_age_restriction(
	country_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Search Users
## GET /iam/v2/admin/namespaces/{namespace}/users
## @deprecated
func admin_search_users_v2(
	namespace_param: String,
	platform_id: String,
	after: String = "",
	before: String = "",
	display_name: String = "",
	limit: int = -1,
	login_id: String = "",
	platform_user_id: String = "",
	role_id: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if not display_name.is_empty():
		query_params["displayName"] = display_name
	if limit >= 0:
		query_params["limit"] = limit
	if not login_id.is_empty():
		query_params["loginId"] = login_id
	if not platform_user_id.is_empty():
		query_params["platformUserId"] = platform_user_id
	if not role_id.is_empty():
		query_params["roleId"] = role_id
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User By User Id
## GET /iam/v2/admin/namespaces/{namespace}/users/{userId}
## @deprecated
func admin_get_user_by_user_id_v2(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User
## PATCH /iam/v2/admin/namespaces/{namespace}/users/{userId}
## @deprecated
func admin_update_user_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Ban a single user
## POST /iam/v2/admin/namespaces/{namespace}/users/{userId}/ban
## @deprecated
func admin_ban_user_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/ban"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user's bans
## GET /iam/v2/admin/namespaces/{namespace}/users/{userId}/bans
## @deprecated
func admin_get_user_ban_v2(
	namespace_param: String,
	user_id: String,
	active_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Disable a user
## PUT /iam/v2/admin/namespaces/{namespace}/users/{userId}/disable
## @deprecated
func admin_disable_user_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Enable a user
## PUT /iam/v2/admin/namespaces/{namespace}/users/{userId}/enable
## @deprecated
func admin_enable_user_v2(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update User Password
## PUT /iam/v2/admin/namespaces/{namespace}/users/{userId}/password
## @deprecated
func admin_reset_password_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete the link of user's account with platform
## DELETE /iam/v2/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link
## @deprecated
func admin_delete_platform_link_v2(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	platform_namespace: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not platform_namespace.is_empty():
		form_data["platform_namespace"] = platform_namespace
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update User Roles, will replace all the existing roles
## PUT /iam/v2/admin/namespaces/{namespace}/users/{userId}/roles
## @deprecated
func admin_put_user_roles_v2(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Save User Roles
## POST /iam/v2/admin/namespaces/{namespace}/users/{userId}/roles
## @deprecated
func admin_create_user_roles_v2(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Public get age restriction by country code
## GET /iam/v2/public/namespaces/{namespace}/countries/{countryCode}/agerestrictions
## @deprecated
func public_get_country_age_restriction(
	country_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/countries/{countryCode}/agerestrictions"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create User
## POST /iam/v2/public/namespaces/{namespace}/users
## @deprecated
func public_create_user_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Request Password Reset Code
## POST /iam/v2/public/namespaces/{namespace}/users/forgotPassword
## @deprecated
func public_forgot_password_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/forgotPassword"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Reset User Password
## POST /iam/v2/public/namespaces/{namespace}/users/resetPassword
## @deprecated
func public_reset_password_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/resetPassword"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get User By User ID
## GET /iam/v2/public/namespaces/{namespace}/users/{userId}
## @deprecated
func public_get_user_by_user_idv2(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User
## PATCH /iam/v2/public/namespaces/{namespace}/users/{userId}
## @deprecated
func public_update_user_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get user's bans
## GET /iam/v2/public/namespaces/{namespace}/users/{userId}/bans
## @deprecated
func public_get_user_ban(
	namespace_param: String,
	user_id: String,
	active_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/{userId}/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User Password
## PUT /iam/v2/public/namespaces/{namespace}/users/{userId}/password
## @deprecated
func public_update_password_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/{userId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get User Justice Platform Accounts
## GET /iam/v2/public/namespaces/{namespace}/users/{userId}/platforms/justice
## @deprecated
func get_list_justice_platform_accounts(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/{userId}/platforms/justice"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Link user's account with platform
## POST /iam/v2/public/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link
## @deprecated
func public_platform_link_v2(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	ticket: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete the link of user's account with platform
## DELETE /iam/v2/public/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link
## @deprecated
func public_delete_platform_link_v2(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	platform_namespace: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v2/public/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not platform_namespace.is_empty():
		form_data["platform_namespace"] = platform_namespace
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get list of ban types
## GET /iam/v3/admin/bans
func admin_get_bans_type_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/bans"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of ban reasons
## GET /iam/v3/admin/bans/reasons
func admin_get_list_ban_reason_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/bans/reasons"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List Client available permissions
## GET /iam/v3/admin/clientConfig/permissions
func admin_list_client_available_permissions(
	exclude_permissions: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/clientConfig/permissions"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["excludePermissions"] = exclude_permissions
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update or create Client permissions module
## PUT /iam/v3/admin/clientConfig/permissions
func admin_update_available_permissions_by_module(
	force_delete: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/clientConfig/permissions"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["forceDelete"] = force_delete
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Client config permissions by module and group
## DELETE /iam/v3/admin/clientConfig/permissions
func admin_delete_config_permissions_by_group(
	force_delete: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/clientConfig/permissions"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["forceDelete"] = force_delete
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List Client templates
## GET /iam/v3/admin/clientConfig/templates
func admin_list_client_templates() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/clientConfig/templates"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Get Input Validations
## GET /iam/v3/admin/inputValidations
func admin_get_input_validations() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/inputValidations"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Update Input Validations
## PUT /iam/v3/admin/inputValidations
func admin_update_input_validations(
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/inputValidations"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Admin Reset Input Validations
## DELETE /iam/v3/admin/inputValidations/{field}
func admin_reset_input_validations(
	field: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/inputValidations/{field}"
	url_path = url_path.replace("{" + "field" + "}", field.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List User Admins
## GET /iam/v3/admin/namespaces/{namespace}/admins
func list_admins_v3(
	namespace_param: String,
	after: String = "",
	before: String = "",
	end_date: String = "",
	limit: int = -1,
	query: String = "",
	role_id: String = "",
	start_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/admins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if limit >= 0:
		query_params["limit"] = limit
	if not query.is_empty():
		query_params["query"] = query
	if not role_id.is_empty():
		query_params["roleId"] = role_id
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get age restriction status
## GET /iam/v3/admin/namespaces/{namespace}/agerestrictions
func admin_get_age_restriction_status_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/agerestrictions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update age restriction config value
## PATCH /iam/v3/admin/namespaces/{namespace}/agerestrictions
func admin_update_age_restriction_config_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/agerestrictions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get List Country age restriction
## GET /iam/v3/admin/namespaces/{namespace}/agerestrictions/countries
func admin_get_list_country_age_restriction_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/agerestrictions/countries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update country's age restriction
## PATCH /iam/v3/admin/namespaces/{namespace}/agerestrictions/countries/{countryCode}
func admin_update_country_age_restriction_v3(
	country_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/agerestrictions/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get list of user filtered by ban types
## GET /iam/v3/admin/namespaces/{namespace}/bans/users
func admin_get_banned_users_v3(
	namespace_param: String,
	active_only: bool = false,
	ban_type: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/bans/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not ban_type.is_empty():
		query_params["banType"] = ban_type
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

## Bulk ban user
## POST /iam/v3/admin/namespaces/{namespace}/bans/users
func admin_ban_user_bulk_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/bans/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk unban user
## PATCH /iam/v3/admin/namespaces/{namespace}/bans/users/disabled
func admin_unban_user_bulk_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/bans/users/disabled"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get list of ban types
## GET /iam/v3/admin/namespaces/{namespace}/bantypes
func admin_get_bans_type_with_namespace_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/bantypes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get clients by namespace
## GET /iam/v3/admin/namespaces/{namespace}/clients
func admin_get_clients_by_namespace_v3(
	namespace_param: String,
	client_id: String = "",
	client_name: String = "",
	client_type: String = "",
	limit: int = -1,
	offset: int = -1,
	skip_login_queue: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not client_name.is_empty():
		query_params["clientName"] = client_name
	if not client_type.is_empty():
		query_params["clientType"] = client_type
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	query_params["skipLoginQueue"] = skip_login_queue
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk Update Clients
## PUT /iam/v3/admin/namespaces/{namespace}/clients
func admin_bulk_update_clients_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create Client
## POST /iam/v3/admin/namespaces/{namespace}/clients
func admin_create_client_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get clients by namespace and client id. Multi tenant mode allows...
## GET /iam/v3/admin/namespaces/{namespace}/clients/{clientId}
func admin_get_clientsby_namespaceby_idv3(
	client_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients/{clientId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Client
## DELETE /iam/v3/admin/namespaces/{namespace}/clients/{clientId}
func admin_delete_client_v3(
	client_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients/{clientId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Client
## PATCH /iam/v3/admin/namespaces/{namespace}/clients/{clientId}
func admin_update_client_v3(
	client_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients/{clientId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update Client Permissions
## PUT /iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions
func admin_update_client_permission_v3(
	client_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Add Client Permissions
## POST /iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions
func admin_add_client_permissions_v3(
	client_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Client Permission
## DELETE /iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions/{resource}/{action}
func admin_delete_client_permission_v3(
	action: int,
	client_id: String,
	namespace_param: String,
	resource: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Config Value
## GET /iam/v3/admin/namespaces/{namespace}/config/{configKey}
func admin_get_config_value_v3(
	config_key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/config/{configKey}"
	url_path = url_path.replace("{" + "configKey" + "}", config_key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Country List
## GET /iam/v3/admin/namespaces/{namespace}/countries
func admin_get_country_list_v3(
	namespace_param: String,
	filter_blacklist: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/countries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["filterBlacklist"] = filter_blacklist
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Country Blacklist
## GET /iam/v3/admin/namespaces/{namespace}/countries/blacklist
func admin_get_country_blacklist_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/countries/blacklist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Country Blacklist
## POST /iam/v3/admin/namespaces/{namespace}/countries/blacklist
func admin_add_country_blacklist_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/countries/blacklist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin get login allowlist
## GET /iam/v3/admin/namespaces/{namespace}/loginAllowlist
func admin_get_login_allowlist_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/loginAllowlist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin update login allowlist
## PUT /iam/v3/admin/namespaces/{namespace}/loginAllowlist
func admin_update_login_allowlist_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/loginAllowlist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get All Third Party Platform Credential
## GET /iam/v3/admin/namespaces/{namespace}/platforms/all/clients
func retrieve_all_third_party_login_platform_credential_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/all/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get All Active Third Party Platform Active Credential
## GET /iam/v3/admin/namespaces/{namespace}/platforms/all/clients/active
func retrieve_all_active_third_party_login_platform_credential_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/all/clients/active"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get All SSO Platform Credential
## GET /iam/v3/admin/namespaces/{namespace}/platforms/sso
func retrieve_all_sso_login_platform_credential_v3(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/sso"
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

## Retrieve Third Party Platform Credential
## GET /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
func retrieve_third_party_login_platform_credential_v3(
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add Third Party Platform Credential
## POST /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
func add_third_party_login_platform_credential_v3(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Third Party Platform Credential
## DELETE /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
func delete_third_party_login_platform_credential_v3(
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Third Party Platform Credential
## PATCH /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
func update_third_party_login_platform_credential_v3(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Set Third Party Platform Credential's domain
## PUT /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain
func update_third_party_login_platform_domain_v3(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Unregister Third Party Platform Credential's domain
## DELETE /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain
func delete_third_party_login_platform_domain_v3(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Partial update third Party Platform Credential's domain
## PATCH /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain
func partial_update_third_party_login_platform_domain_v3(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Retrieve SSO Platform Credential
## GET /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
func retrieve_sso_login_platform_credential(
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add SSO Platform Credential
## POST /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
func add_sso_login_platform_credential(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete SSO Platform Credential
## DELETE /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
func delete_sso_login_platform_credential_v3(
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update SSO Platform Credential
## PATCH /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
func update_sso_platform_credential(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Admin List User ID By Platform User ID
## POST /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/users
func admin_list_user_id_by_platform_user_i_ds_v3(
	namespace_param: String,
	platform_id: String,
	raw_pid: bool = false,
	raw_puid: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["rawPID"] = raw_pid
	query_params["rawPUID"] = raw_puid
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Get User By Platform User ID
## GET /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}
func admin_get_user_by_platform_user_idv3(
	namespace_param: String,
	platform_id: String,
	platform_user_id: String,
	pid_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "platformUserId" + "}", platform_user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not pid_type.is_empty():
		query_params["pidType"] = pid_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get profile update strategy by namespace and field.
## GET /iam/v3/admin/namespaces/{namespace}/profileUpdateStrategies
func admin_get_profile_update_strategy_v3(
	namespace_param: String,
	field: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/profileUpdateStrategies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not field.is_empty():
		query_params["field"] = field
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin update profile update strategy by namespace and field.
## PUT /iam/v3/admin/namespaces/{namespace}/profileUpdateStrategies
func admin_update_profile_update_strategy_v3(
	namespace_param: String,
	field: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/profileUpdateStrategies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not field.is_empty():
		query_params["field"] = field
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get role override config
## GET /iam/v3/admin/namespaces/{namespace}/roleoverride
func admin_get_role_override_config_v3(
	namespace_param: String,
	identity: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/roleoverride"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not identity.is_empty():
		query_params["identity"] = identity
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update role override config
## PATCH /iam/v3/admin/namespaces/{namespace}/roleoverride
func admin_update_role_override_config_v3(
	namespace_param: String,
	identity: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/roleoverride"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not identity.is_empty():
		query_params["identity"] = identity
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get role source permission set
## GET /iam/v3/admin/namespaces/{namespace}/roleoverride/source
func admin_get_role_source_v3(
	namespace_param: String,
	identity: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/roleoverride/source"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not identity.is_empty():
		query_params["identity"] = identity
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Change role override config active status
## PATCH /iam/v3/admin/namespaces/{namespace}/roleoverride/status
func admin_change_role_override_config_status_v3(
	namespace_param: String,
	identity: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/roleoverride/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not identity.is_empty():
		query_params["identity"] = identity
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get role namespace permission
## GET /iam/v3/admin/namespaces/{namespace}/roleoverride/{roleId}/permissions
func admin_get_role_namespace_permission_v3(
	namespace_param: String,
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/roleoverride/{roleId}/permissions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Admin Users By RoleId
## GET /iam/v3/admin/namespaces/{namespace}/roles/{roleId}/users
func get_admin_users_by_role_id_v3(
	namespace_param: String,
	role_id: String,
	after: int = -1,
	before: int = -1,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/roles/{roleId}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if after >= 0:
		query_params["after"] = after
	if before >= 0:
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query Account Identifier Tag
## GET /iam/v3/admin/namespaces/{namespace}/tags
func admin_query_tag_v3(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	tag_name: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not tag_name.is_empty():
		query_params["tagName"] = tag_name
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Account Identifier Tag
## POST /iam/v3/admin/namespaces/{namespace}/tags
func admin_create_tag_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update Account Identifier Tag
## PUT /iam/v3/admin/namespaces/{namespace}/tags/{tagId}
func admin_update_tag_v3(
	namespace_param: String,
	tag_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/tags/{tagId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "tagId" + "}", tag_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Account Identifier Tag
## DELETE /iam/v3/admin/namespaces/{namespace}/tags/{tagId}
func admin_delete_tag_v3(
	namespace_param: String,
	tag_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/tags/{tagId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "tagId" + "}", tag_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get User By Email Address
## GET /iam/v3/admin/namespaces/{namespace}/users
func admin_get_user_by_email_address_v3(
	namespace_param: String,
	email_address: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not email_address.is_empty():
		query_params["emailAddress"] = email_address
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Users
## PUT /iam/v3/admin/namespaces/{namespace}/users
func admin_bulk_update_users_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get bulk user bans
## POST /iam/v3/admin/namespaces/{namespace}/users/bans
func admin_get_bulk_user_ban_v3(
	namespace_param: String,
	active_only: bool = false,
	ban_type: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not ban_type.is_empty():
		query_params["banType"] = ban_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List User By User ID
## POST /iam/v3/admin/namespaces/{namespace}/users/bulk
func admin_list_user_id_by_user_i_ds_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin bulk get users' platform info by user Ids
## POST /iam/v3/admin/namespaces/{namespace}/users/bulk/platforms
func admin_bulk_get_users_platform(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/bulk/platforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Cursor-Based User Retrieval
## POST /iam/v3/admin/namespaces/{namespace}/users/cursor
func admin_cursor_get_user_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/cursor"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Invite User
## POST /iam/v3/admin/namespaces/{namespace}/users/invite
func admin_invite_user_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/invite"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Search linking history of the query platform with platform user id
## GET /iam/v3/admin/namespaces/{namespace}/users/linkhistories
func admin_query_third_platform_link_history_v3(
	namespace_param: String,
	platform_id: String,
	limit: int = -1,
	offset: int = -1,
	platform_user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/linkhistories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not platform_user_id.is_empty():
		query_params["platformUserId"] = platform_user_id
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin List Users V3
## GET /iam/v3/admin/namespaces/{namespace}/users/platforms/justice
func admin_list_users_v3(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/platforms/justice"
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

## Search User
## GET /iam/v3/admin/namespaces/{namespace}/users/search
func admin_search_user_v3(
	namespace_param: String,
	by: String = "",
	end_date: String = "",
	include_total: bool = false,
	limit: int = -1,
	offset: int = -1,
	platform_by: String = "",
	platform_id: String = "",
	query: String = "",
	role_ids: String = "",
	selected_fields: String = "",
	skip_login_queue: bool = false,
	start_date: String = "",
	tag_ids: String = "",
	test_account: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not by.is_empty():
		query_params["by"] = by
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	query_params["includeTotal"] = include_total
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not platform_by.is_empty():
		query_params["platformBy"] = platform_by
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query.is_empty():
		query_params["query"] = query
	if not role_ids.is_empty():
		query_params["roleIds"] = role_ids
	if not selected_fields.is_empty():
		query_params["selectedFields"] = selected_fields
	query_params["skipLoginQueue"] = skip_login_queue
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not tag_ids.is_empty():
		query_params["tagIds"] = tag_ids
	query_params["testAccount"] = test_account
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Bulk User By Email Address
## POST /iam/v3/admin/namespaces/{namespace}/users/search/bulk
func admin_get_bulk_user_by_email_address_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/search/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Get User By User Id
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}
func admin_get_user_by_user_id_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}
func admin_update_user_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get user's bans
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans
func admin_get_user_ban_v3(
	namespace_param: String,
	user_id: String,
	active_only: bool = false,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Ban a single user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans
func admin_ban_user_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user's bans summary
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans/summary
func admin_get_user_ban_summary_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/bans/summary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Enable or disable ban for a single user
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans/{banId}
func admin_update_user_ban_v3(
	ban_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/bans/{banId}"
	url_path = url_path.replace("{" + "banId" + "}", ban_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Send verification code to user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/code/request
func admin_send_verification_code_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/code/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Verify or consume verification code sent to user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/code/verify
func admin_verify_account_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get verification code sent to user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/codes
func get_user_verification_code(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/codes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User Deletion Status
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/deletion/status
func admin_get_user_deletion_status_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/deletion/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User Deletion Status
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/deletion/status
func admin_update_user_deletion_status_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/deletion/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Admin get distinct platform accounts linked to the user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/distinctPlatforms
func admin_list_user_all_platform_accounts_distinct_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/distinctPlatforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Verify or consume verification code. 
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/headless/code/verify
func admin_upgrade_headless_account_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/headless/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete user's information
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/information
func admin_delete_user_information_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/information"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get User's Login Histories
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/logins/histories
func admin_get_user_login_histories_v3(
	namespace_param: String,
	user_id: String,
	after: float = -1.0,
	before: float = -1.0,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/logins/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if after >= 0.0:
		query_params["after"] = after
	if before >= 0.0:
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update User Password
## PUT /iam/v3/admin/namespaces/{namespace}/users/{userId}/password
func admin_reset_password_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update User Permissions
## PUT /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions
func admin_update_user_permission_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Add User Permissions
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions
func admin_add_user_permissions_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete User Permission
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions
func admin_delete_user_permission_bulk_v3(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete User Permission
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions/{resource}/{action}
func admin_delete_user_permission_v3(
	action: int,
	namespace_param: String,
	resource: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get platform accounts linked to the user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms
func admin_get_user_platform_accounts_v3(
	namespace_param: String,
	user_id: String,
	after: String = "",
	before: String = "",
	limit: int = -1,
	platform_id: String = "",
	target_namespace: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not target_namespace.is_empty():
		query_params["targetNamespace"] = target_namespace
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get distinct platforms linked to the user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/distinct
func admin_list_all_distinct_platform_accounts_v3(
	namespace_param: String,
	user_id: String,
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/distinct"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User Justice Platform Accounts
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice
func admin_get_list_justice_platform_accounts(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user mapping
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}
func admin_get_user_mapping(
	namespace_param: String,
	target_namespace: String,
	user_id: String,
	create_if_not_found: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "targetNamespace" + "}", target_namespace.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["createIfNotFound"] = create_if_not_found
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Justice User from Publisher User
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}
func admin_create_justice_user(
	namespace_param: String,
	target_namespace: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "targetNamespace" + "}", target_namespace.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Link a Platform User Account to User Account
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/link
func admin_link_platform_account(
	namespace_param: String,
	user_id: String,
	skip_conflict: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["skipConflict"] = skip_conflict
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin get user's platform link histories.
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/link/histories
func admin_get_user_link_histories_v3(
	namespace_param: String,
	user_id: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/link/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin unlink user's account from specific platform
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}
## @deprecated
func admin_platform_unlink_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin unlink user's account from specific platform for all namespaces
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/all
func admin_platform_unlink_all_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/all"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Link user's account with platform
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link
func admin_platform_link_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	ticket: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin remove user's platform linking history.
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link/histories
## @deprecated
func admin_delete_user_linking_history_by_platform_idv3(
	namespace_param: String,
	platform_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin remove user's platform linking restriction.
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link/restrictions
func admin_delete_user_linking_restriction_by_platform_idv3(
	namespace_param: String,
	platform_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link/restrictions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin get the link status of the third party platform token with user id.
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/linkStatus
func admin_get_third_party_platform_token_link_status_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	platform_token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/linkStatus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not platform_token.is_empty():
		form_data["platformToken"] = platform_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin get user single platform account metadata
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/metadata
func admin_get_user_single_platform_account(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	cross_namespace: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/metadata"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["crossNamespace"] = cross_namespace
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete User Roles
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/roles
func admin_delete_user_roles_v3(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin Save User Role V3
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/roles
func admin_save_user_role_v3(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Add User Role
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/roles/{roleId}
func admin_add_user_role_v3(
	namespace_param: String,
	role_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/roles/{roleId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete User Role
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/roles/{roleId}
func admin_delete_user_role_v3(
	namespace_param: String,
	role_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/roles/{roleId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin Get User State By User Id
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/state
func admin_get_user_state_by_user_id_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/state"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update user status
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/status
func admin_update_user_status_v3(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update User Identity
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/trustly/identity
func admin_trustly_update_user_identity(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/trustly/identity"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Verify user without verification code
## PUT /iam/v3/admin/namespaces/{namespace}/users/{userId}/verify
func admin_verify_user_without_verification_code_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/{userId}/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update Client Secret
## PUT /iam/v3/admin/namespaces/{namespace}/{clientId}/secret
func admin_update_client_secret_v3(
	client_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/{clientId}/secret"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Check 3rd party platform availability
## GET /iam/v3/admin/platforms/{platformId}/availability
func admin_check_third_party_login_platform_availability_v3(
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/platforms/{platformId}/availability"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Roles
## GET /iam/v3/admin/roles
func admin_get_roles_v3(
	after: String = "",
	before: String = "",
	is_wildcard: bool = false,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles"
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	query_params["isWildcard"] = is_wildcard
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Role
## POST /iam/v3/admin/roles
func admin_create_role_v3(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Role
## GET /iam/v3/admin/roles/{roleId}
func admin_get_role_v3(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Role
## DELETE /iam/v3/admin/roles/{roleId}
func admin_delete_role_v3(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Role
## PATCH /iam/v3/admin/roles/{roleId}
func admin_update_role_v3(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get Role Admin Status
## GET /iam/v3/admin/roles/{roleId}/admin
func admin_get_role_admin_status_v3(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Set Role as Admin Role
## POST /iam/v3/admin/roles/{roleId}/admin
func admin_update_admin_role_status_v3(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove Role Admin Status
## DELETE /iam/v3/admin/roles/{roleId}/admin
func admin_remove_role_admin_v3(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Role Managers
## GET /iam/v3/admin/roles/{roleId}/managers
func admin_get_role_managers_v3(
	role_id: String,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add Role Managers
## POST /iam/v3/admin/roles/{roleId}/managers
func admin_add_role_managers_v3(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove Role Managers
## DELETE /iam/v3/admin/roles/{roleId}/managers
func admin_remove_role_managers_v3(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Role Members
## GET /iam/v3/admin/roles/{roleId}/members
func admin_get_role_members_v3(
	role_id: String,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/members"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add Role Members
## POST /iam/v3/admin/roles/{roleId}/members
func admin_add_role_members_v3(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/members"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove Role Members
## DELETE /iam/v3/admin/roles/{roleId}/members
## @deprecated
func admin_remove_role_members_v3(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/members"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Role Permissions
## PUT /iam/v3/admin/roles/{roleId}/permissions
func admin_update_role_permissions_v3(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Add Role Permissions
## POST /iam/v3/admin/roles/{roleId}/permissions
func admin_add_role_permissions_v3(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Role
## DELETE /iam/v3/admin/roles/{roleId}/permissions
func admin_delete_role_permissions_v3(
	role_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete Role Permission
## DELETE /iam/v3/admin/roles/{roleId}/permissions/{resource}/{action}
func admin_delete_role_permission_v3(
	action: int,
	resource: String,
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get My User
## GET /iam/v3/admin/users/me
func admin_get_my_user_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/users/me"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Authentication API
## POST /iam/v3/authenticate
func user_authentication_v3(
	password: String,
	request_id: String,
	user_name: String,
	client_id: String = "",
	extend_exp: bool = false,
	redirect_uri: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/authenticate"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not redirect_uri.is_empty():
		form_data["redirect_uri"] = redirect_uri
	if not password.is_empty():
		form_data["password"] = password
	if not request_id.is_empty():
		form_data["request_id"] = request_id
	if not user_name.is_empty():
		form_data["user_name"] = user_name
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var _cid: String = client_id if not client_id.is_empty() else _client_id
	var _csecret: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(_cid, _csecret)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Authentication with platform link
## POST /iam/v3/authenticateWithLink
func authentication_with_platform_link_v3(
	client_id: String,
	linking_token: String,
	password: String,
	username: String,
	extend_exp: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/authenticateWithLink"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not linking_token.is_empty():
		form_data["linkingToken"] = linking_token
	if not password.is_empty():
		form_data["password"] = password
	if not username.is_empty():
		form_data["username"] = username
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Authentication with platform link, the response will be a forward
## POST /iam/v3/authenticateWithLink/forward
func authenticate_and_link_forward_v3(
	client_id: String,
	linking_token: String,
	password: String,
	username: String,
	extend_exp: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/authenticateWithLink/forward"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not linking_token.is_empty():
		form_data["linkingToken"] = linking_token
	if not password.is_empty():
		form_data["password"] = password
	if not username.is_empty():
		form_data["username"] = username
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Public System Config Value
## GET /iam/v3/config/public
func public_get_system_config_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/config/public"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create headless account and response token
## POST /iam/v3/headless/token
func generate_token_by_new_headless_account_v3(
	linking_token: String,
	additional_data: String = "",
	extend_exp: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/headless/token"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not linking_token.is_empty():
		form_data["linkingToken"] = linking_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	# Request basic auth headers from HTTP layer (credentials not stored in service)
	var headers: PackedStringArray = _http.get_basic_auth_headers_for_oauth(_client_id)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Generate one time linking code
## POST /iam/v3/link/code/request
func request_one_time_linking_code_v3(
	platform_id: String,
	redirect_uri: String = "",
	state: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/link/code/request"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not redirect_uri.is_empty():
		form_data["redirectUri"] = redirect_uri
	if not state.is_empty():
		form_data["state"] = state
	if not platform_id.is_empty():
		form_data["platformId"] = platform_id
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Validate one time linking code
## POST /iam/v3/link/code/validate
func validate_one_time_linking_code_v3(
	one_time_link_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/link/code/validate"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not one_time_link_code.is_empty():
		form_data["oneTimeLinkCode"] = one_time_link_code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Generate token by headless account's one time link code
## POST /iam/v3/link/token/exchange
func request_token_by_one_time_link_code_response_v3(
	client_id: String,
	one_time_link_code: String,
	additional_data: String = "",
	is_transient: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/link/token/exchange"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	form_data["isTransient"] = "true" if is_transient else "false"
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not one_time_link_code.is_empty():
		form_data["oneTimeLinkCode"] = one_time_link_code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Get Country Location
## GET /iam/v3/location/country
func get_country_location_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/location/country"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Logout
## POST /iam/v3/logout
func logout() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/logout"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Request code to get a new token
## POST /iam/v3/namespace/{namespace}/token/request
func request_token_exchange_code_v3(
	namespace_param: String,
	client_id: String,
	code_challenge: String = "",
	code_challenge_method: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/namespace/{namespace}/token/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not code_challenge.is_empty():
		query_params["code_challenge"] = code_challenge
	if not code_challenge_method.is_empty():
		query_params["code_challenge_method"] = code_challenge_method
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Retrieve User Third Party Platform Token
## GET /iam/v3/oauth/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/platformToken
func admin_retrieve_user_third_party_platform_token_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	platform_user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/platformToken"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not platform_user_id.is_empty():
		query_params["platformUserId"] = platform_user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Revokes user's tokens'
## POST /iam/v3/oauth/admin/namespaces/{namespace}/users/{userId}/revoke
func revoke_user_v3(
	namespace_param: String,
	user_id: String,
	include_game_namespace: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/admin/namespaces/{namespace}/users/{userId}/revoke"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["includeGameNamespace"] = include_game_namespace
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _revoke_callback.is_valid():
		_revoke_callback.call()
	return _result

## OAuth2 authorize API
## GET /iam/v3/oauth/authorize
func authorize_v3(
	client_id: String,
	response_type: String,
	blocked_platform_id: String = "",
	code_challenge: String = "",
	code_challenge_method: String = "",
	create_headless: bool = false,
	login_web_based: bool = false,
	nonce: String = "",
	one_time_link_code: String = "",
	redirect_uri: String = "",
	scope: String = "",
	state: String = "",
	target_auth_page: String = "",
	use_redirect_uri_as_login_url_when_locked: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/authorize"
	# Build query parameters
	var query_params: Dictionary = {}
	if not blocked_platform_id.is_empty():
		query_params["blockedPlatformId"] = blocked_platform_id
	if not code_challenge.is_empty():
		query_params["code_challenge"] = code_challenge
	if not code_challenge_method.is_empty():
		query_params["code_challenge_method"] = code_challenge_method
	query_params["createHeadless"] = create_headless
	query_params["loginWebBased"] = login_web_based
	if not nonce.is_empty():
		query_params["nonce"] = nonce
	if not one_time_link_code.is_empty():
		query_params["oneTimeLinkCode"] = one_time_link_code
	if not redirect_uri.is_empty():
		query_params["redirect_uri"] = redirect_uri
	if not scope.is_empty():
		query_params["scope"] = scope
	if not state.is_empty():
		query_params["state"] = state
	if not target_auth_page.is_empty():
		query_params["target_auth_page"] = target_auth_page
	query_params["useRedirectUriAsLoginUrlWhenLocked"] = use_redirect_uri_as_login_url_when_locked
	if not client_id.is_empty():
		query_params["client_id"] = client_id
	if not response_type.is_empty():
		query_params["response_type"] = response_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## OAuth2 token introspection API
## POST /iam/v3/oauth/introspect
func token_introspection_v3(
	token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/introspect"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not token.is_empty():
		form_data["token"] = token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	# Request basic auth headers from HTTP layer (credentials not stored in service)
	var headers: PackedStringArray = _http.get_basic_auth_headers_for_oauth(_client_id)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## JSON Web Key Set for verifying JWT
## GET /iam/v3/oauth/jwks
func get_jwksv3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/jwks"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Send 2FA code
## POST /iam/v3/oauth/mfa/code
func send_mfa_authentication_code(
	client_id: String,
	factor: String,
	mfa_token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/mfa/code"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not client_id.is_empty():
		form_data["clientId"] = client_id
	if not factor.is_empty():
		form_data["factor"] = factor
	if not mfa_token.is_empty():
		form_data["mfaToken"] = mfa_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Change 2FA method
## POST /iam/v3/oauth/mfa/factor/change
func change2fa_method(
	factor: String,
	mfa_token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/mfa/factor/change"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not factor.is_empty():
		form_data["factor"] = factor
	if not mfa_token.is_empty():
		form_data["mfaToken"] = mfa_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Verify 2FA code
## POST /iam/v3/oauth/mfa/verify
func verify2fa_code(
	code: String,
	factor: String,
	mfa_token: String,
	remember_device: bool
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/mfa/verify"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	if not factor.is_empty():
		form_data["factor"] = factor
	if not mfa_token.is_empty():
		form_data["mfaToken"] = mfa_token
	form_data["rememberDevice"] = "true" if remember_device else "false"
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Verify 2FA code
## POST /iam/v3/oauth/mfa/verify/forward
func verify2fa_code_forward(
	client_id: String,
	code: String,
	factor: String,
	mfa_token: String,
	default_factor: String = "",
	factors: String = "",
	remember_device: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/mfa/verify/forward"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not default_factor.is_empty():
		form_data["defaultFactor"] = default_factor
	if not factors.is_empty():
		form_data["factors"] = factors
	form_data["rememberDevice"] = "true" if remember_device else "false"
	if not client_id.is_empty():
		form_data["clientId"] = client_id
	if not code.is_empty():
		form_data["code"] = code
	if not factor.is_empty():
		form_data["factor"] = factor
	if not mfa_token.is_empty():
		form_data["mfaToken"] = mfa_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve User Third Party Platform Token
## GET /iam/v3/oauth/namespaces/{namespace}/users/{userId}/platforms/{platformId}/platformToken
func retrieve_user_third_party_platform_token_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/namespaces/{namespace}/users/{userId}/platforms/{platformId}/platformToken"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate url to request auth code from third party platform.
## GET /iam/v3/oauth/platforms/{platformId}/authorize
func auth_code_request_v3(
	platform_id: String,
	request_id: String,
	client_id: String = "",
	redirect_uri: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/platforms/{platformId}/authorize"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["client_id"] = client_id
	if not redirect_uri.is_empty():
		query_params["redirect_uri"] = redirect_uri
	if not request_id.is_empty():
		query_params["request_id"] = request_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## OAuth2 access token generation specific to platform
## POST /iam/v3/oauth/platforms/{platformId}/token
func platform_token_grant_v3(
	platform_id: String,
	additional_data: String = "",
	client_id: String = "",
	create_headless: bool = false,
	device_id: String = "",
	mac_address: String = "",
	platform_token: String = "",
	service_label: float = -1.0,
	skip_set_cookie: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/platforms/{platformId}/token"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	form_data["createHeadless"] = "true" if create_headless else "false"
	if not device_id.is_empty():
		form_data["device_id"] = device_id
	if not mac_address.is_empty():
		form_data["macAddress"] = mac_address
	if not platform_token.is_empty():
		form_data["platform_token"] = platform_token
	if service_label >= 0.0:
		form_data["serviceLabel"] = str(service_label)
	form_data["skipSetCookie"] = "true" if skip_set_cookie else "false"
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var _cid: String = client_id if not client_id.is_empty() else _client_id
	var _csecret: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(_cid, _csecret)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## OAuth2 revocation list API
## GET /iam/v3/oauth/revocationlist
func get_revocation_list_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/revocationlist"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## OAuth2 token revocation API
## POST /iam/v3/oauth/revoke
func token_revocation_v3(
	token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/revoke"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not token.is_empty():
		form_data["token"] = token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	# Request basic auth headers from HTTP layer (credentials not stored in service)
	var headers: PackedStringArray = _http.get_basic_auth_headers_for_oauth(_client_id)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _revoke_callback.is_valid():
		_revoke_callback.call()
	return _result

## Simultaneous login
## POST /iam/v3/oauth/simultaneousLogin
func simultaneous_login_v3(
	native_platform: String,
	native_platform_ticket: String,
	simultaneous_platform: String = "",
	simultaneous_ticket: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/simultaneousLogin"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not simultaneous_platform.is_empty():
		form_data["simultaneousPlatform"] = simultaneous_platform
	if not simultaneous_ticket.is_empty():
		form_data["simultaneousTicket"] = simultaneous_ticket
	if not native_platform.is_empty():
		form_data["nativePlatform"] = native_platform
	if not native_platform_ticket.is_empty():
		form_data["nativePlatformTicket"] = native_platform_ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## OAuth2 access token generation endpoint
## POST /iam/v3/oauth/token
func token_grant_v3(
	grant_type: String,
	additional_data: String = "",
	client_id: String = "",
	client_secret: String = "",
	code: String = "",
	code_verifier: String = "",
	extend_namespace: String = "",
	extend_exp: bool = false,
	password: String = "",
	redirect_uri: String = "",
	refresh_token: String = "",
	scope: String = "",
	username: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/token"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not client_secret.is_empty():
		form_data["client_secret"] = client_secret
	if not code.is_empty():
		form_data["code"] = code
	if not code_verifier.is_empty():
		form_data["code_verifier"] = code_verifier
	if not extend_namespace.is_empty():
		form_data["extendNamespace"] = extend_namespace
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not password.is_empty():
		form_data["password"] = password
	if not redirect_uri.is_empty():
		form_data["redirect_uri"] = redirect_uri
	if not refresh_token.is_empty():
		form_data["refresh_token"] = refresh_token
	if not scope.is_empty():
		form_data["scope"] = scope
	if not username.is_empty():
		form_data["username"] = username
	if not grant_type.is_empty():
		form_data["grant_type"] = grant_type
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var _cid: String = client_id if not client_id.is_empty() else _client_id
	var _csecret: String = client_secret
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(_cid, _csecret)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## OAuth2 token verification API
## POST /iam/v3/oauth/verify
func verify_token_v3(
	token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/verify"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not token.is_empty():
		form_data["token"] = token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	# Request basic auth headers from HTTP layer (credentials not stored in service)
	var headers: PackedStringArray = _http.get_basic_auth_headers_for_oauth(_client_id)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Platform Authentication API
## GET /iam/v3/platforms/{platformId}/authenticate
func platform_authentication_v3(
	platform_id: String,
	state: String,
	code: String = "",
	error: String = "",
	openid_assoc_handle: String = "",
	openid_claimed_id: String = "",
	openid_identity: String = "",
	openid_mode: String = "",
	openid_ns: String = "",
	openid_op_endpoint: String = "",
	openid_response_nonce: String = "",
	openid_return_to: String = "",
	openid_sig: String = "",
	openid_signed: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/platforms/{platformId}/authenticate"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not code.is_empty():
		query_params["code"] = code
	if not error.is_empty():
		query_params["error"] = error
	if not openid_assoc_handle.is_empty():
		query_params["openid.assoc_handle"] = openid_assoc_handle
	if not openid_claimed_id.is_empty():
		query_params["openid.claimed_id"] = openid_claimed_id
	if not openid_identity.is_empty():
		query_params["openid.identity"] = openid_identity
	if not openid_mode.is_empty():
		query_params["openid.mode"] = openid_mode
	if not openid_ns.is_empty():
		query_params["openid.ns"] = openid_ns
	if not openid_op_endpoint.is_empty():
		query_params["openid.op_endpoint"] = openid_op_endpoint
	if not openid_response_nonce.is_empty():
		query_params["openid.response_nonce"] = openid_response_nonce
	if not openid_return_to.is_empty():
		query_params["openid.return_to"] = openid_return_to
	if not openid_sig.is_empty():
		query_params["openid.sig"] = openid_sig
	if not openid_signed.is_empty():
		query_params["openid.signed"] = openid_signed
	if not state.is_empty():
		query_params["state"] = state
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Platform Token Validation
## POST /iam/v3/platforms/{platformId}/token/verify
func platform_token_refresh_v3(
	platform_id: String,
	platform_token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/platforms/{platformId}/token/verify"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not platform_token.is_empty():
		form_data["platform_token"] = platform_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Public Get Input Validations
## GET /iam/v3/public/inputValidations
func public_get_input_validations(
	default_on_empty: bool = false,
	language_code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/inputValidations"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["defaultOnEmpty"] = default_on_empty
	if not language_code.is_empty():
		query_params["languageCode"] = language_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Public Get Input Validation by field
## GET /iam/v3/public/inputValidations/{field}
func public_get_input_validation_by_field(
	field: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/inputValidations/{field}"
	url_path = url_path.replace("{" + "field" + "}", field.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Public get age restriction by country code
## GET /iam/v3/public/namespaces/{namespace}/agerestrictions/countries/{countryCode}
func public_get_country_age_restriction_v3(
	country_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/agerestrictions/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Config Value
## GET /iam/v3/public/namespaces/{namespace}/config/{configKey}
func public_get_config_value_v3(
	config_key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/config/{configKey}"
	url_path = url_path.replace("{" + "configKey" + "}", config_key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Country List
## GET /iam/v3/public/namespaces/{namespace}/countries
func public_get_country_list_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/countries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get All Active Third Party Platform Active Credential for Public Usage
## GET /iam/v3/public/namespaces/{namespace}/platforms/clients/active
func retrieve_all_active_third_party_login_platform_credential_public_v3(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/platforms/clients/active"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Active OIDC Platform Credential By Client ID
## GET /iam/v3/public/namespaces/{namespace}/platforms/clients/oidc
func retrieve_active_oidc_clients_public_v3(
	namespace_param: String,
	client_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/platforms/clients/oidc"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List User ID By Platform User ID
## POST /iam/v3/public/namespaces/{namespace}/platforms/{platformId}/users
## @deprecated
func public_list_user_id_by_platform_user_i_ds_v3(
	namespace_param: String,
	platform_id: String,
	raw_pid: bool = false,
	raw_puid: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/platforms/{platformId}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["rawPID"] = raw_pid
	query_params["rawPUID"] = raw_puid
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get User By Platform User ID
## GET /iam/v3/public/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}
## @deprecated
func public_get_user_by_platform_user_idv3(
	namespace_param: String,
	platform_id: String,
	platform_user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "platformUserId" + "}", platform_user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Public get profile update strategy by namespace and field.
## GET /iam/v3/public/namespaces/{namespace}/profileUpdateStrategies
func public_get_profile_update_strategy_v3(
	namespace_param: String,
	field: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/profileUpdateStrategies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not field.is_empty():
		query_params["field"] = field
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Linking Progress Status
## GET /iam/v3/public/namespaces/{namespace}/requests/{requestId}/async/status
func public_get_async_status(
	namespace_param: String,
	request_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/requests/{requestId}/async/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestId" + "}", request_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Search User
## GET /iam/v3/public/namespaces/{namespace}/users
func public_search_user_v3(
	namespace_param: String,
	by: String = "",
	limit: int = -1,
	offset: int = -1,
	platform_by: String = "",
	platform_id: String = "",
	query: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not by.is_empty():
		query_params["by"] = by
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not platform_by.is_empty():
		query_params["platformBy"] = platform_by
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query.is_empty():
		query_params["query"] = query
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create User
## POST /iam/v3/public/namespaces/{namespace}/users
func public_create_user_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check user's account availability
## GET /iam/v3/public/namespaces/{namespace}/users/availability
func check_user_availability(
	namespace_param: String,
	field: String,
	query: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/availability"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not field.is_empty():
		query_params["field"] = field
	if not query.is_empty():
		query_params["query"] = query
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get users' basic info by user Id
## POST /iam/v3/public/namespaces/{namespace}/users/bulk/basic
## @deprecated
func public_bulk_get_users(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/bulk/basic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Send verification code to new unregistered account's email address
## POST /iam/v3/public/namespaces/{namespace}/users/code/request
func public_send_registration_code(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/code/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Verify the registration code
## POST /iam/v3/public/namespaces/{namespace}/users/code/verify
func public_verify_registration_code(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Request Password Reset Code
## POST /iam/v3/public/namespaces/{namespace}/users/forgot
func public_forgot_password_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/forgot"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Validate user's input.
## POST /iam/v3/public/namespaces/{namespace}/users/input/validation
func public_validate_user_input(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/input/validation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get User Invitation
## GET /iam/v3/public/namespaces/{namespace}/users/invite/{invitationId}
func get_admin_invitation_v3(
	invitation_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/invite/{invitationId}"
	url_path = url_path.replace("{" + "invitationId" + "}", invitation_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create User From Invitation
## POST /iam/v3/public/namespaces/{namespace}/users/invite/{invitationId}
func create_user_from_invitation_v3(
	invitation_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/invite/{invitationId}"
	url_path = url_path.replace("{" + "invitationId" + "}", invitation_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update User
## PUT /iam/v3/public/namespaces/{namespace}/users/me
func update_user_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update User
## PATCH /iam/v3/public/namespaces/{namespace}/users/me
func public_partial_update_user_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Send verification code to user
## POST /iam/v3/public/namespaces/{namespace}/users/me/code/request
func public_send_verification_code_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/code/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Validate or consume verification code sent to user
## POST /iam/v3/public/namespaces/{namespace}/users/me/code/verify
func public_user_verification_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Verify or consume verification code.
## POST /iam/v3/public/namespaces/{namespace}/users/me/headless/code/verify
func public_upgrade_headless_account_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/headless/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Upgrade user headless account to full account (with email)
## POST /iam/v3/public/namespaces/{namespace}/users/me/headless/verify
func public_verify_headless_account_v3(
	namespace_param: String,
	need_verification_code: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/headless/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["needVerificationCode"] = need_verification_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update User Password
## PUT /iam/v3/public/namespaces/{namespace}/users/me/password
func public_update_password_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create Justice User from Publisher User
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/justice/{targetNamespace}
func public_create_justice_user(
	namespace_param: String,
	target_namespace: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/justice/{targetNamespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "targetNamespace" + "}", target_namespace.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Link user's account with platform
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}
func public_platform_link_v3(
	namespace_param: String,
	platform_id: String,
	ticket: String,
	redirect_uri: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not redirect_uri.is_empty():
		form_data["redirectUri"] = redirect_uri
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Public unlink user's account from specific platform
## DELETE /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}
## @deprecated
func public_platform_unlink_v3(
	namespace_param: String,
	platform_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Public unlink user's account from specific platform for all namespaces
## DELETE /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/all
func public_platform_unlink_all_v3(
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/all"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Force linking user's account with platform
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/force
func public_force_platform_link_v3(
	namespace_param: String,
	platform_id: String,
	ticket: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/force"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create Public Web Linking
## GET /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link
func public_web_link_platform(
	namespace_param: String,
	platform_id: String,
	client_id: String = "",
	redirect_uri: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not redirect_uri.is_empty():
		query_params["redirectUri"] = redirect_uri
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Establish Link Progress 
## GET /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link/establish
func public_web_link_platform_establish(
	namespace_param: String,
	platform_id: String,
	state: String,
	code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link/establish"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not code.is_empty():
		query_params["code"] = code
	if not state.is_empty():
		query_params["state"] = state
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Process Link Progress 
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link/process
func public_process_web_link_platform_v3(
	namespace_param: String,
	platform_id: String,
	state: String,
	code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link/process"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	if not state.is_empty():
		form_data["state"] = state
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user's basic info and public info of 3rd party account
## POST /iam/v3/public/namespaces/{namespace}/users/platforms
func public_get_users_platform_infos_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/platforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Reset User Password
## POST /iam/v3/public/namespaces/{namespace}/users/reset
func reset_password_v3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get User By User ID
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}
## @deprecated
func public_get_user_by_user_id_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user's bans
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/bans
func public_get_user_ban_history_v3(
	namespace_param: String,
	user_id: String,
	active_only: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
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

## Get distinct platform accounts linked to the user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/distinctPlatforms
func public_list_user_all_platform_accounts_distinct_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/distinctPlatforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user's information v3
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/information
func public_get_user_information_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/information"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User's Login Histories
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/logins/histories
func public_get_user_login_histories_v3(
	namespace_param: String,
	user_id: String,
	after: float = -1.0,
	before: float = -1.0,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/logins/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if after >= 0.0:
		query_params["after"] = after
	if before >= 0.0:
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get platform accounts linked to the user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/platforms
func public_get_user_platform_accounts_v3(
	namespace_param: String,
	user_id: String,
	after: String = "",
	before: String = "",
	limit: int = -1,
	platform_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/platforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User Justice Platform Accounts
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/justice
func public_list_justice_platform_accounts_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/justice"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Link a Platform User Account to User Account
## POST /iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/link
func public_link_platform_account(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Force link 3rd platform account and transfer progression
## POST /iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/linkWithProgression
func public_force_link_platform_with_progression(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/linkWithProgression"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Publisher User
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/publisher
func public_get_publisher_user_v3(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/publisher"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Validate user password by user ID and password
## POST /iam/v3/public/namespaces/{namespace}/users/{userId}/validate
func public_validate_user_by_user_id_and_password_v3(
	namespace_param: String,
	user_id: String,
	password: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/{userId}/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Roles
## GET /iam/v3/public/roles
func public_get_roles_v3(
	after: String = "",
	before: String = "",
	is_wildcard: bool = false,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/roles"
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	query_params["isWildcard"] = is_wildcard
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Public Role
## GET /iam/v3/public/roles/{roleId}
func public_get_role_v3(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Request Password Reset Code
## POST /iam/v3/public/users/forgot
func public_forgot_password_without_namespace_v3(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/forgot"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get My User
## GET /iam/v3/public/users/me
func public_get_my_user_v3(
	include_all_platforms: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["includeAllPlatforms"] = include_all_platforms
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Send verification code to user
## POST /iam/v3/public/users/me/code/request/forward
func public_send_code_forward_v3(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/code/request/forward"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get conflict result when link headless account to current full...
## GET /iam/v3/public/users/me/headless/link/conflict
func public_get_link_headless_account_to_my_account_conflict_v3(
	one_time_link_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/headless/link/conflict"
	# Build query parameters
	var query_params: Dictionary = {}
	if not one_time_link_code.is_empty():
		query_params["oneTimeLinkCode"] = one_time_link_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Link headless account to current full account
## POST /iam/v3/public/users/me/headless/linkWithProgression
func link_headless_account_to_my_account_v3(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/headless/linkWithProgression"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get My Forward URI Link
## GET /iam/v3/public/users/me/link/redirection
func public_get_my_redirection_after_link_v3(
	one_time_link_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/link/redirection"
	# Build query parameters
	var query_params: Dictionary = {}
	if not one_time_link_code.is_empty():
		query_params["oneTimeLinkCode"] = one_time_link_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Public get my profile allowed update status.
## GET /iam/v3/public/users/me/profileStatus
func public_get_my_profile_allow_update_status_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/profileStatus"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Send verification link to user, this link will point to...
## POST /iam/v3/public/users/me/verify_link/request
func public_send_verification_link_v3(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/verify_link/request"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get my user info
## GET /iam/v3/public/users/userinfo
func public_get_openid_user_info_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/userinfo"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Verify user email by the verification link code
## GET /iam/v3/public/users/verify_link/verify
func public_verify_user_by_link_v3(
	code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/verify_link/verify"
	# Build query parameters
	var query_params: Dictionary = {}
	if not code.is_empty():
		query_params["code"] = code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## SAML platform Authentication API
## POST /iam/v3/sso/saml/platforms/{platformId}/authenticate
func platform_authenticate_samlv3_handler(
	platform_id: String,
	state: String,
	code: String = "",
	error: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/sso/saml/platforms/{platformId}/authenticate"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not code.is_empty():
		query_params["code"] = code
	if not error.is_empty():
		query_params["error"] = error
	if not state.is_empty():
		query_params["state"] = state
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Login to SSO client with provided platformId
## GET /iam/v3/sso/{platformId}
func login_sso_client(
	platform_id: String,
	payload: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/sso/{platformId}"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not payload.is_empty():
		query_params["payload"] = payload
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Logout
## POST /iam/v3/sso/{platformId}/logout
func logout_sso_client(
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/sso/{platformId}/logout"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Generate target token by code
## POST /iam/v3/token/exchange
func request_target_token_response_v3(
	code: String,
	additional_data: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/token/exchange"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	if not code.is_empty():
		form_data["code"] = code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	# Request basic auth headers from HTTP layer (credentials not stored in service)
	var headers: PackedStringArray = _http.get_basic_auth_headers_for_oauth(_client_id)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Handle the forward for account upgrade
## POST /iam/v3/upgrade/forward
func upgrade_and_authenticate_forward_v3(
	client_id: String,
	upgrade_success_token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/upgrade/forward"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not upgrade_success_token.is_empty():
		form_data["upgrade_success_token"] = upgrade_success_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin List Invitation Histories V4
## GET /iam/v4/admin/invitationHistories
func admin_list_invitation_histories_v4(
	limit: int = -1,
	namespace_param: String = "",
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/invitationHistories"
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get devices by user id
## GET /iam/v4/admin/namespaces/{namespace}/devices
func admin_get_devices_by_user_v4(
	namespace_param: String,
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get banned devices
## GET /iam/v4/admin/namespaces/{namespace}/devices/banned
func admin_get_banned_devices_v4(
	namespace_param: String,
	device_type: String = "",
	end_date: String = "",
	limit: int = -1,
	offset: int = -1,
	start_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/banned"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not device_type.is_empty():
		query_params["deviceType"] = device_type
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get device bans of user
## GET /iam/v4/admin/namespaces/{namespace}/devices/bans
func admin_get_user_device_bans_v4(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Ban a device
## POST /iam/v4/admin/namespaces/{namespace}/devices/bans
func admin_ban_device_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin get device ban config
## GET /iam/v4/admin/namespaces/{namespace}/devices/bans/{banId}
func admin_get_device_ban_v4(
	ban_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/bans/{banId}"
	url_path = url_path.replace("{" + "banId" + "}", ban_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin update device ban config
## PUT /iam/v4/admin/namespaces/{namespace}/devices/bans/{banId}
func admin_update_device_ban_v4(
	ban_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/bans/{banId}"
	url_path = url_path.replace("{" + "banId" + "}", ban_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Admin generate device report
## GET /iam/v4/admin/namespaces/{namespace}/devices/report
func admin_generate_report_v4(
	namespace_param: String,
	device_type: String,
	end_date: String = "",
	start_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/report"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not device_type.is_empty():
		query_params["deviceType"] = device_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get device types
## GET /iam/v4/admin/namespaces/{namespace}/devices/types
func admin_get_device_types_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/types"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get device ban list
## GET /iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/bans
func admin_get_device_bans_v4(
	device_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/bans"
	url_path = url_path.replace("{" + "deviceId" + "}", device_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin decrypt device id
## GET /iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/decrypt
## @deprecated
func admin_decrypt_device_v4(
	device_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/decrypt"
	url_path = url_path.replace("{" + "deviceId" + "}", device_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin unban device
## PUT /iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/unban
func admin_unban_device_v4(
	device_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/unban"
	url_path = url_path.replace("{" + "deviceId" + "}", device_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Admin get users by device id
## GET /iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/users
func admin_get_users_by_device_v4(
	device_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/users"
	url_path = url_path.replace("{" + "deviceId" + "}", device_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Get Invitation History for specific namespace V4
## GET /iam/v4/admin/namespaces/{namespace}/invitationHistories
func admin_get_namespace_invitation_history_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/invitationHistories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Get Users Invitation History for specific namespace V4
## GET /iam/v4/admin/namespaces/{namespace}/invitationHistories/users
func admin_get_namespace_user_invitation_history_v4(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/invitationHistories/users"
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

## [TEST FACILITY ONLY]Create test Users
## POST /iam/v4/admin/namespaces/{namespace}/test_users
func admin_create_test_users_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/test_users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Create User
## POST /iam/v4/admin/namespaces/{namespace}/users
func admin_create_user_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Bulk Update User Account Type V4
## PATCH /iam/v4/admin/namespaces/{namespace}/users/bulk/accountType
func admin_bulk_update_user_account_type_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/bulk/accountType"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Admin Check Valid User ID
## POST /iam/v4/admin/namespaces/{namespace}/users/bulk/validate
func admin_bulk_check_valid_user_idv4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/bulk/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update User
## PUT /iam/v4/admin/namespaces/{namespace}/users/{userId}
func admin_update_user_v4(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update a User Email Address
## PUT /iam/v4/admin/namespaces/{namespace}/users/{userId}/email
func admin_update_user_email_address_v4(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}/email"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Disable User 2FA
## DELETE /iam/v4/admin/namespaces/{namespace}/users/{userId}/mfa/disable
func admin_disable_user_mfav4(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}/mfa/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get User 2FA Status
## GET /iam/v4/admin/namespaces/{namespace}/users/{userId}/mfa/status
func admin_get_user_mfa_status_v4(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}/mfa/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin List User's Roles V4
## GET /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
func admin_list_user_roles_v4(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Update User's Role V4
## PUT /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
func admin_update_user_role_v4(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Admin Add User's Role V4
## POST /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
func admin_add_user_role_v4(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Remove User Role v4
## DELETE /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
func admin_remove_user_role_v4(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/{userId}/roles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Roles
## GET /iam/v4/admin/roles
func admin_get_roles_v4(
	admin_role: bool = false,
	is_wildcard: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["adminRole"] = admin_role
	query_params["isWildcard"] = is_wildcard
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

## Create Role
## POST /iam/v4/admin/roles
func admin_create_role_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Role
## GET /iam/v4/admin/roles/{roleId}
func admin_get_role_v4(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Role
## DELETE /iam/v4/admin/roles/{roleId}
func admin_delete_role_v4(
	role_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Role
## PATCH /iam/v4/admin/roles/{roleId}
func admin_update_role_v4(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update Role Permissions
## PUT /iam/v4/admin/roles/{roleId}/permissions
func admin_update_role_permissions_v4(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Add Role Permissions V4
## POST /iam/v4/admin/roles/{roleId}/permissions
func admin_add_role_permissions_v4(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Role Permission V4
## DELETE /iam/v4/admin/roles/{roleId}/permissions
func admin_delete_role_permissions_v4(
	role_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Role's Assigned Users
## GET /iam/v4/admin/roles/{roleId}/users
func admin_list_assigned_users_v4(
	role_id: String,
	after: String = "",
	before: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/users"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Assign User to Role
## POST /iam/v4/admin/roles/{roleId}/users
func admin_assign_user_to_role_v4(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/users"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Revoke User from Role
## DELETE /iam/v4/admin/roles/{roleId}/users
func admin_revoke_user_from_role_v4(
	role_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/users"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin invite User v4
## POST /iam/v4/admin/users/invite
func admin_invite_user_new_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/invite"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin Update My User
## PATCH /iam/v4/admin/users/me
func admin_update_my_user_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Disable 2FA authenticator
## DELETE /iam/v4/admin/users/me/mfa/authenticator/disable
func admin_disable_my_authenticator_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/authenticator/disable"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Enable 2FA authenticator
## POST /iam/v4/admin/users/me/mfa/authenticator/enable
func admin_enable_my_authenticator_v4(
	code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/authenticator/enable"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Generate secret key for 3rd-party authenticate app
## POST /iam/v4/admin/users/me/mfa/authenticator/key
func admin_generate_my_authenticator_key_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/authenticator/key"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get backup codes
## GET /iam/v4/admin/users/me/mfa/backupCode
## @deprecated
func admin_get_my_backup_codes_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCode"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate backup codes
## POST /iam/v4/admin/users/me/mfa/backupCode
## @deprecated
func admin_generate_my_backup_codes_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCode"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Disable 2FA backup codes
## DELETE /iam/v4/admin/users/me/mfa/backupCode/disable
func admin_disable_my_backup_codes_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCode/disable"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Download user backup codes
## GET /iam/v4/admin/users/me/mfa/backupCode/download
## @deprecated
func admin_download_my_backup_codes_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCode/download"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Enable 2FA backup codes
## POST /iam/v4/admin/users/me/mfa/backupCode/enable
## @deprecated
func admin_enable_my_backup_codes_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCode/enable"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get backup codes and send to email
## GET /iam/v4/admin/users/me/mfa/backupCodes
func admin_get_backup_codes_v4(
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCodes"
	# Build query parameters
	var query_params: Dictionary = {}
	if not language_tag.is_empty():
		query_params["languageTag"] = language_tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate backup codes
## POST /iam/v4/admin/users/me/mfa/backupCodes
func admin_generate_backup_codes_v4(
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCodes"
	# Build query parameters
	var query_params: Dictionary = {}
	if not language_tag.is_empty():
		query_params["languageTag"] = language_tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Enable 2FA backup codes
## POST /iam/v4/admin/users/me/mfa/backupCodes/enable
func admin_enable_backup_codes_v4(
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCodes/enable"
	# Build query parameters
	var query_params: Dictionary = {}
	if not language_tag.is_empty():
		query_params["languageTag"] = language_tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Challenge User MFA
## POST /iam/v4/admin/users/me/mfa/challenge/verify
func admin_challenge_my_mfav4(
	code: String = "",
	factor: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/challenge/verify"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	if not factor.is_empty():
		form_data["factor"] = factor
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Send code for MFA email
## POST /iam/v4/admin/users/me/mfa/email/code
func admin_send_my_mfa_email_code_v4(
	action: String = "",
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/email/code"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not action.is_empty():
		form_data["action"] = action
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Disable 2FA email
## POST /iam/v4/admin/users/me/mfa/email/disable
func admin_disable_my_email_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/email/disable"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Enable 2FA email
## POST /iam/v4/admin/users/me/mfa/email/enable
func admin_enable_my_email_v4(
	code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/email/enable"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user enabled factors
## GET /iam/v4/admin/users/me/mfa/factor
func admin_get_my_enabled_factors_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/factor"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Make 2FA factor default
## POST /iam/v4/admin/users/me/mfa/factor
func admin_make_factor_my_default_v4(
	factor: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/factor"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not factor.is_empty():
		form_data["factor"] = factor
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Admin Own MFA Status
## GET /iam/v4/admin/users/me/mfa/status
func admin_get_my_own_mfa_status_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/status"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User MFA Status
## POST /iam/v4/admin/users/me/mfa/status
## @deprecated
func admin_get_my_mfa_status_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/status"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Admin invite User v4
## POST /iam/v4/admin/users/users/invite
## @deprecated
func admin_invite_user_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/users/invite"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Authentication with platform link
## POST /iam/v4/oauth/authenticateWithLink
func authentication_with_platform_link_v4(
	client_id: String,
	linking_token: String,
	password: String,
	username: String,
	extend_exp: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/oauth/authenticateWithLink"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not linking_token.is_empty():
		form_data["linkingToken"] = linking_token
	if not password.is_empty():
		form_data["password"] = password
	if not username.is_empty():
		form_data["username"] = username
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Create headless account and response token
## POST /iam/v4/oauth/headless/token
func generate_token_by_new_headless_account_v4(
	linking_token: String,
	additional_data: String = "",
	extend_exp: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/oauth/headless/token"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not linking_token.is_empty():
		form_data["linkingToken"] = linking_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Verify 2FA code
## POST /iam/v4/oauth/mfa/verify
func verify2fa_code_v4(
	code: String,
	factor: String,
	mfa_token: String,
	remember_device: bool
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/oauth/mfa/verify"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	if not factor.is_empty():
		form_data["factor"] = factor
	if not mfa_token.is_empty():
		form_data["mfaToken"] = mfa_token
	form_data["rememberDevice"] = "true" if remember_device else "false"
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## OAuth2 access token generation specific to platform
## POST /iam/v4/oauth/platforms/{platformId}/token
func platform_token_grant_v4(
	platform_id: String,
	code_challenge: String = "",
	code_challenge_method: String = "",
	additional_data: String = "",
	client_id: String = "",
	create_headless: bool = false,
	device_id: String = "",
	mac_address: String = "",
	platform_token: String = "",
	service_label: float = -1.0,
	skip_set_cookie: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/oauth/platforms/{platformId}/token"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not code_challenge.is_empty():
		query_params["code_challenge"] = code_challenge
	if not code_challenge_method.is_empty():
		query_params["code_challenge_method"] = code_challenge_method
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	form_data["createHeadless"] = "true" if create_headless else "false"
	if not device_id.is_empty():
		form_data["device_id"] = device_id
	if not mac_address.is_empty():
		form_data["macAddress"] = mac_address
	if not platform_token.is_empty():
		form_data["platform_token"] = platform_token
	if service_label >= 0.0:
		form_data["serviceLabel"] = str(service_label)
	form_data["skipSetCookie"] = "true" if skip_set_cookie else "false"
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var _cid: String = client_id if not client_id.is_empty() else _client_id
	var _csecret: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(_cid, _csecret)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Simultaneous login
## POST /iam/v4/oauth/simultaneousLogin
func simultaneous_login_v4(
	native_platform: String,
	native_platform_ticket: String,
	code_challenge: String = "",
	code_challenge_method: String = "",
	simultaneous_platform: String = "",
	simultaneous_ticket: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/oauth/simultaneousLogin"
	# Build query parameters
	var query_params: Dictionary = {}
	if not code_challenge.is_empty():
		query_params["code_challenge"] = code_challenge
	if not code_challenge_method.is_empty():
		query_params["code_challenge_method"] = code_challenge_method
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not simultaneous_platform.is_empty():
		form_data["simultaneousPlatform"] = simultaneous_platform
	if not simultaneous_ticket.is_empty():
		form_data["simultaneousTicket"] = simultaneous_ticket
	if not native_platform.is_empty():
		form_data["nativePlatform"] = native_platform
	if not native_platform_ticket.is_empty():
		form_data["nativePlatformTicket"] = native_platform_ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## OAuth2 access token generation endpoint V4
## POST /iam/v4/oauth/token
func token_grant_v4(
	grant_type: String,
	code_challenge: String = "",
	code_challenge_method: String = "",
	additional_data: String = "",
	client_id: String = "",
	client_secret: String = "",
	code: String = "",
	code_verifier: String = "",
	extend_namespace: String = "",
	extend_exp: bool = false,
	login_queue_ticket: String = "",
	password: String = "",
	redirect_uri: String = "",
	refresh_token: String = "",
	scope: String = "",
	username: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/oauth/token"
	# Build query parameters
	var query_params: Dictionary = {}
	if not code_challenge.is_empty():
		query_params["code_challenge"] = code_challenge
	if not code_challenge_method.is_empty():
		query_params["code_challenge_method"] = code_challenge_method
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not client_secret.is_empty():
		form_data["client_secret"] = client_secret
	if not code.is_empty():
		form_data["code"] = code
	if not code_verifier.is_empty():
		form_data["code_verifier"] = code_verifier
	if not extend_namespace.is_empty():
		form_data["extendNamespace"] = extend_namespace
	form_data["extend_exp"] = "true" if extend_exp else "false"
	if not login_queue_ticket.is_empty():
		form_data["login_queue_ticket"] = login_queue_ticket
	if not password.is_empty():
		form_data["password"] = password
	if not redirect_uri.is_empty():
		form_data["redirect_uri"] = redirect_uri
	if not refresh_token.is_empty():
		form_data["refresh_token"] = refresh_token
	if not scope.is_empty():
		form_data["scope"] = scope
	if not username.is_empty():
		form_data["username"] = username
	if not grant_type.is_empty():
		form_data["grant_type"] = grant_type
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var _cid: String = client_id if not client_id.is_empty() else _client_id
	var _csecret: String = client_secret
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(_cid, _csecret)
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## Generate target token by code
## POST /iam/v4/oauth/token/exchange
func request_target_token_response_v4(
	code: String,
	additional_data: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/oauth/token/exchange"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not additional_data.is_empty():
		form_data["additionalData"] = additional_data
	if not code.is_empty():
		form_data["code"] = code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	var _result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result

## List User ID By Platform User ID
## POST /iam/v4/public/namespaces/{namespace}/platforms/{platformId}/users
func public_list_user_id_by_platform_user_i_ds_v4(
	namespace_param: String,
	platform_id: String,
	raw_puid: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/platforms/{platformId}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["rawPUID"] = raw_puid
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get User By Platform User ID
## GET /iam/v4/public/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}
func public_get_user_by_platform_user_idv4(
	namespace_param: String,
	platform_id: String,
	platform_user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "platformUserId" + "}", platform_user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## [TEST FACILITY ONLY]Create test User
## POST /iam/v4/public/namespaces/{namespace}/test_users
func public_create_test_user_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/test_users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create User
## POST /iam/v4/public/namespaces/{namespace}/users
func public_create_user_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create User From Invitation
## POST /iam/v4/public/namespaces/{namespace}/users/invite/{invitationId}
func create_user_from_invitation_v4(
	invitation_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/invite/{invitationId}"
	url_path = url_path.replace("{" + "invitationId" + "}", invitation_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update User
## PATCH /iam/v4/public/namespaces/{namespace}/users/me
func public_update_user_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update My Email Address
## PUT /iam/v4/public/namespaces/{namespace}/users/me/email
func public_update_user_email_address_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/email"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Upgrade headless account and automatically verified the email...
## POST /iam/v4/public/namespaces/{namespace}/users/me/headless/code/verify
func public_upgrade_headless_account_with_verification_code_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/headless/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Upgrade user account to full account
## POST /iam/v4/public/namespaces/{namespace}/users/me/headless/verify
func public_upgrade_headless_account_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/headless/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Disable 2FA authenticator
## DELETE /iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/disable
func public_disable_my_authenticator_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Enable 2FA authenticator
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/enable
func public_enable_my_authenticator_v4(
	namespace_param: String,
	code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Generate secret key for 3rd-party authenticate app
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/key
func public_generate_my_authenticator_key_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/key"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get backup codes
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode
## @deprecated
func public_get_my_backup_codes_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate backup codes
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode
## @deprecated
func public_generate_my_backup_codes_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Disable 2FA backup codes
## DELETE /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode/disable
func public_disable_my_backup_codes_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Download user backup codes
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode/download
## @deprecated
func public_download_my_backup_codes_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode/download"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Enable 2FA backup codes
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode/enable
## @deprecated
func public_enable_my_backup_codes_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get backup codes and send to email
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes
func public_get_backup_codes_v4(
	namespace_param: String,
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language_tag.is_empty():
		query_params["languageTag"] = language_tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate backup codes
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes
func public_generate_backup_codes_v4(
	namespace_param: String,
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language_tag.is_empty():
		query_params["languageTag"] = language_tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Enable 2FA backup codes
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes/enable
func public_enable_backup_codes_v4(
	namespace_param: String,
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language_tag.is_empty():
		query_params["languageTag"] = language_tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Challenge User MFA
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/challenge/verify
func public_challenge_my_mfav4(
	namespace_param: String,
	code: String = "",
	factor: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/challenge/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	if not factor.is_empty():
		form_data["factor"] = factor
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove Trusted Device
## DELETE /iam/v4/public/namespaces/{namespace}/users/me/mfa/device
func public_remove_trusted_device_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/device"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Send code for MFA email
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/email/code
func public_send_my_mfa_email_code_v4(
	namespace_param: String,
	action: String = "",
	language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/email/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not action.is_empty():
		form_data["action"] = action
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Disable 2FA email
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/email/disable
func public_disable_my_email_v4(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/email/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Enable 2FA email
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/email/enable
func public_enable_my_email_v4(
	namespace_param: String,
	code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/email/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not code.is_empty():
		form_data["code"] = code
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user enabled factors
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/factor
func public_get_my_enabled_factors_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/factor"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Make 2FA factor default
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/factor
func public_make_factor_my_default_v4(
	namespace_param: String,
	factor: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/factor"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not factor.is_empty():
		form_data["factor"] = factor
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get My Own MFA Status
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/status
func public_get_my_own_mfa_status_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User MFA Status
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/status
## @deprecated
func public_get_my_mfa_status_v4(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get User Public Info By User ID
## GET /iam/v4/public/namespaces/{namespace}/users/{userId}
func public_get_user_public_info_by_user_id_v4(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Public invite admin user v4
## POST /iam/v4/public/users/invite
func public_invite_user_v4(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/users/invite"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Upgrade the headless account and automatically verify the email...
## POST /iam/v4/public/users/me/headless/code/verify/forward
func public_upgrade_headless_with_code_v4_forward(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/users/me/headless/code/verify/forward"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
