## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## iam_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-iam-service
## Version: 7.44.0
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


## OAuth Authorization Server Metadata
## GET /iam/.well-known/oauth-authorization-server/{namespace}
##
## Implements RFC 8414((https://datatracker.ietf.org/doc/html/rfc8414)), providing a standardized mechanism for OAuth 2.0 clients to discover authorization server metadata. Clients can retrieve detailed information about server capabilities, supported grant types, cryptographic algorithms, and API locations without manual configuration.
## ### Key Features:
## Dynamic Discovery: Clients automatically discover server capabilities
## Standard Compliance: Implements RFC 8414 OAuth 2.0 Authorization Server Metadata
## Security Information: Provides details about supported security features
## API Discovery: Returns URLs for all OAuth APIs (authorization, token, revocation, etc.)
## ### Request:
## Method: GET
## Path: '/.well-known/oauth-authorization-server/{namespace}'
## Headers: Accept: application/json
## ### Response:
## Returns a JSON object containing comprehensive metadata about the OAuth authorization server configuration.
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
func get_authorization_server_metadata_with_namespace(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/.well-known/oauth-authorization-server/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists all available ban types
## GET /iam/v3/admin/bans
##
## Ban type is the code available for ban assignment, applicable globally for any namespace.
func admin_get_bans_type_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/bans"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists all available ban reasons
## GET /iam/v3/admin/bans/reasons
##
## Ban reasons is the code available to justify ban assignment, applicable globally for any namespace.
func admin_get_list_ban_reason_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/bans/reasons"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists available client configuration permissions
## GET /iam/v3/admin/clientConfig/permissions
##
## List Client available permissions
##
## Parameters:
## - exclude_permissions: If exclude permissions
func admin_list_client_available_permissions(exclude_permissions: bool = false) -> Dictionary:
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


## Updates or creates client permission modules
## PUT /iam/v3/admin/clientConfig/permissions
##
## Update Client available permissions, if module or group not exists, it will auto create.
##
## Parameters:
## - force_delete: Forces update even when deletions affect groups or modules currently assigned to a client. When false, the request fails if any deletion target is in use.
func admin_update_available_permissions_by_module(
	force_delete: bool = false, body: Dictionary = {}
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


## Deletes client configuration permissions by module and group
## DELETE /iam/v3/admin/clientConfig/permissions
##
## Delete Client config permissions by module and group.
##
## Parameters:
## - force_delete: Forces deletion even if the target group or module is currently assigned to a client. When false, the request fails if the group or module is in use.
func admin_delete_config_permissions_by_group(
	force_delete: bool = false, body: Dictionary = {}
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


## Set permission module package info
## PATCH /iam/v3/admin/clientConfig/permissions/package
##
## Sets the package info for a permission module. Ignores the module if it is not found.
func admin_update_module_package(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/clientConfig/permissions/package"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists available client configuration templates
## GET /iam/v3/admin/clientConfig/templates
##
## List client templates
func admin_list_client_templates() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/clientConfig/templates"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists admin users in a namespace
## GET /iam/v3/admin/namespaces/{namespace}/admins
##
## Lists all users with admin role (role with `admin_role` set to true).
##
## Behavior:
## - When query is set, searches users whose email address or display name matches the query.
## - When `roleId` is set, searches users with the specified role.
## - When `startDate` and `endDate` are set, searches users created within that date range.
## - When `startDate` is set, searches users created from that date onward.
## - When `endDate` is set, searches users created up to that date.
##
## In multi-tenant mode:
## - A super admin searching in the super admin namespace returns all admin users.
## - A super admin searching in a game studio namespace returns all admin users under that namespace.
## - A studio admin searching in their studio namespace returns all admin users in that namespace.
##
## Returns all admins from all namespaces for callers in the publisher namespace. Otherwise, returns all admins from the path namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - end_date: End Date, format YYYY-MM-DD
## - limit: Number of results to return
## - query: Query, can be either display name or email address
## - role_id: IAM role ID
## - start_date: Start Date, format YYYY-MM-DD
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


## Retrieves age restriction status for a namespace
## GET /iam/v3/admin/namespaces/{namespace}/agerestrictions
##
## Returns the age restriction configuration for the specified namespace, including whether age restriction is active and the minimum age threshold.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_age_restriction_status_v3(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/agerestrictions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates age restriction configuration for a namespace
## PATCH /iam/v3/admin/namespaces/{namespace}/agerestrictions
##
## Updates the age restriction configuration for the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_age_restriction_config_v3(
	namespace_param: String, body: Dictionary = {}
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


## Lists country age restrictions for a namespace
## GET /iam/v3/admin/namespaces/{namespace}/agerestrictions/countries
##
## Returns the age restriction settings for each country in the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_list_country_age_restriction_v3(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/agerestrictions/countries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates age restriction for a specific country
## PATCH /iam/v3/admin/namespaces/{namespace}/agerestrictions/countries/{countryCode}
##
## Updates the age restriction setting for a specific country in the namespace.
##
## Parameters:
## - country_code: ISO 3166-1 alpha-2 country code.
## - namespace_param: Game namespace
func admin_update_country_age_restriction_v3(
	country_code: String, namespace_param: String, body: Dictionary = {}
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


## Lists users filtered by ban type
## GET /iam/v3/admin/namespaces/{namespace}/bans/users
##
## Lists users with active bans within a namespace, filtered by ban type and status. Supports offset-based pagination using the limit and offset parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filter ban based on the ban status. If you set this, only active ban returned
## - ban_type: Filters results by ban type code.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Applies a ban to the specified users
## POST /iam/v3/admin/namespaces/{namespace}/bans/users
##
## Bans up to 100 users with a specified ban type. Retrieve available ban types and reasons from the bans list.
##
## Parameters:
## - namespace_param: Game namespace
func admin_ban_user_bulk_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/bans/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes bans from users in bulk
## PATCH /iam/v3/admin/namespaces/{namespace}/bans/users/disabled
##
## Removes bans from users in bulk. The limit is 100 users per request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_unban_user_bulk_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/bans/users/disabled"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists ban types available in a namespace
## GET /iam/v3/admin/namespaces/{namespace}/bantypes
##
## Ban type is the code available for ban assignment, applicable globally for any namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_bans_type_with_namespace_v3(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/bantypes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists OAuth 2.0 clients in a namespace
## GET /iam/v3/admin/namespaces/{namespace}/clients
##
## Lists OAuth 2.0 clients in a namespace with optional filters. Supports offset-based pagination using the limit and offset parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - client_id: OAuth client ID
## - client_name: Client name, support fuzzy query
## - client_type: OAuth 2.0 client type to filter by. Valid values: 'Public' for browser or mobile clients, 'Confidential' for server-side clients.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - skip_login_queue: Filters results to clients exempted from the login queue. When not specified, results include both exempted and non-exempted clients.
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


## Updates a set of OAuth 2.0 clients
## PUT /iam/v3/admin/namespaces/{namespace}/clients
##
## Updates a set of OAuth 2.0 clients. Specify only the fields to update, e.g. {"ClientName":"E-commerce", "BaseUri":"https://example.net"}
##
## **Note for Multi Tenant Mode (Confidential Client):**
## Only Super admin can set permission with resource & action.
## Studio admin & game admin need set permission with permission module.
##
## **Fields Description:**
## - **clientName** : The client name. Must not be empty if included. e.g E-commerce
## - **namespace** : The namespace where the client lives. e.g sample-game
## - **redirectUri** : Contains the redirect URI used in OAuth callback. Must not be empty if included. e.g https://example.net/platform
## - **audiences** : List of target client IDs intended to receive the token. e.g ["eaaa65618fe24293b00a61454182b435", "40073ee9bc3446d3a051a71b48509a5d"]
## - **baseUri** : A base URI of the application, used to verify the token targets the correct resource server. Required for server-type applications. e.g https://example.net/platform
## - **clientPermissions** : Contains the client permissions.
## - **`deletable`** : Whether the client can be deleted (optional). e.g. true
## - **clientPlatform** : Available client platform (optional). Default value: "".
## - Playstation
## - Xbox
## - Steam
## - Epic
## - IOS
## - GooglePlay
## - Nintendo
## - Oculus
## - **twoFactorEnabled**: Whether 2FA validation is enabled for this client. Default value: false.
## - **oauthAccessTokenExpiration**: Configurable expiration time for access_token. Default value: 0 (uses environment variable).
## - **oauthRefreshTokenExpiration**: Configurable expiration time for refresh_token. Default value: 0 (uses environment variable).
## - **oauthAccessTokenExpirationTimeUnit**: Configurable expiration time unit for access_token; uses previous value if not specified.
## - **oauthRefreshTokenExpirationTimeUnit**: Configurable expiration time unit for refresh_token; uses previous value if not specified.
## - **skipLoginQueue**: Whether this client is exempted from the login queue.
##
## Parameters:
## - namespace_param: Game namespace
func admin_bulk_update_clients_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates a new OAuth 2.0 client
## POST /iam/v3/admin/namespaces/{namespace}/clients
##
## Creates a new OAuth 2.0 client. New clients automatically receive these scopes: commerce, account, analytics, publishing, social.
##
## **Note for Multi Tenant Mode (Confidential Client):**
## Only Super admin can set permission with resource & action.
## Studio admin & game admin need set permission with permission module.
##
## **Fields Description:**
## - **`clientId`** : The client ID. e.g f815e5c44f364993961be3b3f26a7bf4
## - **clientName** : The client name. e.g E-commerce
## - **secret** : The client secret. Empty for public clients; required for confidential clients.
## - **namespace** : The namespace where the client lives. e.g sample-game
## - **redirectUri** : Contains the redirect URI used in OAuth callback. e.g https://example.net/platform
## - **oauthClientType** : The OAuth 2.0 client type. Determines whether authorization requires Proof of Key Exchange (PKCE).
## A public client type does not have a client secret and should use PKCE flow.
## A confidential client type has a client secret and does not use PKCE flow.
## Supported oAuthClientType :
## - **Public**
## - **Confidential**
## - **audiences** : List of target client IDs intended to receive the token. e.g ["eaaa65618fe24293b00a61454182b435", "40073ee9bc3446d3a051a71b48509a5d"]
## - **baseUri** : A base URI of the application, used to verify the token targets this client. e.g https://example.net/platform
## - **clientPermissions** : Contains the client permissions.
## - **deletable** : Whether the client is deletable (optional). Default value: true.
## - **clientPlatform**: Available client platform (optional). Default value: "".
## - Playstation
## - Xbox
## - Steam
## - Epic
## - IOS
## - GooglePlay
## - Nintendo
## - Oculus
## - **twoFactorEnabled**: Whether 2FA validation is enabled for this client. Default value: false.
## - **oauthAccessTokenExpiration**: Configurable expiration time for access_token. Default value: 0 (uses environment variable).
## - **oauthRefreshTokenExpiration**: Configurable expiration time for refresh_token. Default value: 0 (uses environment variable).
## - **oauthAccessTokenExpirationTimeUnit**: Configurable expiration time unit for access_token. Default value: SECONDS.
## - **oauthRefreshTokenExpirationTimeUnit**: Configurable expiration time unit for refresh_token. Default value: SECONDS.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_client_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves an OAuth 2.0 client by ID
## GET /iam/v3/admin/namespaces/{namespace}/clients/{clientId}
##
## Returns the configuration details for a specific OAuth 2.0 client.
##
## Parameters:
## - client_id: OAuth client ID
## - namespace_param: Game namespace
func admin_get_clientsby_namespaceby_idv3(client_id: String, namespace_param: String) -> Dictionary:
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


## Deletes an OAuth 2.0 client
## DELETE /iam/v3/admin/namespaces/{namespace}/clients/{clientId}
##
## Deletes a specific OAuth 2.0 client from the namespace.
##
## Parameters:
## - client_id: OAuth client ID
## - namespace_param: Game namespace
func admin_delete_client_v3(client_id: String, namespace_param: String) -> Dictionary:
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


## Updates an OAuth 2.0 client
## PATCH /iam/v3/admin/namespaces/{namespace}/clients/{clientId}
##
## Updates an OAuth 2.0 client. Specify only the fields to update, e.g. {"ClientName":"E-commerce", "BaseUri":"https://example.net"}
##
## **Note for Multi Tenant Mode (Confidential Client):**
## Only Super admin can set permission with resource & action.
## Studio admin & game admin need set permission with permission module.
##
## **Fields Description:**
## - **clientName** : The client name. Must not be empty if included. e.g E-commerce
## - **namespace** : The namespace where the client lives. e.g sample-game
## - **redirectUri** : Contains the redirect URI used in OAuth callback. Must not be empty if included. e.g https://example.net/platform
## - **audiences** : List of target client IDs intended to receive the token. e.g ["eaaa65618fe24293b00a61454182b435", "40073ee9bc3446d3a051a71b48509a5d"]
## - **baseUri** : A base URI of the application, used to verify the token targets the correct resource server. Required for server-type applications. e.g https://example.net/platform
## - **clientPermissions** : Contains the client permissions.
## - **`deletable`** : Whether the client can be deleted (optional). e.g. true
## - **clientPlatform** : Available client platform (optional). Default value: "".
## - Playstation
## - Xbox
## - Steam
## - Epic
## - IOS
## - GooglePlay
## - Nintendo
## - Oculus
## - **twoFactorEnabled**: Whether 2FA validation is enabled for this client. Default value: false.
## - **oauthAccessTokenExpiration**: Configurable expiration time for access_token. Default value: 0 (uses environment variable).
## - **oauthRefreshTokenExpiration**: Configurable expiration time for refresh_token. Default value: 0 (uses environment variable).
## - **oauthAccessTokenExpirationTimeUnit**: Configurable expiration time unit for access_token; uses previous value if not specified.
## - **oauthRefreshTokenExpirationTimeUnit**: Configurable expiration time unit for refresh_token; uses previous value if not specified.
## - **skipLoginQueue**: Whether this client is exempted from the login queue.
##
## Parameters:
## - client_id: OAuth client ID
## - namespace_param: Game namespace
func admin_update_client_v3(
	client_id: String, namespace_param: String, body: Dictionary = {}
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


## Replaces all permissions for an OAuth 2.0 client
## PUT /iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions
##
## **Note for Multi Tenant Mode:**
## This is for super admin only.
##
## Parameters:
## - client_id: OAuth client ID
## - namespace_param: Game namespace
func admin_update_client_permission_v3(
	client_id: String, namespace_param: String, body: Dictionary = {}
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


## Adds permissions to an OAuth 2.0 client
## POST /iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions
##
## **Note for Multi Tenant Mode:**
## This is for super admin only.
##
## Parameters:
## - client_id: OAuth client ID
## - namespace_param: Game namespace
func admin_add_client_permissions_v3(
	client_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a specific permission from an OAuth 2.0 client
## DELETE /iam/v3/admin/namespaces/{namespace}/clients/{clientId}/permissions/{resource}/{action}
##
## **Note for Multi Tenant Mode:**
## This is for super admin only.
##
## Parameters:
## - action: Action, value must be in range 1-15
## - client_id: OAuth client ID
## - namespace_param: Game namespace
## - resource: Resource Name
func admin_delete_client_permission_v3(
	action: int, client_id: String, namespace_param: String, resource: String
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


## Retrieves a configuration value by key
## GET /iam/v3/admin/namespaces/{namespace}/config/{configKey}
##
## Returns the value of a configuration key. The namespace must be a publisher or studio namespace.
##
## **Supported config keys:**
## * uniqueDisplayNameEnabled
## * usernameDisabled
## * mandatoryEmailVerificationEnabled
##
## Parameters:
## - config_key: Configuration key to retrieve.
## - namespace_param: Game namespace
func admin_get_config_value_v3(config_key: String, namespace_param: String) -> Dictionary:
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


## Lists available countries
## GET /iam/v3/admin/namespaces/{namespace}/countries
##
## Admin get country list
##
## Parameters:
## - namespace_param: Game namespace
## - filter_blacklist: Filter black list
func admin_get_country_list_v3(
	namespace_param: String, filter_blacklist: bool = false
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


## Retrieves the country blacklist
## GET /iam/v3/admin/namespaces/{namespace}/countries/blacklist
##
## Admin get country blacklist
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_country_blacklist_v3(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/countries/blacklist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the country blacklist
## POST /iam/v3/admin/namespaces/{namespace}/countries/blacklist
##
## Admin update country blacklist
##
## Parameters:
## - namespace_param: Game namespace
func admin_add_country_blacklist_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/countries/blacklist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Admin Get Input Validations
## GET /iam/v3/admin/namespaces/{namespace}/inputValidations
##
## Returns the list of input validation configuration.
## Supported namespace:
## - publisher namespace
## - studio namespace
##
## `regex` parameter will be returned if `isCustomRegex` is true. Otherwise, it will be empty.
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
func admin_get_namespace_scoped_input_validations(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/inputValidations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Admin Update Input Validations
## PUT /iam/v3/admin/namespaces/{namespace}/inputValidations
##
## Updates input validation configuration.
## Supported namespace:
## - publisher namespace
## - studio namespace
##
## Supported `field`:
## - displayName
## - password
## - username
## - email
## - avatar
##
## If `isCustomRegex` is set to true, `regex` parameter will be used as input validation and the other parameters will be ignored. Otherwise, `regex` parameter will be ignored and regex for input validation will be generated based on the combination of the other parameters.
## If `allowUnicode` is set to true, unicode regex pattern will be use as the input validation and the other parameters will be ignored.
## Supported `letterCase`:
## - lowercase
## - uppercase
## - mixed: uppercase and lowercase
## - any: uppercase and/or lowercase
##
## To allow flexible non-word special characters, use `allowAllSpecialCharacters`.
## If `allowAllSpecialCharacters` is set to true, `specialCharacters` will be forced to empty.
## Supported `specialCharacterLocation`:
## - anywhere
## - middle
##
## If `specialCharacters` is empty, `specialCharacterLocation` and `maxRepeatingSpecialCharacter` will be ignored.
## `minCharType` is used to identify how many required criteria in the regex. The supported criteria are number, letter, special character, and letter case. If set to 0 or 1, all criteria are optional. It can be set as much as the number of criteria enabled.
## If `blockedWord` is set by an admin, any user input containing a blocked word will be rejected during account creation, upgrade, or update.
## If `avatarConfig` is set, will use this config and skip all the other validation conditions.
##
## These are the boundary values for string length:
## minLength: 1,
## maxLength: 256
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
func admin_update_namespace_scoped_input_validations(
	namespace_param: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/inputValidations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Admin Reset Input Validations
## DELETE /iam/v3/admin/namespaces/{namespace}/inputValidations/{field}
##
## Resets input validation to the default input validation configurations.
## Supported namespace:
## - publisher namespace
## - studio namespace
##
## Parameters:
## - field: Name of the input validation field to reset: email, username, displayName, password, avatar
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
func admin_reset_namespace_scoped_input_validations(
	field: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/inputValidations/{field}"
	url_path = url_path.replace("{" + "field" + "}", field.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the login allowlist configuration
## GET /iam/v3/admin/namespaces/{namespace}/loginAllowlist
##
## Returns the login allowlist configuration for the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_login_allowlist_v3(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/loginAllowlist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the login allowlist configuration
## PUT /iam/v3/admin/namespaces/{namespace}/loginAllowlist
##
## Updates the login allowlist configuration for the specified game namespace.
## roleIds: list of role IDs allowed to log in.
## Note: Only accepts game namespaces.
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_login_allowlist_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/loginAllowlist"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists all third-party platform credentials
## GET /iam/v3/admin/namespaces/{namespace}/platforms/all/clients
##
## This is the API to Get All Active 3rd Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
func retrieve_all_third_party_login_platform_credential_v3(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/platforms/all/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists all active third-party platform credentials
## GET /iam/v3/admin/namespaces/{namespace}/platforms/all/clients/active
##
## This is the API to Get All Active 3rd Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
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


## Lists all SSO platform credentials
## GET /iam/v3/admin/namespaces/{namespace}/platforms/sso
##
## Returns all active SSO platform credentials. Supports offset-based pagination using the limit and offset parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func retrieve_all_sso_login_platform_credential_v3(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves third-party platform credentials
## GET /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
##
## This is the API to Get 3rd Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func retrieve_third_party_login_platform_credential_v3(
	namespace_param: String, platform_id: String
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


## Adds third-party platform credentials
## POST /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
##
## Adds a third-party platform credential. Configuration varies by platform:
## - The secret for **apple** is a base64-encoded private key.
## - No secret for **awscognito**; configure AWS Cognito Region and User Pool.
## - The secret for **discord** is the client secret of the twitch client ID.
## - The secret for **epicgames** is the client secret of the epicgames client ID.
## - The secret for **facebook** is the client secret of the facebook client ID.
## - The secret for **google** is the client secret of the google OAuth client.
## - No secret for **nintendo**; configure the app ID of the game.
## - No secret for **netflix**; configure the Root, Public, Private Key certificate PEM file and target environment. Values: [sandbox, production].
## - The secret for **oculus** is the app secret of the oculus app.
## - The secret for **ps4, ps5, and ps4web** is the client secret of the PSN web server.
## - The secret for **steam** is the Steam Web API Key.
## - The secret for **steamopenid** is the Steam Web API Key.
## - The secret for **twitch** is the client secret of the twitch client.
## - The secret for **live** is the Relying Party Private Key in base64-encoded PEM format.
## - The secret for **xblwebapi** is the client secret of the XBL client.
##
## When generic OAuth flow is enabled:
## - Supported values for TokenAuthenticationType: **code, idToken and bearerToken**
## - `TokenClaimsMapping` extracts user info from idToken claims or user info accessed using bearerToken.
## It is a JSON format where keys must be `name`, `email` and `avatarUrl`,
## since the service looks up these keys when extracting user info. Default claims keys: userIdentity/sub, name, email and avatarUrl/picture.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func add_third_party_login_platform_credential_v3(
	namespace_param: String, platform_id: String, body: Dictionary = {}
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


## Deletes third-party platform credentials
## DELETE /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
##
## This is the API to Delete 3rd Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func delete_third_party_login_platform_credential_v3(
	namespace_param: String, platform_id: String
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


## Updates third-party platform credentials
## PATCH /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients
##
## Updates a third-party platform credential. Configuration varies by platform:
## - The secret for **apple** is a base64-encoded private key.
## - No secret for **awscognito**; configure AWS Cognito Region and User Pool.
## - The secret for **discord** is the client secret of the twitch client ID.
## - The secret for **epicgames** is the client secret of the epicgames client ID.
## - The secret for **facebook** is the client secret of the facebook client ID.
## - The secret for **google** is the client secret of the google OAuth client.
## - No secret for **nintendo**; configure the app ID of the game.
## - No secret for **netflix**; configure the Root, Public, Private Key certificate PEM file and target environment. Values: [sandbox, production].
## - The secret for **oculus** is the app secret of the oculus app.
## - The secret for **ps4, ps5, and ps4web** is the client secret of the PSN web server.
## - The secret for **steam** is the Steam Web API Key.
## - The secret for **steamopenid** is the Steam Web API Key.
## - The secret for **twitch** is the client secret of the twitch client.
## - The secret for **live** is the Relying Party Private Key in base64-encoded PEM format.
## - The secret for **xblwebapi** is the client secret of the XBL client.
##
## When generic OAuth flow is enabled:
## - Supported values for TokenAuthenticationType: **code, idToken and bearerToken**
## - `TokenClaimsMapping` extracts user info from idToken claims or user info accessed using bearerToken.
## It is a JSON format where keys must be `name`, `email` and `avatarUrl`,
## since the service looks up these keys when extracting user info. Default claims keys: userIdentity/sub, name, email and avatarUrl/picture.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func update_third_party_login_platform_credential_v3(
	namespace_param: String, platform_id: String, body: Dictionary = {}
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


## Sets third-party platform domain configuration
## PUT /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain
##
## Creates or replaces a third-party platform domain. When updating an existing domain, replaces the entire configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func update_third_party_login_platform_domain_v3(
	namespace_param: String, platform_id: String, body: Dictionary = {}
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


## Removes a third-party platform domain
## DELETE /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain
##
## Removes a third-party platform domain. When `ssoGroups` is specified, the service removes only the SSO group from the domain without deleting the domain itself.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func delete_third_party_login_platform_domain_v3(
	namespace_param: String, platform_id: String, body: Dictionary = {}
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


## Updates third-party platform domain configuration
## PATCH /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/clients/domain
##
## Creates or partially updates a third-party platform domain. When updating an existing domain, applies a partial update.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func partial_update_third_party_login_platform_domain_v3(
	namespace_param: String, platform_id: String, body: Dictionary = {}
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


## Retrieves SSO platform credentials
## GET /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
##
## This is the API to Get SSO Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func retrieve_sso_login_platform_credential(
	namespace_param: String, platform_id: String
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


## Adds SSO platform credentials
## POST /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
##
## Adds SSO platform credentials for the specified namespace and platform.
##
## ## Supported platforms:
## - **discourse**: The ssoUrl is the discourse forum URL. Example: https://forum.example.com
## - **azure with SAML**: **appId** is the application identifier in the IdP (EntityID in Azure). **acsUrl** is the service provider URL where the identity provider redirects with its authentication response. **federationMetadataUrl** is the IdP metadata URL used to establish a trust relationship.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func add_sso_login_platform_credential(
	namespace_param: String, platform_id: String, body: Dictionary = {}
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


## Deletes SSO platform credentials
## DELETE /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
##
## This is the API to Delete SSO Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func delete_sso_login_platform_credential_v3(
	namespace_param: String, platform_id: String
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


## Updates SSO platform credentials
## PATCH /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/sso
##
## This is the API to Delete SSO Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func update_sso_platform_credential(
	namespace_param: String, platform_id: String, body: Dictionary = {}
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


## Lists user IDs by platform user ID
## POST /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/users
##
## Lists AccelByte user IDs matching the given platform user IDs in the namespace.
##
## Supported platforms:
## - steam
## - steamopenid
## - ps4web
## - ps4
## - ps5
## - live
## - xblweb
## - oculus
## - oculusweb
## - facebook
## - google
## - googleplaygames
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - justice
## - epicgames
## - nintendo
## - awscognito
## - netflix
## - snapchat
## - oidc platform id
##
## Note:
## **nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. Example: kmzwa8awaa:dd1
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - raw_pid: Whether to return raw platform user IDs. When false, the service encrypts some platform user IDs. Deprecated; use `rawPUID` instead.
## - raw_puid: Whether to return raw platform user IDs. When false, the service encrypts some platform user IDs.
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


## Retrieves a user by platform user ID
## GET /iam/v3/admin/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}
##
## Retrieves user information by platform ID and platform user ID. Several platforms are grouped under account groups; specify either the platform ID or platform group as the `platformId`.
##
## Example: for the steam network platform, use steamnetwork, steam, or steamopenid as the `platformId`.
##
## **Supported platforms:**
## - Steam group (steamnetwork): steam, steamopenid
## - PSN group (psn): ps4web, ps4, ps5
## - XBOX group (xbox): live, xblweb
## - Oculus group (oculusgroup): oculus, oculusweb
## - Google group (google): google, googleplaygames
## - epicgames, facebook, twitch, discord, android, ios, apple, device, nintendo, awscognito, amazon, netflix, snapchat, oidc platform id
##
## Notes:
## - **Nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. Example: kmzwa8awaa:dd1
## - **Oculus**: to query by app user ID, set the `pidType` parameter to OCULUS_APP_USER_ID (game namespace only).
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - platform_user_id: User identifier on the third-party platform
## - pid_type: Platform User ID Type
func admin_get_user_by_platform_user_idv3(
	namespace_param: String, platform_id: String, platform_user_id: String, pid_type: String = ""
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


## Retrieves profile update strategies for a namespace
## GET /iam/v3/admin/namespaces/{namespace}/profileUpdateStrategies
##
## Is for admin to get profile update strategy by namespace and field.
## Note: If the config is not found, this API will return a config with unlimited.
##
## Parameters:
## - namespace_param: Game namespace
## - field: Target field
func admin_get_profile_update_strategy_v3(
	namespace_param: String, field: String = ""
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


## Updates profile update strategies for a namespace
## PUT /iam/v3/admin/namespaces/{namespace}/profileUpdateStrategies
##
## Updates profile update strategies for the namespace with upsert behavior.
##
## Note: The 'config' field only applies when type is 'limited'.
##
## Parameters:
## - namespace_param: Game namespace
## - field: Target field
func admin_update_profile_update_strategy_v3(
	namespace_param: String, field: String, body: Dictionary = {}
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


## Retrieves role override configuration
## GET /iam/v3/admin/namespaces/{namespace}/roleoverride
##
## Get role override config.
## This API has upsert behavior, if there is no config yet, it will create a new one with inactive status.
##
## Parameters:
## - namespace_param: Game namespace
## - identity: Role identity
func admin_get_role_override_config_v3(namespace_param: String, identity: String) -> Dictionary:
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


## Updates role override configuration
## PATCH /iam/v3/admin/namespaces/{namespace}/roleoverride
##
## Is for updating role override config.
## Note:
## This API has upsert behavior, if there is no config yet, it will create a new one first.
##
## Parameters:
## - namespace_param: Game namespace
## - identity: Role identity
func admin_update_role_override_config_v3(
	namespace_param: String, identity: String, body: Dictionary = {}
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


## Retrieves the source permission set for role overrides
## GET /iam/v3/admin/namespaces/{namespace}/roleoverride/source
##
## Get role source permission set.
##
## Parameters:
## - namespace_param: Game namespace
## - identity: Role identity
func admin_get_role_source_v3(namespace_param: String, identity: String) -> Dictionary:
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


## Updates the active status of role override configuration
## PATCH /iam/v3/admin/namespaces/{namespace}/roleoverride/status
##
## Enable or disable the target role override feature in path namespace.
## Note:
## This API has upsert behavior, if there is no config yet, it will create a new one first.
##
## Parameters:
## - namespace_param: Game namespace
## - identity: Role identity
func admin_change_role_override_config_status_v3(
	namespace_param: String, identity: String, body: Dictionary = {}
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


## Retrieves namespace permissions for a role override
## GET /iam/v3/admin/namespaces/{namespace}/roleoverride/{roleId}/permissions
##
## Get role namespace permission set.
##
## Parameters:
## - namespace_param: Game namespace
## - role_id: IAM role ID
func admin_get_role_namespace_permission_v3(namespace_param: String, role_id: String) -> Dictionary:
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


## Retrieves admin users assigned to a role
## GET /iam/v3/admin/namespaces/{namespace}/roles/{roleId}/users
##
## Retrieves admin users assigned to the specified role.
##
## Notes: This operation only accepts admin roles. An admin role has admin status and members.
## Use [GET] /roles/{roleId}/admin to check the role status.
##
## Parameters:
## - namespace_param: Game namespace
## - role_id: IAM role ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
func get_admin_users_by_role_id_v3(
	namespace_param: String, role_id: String, after: int = -1, before: int = -1, limit: int = -1
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


## Queries account identifier tags
## GET /iam/v3/admin/namespaces/{namespace}/tags
##
## Retrieves account identifier tags for the namespace. Filter results by tag name using partial matching. Supports offset-based pagination using the limit and offset parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - tag_name: Tag name to filter by. Supports partial matching.
func admin_query_tag_v3(
	namespace_param: String, limit: int = -1, offset: int = -1, tag_name: String = ""
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


## Creates an account identifier tag
## POST /iam/v3/admin/namespaces/{namespace}/tags
##
## Creates a new account identifier tag for identifying and categorizing user accounts.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_tag_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates an account identifier tag
## PUT /iam/v3/admin/namespaces/{namespace}/tags/{tagId}
##
## Updates the details of the specified account identifier tag.
##
## Parameters:
## - namespace_param: Game namespace
## - tag_id: Tag ID, should follow UUID version 4 without hyphen
func admin_update_tag_v3(
	namespace_param: String, tag_id: String, body: Dictionary = {}
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


## Deletes an account identifier tag
## DELETE /iam/v3/admin/namespaces/{namespace}/tags/{tagId}
##
## Deletes the specified account identifier tag.
##
## Parameters:
## - namespace_param: Game namespace
## - tag_id: Tag ID, should follow UUID version 4 without hyphen
func admin_delete_tag_v3(namespace_param: String, tag_id: String) -> Dictionary:
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


## Retrieves a user by email address
## GET /iam/v3/admin/namespaces/{namespace}/users
##
## Retrieves the user who owns the given email address.
##
## Parameters:
## - namespace_param: Game namespace
## - email_address: Email Address, should follow OWASP email format
func admin_get_user_by_email_address_v3(
	namespace_param: String, email_address: String = ""
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


## Updates users in bulk
## PUT /iam/v3/admin/namespaces/{namespace}/users
##
## Updates users in bulk based on the provided data.
##
## Supported fields:
## - skipLoginQueue
##
## Parameters:
## - namespace_param: Game namespace
func admin_bulk_update_users_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves bans for a list of users
## POST /iam/v3/admin/namespaces/{namespace}/users/bans
##
## Returns ban records for the specified user IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filter ban based on the ban status. If you set this, only active ban returned
## - ban_type: Ban type to filter results by.
func admin_get_bulk_user_ban_v3(
	namespace_param: String, active_only: bool = false, ban_type: String = "", body: Dictionary = {}
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


## Retrieves users by user ID
## POST /iam/v3/admin/namespaces/{namespace}/users/bulk
##
## Retrieves user information for the given list of user IDs within the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_list_user_id_by_user_i_ds_v3(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves platform information for a list of users
## POST /iam/v3/admin/namespaces/{namespace}/users/bulk/platforms
##
## Retrieves platform information for users by user ID.
##
## Notes:
## - The limit is 100 users per request.
## - For game namespaces, searches by game user ID; otherwise searches by publisher namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_bulk_get_users_platform(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/bulk/platforms"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves users using cursor-based pagination
## POST /iam/v3/admin/namespaces/{namespace}/users/cursor
##
## 1. **Cursor-Based Retrieval**
## Fetches user records ordered by `created_at` ASC, `user_id` ASC for stable pagination.
## Pagination uses a cursor consisting of `created_at` and `user_id`.
## 2. **Field Selection**
## By default, only the user ID is returned.
## To include additional fields, specify them under the fields parameter.
## ***Supported fields***: ['created_at', 'email_address']
## ***Note***: The service silently ignores unsupported fields.
## 3. **Cursor Mechanics**
## The cursor consists of `created_at` and `user_id` from the last retrieved record.
## The next page fetches records strictly after the provided cursor.
## Records sharing the same `created_at` value as the cursor are excluded to prevent duplication.
## 4. **Usage**
## For the first request, omit the cursor.
## When the data array is empty, all available records have been retrieved.
##
## Parameters:
## - namespace_param: Game namespace
func admin_cursor_get_user_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/cursor"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Invites a user to the namespace
## POST /iam/v3/admin/namespaces/{namespace}/users/invite
##
## Invites an admin or non-admin user to the namespace and optionally assigns a role. The role must apply to the specified namespace. An admin user can only assign roles to namespaces where they have the required permission. When no role is specified, the service assigns only the User role. The invited user also receives the User role by default.
##
## Parameters:
## - namespace_param: Game namespace
func admin_invite_user_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/namespaces/{namespace}/users/invite"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Searches link history for a platform user ID
## GET /iam/v3/admin/namespaces/{namespace}/users/linkhistories
##
## If limit is not defined, The default limit is 100
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - platform_user_id: User identifier on the third-party platform
## - platform_id: Third-party platform identifier
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


## Lists users with Justice platform accounts
## GET /iam/v3/admin/namespaces/{namespace}/users/platforms/justice
##
## **Requires publisher namespace.**
##
## Returns a list of user IDs and namespaces with their Justice platform accounts. If a user does not have a Justice platform account, the linkedPlatforms field is an empty array.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_list_users_v3(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Searches users in the namespace
## GET /iam/v3/admin/namespaces/{namespace}/users/search
##
## Searches users in the namespace based on the provided filters.
##
## - By default, searches all users in the specified namespace.
## - When query is set, searches users whose email address, display name, username, or third-party account partially matches.
## - The query must be 3-30 characters (or 3-40 for email addresses containing '@'); otherwise, the operation returns no results.
## - When startDate and endDate are set, searches users created within that range.
## - When platformId is set and by is 'thirdparty', searches users by the linked platform.
## - When platformBy is set and by is 'thirdparty', searches by platformUserId or platformDisplayName.
## - Default limit is 100.
##
## Field selection:
## - By default, returns: displayName, authType, createdAt, uniqueDisplayName, deletionStatus, enabled, emailAddress, skipLoginQueue, testAccount.
## - To include additional fields, specify them in the selectedFields parameter.
## - Supported extra fields: country, emailVerified, avatarUrl, enabled.
##
## In multi-tenant mode, results depend on the admin role and the target namespace type.
##
## Parameters:
## - namespace_param: Game namespace
## - by: Search by given attribute, possible values are emailAddress, displayName, uniqueDisplayName, username and thirdPartyPlatform
## - end_date: End Date, format YYYY-MM-DD
## - include_total: A flag whether this request should include total count, default false
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - platform_by: Search platformBy given attribute, possible values are platformDisplayName
## - platform_id: Third-party platform identifier
## - query: Query, can be either email address or display name
## - role_ids: Comma separated role ids
## - selected_fields: Comma separated selected fields.
## - skip_login_queue: Whether to filter users exempted from the login queue. When not set, results include both exempted and non-exempted users.
## - start_date: Start Date, format YYYY-MM-DD
## - tag_ids: Comma separated tag ids less than 4
## - test_account: A flag to filter test account. if testAccount parameter is not defined, search result will include both real and test accounts
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


## Retrieves users by email address in bulk
## POST /iam/v3/admin/namespaces/{namespace}/users/search/bulk
##
## Searches for users matching the provided list of email addresses.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_bulk_user_by_email_address_v3(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves a user by user ID
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}
##
## Admin Get User By User Id
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_by_user_id_v3(namespace_param: String, user_id: String) -> Dictionary:
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


## Updates a user
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}
##
## Updates the specified user with the provided data. A single request can update one or more fields.
##
## Supported fields: country, displayName, languageTag, dateOfBirth, avatarUrl, userName, tags.
##
## - Country: ISO 3166-1 alpha-2 format.
## - Date of birth: YYYY-MM-DD format.
## - Tags: array of strings, up to 5, no duplicates. Send an empty array to clear all tags.
##
## **Email address update behavior:**
## - When the current email is verified, the service sets NewEmailAddress to the new email.
## - When the current email is not verified, the service sets LoginId, OldEmailAddress, and EmailAddress to the new email.
## - When the email was previously verified then updated, LoginId, OldEmailAddress, and EmailAddress hold the verified email and NewEmailAddress holds the new email.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves ban records for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans
##
## Returns ban records. Omit the cursor to start from the first page.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: Filter ban based on the ban status. If you set this, only active ban returned
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
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


## Bans a user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans
##
## Bans a user with a specific ban type. Retrieve available ban types and reasons from the ban types operation.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_ban_user_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a summary of ban records for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans/summary
##
## Retrieves a summary of ban records for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_ban_summary_v3(namespace_param: String, user_id: String) -> Dictionary:
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


## Enables or disables a ban for a user
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/bans/{banId}
##
## Set ban status for a single user for a specific ban. Retrieve
## user ban and choose the ban ID. Set the form parameter to true/false to enable
## or disable the ban.
##
## Parameters:
## - ban_id: Identifier of the ban record to update.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_ban_v3(
	ban_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Sends a verification code to a user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/code/request
##
## Sends a verification code to the user's email address.
##
## Available contexts:
## - **UserAccountRegistration**: Verifies the email address during account registration. Returns 409 if the email address is already verified. This is the default context when the Context field is empty.
## - **UpdateEmailAddress**: Verifies the user before updating their email address (without checking if already verified).
## - **upgradeHeadlessAccount**: Automatically verifies the email address when upgrading a headless account. Returns 409 if the email address is already in use by another user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_send_verification_code_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Verifies or consumes a verification code for a user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/code/verify
##
## Verifies and consumes a verification code to confirm the user's contact address. When validateOnly is true, verifies the code without consuming it.
##
## Available contact types: email, phone.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_verify_account_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves active verification codes for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/codes
##
## **[WARNING] For testing purposes only.**
##
## Retrieves active verification codes for the user. The service generates codes in the following scenarios:
## - After account registration
## - After reset password request
## - After headless account upgrade
## - After email address update request
##
## Only valid for publisher and studio namespaces.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_verification_code(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves deletion status for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/deletion/status
##
## Returns the account deletion status for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_deletion_status_v3(namespace_param: String, user_id: String) -> Dictionary:
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


## Updates deletion status for a user
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/deletion/status
##
## Updates the account deletion status for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_deletion_status_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves distinct platform accounts linked to a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/distinctPlatforms
##
## Retrieves all platform accounts linked to the user. The service groups results by platform with deduplication. When more than one account exists on the same platform, the service returns the oldest linked account.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_list_user_all_platform_accounts_distinct_v3(
	namespace_param: String, user_id: String
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


## Verifies or consumes a verification code
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/headless/code/verify
##
## When validateOnly is false, upgrades the headless account by linking it with the email address and password. After upgrading, the user can sign in using their email address and password. This operation also verifies the email address in the same call. Optionally updates user data fields after account upgrade.
## Supported user data fields:
## - displayName
## - dateOfBirth: format YYYY-MM-DD, e.g. 2019-04-29
## - country: format ISO 3166-1 alpha-2, e.g. US
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_upgrade_headless_account_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a user's information
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/information
##
## [WARNING] Deletes user data directly from the database, bypassing the GDPR deletion flow.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_user_information_v3(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves login history for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/logins/histories
##
## Retrieves login history for the user. Returns the first page when called without a cursor.
## - Limit: 1-100.
## - Use the after parameter with a Unix timestamp for forward pagination.
## - Use the before parameter with a Unix timestamp for backward pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
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


## Updates a user's password
## PUT /iam/v3/admin/namespaces/{namespace}/users/{userId}/password
##
## Update User Password
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_reset_password_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Replaces a user's permissions
## PUT /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions
##
## Replaces the user's existing permissions with those specified.
## Schedule contains a cron string or date range (both are UTC, also in cron syntax) to indicate when a permission and action are in effect.
## Both schedule types accept quartz-compatible cron syntax, e.g. * * * * * * *.
## In a ranged schedule, the first element is the start date and the second is the end date.
## When a schedule is defined, the scheduled action must be valid, between 1 and 15, inclusive.
## Syntax reference
## Fields:
## 1. Seconds: 0-59 * / , -
## 2. Minutes: 0-59 * / , -
## 3. Hours: 0-23 * / , -
## 4. Day of month: 1-31 * / , - L W
## 5. Month: 1-12 JAN-DEC * / , -
## 6. Day of week: 0-6 SUN-SAT * / , - L #
## 7. Year: 1970-2099 * / , -
##
## Special characters:
## 1. *: all values in the fields, e.g. * in seconds fields indicates every second
## 2. /: increments of ranges, e.g. 3-59/15 in the minute field indicate the third minute of the hour and every 15 minutes thereafter
## 3. ,: separate items of a list, e.g. MON,WED,FRI in day of week
## 4. -: range, e.g. 2010-2018 indicates every year between 2010 and 2018, inclusive
## 5. L: last, e.g. When used in the day-of-week field, it allows you to specify constructs such as "the last Friday" (5L) of a given month. In the day-of-month field, it specifies the last day of the month.
## 6. W: business day, e.g. if you were to specify 15W as the value for the day-of-month field, the meaning is: "the nearest business day to the 15th of the month."
## 7. #: requires a number between one and five. It allows you to specify constructs such as "the second Friday" of a given month.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_permission_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Adds permissions to the user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions
##
## Adds the specified permissions to the user's existing permissions.
## Schedule contains a cron string or date range (both are UTC, also in cron syntax) to indicate when a permission and action are in effect.
## Both schedule types accept quartz-compatible cron syntax, e.g. * * * * * * *.
## In a ranged schedule, the first element is the start date and the second is the end date.
## When a schedule is defined, the scheduled action must be valid, between 1 and 15, inclusive.
## Syntax reference
## Fields:
## 1. Seconds: 0-59 * / , -
## 1. Minutes: 0-59 * / , -
## 1. Hours: 0-23 * / , -
## 1. Day of month: 1-31 * / , - L W
## 1. Month: 1-12 JAN-DEC * / , -
## 1. Day of week: 0-6 SUN-SAT * / , - L #
## 1. Year: 1970-2099 * / , -
##
## Special characters:
## 1. *: all values in the fields, e.g. * in seconds fields indicates every second
## 1. /: increments of ranges, e.g. 3-59/15 in the minute field indicate the third minute of the hour and every 15 minutes thereafter
## 1. ,: separate items of a list, e.g. MON,WED,FRI in day of week
## 1. -: range, e.g. 2010-2018 indicates every year between 2010 and 2018, inclusive
## 1. L: last, e.g. When used in the day-of-week field, it allows you to specify constructs such as "the last Friday" (5L) of a given month. In the day-of-month field, it specifies the last day of the month.
## 1. W: business day, e.g. if you were to specify 15W as the value for the day-of-month field, the meaning is: "the nearest business day to the 15th of the month."
## 1. #: requires a number between one and five. It allows you to specify constructs such as "the second Friday" of a given month.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_add_user_permissions_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes user permissions
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions
##
## Delete User Permission
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_user_permission_bulk_v3(
	namespace_param: String, user_id: String, body: Array = []
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


## Deletes a permission from a user
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/permissions/{resource}/{action}
##
## Delete User Permission
##
## Parameters:
## - action: Action (1..15)
## - namespace_param: Game namespace
## - resource: Resource Name
## - user_id: AccelByte user ID
func admin_delete_user_permission_v3(
	action: int, namespace_param: String, resource: String, user_id: String
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


## Lists platform accounts linked to a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms
##
## Lists platform accounts linked to the user account.
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - _oidc platform id_
##
## Note:
## - Specify either the platform ID or platform group as the **platformId** parameter.
## - **Nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. Example: kmzwa8awaa:dd1
##
## ## Justice Platform Account
## The permission 'ADMIN:NAMESPACE:{namespace}:JUSTICE:USER:{userId}' [READ] is required to read the linked UserID.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
## - platform_id: Third-party platform identifier
## - target_namespace: Target Namespace, query platform account on specific namespace
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


## Lists distinct third-party platforms linked to a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/distinct
##
## Retrieves distinct third-party platform accounts linked to the user, grouped by platform. For duplicate platforms, the service returns the oldest linked account.
## ------
## Supported status:
## - LINKED
## - RESTRICTIVELY_UNLINKED
## - UNLINKED
## - ALL
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - status: Link status to filter results by. Valid values: LINKED, RESTRICTIVELY_UNLINKED, UNLINKED, ALL.
func admin_list_all_distinct_platform_accounts_v3(
	namespace_param: String, user_id: String, status: String = ""
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


## Lists Justice platform accounts for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice
##
## Lists Justice platform accounts associated with the given publisher namespace and publisher user ID.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_list_justice_platform_accounts(
	namespace_param: String, user_id: String
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


## Retrieves the namespace user ID mapping for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}
##
## Retrieves the user ID mapping between publisher and game namespaces.
## If targetNamespace is a publisher namespace, returns the publisher user ID and namespace.
## If targetNamespace is a game namespace, returns the game user ID and namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - target_namespace: Namespace to retrieve the corresponding user ID for.
## - user_id: AccelByte user ID
## - create_if_not_found: Create target namespace account if not found
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


## Creates a Justice user from a publisher user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/justice/{targetNamespace}
##
## Create Justice User from Publisher User information. It will check first if Justice User on target namespace already exist.
##
## Parameters:
## - namespace_param: Game namespace
## - target_namespace: Namespace in which to create the Justice user.
## - user_id: AccelByte user ID
func admin_create_justice_user(
	namespace_param: String, target_namespace: String, user_id: String
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


## Links a platform account to a user
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/link
##
## Force-links a third-party platform account to a user, bypassing default conflict restrictions.
## By default, the service disallows the following cases:
## - The platform account already links to another user account.
## - The target account previously linked a different account on this platform.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - skip_conflict: Whether to unlink the platform account from its current account and force-link it to this user. Defaults to true.
func admin_link_platform_account(
	namespace_param: String, user_id: String, skip_conflict: bool = false, body: Dictionary = {}
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


## Lists platform link history for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/link/histories
##
## Retrieves the platform link history for a user.
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - _oidc platform id_
##
## Note:
## - Specify either the platform ID or platform group as the **platformId** parameter.
## - **Nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. Example: kmzwa8awaa:dd1
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - platform_id: Third-party platform identifier
func admin_get_user_link_histories_v3(
	namespace_param: String, user_id: String, platform_id: String
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


## Unlinks a user's account from a platform across all namespaces
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/all
##
## Unlinks the user's account from a third-party platform across all namespaces.
## Several platforms are grouped under account groups; specify either the platform ID or platform group as the `platformId` path parameter.
## Example: to unlink a steam account, use steamnetwork, steam, or steamopenid as the `platformId`.
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - _oidc platform id_
##
## Note:
## - Specify either the platform ID or platform group as the **platformId** parameter.
## - **Nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. Example: kmzwa8awaa:dd1
##
## Unlinking a platform account associated with a group also unlinks all other platform accounts in that group.
## Example: unlinking from ps4 also unlinks ps5 and ps4web.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - user_id: AccelByte user ID
func admin_platform_unlink_all_v3(
	namespace_param: String, platform_id: String, user_id: String
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


## Links a user's account to a platform
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link
##
## **Prerequisite:** Platform client configuration must be set up for the specified `platformId`. Specify the Namespace service URL.
## ## Supported platforms:
## - **steam**: The ticket's value is the authentication code returned by Steam.
## - **steamopenid**: Steam's user authentication method using OpenID 2.0. The ticket's value is the URL generated by Steam on web authentication.
## - **facebook**: The ticket's value is the authorization code returned by Facebook OAuth.
## - **google**: The ticket's value is the authorization code returned by Google OAuth.
## - **googleplaygames**: The ticket's value is the authorization code returned by Google play games OAuth.
## - **oculus**: The ticket's value is a string composed of Oculus's user ID and the nonce separated by a colon (:).
## - **twitch**: The ticket's value is the authorization code returned by Twitch OAuth.
## - **android**: The ticket's value is the Android device ID.
## - **ios**: The ticket's value is the iOS device ID.
## - **apple**: The ticket's value is the authorization code returned by Apple OAuth.
## - **device**: Every device that doesn't run Android and iOS is categorized as a device platform. The ticket's value is the device's ID.
## - **discord**: The ticket's value is the authorization code returned by Discord OAuth.
## - **awscognito**: The ticket's value is the AWS Cognito access token (JWT).
## - **epicgames**: The ticket's value is an access token obtained from Epicgames EOS Account Service.
## - **nintendo**: The ticket's value is the authorization code (id_token) returned by Nintendo OAuth.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - user_id: AccelByte user ID
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - ticket: Ticket from platform
func admin_platform_link_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	ticket: String,
	app_id: String = ""
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
	if not app_id.is_empty():
		form_data["appId"] = app_id
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes a user's platform linking restriction
## DELETE /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/link/restrictions
##
## Removes the linking restriction for the user on the specified platform.
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - _oidc platform id_
##
## Note:
## - Specify either the platform ID or platform group as the **platformId** parameter.
## - **Nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. Example: kmzwa8awaa:dd1
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - user_id: AccelByte user ID
func admin_delete_user_linking_restriction_by_platform_idv3(
	namespace_param: String, platform_id: String, user_id: String
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


## Checks the link status of a third-party platform token
## POST /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/linkStatus
##
## Checks whether the third-party user represented by the platform token is linked to the corresponding user ID.
##
## ## Supported platforms:
## - **steam**: The platform_token's value is the authentication code returned by Steam.
## - **steamopenid**: Steam's user authentication method using OpenID 2.0. The platform_token's value is the URL generated by Steam on web authentication.
## - **facebook**: The platform_token's value is the authorization code returned by Facebook OAuth.
## - **google**: The platform_token's value is the authorization code returned by Google OAuth.
## - **googleplaygames**: The platform_token's value is the authorization code returned by Google play games OAuth.
## - **oculus**: The platform_token's value is a string composed of Oculus's user ID and the nonce separated by a colon (:).
## - **twitch**: The platform_token's value is the authorization code returned by Twitch OAuth.
## - **discord**: The platform_token's value is the authorization code returned by Discord OAuth.
## - **android**: The device_id is the Android device ID.
## - **ios**: The device_id is the iOS device ID.
## - **apple**: The platform_token's value is the authorization code returned by Apple OAuth.
## - **device**: Every device that doesn't run Android and iOS is categorized as a device. The device_id is the device's ID.
## - **justice**: The platform_token's value is the designated user's access token.
## - **epicgames**: The platform_token's value is an access token obtained from Epicgames EOS Account Service.
## - **ps4**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **ps5**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **nintendo**: The platform_token's value is the authorization code (id_token) returned by Nintendo OAuth.
## - **awscognito**: The platform_token's value is the AWS Cognito access token or ID token (JWT).
## - **live**: The platform_token's value is the Xbox XSTS token.
## - **xblweb**: The platform_token's value is the code returned by Xbox after login.
## - **netflix**: The platform_token's value is the GAT (Gamer Access Token) returned by Netflix.
## - **snapchat**: The platform_token's value is the authorization code returned by Snapchat OAuth.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - user_id: AccelByte user ID
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - platform_token: Authentication token from the third-party platform.
func admin_get_third_party_platform_token_link_status_v3(
	namespace_param: String,
	platform_id: String,
	user_id: String,
	platform_token: String,
	app_id: String = ""
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
	if not app_id.is_empty():
		form_data["appId"] = app_id
	if not platform_token.is_empty():
		form_data["platformToken"] = platform_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves platform account metadata for a user
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/metadata
##
## Retrieves platform account metadata for a user.
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - _oidc platform id_
##
## Note:
## - Specify either the platform ID or platform group as the **platformId** parameter.
## - **Nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. Example: kmzwa8awaa:dd1
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - user_id: AccelByte user ID
## - cross_namespace: Whether to search across all namespaces. When true, searches all namespaces and returns the first match. Defaults to false.
func admin_get_user_single_platform_account(
	namespace_param: String, platform_id: String, user_id: String, cross_namespace: bool = false
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


## Replaces the roles assigned to a user
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/roles
##
## Replaces the user's roles with those specified.
## An admin user can only assign a role with a namespace if they have the same permission required by the AdminAddUserRoleV4 operation.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_save_user_role_v3(
	namespace_param: String, user_id: String, body: Array = []
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


## Retrieves the state of a user account
## GET /iam/v3/admin/namespaces/{namespace}/users/{userId}/state
##
## Admin Get User State By User Id
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_state_by_user_id_v3(namespace_param: String, user_id: String) -> Dictionary:
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


## Enables or disables a user account
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/status
##
## Enables or disables a user account. Set enabled to true to enable the account or false to disable it.
## When disabling for **Account Disable** purpose, provide a reason:
## - **AdminDeactivateAccount**: when the disable request comes from an admin
##
## The service ignores the reason field when enabling an account.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_status_v3(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Updates a user's identity without email notification
## PATCH /iam/v3/admin/namespaces/{namespace}/users/{userId}/trustly/identity
##
## Updates a user's identity (email or password) using a Client Token only, when email notifications are off.
## The service marks the user's email as verified.
##
## Note:
## - emailAddress and password fields are both optional.
## - At least one field is required.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_trustly_update_user_identity(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Verifies a user account
## PUT /iam/v3/admin/namespaces/{namespace}/users/{userId}/verify
##
## Force-verifies a user account without a verification code.
## Note:
## - namespace: only accepts publisher/studio namespace.
## - userId: only accepts publisher/studio user IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_verify_user_without_verification_code_v3(
	namespace_param: String, user_id: String
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


## Updates the secret for an OAuth client
## PUT /iam/v3/admin/namespaces/{namespace}/{clientId}/secret
##
## Update Client Secret
##
## Parameters:
## - client_id: OAuth client ID
## - namespace_param: Game namespace
func admin_update_client_secret_v3(
	client_id: String, namespace_param: String, body: Dictionary = {}
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


## Checks the availability of a third-party platform
## GET /iam/v3/admin/platforms/{platformId}/availability
##
## This is the API to check specific 3rd party platform availability.
## Passing platform group name or it's member will return same platform availability data
## Supported third party platform and platform group:
## - PSN group(psn)
## - ps4web
## - ps4
## - ps5
##
## Parameters:
## - platform_id: Third-party platform identifier
func admin_check_third_party_login_platform_availability_v3(platform_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/platforms/{platformId}/availability"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Get Third Party Platform Defaults
## GET /iam/v3/admin/platforms/{platformId}/defaults
##
## Returns the built-in default configuration values for a given platform.
##
## Parameters:
## - platform_id: Platform ID
func get_third_party_login_platform_defaults_v3(platform_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/platforms/{platformId}/defaults"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists available roles
## GET /iam/v3/admin/roles
##
## Returns a paginated list of roles for the namespace.
##
## Parameters:
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - is_wildcard: - true if the expected result should only returns records with wildcard = true - false if the expected result should only returns records with wildcard = false - empty (omitted) if the expected result should returns records with no wildcard filter at all
## - limit: Number of results to return
func admin_get_roles_v3(
	after: String = "", before: String = "", is_wildcard: bool = false, limit: int = -1
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


## Creates a new role
## POST /iam/v3/admin/roles
##
## Creates a new role with the specified name, permissions, and settings.
## - roleName: alphanumeric, no special characters (required).
## - permissions: permissions to assign to the role.
## - managers: users who manage this role.
## - members: users who are members of this role.
## - adminRole: whether the role is for admin users (default false).
## - isWildcard: whether the role can be assigned to a wildcard (*) namespace (default false).
## - `deletable`: whether the role can be deleted (default true).
func admin_create_role_v3(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a role by ID
## GET /iam/v3/admin/roles/{roleId}
##
## Returns the specified role details.
##
## Parameters:
## - role_id: IAM role ID
func admin_get_role_v3(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a role
## DELETE /iam/v3/admin/roles/{roleId}
##
## Deletes the specified role.
##
## Parameters:
## - role_id: IAM role ID
func admin_delete_role_v3(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a role
## PATCH /iam/v3/admin/roles/{roleId}
##
## Updates the specified role.
## - roleName: alphanumeric, no special characters (required).
## - isWildcard: whether the role can be assigned to a wildcard (*) namespace (default false).
## - `deletable`: whether the role can be deleted (optional).
##
## Parameters:
## - role_id: IAM role ID
func admin_update_role_v3(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves the admin status of a role
## GET /iam/v3/admin/roles/{roleId}/admin
##
## Admin roles has its members listed in the role.
##
## Parameters:
## - role_id: IAM role ID
func admin_get_role_admin_status_v3(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Marks a role as an admin role
## POST /iam/v3/admin/roles/{roleId}/admin
##
## Marks a role as an admin role. Admin roles list their members within the role.
## A role becomes an admin role only when it has at least one manager.
##
## Parameters:
## - role_id: IAM role ID
func admin_update_admin_role_status_v3(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes the admin status from a role
## DELETE /iam/v3/admin/roles/{roleId}/admin
##
## Code: 10413
##
## Parameters:
## - role_id: IAM role ID
func admin_remove_role_admin_v3(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/admin"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists the managers of a role
## GET /iam/v3/admin/roles/{roleId}/managers
##
## Lists users who manage this role. Only the role's manager can assign the role to other users.
##
## Parameters:
## - role_id: IAM role ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
func admin_get_role_managers_v3(
	role_id: String, after: String = "", before: String = "", limit: int = -1
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


## Adds managers to a role
## POST /iam/v3/admin/roles/{roleId}/managers
##
## Adds users as managers of this role. Only the role's managers can assign the role to other users.
##
## Parameters:
## - role_id: IAM role ID
func admin_add_role_managers_v3(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes managers from a role
## DELETE /iam/v3/admin/roles/{roleId}/managers
##
## Removes the specified managers from a role. Only the role's manager can assign the role to other users.
##
## Parameters:
## - role_id: IAM role ID
func admin_remove_role_managers_v3(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/managers"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists the members of a role
## GET /iam/v3/admin/roles/{roleId}/members
##
## Admin roles has its members listed in the role.
##
## Parameters:
## - role_id: IAM role ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
func admin_get_role_members_v3(
	role_id: String, after: String = "", before: String = "", limit: int = -1
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


## Adds members to a role
## POST /iam/v3/admin/roles/{roleId}/members
##
## Adds members to this role. Admin roles list their members within the role. Only the role's managers can assign the role to other users.
##
## Parameters:
## - role_id: IAM role ID
func admin_add_role_members_v3(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/members"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Replaces a role's permissions
## PUT /iam/v3/admin/roles/{roleId}/permissions
##
## Replaces the role's permissions with those specified.
##
## Special characters:
## 1. *: all values in the fields, e.g. * in seconds fields indicates every second
## 1. /: increments of ranges, e.g. 3-59/15 in the minute field indicate the third minute of the hour and every 15 minutes thereafter
## 1. ,: separate items of a list, e.g. MON,WED,FRI in day of week
## 1. -: range, e.g. 2010-2018 indicates every year between 2010 and 2018, inclusive
## 1. L: last, e.g. When used in the day-of-week field, it allows you to specify constructs such as "the last Friday" (5L) of a given month. In the day-of-month field, it specifies the last day of the month.
## 1. W: business day, e.g. if you were to specify 15W as the value for the day-of-month field, the meaning is: "the nearest business day to the 15th of the month."
## 1. #: requires a number between one and five. It allows you to specify constructs such as "the second Friday" of a given month.
##
## Parameters:
## - role_id: IAM role ID
func admin_update_role_permissions_v3(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Adds permissions to the role
## POST /iam/v3/admin/roles/{roleId}/permissions
##
## Adds the specified permissions to the role.
##
## Special characters:
## 1. *: all values in the fields, e.g. * in seconds fields indicates every second
## 1. /: increments of ranges, e.g. 3-59/15 in the minute field indicate the third minute of the hour and every 15 minutes thereafter
## 1. ,: separate items of a list, e.g. MON,WED,FRI in day of week
## 1. -: range, e.g. 2010-2018 indicates every year between 2010 and 2018, inclusive
## 1. L: last, e.g. When used in the day-of-week field, it allows you to specify constructs such as "the last Friday" (5L) of a given month. In the day-of-month field, it specifies the last day of the month.
## 1. W: business day, e.g. if you were to specify 15W as the value for the day-of-month field, the meaning is: "the nearest business day to the 15th of the month."
## 1. #: requires a number between one and five. It allows you to specify constructs such as "the second Friday" of a given month.
##
## Parameters:
## - role_id: IAM role ID
func admin_add_role_permissions_v3(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes permissions from a role
## DELETE /iam/v3/admin/roles/{roleId}/permissions
##
## Removes the specified permissions from a role.
##
## Parameters:
## - role_id: IAM role ID
func admin_delete_role_permissions_v3(role_id: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Removes a permission from a role
## DELETE /iam/v3/admin/roles/{roleId}/permissions/{resource}/{action}
##
## Deletes a specific permission from the role.
##
## Parameters:
## - action: Action, value must be in range 1-15
## - resource: Resource Name
## - role_id: IAM role ID
func admin_delete_role_permission_v3(action: int, resource: String, role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/roles/{roleId}/permissions/{resource}/{action}"
	url_path = url_path.replace("{" + "action" + "}", str(action).uri_encode())
	url_path = url_path.replace("{" + "resource" + "}", resource.uri_encode())
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the current user account
## GET /iam/v3/admin/users/me
##
## Get my user data
func admin_get_my_user_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/admin/users/me"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Authenticates a user account
## POST /iam/v3/authenticate
##
## Authenticates a user account by validating email or username and password.
## Deactivated or login-banned users cannot log in.
## Specify Redirect URI and Client ID as a pair; the service uses them to redirect to the specified URI only when the `requestId` expires.
##
## ## Device Cookie Validation
##
## Device Cookie protects the user account from brute force login attacks, [more detail from OWASP](https://owasp.org/www-community/Slow_Down_Online_Guessing_Attacks_with_Device_Cookies).
## Reads device cookie from cookie **auth-trust-id**. When no device cookie is present, generates a new one and sets it as a cookie on successful authentication.
##
## Parameters:
## - client_id: OAuth client ID of the application.
## - extend_exp: Whether to extend the refresh token lifetime.
## - redirect_uri: URI to redirect to after successful authentication.
## - password: Account password
## - request_id: OAuth authorization request ID from the login flow.
## - user_name: Account username
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


## Authenticates a user and links a platform account
## POST /iam/v3/authenticateWithLink
##
## Authenticates a user account and links a platform account.
## It validates user's email / username and password.
## When 2FA is enabled, invoke `/mfa/verify` using the **mfa_token** from this operation's response.
##
## ## Device Cookie Validation
##
## Device Cookie protects the user account from brute force login attacks, [more detail from OWASP](https://owasp.org/www-community/Slow_Down_Online_Guessing_Attacks_with_Device_Cookies).
## Reads device cookie from cookie **auth-trust-id**. When no device cookie exists, the service generates a new one and sets it as a cookie on successful authentication.
##
## Parameters:
## - extend_exp: Whether to extend the refresh token lifetime.
## - client_id: OAuth client ID of the application.
## - linking_token: Platform linking Token
## - password: Account password
## - username: Account username
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Authenticates a user and links a platform account with a redirect response
## POST /iam/v3/authenticateWithLink/forward
##
## Authenticates a user account and links a platform account, returning a forward redirect response.
## It validates user's email / username and password.
## When 2FA is enabled, invoke `/mfa/verify` using the **mfa_token** from this operation's response.
##
## ## Device Cookie Validation
##
## Device Cookie protects the user account from brute force login attacks, [more detail from OWASP](https://owasp.org/www-community/Slow_Down_Online_Guessing_Attacks_with_Device_Cookies).
## Reads device cookie from cookie **auth-trust-id**. When no device cookie exists, the service generates a new one and sets it as a cookie on successful authentication.
##
## Parameters:
## - extend_exp: Whether to extend the refresh token lifetime.
## - client_id: OAuth client ID of the application.
## - linking_token: Platform linking Token
## - password: Account password
## - username: Account username
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves public system configuration values
## GET /iam/v3/config/public
##
## Retrieves publicly accessible system configuration values.
func public_get_system_config_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/config/public"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a headless account and returns a token
## POST /iam/v3/headless/token
##
## Creates a headless account after third-party platform authentication, and returns a token.
## The `linkingToken` comes from "/platforms/{platformId}/token" when the third-party platform account is not yet linked to a Justice account.
##
## Parameters:
## - additional_data: Supplemental metadata sent with the login success event.
## - extend_exp: Whether to extend the refresh token lifetime.
## - linking_token: Platform linking Token
func generate_token_by_new_headless_account_v3(
	linking_token: String, additional_data: String = "", extend_exp: bool = false
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Generates a one-time account linking code
## POST /iam/v3/link/code/request
##
## Generates an 8-character one-time code for a headless account to link or upgrade to a full account.
## Should specify the target platform id and current user should already linked to this platform.
## Current user should be a headless account.
## ## Supported platforms:
## - **steam**
## - **steamopenid**
## - **facebook**
## - **google**
## - **googleplaygames**
## - **oculus**
## - **twitch**
## - **discord**
## - **android**
## - **ios**
## - **apple**
## - **device**
## - **justice**
## - **epicgames**
## - **ps4**
## - **ps5**
## - **nintendo**
## - **awscognito**
## - **live**
## - **xblweb**
## - **netflix**
## - **snapchat**
##
## Parameters:
## - redirect_uri: URI to redirect to after the linking flow completes.
## - state: Opaque value to maintain state between the request and the callback.
## - platform_id: Third-party platform identifier
func request_one_time_linking_code_v3(
	platform_id: String, redirect_uri: String = "", state: String = ""
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Validates a one-time account linking code
## POST /iam/v3/link/code/validate
##
## Validates a one-time account linking code.
##
## Parameters:
## - one_time_link_code: One time linking code
func validate_one_time_linking_code_v3(one_time_link_code: String) -> Dictionary:
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


## Issues a user token for a one-time linking code
## POST /iam/v3/link/token/exchange
##
## Generates a user token by exchanging a one-time account linking code.
## It requires a code generated by `/iam/v3/link/code/request` or `/iam/v3/public/users/me/link/forward`.
##
## Supports creating a transient token using the **isTransient** parameter:
## **isTransient=true** generates a transient token with a short lifetime and no refresh token.
## **isTransient=false** consumes the one-time code and generates the access token with a refresh token.
##
## Parameters:
## - additional_data: Supplemental metadata sent with the login success event.
## - is_transient: Will produce transient token
## - client_id: OAuth client ID of the application.
## - one_time_link_code: One time linking code
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Retrieves the country based on request location
## GET /iam/v3/location/country
##
## Retrieves the country location based on the request IP address.
func get_country_location_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/location/country"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Logs out the current user
## POST /iam/v3/logout
##
## Removes the **access_token** and **refresh_token** from cookies.
func logout() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/logout"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Requests a code for cross-namespace token exchange
## POST /iam/v3/namespace/{namespace}/token/request
##
## Requests a code to exchange for a new token in a different namespace.
## The target new token's `clientId` must differ from the current one.
## Set the path namespace to the target namespace.
## Client ID should match the target namespace.
##
## The code in the response can be exchanged at `/iam/v3/token/exchange`.
##
## Parameters:
## - namespace_param: Game namespace
## - code_challenge: Value generated by transforming code verifier using code challenge method.
## - code_challenge_method: Method used to transform the code verifier into the code challenge. Valid values: plain, S256.
## - client_id: Client ID for target namespace
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a third-party platform token for a user
## GET /iam/v3/oauth/admin/namespaces/{namespace}/users/{userId}/platforms/{platformId}/platformToken
##
## Retrieves the third-party platform token for a user authenticated via that platform.
## When the user has not linked the requested platform in the game namespace, the service retrieves the token from the publisher namespace.
## Passing a platform group name or its member returns the same access token, usable across all platform members.
## When `platformUserId` is included, the service uses the platform user ID to retrieve the token.
##
## Notes:
## The third-party platform and platform group covered for this operation:
## - (psn) ps4web
## - (psn) ps4
## - (psn) ps5
## - epicgames
## - twitch
## - awscognito
## - amazon
## - eaorigin
## - snapchat
## - twitch
## - live
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - user_id: AccelByte user ID
## - platform_user_id: User identifier on the third-party platform
func admin_retrieve_user_third_party_platform_token_v3(
	namespace_param: String, platform_id: String, user_id: String, platform_user_id: String = ""
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


## Revokes user's tokens
## POST /iam/v3/oauth/admin/namespaces/{namespace}/users/{userId}/revoke
##
## Revokes all access tokens and refresh tokens for a user, issued before the revocation time.
## Use this to invalidate all tokens generated before a specific point in time.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - include_game_namespace: This queryParameter only works when utilizing userID and namespace publisher. If true, the system will revoke all game account under the publisher account.
func revoke_user_v3(
	namespace_param: String, user_id: String, include_game_namespace: bool = false
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _revoke_callback.is_valid():
		_revoke_callback.call()
	return _result


## Starts the OAuth 2.0 authorization flow
## GET /iam/v3/oauth/authorize
##
## Initializes the OAuth 2.0 authorization code flow.
## Stores the authorization request and redirects to the login page with the authorization request ID.
## The user authenticates on the login page; on success, the authorization server redirects them back to the requesting client with an authorization code on success.
##
## Only the authorization code flow is supported; the implicit flow is not supported.
## - **Authorize success**:
## redirects to login page with the following information: ?request_id={authorization_request_id}
## - **Authorize failure**:
## redirects to the given redirect URI with the following information:
## ?error={error_code}&error;_description={error description}
##
## For public clients, fill **code_challenge** to prevent authorization code interception attacks.
## See the RFC for Proof Key for Code Exchange (PKCE): https://datatracker.ietf.org/doc/html/rfc7636
##
## Error codes based on the specification:
## - invalid_request: The request is missing a required parameter,
## includes an invalid parameter value, includes a parameter more than once, or is otherwise malformed.
## - server_error:
## The authorization server encountered an unexpected condition that prevented it from fulfilling the request.
## - unauthorized_client: The client is not authorized to request a token using this method.
## - access_denied: The resource owner or authorization server denied the request.
## - invalid_scope: The requested scope is invalid, unknown, or malformed.
## - unsupported_response_type: The authorization server does not support obtaining a token using this method.
## - temporarily_unavailable: The authorization server is currently unable to handle the request
## due to a temporary overloading or maintenance of the server.
## See the RFC for more information about the authorization code flow: https://tools.ietf.org/html/rfc6749#section-4.1
##
## Parameters:
## - blocked_platform_id: Platform ID to block from the login page, such as the platform used to generate a one-time link.
## - code_challenge: Value generated by transforming code verifier using code challenge method. Mandatory for public client.
## - code_challenge_method: Method used to transform the code verifier into the code challenge. Valid values: plain, S256.
## - create_headless: If create new headless account when login by new third platform user
## - issuer_namespace: Opt-in to the per-namespace issuer. Must equal the client's namespace. When set, the RFC 9207 'iss' parameter on the authorization response and the 'iss' claim of every token in the grant chain carry the namespaced issuer ({baseUri}/{namespace}) instead of the base URI. Embedded in the authorization_endpoint advertised by the namespaced OAuth AS metadata; not intended to be set manually.
## - login_web_based: If need use new login web based OAuth flow
## - nonce: The nonce parameter complies with the OIDC standard documentation: https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest
## - one_time_link_code: One-time link code for a headless account to link. Obtained from /iam/v3/link/code/request.
## - redirect_uri: URI to redirect to after authentication. Required when the client has more than one registered redirect URI.
## - scope: Requested access scopes, separated by whitespace.
## - state: Random value for preventing cross-site request forgery used by client.
## - target_auth_page: Custom query to tell authorization web which page to present to user
## - use_redirect_uri_as_login_url_when_locked: Use Redirect URI as the Login URL after resetting password when got locked
## - client_id: Registered client ID
## - response_type: Supported response type : 'code'
func authorize_v3(
	client_id: String,
	response_type: String,
	blocked_platform_id: String = "",
	code_challenge: String = "",
	code_challenge_method: String = "",
	create_headless: bool = false,
	issuer_namespace: String = "",
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
	if not issuer_namespace.is_empty():
		query_params["issuerNamespace"] = issuer_namespace
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


## OAuth2 consent details API
## GET /iam/v3/oauth/consent
##
## Returns the details the consent page renders for an authorization awaiting user consent:
## the client's hostname (primary identity), display name (untrusted), and requested scopes.
## The request_id is the one issued by the authorize endpoint; the authorization must have been
## parked for consent by a completed login.
##
## Parameters:
## - request_id: Authorization request id awaiting consent
func get_consent_details_v3(request_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/consent"
	# Build query parameters
	var query_params: Dictionary = {}
	if not request_id.is_empty():
		query_params["request_id"] = request_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## OAuth2 consent decision API
## POST /iam/v3/oauth/consent
##
## Records the user's approve/deny decision for an authorization awaiting consent.
## On accept: the grant is persisted for future authorizations (per user and client, covering the
## requested scopes) and the flow resumes â the response redirects to the client's redirect_uri
## carrying the authorization code. On deny: the response redirects to the client's redirect_uri
## with error=access_denied (RFC 6749 section 4.1.2.1).
##
## Parameters:
## - decision: accept or deny
## - request_id: Authorization request id awaiting consent
func consent_v3(decision: String, request_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/consent"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not decision.is_empty():
		form_data["decision"] = decision
	if not request_id.is_empty():
		form_data["request_id"] = request_id
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Returns information about an access token
## POST /iam/v3/oauth/introspect
##
## Returns information about an access token for validation by resource servers.
##
## Parameters:
## - token: Access Token / Refresh Token
func token_introspection_v3(token: String) -> Dictionary:
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


## Retrieves the JSON Web Key Set for JWT verification
## GET /iam/v3/oauth/jwks
##
## Serves the public key set for verifying JWT access tokens.
## When a client application wants to verify a JWT token, it needs to get the 'kid' value found in the JWT token header and use it
## to look up the corresponding public key from a set returned by this operation. The client application can then use that public key to verify the JWT.
## A client application might cache the keys so it doesn't need to make a request each time it verifies a JWT token. When the cache does not contain a key with the matching 'kid', the application should refresh the keys by calling this operation again.
## See the RFC for more information about JWK (JSON Web Key): https://tools.ietf.org/html/rfc7517
func get_jwksv3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/jwks"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Sends a two-factor authentication code
## POST /iam/v3/oauth/mfa/code
##
## Sends a two-factor authentication code to the user.
##
## Parameters:
## - client_id: OAuth client ID
## - factor: 2FA method to use for sending the code. Valid values: authenticator, backupCode, email.
## - mfa_token: MFA token from the authentication step.
func send_mfa_authentication_code(
	client_id: String, factor: String, mfa_token: String
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates the active 2FA method
## POST /iam/v3/oauth/mfa/factor/change
##
## Changes the active 2FA method for the user. Only enabled methods are valid.
## Supported methods:
## - authenticator
## - `backupCode`
## - email
##
## Parameters:
## - factor: 2FA method to set as active. Valid values: authenticator, backupCode, email.
## - mfa_token: MFA token from the authentication step.
func change2fa_method(factor: String, mfa_token: String) -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Verifies a 2FA code
## POST /iam/v3/oauth/mfa/verify
##
## Verifies a 2FA code.
## ## 2FA remember device
## To remember device for 2FA, should provide cookie: device_token or header: Device-Token
##
## Parameters:
## - code: 2FA verification code.
## - factor: 2FA method used to generate the code. Valid values: authenticator, backupCode, email.
## - mfa_token: MFA token from the authentication step.
## - remember_device: Whether to remember this device for future 2FA logins.
func verify2fa_code(
	code: String, factor: String, mfa_token: String, remember_device: bool
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Verifies a 2FA code with redirect on result
## POST /iam/v3/oauth/mfa/verify/forward
##
## Forward version of /mfa/verify that redirects on error or forwards on success.
## If there is any error, redirects to the login page with error details. If successful, forwards to the auth redirect URL.
## Verifies a 2FA code.
## ## 2FA remember device
## To remember device for 2FA, provide cookie: device_token or header: Device-Token
##
## Parameters:
## - default_factor: Default 2FA method for the user.
## - factors: Enabled 2FA methods available to the user.
## - remember_device: Whether to remember this device for future 2FA logins.
## - client_id: OAuth client ID
## - code: 2FA verification code.
## - factor: 2FA method used to generate the code. Valid values: authenticator, backupCode, email.
## - mfa_token: MFA token from the authentication step.
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## [Dynamic client register] Register Client
## POST /iam/v3/oauth/namespace/{namespace}/register
##
## Implements OAuth 2.0 Dynamic Client Registration Management Protocol as defined in RFC 7591.
##
## Enables public users to register with an authorization server, obtaining an OAuth client dynamically without manual intervention.
##
## ð Standards Compliance: This API fully conforms to RFC 7591 specifications for OAuth 2.0 Dynamic Client Registration.
##
## â ï¸ Security Notice: Protected by IP-based rate limiting to prevent abuse while maintaining RFC 7591 compliance.
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
func o_auth_dynamic_client_register_with_namespace_v3(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/namespace/{namespace}/register"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a third-party platform token for a user
## GET /iam/v3/oauth/namespaces/{namespace}/users/{userId}/platforms/{platformId}/platformToken
##
## Retrieves the third-party platform token for a user authenticated via that platform.
## If the user has not linked the requested platform in the game namespace, retrieves the token from the publisher namespace instead.
## Passing a platform group name or any of its members returns the same access token, usable across all platform members.
##
## The third-party platforms and platform groups covered:
## - (psn) ps4web
## - (psn) ps4
## - (psn) ps5
## - epicgames
## - twitch
## - awscognito
## - amazon
## - `eaorigin`
## - snapchat
## - twitch
## - live
##
## **Authentication:**
## The _**userId**_ parameter must match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - user_id: AccelByte user ID
func retrieve_user_third_party_platform_token_v3(
	namespace_param: String, platform_id: String, user_id: String
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


## Generates a URL to request an auth code from a third-party platform
## GET /iam/v3/oauth/platforms/{platformId}/authorize
##
## Generates a URL to request an authorization code from a third-party platform.
## ## Supported platforms:
## - **`steamopenid`** Redirects to the Steam login page, then redirects back to the platform authentication callback after successfully authenticating the Steam user.
## - **xblweb** Redirects to the Xbox login page, then redirects back to the platform authentication callback after successfully authenticating the Xbox user.
## - **ps4web** Redirects to the PSN login page, then redirects back to the platform authentication callback after successfully authenticating the PSN user.
## - **epicgames** Redirects to the Epic Games OAuth login page, then redirects to the platform authentication callback after successfully authenticating the Epic Games credential.
## - **twitch** Redirects to the Twitch login page, then redirects back to the platform authentication callback after successfully authenticating the Twitch user.
## - **azure** Redirects to the Azure login page, then redirects back to the platform authentication (SAML) callback after successfully authenticating the Azure user.
## - **facebook** Redirects to the Facebook login page, then redirects back to the platform authentication callback after successfully authenticating the Facebook user.
## - **google** Redirects to the Google login page, then redirects back to the platform authentication callback after successfully authenticating the Google user.
## - **snapchat** Redirects to the Snapchat login page, then redirects back to the platform authentication callback after successfully authenticating the Snapchat user.
## - **discord** Redirects to the Discord login page, then redirects back to the platform authentication callback after successfully authenticating the Discord user.
## - **amazon** Redirects to the Amazon login page, then redirects back to the platform authentication callback after successfully authenticating the Amazon user.
## - **oculusweb** Redirects to the Oculus login page, then redirects to the Login Website after successfully authenticating the Oculus user.
##
## Parameters:
## - platform_id: Third-party platform identifier
## - client_id: OAuth client ID of the application.
## - redirect_uri: URI to redirect to after authorization.
## - request_id: Authorization request ID returned by the OAuth authorization flow.
func auth_code_request_v3(
	platform_id: String, request_id: String, client_id: String = "", redirect_uri: String = ""
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


## Grants an access token using a third-party platform token
## POST /iam/v3/oauth/platforms/{platformId}/token
##
## Grants an access token using a third-party platform token, such as Steam or Justice. Automatically creates an account if none exists for the given platform.
## All requests require an Authorization header with Basic access authentication
## constructed from the client ID and client secret. For publisher-game namespace schema : Specify only either platform_token or device_id. Request a device token grant with the `device_id` parameter against the game namespace. Request a third-party platform token grant with the `platform_token` parameter against the publisher namespace.
## ## 2FA remember device
## To remember device for 2FA, should provide cookie: device_token or header: Device-Token
## ## Supported platforms:
## - **steam**: The platform_token's value is the binary ticket returned by Steam.
## If this ticket was generated by Steam `GetAuthTicketForWebApi` with version >= 1.57, then platform token should use this style: `{identity}:{ticket}`, the `{identity}` was the parameter to call `GetAuthTicketForWebApi` when the ticket was created. Note: Do not contain `:` in this `{identity}`.
## - **steamopenid**: Steam's user authentication method using OpenID 2.0. The platform_token's value is URL generated by Steam on web authentication
## - **facebook**: The platform_token's value is the authorization code returned by Facebook OAuth
## - **google**: The platform_token's value is the authorization code or idToken returned by Google OAuth
## - **googleplaygames**: The platform_token's value is the authorization code or idToken returned by Google play games OAuth
## - **oculus**: The platform_token's value is a string composed of Oculus's user ID and the nonce separated by a colon (:).
## - **twitch**: The platform_token's value is the authorization code returned by Twitch OAuth.
## - **discord**: The platform_token's value is the authorization code returned by Discord OAuth
## - **android**: The device_id is the Android's device ID
## - **ios**: The device_id is the iOS's device ID.
## - **apple**: The platform_token's value is the authorization code or idToken returned by Apple OAuth.(We will use this code to generate APP token)
## - **device**: Every device that does'nt run Android and iOS is categorized as a device. The device_id is the device's ID.
## - **justice**: The platform_token's value is the designated user's access token.
## - **epicgames**: The platform_token's value is an access-token or authorization code obtained from Epicgames EOS Account Service.
## - **ps4**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **ps5**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **nintendo**: The platform_token's value is the id_token returned by Nintendo OAuth.
## - **awscognito**: The platform_token's value is the aws cognito access token or id token (JWT).
## - **live**: The platform_token's value is xbox XSTS token
## - **xblweb**: The platform_token's value is code returned by xbox after login
## - **netflix**: The platform_token's value is GAT (Gamer Access Token) returned by Netflix backend
## - **snapchat**: The platform_token's value is the authorization code returned by Snapchat OAuth.
## - **for specific generic oauth (OIDC)**: The platform_token's value should be the same type as created OIDC auth type whether it is auth code, idToken or bearerToken.
##
## ## Account Group
## Several platforms are grouped under account groups. The accounts on these platforms have the same platform user id.
## Login using one of these platform will returns the same IAM user.
## Following is the current registered account grouping:
## - Steam group(steamnetwork):
## - steam
## - steamopenid
## - PSN group(psn)
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox)
## - live
## - xblweb
## - Oculus group(oculusgroup)
## - oculus
## - oculusweb
##
## ## Access Token Content
## Following is the access token's content:
## - **namespace**. The namespace from which the service generated the token.
## - **display_name**. The display name of the sub. It is empty if the token is generated from the client credential
## - **roles**. The sub's roles. It is empty if the token is generated from the client credential
## - **namespace_roles**. The sub's roles scoped to namespace. Improvement from roles, which make the role scoped to specific namespace instead of global to publisher namespace
## - **permissions**. The sub or aud' permissions
## - **bans**. The sub's list of bans. It is used by the IAM client for validating the token.
## - **jflgs**. It stands for Justice Flags. It is a special flag used for storing additional status information regarding the sub. It is implemented as a bit mask. Following explains what each bit represents:
## - 1: Email Address Verified
## - 2: Phone Number Verified
## - 4: Anonymous
## - 8: Suspicious Login
## - **aud**. The aud is the client ID.
## - **iat**. The time the token issues at. It is in Epoch time format
## - **exp**. The time the token expires. It is in Epoch time format
## - **sub**. The UserID. The sub is omitted if the token is generated from client credential
##
## ## Bans
## The JWT contains user's active bans with its expiry date. List of ban types can be obtained from /bans.
##
## Parameters:
## - platform_id: Third-party platform identifier
## - additional_data: Metadata passed to the login success event.
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - client_id: Client ID, only accept UUID version 4 without hyphen
## - code_verifier: RFC 7636 PKCE code verifier. Required when the platform authorization code was requested with a code_challenge, as the Discord Social SDK does by default on Android and Meta Quest. Must be 43 to 128 unreserved characters.
## - create_headless: If directly create new account when not linked yet
## - device_id: Device/hardware identifier
## - mac_address: Mac address of device
## - platform_token: Token from platform auth
## - redirect_uri: The same redirect URI the client used when it requested the platform authorization code. Only read together with code_verifier, and required by platforms that verify the redirect URI at token exchange. Defaults to the redirect URI configured on the platform client when omitted.
## - service_label: PSN service label used to verify the app ID on PS5 and PS4.
## - skip_set_cookie: If need skip set cookie. Default is false
func platform_token_grant_v3(
	platform_id: String,
	additional_data: String = "",
	app_id: String = "",
	client_id: String = "",
	code_verifier: String = "",
	create_headless: bool = false,
	device_id: String = "",
	mac_address: String = "",
	platform_token: String = "",
	redirect_uri: String = "",
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
	if not app_id.is_empty():
		form_data["appId"] = app_id
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not code_verifier.is_empty():
		form_data["code_verifier"] = code_verifier
	form_data["createHeadless"] = "true" if create_headless else "false"
	if not device_id.is_empty():
		form_data["device_id"] = device_id
	if not mac_address.is_empty():
		form_data["macAddress"] = mac_address
	if not platform_token.is_empty():
		form_data["platform_token"] = platform_token
	if not redirect_uri.is_empty():
		form_data["redirect_uri"] = redirect_uri
	if service_label >= 0.0:
		form_data["serviceLabel"] = str(service_label)
	form_data["skipSetCookie"] = "true" if skip_set_cookie else "false"
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var _cid: String = client_id if not client_id.is_empty() else _client_id
	var _csecret: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(_cid, _csecret)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Retrieves the token and user revocation list
## GET /iam/v3/oauth/revocationlist
##
## Returns a list of revoked users and revoked tokens, with revoked tokens in Bloom filter format.
func get_revocation_list_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/revocationlist"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Revokes an access or refresh token
## POST /iam/v3/oauth/revoke
##
## Revokes a token, invalidating further use of the access or refresh token.
##
## Parameters:
## - token: Access token / Refresh token
func token_revocation_v3(token: String) -> Dictionary:
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _revoke_callback.is_valid():
		_revoke_callback.call()
	return _result


## Authenticates on two platforms simultaneously
## POST /iam/v3/oauth/simultaneousLogin
##
## # ALPHA: Avoid using this operation for now. Contact AccelByte support for inquiries.
##
## Simultaneous login flow.
##
## The primary goals of this project are to entitle players to authenticate on a native PC platform(Steam/Epic) and the PlayStation platform,
## link their accounts, and provide support for platform sync with a valid third-party platform access token.
##
## ## Given a valid native ticket and empty simultaneous ticket, these cases fail
## - Native ticket's account is not linked AGS account yet
## - Native ticket's account is linked AGS account, but AGS account is not linked simultaneous platform yet
## - Native ticket's account is linked AGS account, AGS account is linked simultaneous platform but there is no available simultaneous token.(only if this platform is expected to store the platform token)
##
## ## Given a valid native ticket and empty simultaneous ticket, this case succeeds
## - Native ticket's account already linked AGS account, this AGS account already linked simultaneous platform. There is valid simultaneous token.(this is required only when this simultaneous is expected to cache platform token)
##
## ## Given a valid native ticket token and valid simultaneous ticket, these cases fail
## #### Native ticket's account is already linked with AGS account
## - Native linked AGS account is linked this simultaneous platform but is different with simultaneous ticket's account
## - Native linked AGS account is not linked with simultaneous but has a linking history with simultaneous platform and it is different with simultaneous ticket's account
## #### Native ticket's account is not linked with AGS account and Simultaneous ticket's account is already linked wth AGS account
## - Simultaneous linked AGS account is linked this native platform but is different with native ticket's account
## - Simultaneous linked AGS account is not linked with native but has a linking history with native platform and it is different with native ticket's account
##
## ## Given a valid native ticket and valid simultaneous ticket, these cases succeed
## - Native ticket's account & Simultaneous ticket's account are both not linked to AGS account yet
## - Native ticket's account & Simultaneous ticket's account are already linked to same AGS account
##
## Parameters:
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - simultaneous_platform: Platform to authenticate on simultaneously (e.g., psn).
## - simultaneous_ticket: Simultaneous ticket, can be authCode,authTicket,authToken
## - native_platform: Native PC platform ID (e.g., steam, epicgames).
## - native_platform_ticket: Authentication ticket from the native platform.
func simultaneous_login_v3(
	native_platform: String,
	native_platform_ticket: String,
	app_id: String = "",
	simultaneous_platform: String = "",
	simultaneous_ticket: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/oauth/simultaneousLogin"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not app_id.is_empty():
		form_data["appId"] = app_id
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Generates an OAuth2 access token
## POST /iam/v3/oauth/token
##
## Generates access tokens using one of these OAuth 2.0 grant types:
## 1. Grant Type == `authorization_code`:
## It generates the user token by given the authorization
## code generated by the `/iam/v3/authenticate` operation. It should also pass
## in the `redirect_uri`, which should be the same as generating the
## authorization code request.
## 2. Grant Type == `password`:
## The grant type to use for authenticating a user, whether it's by email / username and password combination
## or through platform.
## 3. Grant Type == `refresh_token`:
## Used to get a new access token for a valid refresh token.
## 4. Grant Type == `client_credentials`:
## It generates a token by checking the client credentials provided through Authorization header.
## 5. Grant Type == `urn:ietf:params:oauth:grant-type:extend_client_credentials`:
## It generates a token by checking the client credentials provided through Authorization header.
## It only allows publisher/studio namespace client.
## In generated token:
## 1. There wil be no roles, namespace_roles & permission.
## 2. The scope defaults to 'extend'.
## 3. There will have a new field 'extend_namespace', the value comes from the `extendNamespace` field in the request.
##
## ## Access Token Content
## Following is the access token's content:
## - **namespace**. It is the namespace the token was generated from.
## - **display_name**. The display name of the sub. It is empty if the token is generated from the client credential
## - **roles**. The sub's roles. It is empty if the token is generated from the client credential
## - **namespace_roles**. The sub's roles scoped to namespace. Improvement from roles, which make the role scoped to specific namespace instead of global to publisher namespace
## - **permissions**. The sub or aud' permissions
## - **bans**. The sub's list of bans. It is used by the IAM client for validating the token.
## - **jflgs**. It stands for Justice Flags. It is a special flag used for storing additional status information regarding the sub. It is implemented as a bit mask. Following explains what each bit represents:
## - 1: Email Address Verified
## - 2: Phone Number Verified
## - 4: Anonymous
## - 8: Suspicious Login
## - **aud**. The aud is the targeted resource server.
## - **iat**. The time the token issues at. It is in Epoch time format
## - **exp**. The time the token expires. It is in Epoch time format
## - **client_id**. The UserID. The sub is omitted if the token is generated from client credential
## - **scope**. The scope of the access request, expressed as a list of space-delimited, case-sensitive strings
##
## ## Bans
## The JWT contains user's active bans with its expiry date. List of ban types can be obtained from /bans.
## ## Device Cookie Validation
## _**For grant type "password" only**_
## Device Cookie is used to protect the user account from brute force login attack, more detail from OWASP.
## The operation reads the device cookie from the **Auth-Trust-Id** header. If not found, a new cookie is generated and returned as **auth_trust_id** in the response on successful login.
## ## Track Login History
## The operation tracks login history to detect suspicious login activity. Provide **Device-Id** (alphanumeric) in the request header; if absent, it defaults to "unknown".
## Align with General Data Protection Regulation in Europe, user login history will be kept within 28 days by default"
## ## 2FA remember device
## To remember device for 2FA, should provide cookie: device_token or header: Device-Token
## ## Response note
## If it is a user token request and user hasn't accepted required legal policy, the field `is_comply` will be false in response and responsed token will have no permission.
##
## Parameters:
## - additional_data: Metadata passed to the login success event.
## - client_id: Client Id (used with grant type 'authorization_code')
## - client_secret: Confidential Client Secret (used with grant type 'authorization_code' when using confidential client with client_secret_post authentication method, i.e. not using HTTP Basic authentication)
## - code: The authorization code received from the authorization server (used with grant type 'authorization_code')
## - code_verifier: Code verifier received from the authorization server
## - extend_namespace: Extend namespace, Used on grant type 'urn:ietf:params:oauth:grant-type:extend_client_credentials'.
## - extend_exp: Whether to extend the refresh token lifetime. Only available for grant type 'password'.
## - password: Password (used with grant type 'password')
## - redirect_uri: Redirect URI (used with grant type 'authorization_code')
## - refresh_token: Refresh Token (used with grant type 'refresh_token'). This field is optional if the request header provides the "refresh_token" cookie
## - scope: Access token scopes to request. Separate values with whitespace. Used with grant types `password` and `client_credentials`.
## - username: User Name (used with grant type 'password')
## - grant_type: OAuth 2.0 grant type. Supported values: authorization_code, password, refresh_token, client_credentials.
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Verifies an OAuth2 token
## POST /iam/v3/oauth/verify
##
## Verifies a token and returns its claims if valid.
##
## Parameters:
## - token: Access or refresh token to verify.
func verify_token_v3(token: String) -> Dictionary:
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Authenticates a user via a third-party platform
## GET /iam/v3/platforms/{platformId}/authenticate
##
## Authenticates a user via a third-party platform. Deactivated or login-banned users cannot log in.
## If already linked with justice account or match SSO condition, will redirect to client's redirect URL with code. then invoke '/iam/v3/oauth/token' with grant_type=authorization_code
## If already not linked with justice account and not match SSO condition, will redirect to client's account linking page
## ## Supported platforms:
## - **steamopenid**Steam login page redirects to this operation after login success
## as defined in the openID request parameter `openid.return_to` when request login to steam
## https://openid.net/specs/openid-authentication-2_0.html#anchor27
## - **ps4web**PS4 login page redirects to this operation after login success
## as defined in the authorization request parameter `redirect_uri`
## https://ps4.siedev.net/resources/documents/WebAPI/1/Auth_WebAPI-Reference/0002.html#0GetAccessTokenUsingAuthorizationCode
## - **xblweb**XBL login page redirects to this operation after login success
## as defined in the authorization request parameter `redirect_uri`
## - **epicgames**Epicgames login page redirects to this operation after login success
## or an error occurred. If error, it redirects to the login page.
## - **twitch**Twitch login page redirects to this operation after login success
## as defined in the authorization request parameter `redirect_uri`
## - **facebook**Facebook login page redirects to this operation after login success
## as defined in the authorization request parameter `redirect_uri`
## - **google**Google login page redirects to this operation after login success
## as defined in the authorization request parameter `redirect_uri`
## - **snapchat**Snapchat login page redirects to this operation after login success
## as defined in the authorization request parameter `redirect_uri`
## - **discord**Discord login page redirects to this operation after login success
## as defined in the authorization request parameter `redirect_uri`
##
## Parameters:
## - platform_id: Third-party platform identifier
## - code: The authorization code from 3rd party OAuth server
## - error: The error message from 3rd party OAuth server
## - openid_assoc_handle: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_claimed_id: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_identity: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_mode: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_ns: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_op_endpoint: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_response_nonce: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_return_to: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_sig: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - openid_signed: [steamopenid] Steam OpenID response parameters https://openid.net/specs/openid-authentication-2_0.html#positive_assertions
## - state: State value containing the authorization request ID, used to match this callback to the original authorization request.
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


## Verifies a third-party platform token
## POST /iam/v3/platforms/{platformId}/token/verify
##
## Verifies the third-party platform token. For some platforms, also refreshes the token stored in IAM. Does not generate any event or AccelByte access/refresh token.
## Game clients can use this to refresh a third-party token when a platform token not found error occurs (for example, a 404 from IAP/DLC).
##
## ## Platforms will refresh stored token:
## - **twitch**: The `platform_token`'s value is the authorization code returned by Twitch OAuth.
## - **epicgames**: The `platform_token`'s value is an access-token or authorization code obtained from Epicgames EOS Account Service.
## - **ps4**: The `platform_token`'s value is the authorization code returned by Sony OAuth.
## - **ps5**: The `platform_token`'s value is the authorization code returned by Sony OAuth.
## - **amazon**: The `platform_token`'s value is authorization code.
## - **awscognito**: The `platform_token`'s value is the aws cognito access token or id token (JWT).
## - **live**: The `platform_token`'s value is xbox XSTS token
## - **snapchat**: The `platform_token`'s value is the authorization code returned by Snapchat OAuth.
## - **for specific generic oauth (OIDC)**: The `platform_token`'s value should be the same type as created OIDC auth type whether auth code, idToken, or bearerToken.
##
## Parameters:
## - platform_id: Third-party platform identifier
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - platform_token: The token obtained from the third-party platform. Accepted format varies by platform; see the operation description for details.
func platform_token_refresh_v3(
	platform_id: String, platform_token: String, app_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/platforms/{platformId}/token/verify"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not app_id.is_empty():
		form_data["appId"] = app_id
	if not platform_token.is_empty():
		form_data["platform_token"] = platform_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves age restriction settings for a country
## GET /iam/v3/public/namespaces/{namespace}/agerestrictions/countries/{countryCode}
##
## Get age restriction by country code. It will always get by publisher namespace
##
## Parameters:
## - country_code: ISO 3166-1 alpha-2 country code to look up age restrictions for.
## - namespace_param: Game namespace
func public_get_country_age_restriction_v3(
	country_code: String, namespace_param: String
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


## Retrieves a namespace configuration value
## GET /iam/v3/public/namespaces/{namespace}/config/{configKey}
##
## Returns the value for the specified configuration key. The namespace must be a publisher or studio namespace.
##
## **Supported config keys:**
## * uniqueDisplayNameEnabled
## * usernameDisabled
## * mandatoryEmailVerificationEnabled
## * verificationCodeType
##
## If the key is verificationCodeType, the value format is '{collection}:{N}'; example: 'ABCDEFGHI:6', 'ABCDEFGHI1234:8', '01234567894:7'
##
## Parameters:
## - config_key: The configuration key to retrieve.
## - namespace_param: Game namespace
func public_get_config_value_v3(config_key: String, namespace_param: String) -> Dictionary:
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


## Retrieves the list of countries
## GET /iam/v3/public/namespaces/{namespace}/countries
##
## Public get country list, will filter out countries in black list
##
## Parameters:
## - namespace_param: Game namespace
func public_get_country_list_v3(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/countries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Public Get Input Validations
## GET /iam/v3/public/namespaces/{namespace}/inputValidations
##
## Supported namespace:
## - publisher namespace
## - studio namespace
##
## Returns the list of input validation configuration.
## `regex` parameter will be returned if `isCustomRegex` is true. Otherwise, it will be empty.
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
## - default_on_empty: default true, will return default language if languageCode is empty or language not available
## - language_code: Language Code for description
func public_get_namespace_scoped_input_validations(
	namespace_param: String, default_on_empty: bool = false, language_code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/inputValidations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
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
## GET /iam/v3/public/namespaces/{namespace}/inputValidations/{field}
##
## Returns input validation configuration by field.
## Supported namespace:
## - publisher namespace
## - studio namespace
##
## Parameters:
## - field: Name of the input validation field to get: email, username, displayName, password or avatar
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
func public_get_namespace_scoped_input_validation_by_field(
	field: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/inputValidations/{field}"
	url_path = url_path.replace("{" + "field" + "}", field.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves active third-party platform credentials for public use
## GET /iam/v3/public/namespaces/{namespace}/platforms/clients/active
##
## This is the Public API to Get All Active 3rd Platform Credential.
##
## Parameters:
## - namespace_param: Game namespace
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


## Retrieves the active OIDC platform credential for a client
## GET /iam/v3/public/namespaces/{namespace}/platforms/clients/oidc
##
## This is the Public API to Get All Active OIDC Platform Credential By Client ID
##
## Parameters:
## - namespace_param: Game namespace
## - client_id: OAuth client ID
func retrieve_active_oidc_clients_public_v3(
	namespace_param: String, client_id: String
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


## Retrieves profile update strategies for a namespace
## GET /iam/v3/public/namespaces/{namespace}/profileUpdateStrategies
##
## Is for public user to get profile update strategy by namespace and field.
## Note: If the config is not found, this API will return a config with unlimited.
##
## Parameters:
## - namespace_param: Game namespace
## - field: Target field
func public_get_profile_update_strategy_v3(
	namespace_param: String, field: String = ""
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


## Retrieves the async account linking progress status
## GET /iam/v3/public/namespaces/{namespace}/requests/{requestId}/async/status
##
## Returns the status of an async account linking request. Users can only request their own linking status.
##
## Parameters:
## - namespace_param: Game namespace
## - request_id: Request ID of the link status
func public_get_async_status(namespace_param: String, request_id: String) -> Dictionary:
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


## Searches for users by display name, username, or third-party display name
## GET /iam/v3/public/namespaces/{namespace}/users
##
## Search all users on the specified namespace that match the query on these fields: display name, unique display name, username or by 3rd party display name.
## The query length must be between 3 and 30 characters. For email address queries (i.e. contains '@'), the allowed length is 3 to 40 characters. Otherwise, the query returns no results.
## The default limit value is 20.
##
## ## Searching by 3rd party platform
##
## **Note: searching by 3rd party platform display name will use exact query, not fuzzy query.**
##
## Step when searching by 3rd party platform display name:
## 1. set **by** to **thirdPartyPlatform**
## 2. set **platformId** to the the supported platform ID
## 3. set **platformBy** to __platformDisplayName__
##
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - oidc platform id
##
## Note:
## - You can use either platform id or platform group as **platformId** parameter.
## - **Nintendo platform user id**: Append the Environment ID to the NSA ID using a colon separator. e.g kmzwa8awaa:dd1
##
## ## IP Rate Limit validation
##
## This operation has IP rate limit validation, which activates when triggered excessively from the same IP address (returns 429).
## The default rule: 10 max requests per 30 seconds (per unique IP address).
##
## To mitigate unexpected issues in your implementation, consider these best practices:
## * Delay searching if the player continues typing in the search box, and only use the latest input provided.
## * Prevent players from double-clicking or making repeated clicks within a short time frame.
##
## Parameters:
## - namespace_param: Game namespace
## - by: Search by given attribute, possible values are displayName, uniqueDisplayName, username, and thirdPartyPlatform
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - platform_by: Search platformBy given attribute, possible value is platformDisplayName
## - platform_id: Third-party platform identifier
## - query: Query, can be either display name or username. Max character is 50
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


## Creates a new user account
## POST /iam/v3/public/namespaces/{namespace}/users
##
## Available Authentication Types:
## 1. **EMAILPASSWD**: an authentication type used for new user registration through email.
##
## **Note**:
## * **uniqueDisplayName**: required when uniqueDisplayNameEnabled/UNIQUE_DISPLAY_NAME_ENABLED is true.
## * **code**: required when mandatoryEmailVerificationEnabled config is true. Refer to the configuration from /iam/v3/public/namespaces/{namespace}/config/{configKey}.
##
## Country uses ISO3166-1 alpha-2 two letter, e.g. US.
## Date of Birth format: YYYY-MM-DD, e.g. 2019-04-29.
## Supports accepting agreements for the created user; supply the accepted agreements in acceptedPolicies.
##
## Parameters:
## - namespace_param: Game namespace
func public_create_user_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Checks whether a user account field value is available
## GET /iam/v3/public/namespaces/{namespace}/users/availability
##
## Checks whether a user account field value is available.
## Supported fields:
## - displayName
## - uniqueDisplayName
## - username
##
## If the request includes an access token, the check excludes that user's own value, so a user can reuse their existing value when updating their account.
##
## Response codes:
## - Available: 404 (not found)
## - Not available: 204 (no content)
##
## Parameters:
## - namespace_param: Game namespace
## - field: The field to check availability for.
## - query: The value to check availability for.
func check_user_availability(namespace_param: String, field: String, query: String) -> Dictionary:
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


## Sends a verification code to a new account's email address
## POST /iam/v3/public/namespaces/{namespace}/users/code/request
##
## Validates the email address in the request. If the address is already in use, returns 409. If available, sends a verification code to the email address.
## Verify the code using the operation.
##
## Parameters:
## - namespace_param: Game namespace
func public_send_registration_code(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/code/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Verifies the registration code
## POST /iam/v3/public/namespaces/{namespace}/users/code/verify
##
## Verify the registration code
##
## Parameters:
## - namespace_param: Game namespace
func public_verify_registration_code(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Requests a password reset code
## POST /iam/v3/public/namespaces/{namespace}/users/forgot
##
## **Special note for publisher-game scenario:**
## Game clients should pass the game namespace path parameter; publisher clients should pass the publisher namespace path parameter.
## The password reset code is sent to the publisher account's email address.
##
## Parameters:
## - namespace_param: Game namespace
func public_forgot_password_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/forgot"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Validates user input against configured validation rules
## POST /iam/v3/public/namespaces/{namespace}/users/input/validation
##
## Validates user input fields against the configured validation rules and profanity filter (if enabled). The namespace must be a publisher namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_validate_user_input(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/input/validation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a user invitation
## GET /iam/v3/public/namespaces/{namespace}/users/invite/{invitationId}
##
## Validates a user invitation. Returns 404 when not found or when the invitation has expired.
##
## Parameters:
## - invitation_id: Invitation ID, should follow UUID version 4 without hyphen
## - namespace_param: Game namespace
func get_admin_invitation_v3(invitation_id: String, namespace_param: String) -> Dictionary:
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


## Creates a user account from an invitation
## POST /iam/v3/public/namespaces/{namespace}/users/invite/{invitationId}
##
## Creates a user with the roles specified in the invitation, using the submitted data.
## Users can log in after the submission is complete.
## Available Authentication Types:
## EMAILPASSWD: an authentication type used for new user registration through email.
##
## **Note**:
## * **uniqueDisplayName**: required when uniqueDisplayNameEnabled/UNIQUE_DISPLAY_NAME_ENABLED is true.
##
## Country uses ISO3166-1 alpha-2 two letter, e.g. US.
## Date of Birth format: YYYY-MM-DD, e.g. 2019-04-29.
##
## Parameters:
## - invitation_id: Invitation ID, should follow UUID version 4 without hyphen
## - namespace_param: Game namespace
func create_user_from_invitation_v3(
	invitation_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates the current user's profile
## PUT /iam/v3/public/namespaces/{namespace}/users/me
##
## Updates the current user profile based on the provided fields. A single request can update one or more fields.
## Supported fields: `country`, `displayName`, `languageTag`, `dateOfBirth`, `avatarUrl`, `userName`.
## Country uses ISO3166-1 alpha-2 two letter, e.g. US.
## Date of Birth format: YYYY-MM-DD, e.g. 2019-04-29.
## **Response logic when updating email address:**
## - When updating a verified email address, `newEmailAddress` receives the new email address.
## - When updating an unverified email address, `oldEmailAddress` and `emailAddress` hold the new email address.
## - When updating an email address that was previously verified and updated, `oldEmailAddress` and `emailAddress` show the previously verified address; `newEmailAddress` shows the newest address.
##
## **Important notes:**
## Provided for clients without PATCH support.
## If the client supports PATCH, use [PATCH] /iam/v3/public/namespaces/{namespace}/users/me instead.
##
## Parameters:
## - namespace_param: Game namespace
func update_user_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates the current user's profile
## PATCH /iam/v3/public/namespaces/{namespace}/users/me
##
## Updates the current user profile based on the provided fields. A single request can update one or more fields.
## Supported fields: `country`, `displayName`, `languageTag`, `dateOfBirth`, `avatarUrl`, `userName`.
## Country uses ISO3166-1 alpha-2 two letter, e.g. US.
## Date of Birth format: YYYY-MM-DD, e.g. 2019-04-29.
## **Response logic when updating email address:**
## - When updating a verified email address, `newEmailAddress` receives the new email address.
## - When updating an unverified email address, `oldEmailAddress` and `emailAddress` hold the new email address.
## - When updating an email address that was previously verified and updated, `oldEmailAddress` and `emailAddress` show the previously verified address; `newEmailAddress` shows the newest address.
##
## Parameters:
## - namespace_param: Game namespace
func public_partial_update_user_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Sends a verification code to the current user's email address
## POST /iam/v3/public/namespaces/{namespace}/users/me/code/request
##
## Sends a verification code to the current user's email address.
## Available contexts:
## 1. **`UserAccountRegistration`**
## Used for verifying an email address during user account registration. Returns 409 if the email address is already verified.
## **_This is the default context if the Context field is empty._**
## 2. **`UpdateEmailAddress`**
## Used to verify the user before updating their email address (without checking whether the email address is already verified).
## 3. **`upgradeHeadlessAccount`**
## Used when the email address should be automatically verified on upgrading a headless account.
## The operation returns 409 if the email address is already in use by another account (returns 409).
##
## Parameters:
## - namespace_param: Game namespace
func public_send_verification_code_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/code/request"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Validates or consumes a verification code for the current user
## POST /iam/v3/public/namespaces/{namespace}/users/me/code/verify
##
## Redeems a verification code to verify the user's contact address. Consumes the code when `validateOnly` is false.
## Available contact type: **email**.
##
## Parameters:
## - namespace_param: Game namespace
func public_user_verification_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/code/verify"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Verifies or consumes a code to upgrade a headless account
## POST /iam/v3/public/namespaces/{namespace}/users/me/headless/code/verify
##
## Upgrades a headless account by linking it with an email address and password. If validateOnly is false, also consumes the code and verifies the email address.
## This is a shortcut for upgrading a headless account and verifying the email address in a single call. After upgrade, the user can log in using the email address and password.
## Optionally updates user data fields immediately after the upgrade. Supported user data fields:
## - displayName
## - dateOfBirth: format YYYY-MM-DD, e.g. 2019-04-29
## - country: format ISO3166-1 alpha-2 two letter, e.g. US
##
## Parameters:
## - namespace_param: Game namespace
func public_upgrade_headless_account_v3(
	namespace_param: String, body: Dictionary = {}
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


## Upgrades a headless account to a full account with email
## POST /iam/v3/public/namespaces/{namespace}/users/me/headless/verify
##
## When `NeedVerificationCode` is true, the operation sends a verification code to the email address. Verify the code using the /iam/v3/public/namespaces/{namespace}/users/me/code/verify operation.
##
## Parameters:
## - namespace_param: Game namespace
## - need_verification_code: Default false, will send verification code to email if true
func public_verify_headless_account_v3(
	namespace_param: String, need_verification_code: bool = false, body: Dictionary = {}
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


## Updates the current user's password
## PUT /iam/v3/public/namespaces/{namespace}/users/me/password
##
## Changes the current user's account password.
##
## Parameters:
## - namespace_param: Game namespace
func public_update_password_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates a game namespace user from a publisher account
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/justice/{targetNamespace}
##
## Create Justice User from Publisher User information. It will check first if Justice User on target namespace already exist.
##
## Parameters:
## - namespace_param: Game namespace
## - target_namespace: The game namespace to create the user in.
func public_create_justice_user(namespace_param: String, target_namespace: String) -> Dictionary:
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


## Links the current user's account to a third-party platform
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}
##
## **Prerequisite:**
## Set up platform client configuration for the specific `platformId`. Configure the namespace service URL.
## ## Supported platforms:
## - **steam**: The ticket's value is the binary ticket returned by Steam.
## - **steamopenid**: Steam's user authentication method using OpenID 2.0. The ticket's value is URL generated by Steam on web authentication
## - **facebook**: The ticket's value is the authorization code returned by Facebook OAuth
## - **google**: The ticket's value is the authorization code returned by Google OAuth
## - **googleplaygames**: The ticket's value is the authorization code returned by Google play games OAuth
## - **oculus**: The ticket's value is a string composed of Oculus's user ID and the nonce separated by a colon (:).
## - **twitch**: The ticket's value is the authorization code returned by Twitch OAuth.
## - **android**: The ticket's value is the Android's device ID
## - **ios**: The ticket's value is the iOS's device ID.
## - **apple**: The ticket's value is the authorization code returned by Apple OAuth.
## - **device**: Every device that doesn't run Android or iOS falls into the device platform category. The ticket's value is the device's ID.
## - **discord**: The ticket's value is the authorization code returned by Discord OAuth.
## - **ps4web**: The ticket's value is the authorization code returned by PSN OAuth.
## - **ps4**: The ticket's value is the authorization code returned by PSN OAuth.
## - **ps5**: The ticket's value is the authorization code returned by PSN OAuth.
## - **xblweb**: The ticket's value is the authorization code returned by XBox Live OAuth.
## - **live**: The ticket's value is the XSTS token.
## - **awscognito**: The ticket's value is the aws cognito access token (JWT).
## - **epicgames**: The ticket's value is an access-token or authorization code obtained from Epicgames EOS Account Service.
## - **nintendo**: The ticket's value is the id_token returned by Nintendo OAuth.
## - **netflix**: The ticket's value is GAT (Gamer Access Token) returned by Netflix backend.
## - **snapchat**: The ticket's value is authorization code returned by Snapchat OAuth.
## - **for specific generic oauth (OIDC)**: The platform_token's value should be the same type as created OIDC auth type whether it is auth code, idToken or bearerToken.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - code_verifier: RFC 7636 PKCE code verifier. Required when the platform authorization code was requested with a code_challenge, as the Discord Social SDK does by default on Android and Meta Quest. Must be 43 to 128 unreserved characters. Also accepted as code_verifier.
## - redirect_uri: [Special case for ps4web and xblweb platform] The same redirectUri as when the client request authorization code. The redirectUri when client request auth code need to be exactly same with redirectUri when IAM requesting exchange token to the Platform (ps4web, xblweb)
## - ticket: Ticket from platform, not contain whitespace
func public_platform_link_v3(
	namespace_param: String,
	platform_id: String,
	ticket: String,
	app_id: String = "",
	code_verifier: String = "",
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
	if not app_id.is_empty():
		form_data["appId"] = app_id
	if not code_verifier.is_empty():
		form_data["codeVerifier"] = code_verifier
	if not redirect_uri.is_empty():
		form_data["redirectUri"] = redirect_uri
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Unlinks the current user's account from a platform across all namespaces
## DELETE /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/all
##
## Unlinks the current user's account from a third-party platform across all namespaces.
## Platforms form account groups; you can use either a platform ID or platform group as the platformId path parameter.
## Example: to unlink a Steam account, you can use steamnetwork, steam, or steamopenid as the platformId.
##
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - oidc platform id
##
## Note:
## - You can use either platform id or platform group as **platformId** parameter.
## - **Nintendo platform user id**: NSA ID must be appended with the Environment ID using a colon separator. e.g kmzwa8awaa:dd1
##
## Unlinking a platform account associated with a group:
## Unlinking a platform account in a group will also unlink all other accounts in that group.
## Example: unlinking from ps4 will also unlink ps5 and ps4web.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func public_platform_unlink_all_v3(namespace_param: String, platform_id: String) -> Dictionary:
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


## Links the current user's account to a platform, overriding any existing link.
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/force
##
## Force-links the current user's account to a platform.
## If this platform account is already linked to another user account, the operation force-links it and removes the platform from the conflicting user across all enrolled namespaces.
## If the current user has already linked (or linked and unlinked) to this platform with a different platform account, linking is not allowed.
## ## Supported platforms:
## - **steam**: The platform_token's value is the binary ticket returned by Steam.
## - **steamopenid**: Steam's user authentication method using OpenID 2.0. The platform_token's value is URL generated by Steam on web authentication
## - **facebook**: The platform_token's value is the authorization code returned by Facebook OAuth
## - **google**: The platform_token's value is the authorization code returned by Google OAuth
## - **googleplaygames**: The platform_token's value is the authorization code returned by Google play games OAuth
## - **oculus**: The platform_token's value is a string composed of Oculus's user ID and the nonce separated by a colon (:).
## - **twitch**: The platform_token's value is the authorization code returned by Twitch OAuth.
## - **discord**: The platform_token's value is the authorization code returned by Discord OAuth
## - **android**: The device_id is the Android's device ID
## - **ios**: The device_id is the iOS's device ID.
## - **apple**: The platform_token's value is the authorization code returned by Apple OAuth.(We will use this code to generate APP token)
## - **device**: Every device that does'nt run Android and iOS is categorized as a device. The device_id is the device's ID.
## - **justice**: The platform_token's value is the designated user's access token.
## - **epicgames**: The platform_token's value is an access-token obtained from Epicgames EOS Account Service.
## - **ps4**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **ps5**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **nintendo**: The platform_token's value is the id_token returned by Nintendo OAuth.
## - **awscognito**: The platform_token's value is the aws cognito access token or id token (JWT).
## - **live**: The platform_token's value is xbox XSTS token
## - **xblweb**: The platform_token's value is code returned by xbox after login
## - **netflix**: The platform_token's value is GAT (Gamer Access Token) returned by Netflix backend
## - **snapchat**: The platform_token's value is the authorization code returned by Snapchat OAuth.
## - **for specific generic oauth (OIDC)**: The platform_token's value should be the same type as created OIDC auth type whether it is auth code, idToken or bearerToken.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - code_verifier: RFC 7636 PKCE code verifier. Required when the platform authorization code was requested with a code_challenge, as the Discord Social SDK does by default on Android and Meta Quest. Must be 43 to 128 unreserved characters. Also accepted as code_verifier.
## - redirect_uri: The same redirectUri as when the client requested the authorization code. Only read together with codeVerifier, and required by platforms that verify the redirect URI at token exchange. Defaults to the redirect URI configured on the platform client when omitted
## - ticket: Token from platform auth
func public_force_platform_link_v3(
	namespace_param: String,
	platform_id: String,
	ticket: String,
	app_id: String = "",
	code_verifier: String = "",
	redirect_uri: String = ""
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
	if not app_id.is_empty():
		form_data["appId"] = app_id
	if not code_verifier.is_empty():
		form_data["codeVerifier"] = code_verifier
	if not redirect_uri.is_empty():
		form_data["redirectUri"] = redirect_uri
	if not ticket.is_empty():
		form_data["ticket"] = ticket
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Generates a third-party platform login URL for web account linking
## GET /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link
##
## Generates a third-party platform login page URL, which redirects to the establish linking operation after login.
## Supported platforms:
## - ps4web
## - xblweb
## - steamopenid
## - epicgames
## - facebook
## - twitch
## - google
## - apple
## - snapchat
## - discord
## - amazon
## - oculusweb
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - client_id: OAuth client ID
## - redirect_uri: The redirect URI for the client after authentication.
func public_web_link_platform(
	namespace_param: String, platform_id: String, client_id: String = "", redirect_uri: String = ""
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


## Creates the third-party platform account link after the authorization redirect.
## GET /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link/establish
##
## Called by the third-party platform after redirect to complete the account linking process.
## Supported platforms:
## - ps4web
## - xblweb
## - steamopenid
## - epicgames
## - facebook
## - twitch
## - google
## - apple
## - snapchat
## - discord
## - amazon
## - oculusweb
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - code: Authorization code from third party
## - state: State from third party redirect
func public_web_link_platform_establish(
	namespace_param: String, platform_id: String, state: String, code: String = ""
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


## Processes the third-party web link callback and returns link status
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/link/process
##
## Processes a third-party account link and returns the link status directly rather than redirecting to the original page.
## The **state** parameter comes from the response of `/users/me/platforms/{platformId}/web/link`.
## Supported platforms:
## - ps4web
## - xblweb
## - steamopenid
## - epicgames
## - facebook
## - twitch
## - google
## - apple
## - snapchat
## - discord
## - amazon
## - oculusweb
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - code: Authorization code from third party
## - state: The state value returned by the web link generation operation.
func public_process_web_link_platform_v3(
	namespace_param: String, platform_id: String, state: String, code: String = ""
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Initiate Platform Web Re-authentication
## GET /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/reauth
##
## Generates a redirect to a third party login page for re-authentication purpose.
##
## Supported platforms:
## - ps4web
## - xblweb
## - steamopenid
## - epicgames
## - facebook
## - twitch
## - google
## - apple
## - snapchat
## - discord
## - amazon
## - oculusweb
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
## - platform_id: Platform ID
## - client_id: Client ID
## - redirect_uri: Redirect URI
## - operation: Re-auth operation. **GDPR**: obtain a **gdpr_token** cookie after re-authentication completes. **LINK**: perform a platform account link.
func public_web_reauth_platform(
	namespace_param: String,
	platform_id: String,
	operation: String,
	client_id: String = "",
	redirect_uri: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/reauth"
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
	if not operation.is_empty():
		query_params["operation"] = operation
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Platform Web Re-auth Callback
## GET /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/reauth/establish
##
## Callback endpoint for the third party to redirect to after authentication to complete the re-auth flow on the IAM side.
##
## The re-auth flow inside IAM depends on the **operation** parameter passed to `GET /users/me/platforms/{platformId}/web/reauth` endpoint.
## For **operation=GDPR**, the **gdpr_token** cookie is set in the response headers on success.
##
## After completing the re-auth flow, it will redirect to the **redirectUri** defined when calling the `GET /users/me/platforms/{platformId}/web/reauth` endpoint.
##
## Supported platforms:
## - ps4web
## - xblweb
## - steamopenid
## - epicgames
## - facebook
## - twitch
## - google
## - apple
## - snapchat
## - discord
## - amazon
## - oculusweb
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
## - platform_id: Platform ID
## - code: Authorization code from third party
## - state: State from third party redirect
func public_web_reauth_platform_establish(
	namespace_param: String, platform_id: String, state: String, code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/reauth/establish"
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


## Complete Platform Web Re-auth
## POST /iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/reauth/process
##
## Completes the re-auth flow on the IAM side and returns the result directly instead of redirecting to the **redirectUri** defined when calling the `GET /users/me/platforms/{platformId}/web/reauth` endpoint.
##
## The re-auth flow inside IAM depends on the **operation** parameter passed to `GET /users/me/platforms/{platformId}/web/reauth` endpoint.
## For **operation=GDPR**, the **gdpr_token** cookie is set in the response headers on success.
##
## Supported platforms:
## - ps4web
## - xblweb
## - steamopenid
## - epicgames
## - facebook
## - twitch
## - google
## - apple
## - snapchat
## - discord
## - amazon
## - oculusweb
##
## Parameters:
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
## - platform_id: Platform ID
## - code: Authorization code from third party
## - state: State, comes from the response of `GET /users/me/platforms/{platformId}/web/reauth` endpoint
func public_web_reauth_platform_process(
	namespace_param: String, platform_id: String, state: String, code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/me/platforms/{platformId}/web/reauth/process"
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves users' basic info and linked third-party platform info
## POST /iam/v3/public/namespaces/{namespace}/users/platforms
##
## Note:
## 1. the max count of user ids in the request is 100
## 2. if platform id is not empty, the result will only contain the corresponding platform infos
## 3. if platform id is empty, the result will contain all the supported platform infos
##
## __Supported 3rd platforms:__
##
## * __PSN(ps4web, ps4, ps5)__
## * account id
## * display name
## * avatar
## * __Xbox(live, xblweb)__
## * xuid or pxuid
## * display name
## * __Steam(steam, steamopenid)__
## * steam id
## * display name
## * avatar
## * __EpicGames(epicgames)__
## * epic account id
## * display name
##
## Parameters:
## - namespace_param: Game namespace
func public_get_users_platform_infos_v3(
	namespace_param: String, body: Dictionary = {}
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


## Resets a user's password
## POST /iam/v3/public/namespaces/{namespace}/users/reset
##
## Resets a user's password using a verification code.
##
## Parameters:
## - namespace_param: Game namespace
func reset_password_v3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/namespaces/{namespace}/users/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves ban records for a user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/bans
##
## Retrieves ban records for a user, with offset/limit pagination.
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: Filter ban based on the ban status. If you set this, only active ban returned
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Retrieves distinct platform accounts linked to a user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/distinctPlatforms
##
## Retrieves distinct platform accounts linked to a user. The operation groups results by platform; for each platform, the service returns the oldest linked account.
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_list_user_all_platform_accounts_distinct_v3(
	namespace_param: String, user_id: String
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


## Retrieves a user's profile and linked platform accounts
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/information
##
## Retrieves a user's profile and linked platform accounts.
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_user_information_v3(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves login history for a user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/logins/histories
##
## Notes:
## - The limit range is 1 to 100.
## - Returns the first page when `after` and `before` parameters are empty.
## - Returns the next page when `after` contains a valid Unix timestamp.
## - Returns the previous page when `before` contains a valid Unix timestamp.
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
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


## Retrieves platform accounts linked to a user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/platforms
##
## Retrieves platform accounts linked to a user.
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - oidc platform id
##
## Note:
## - You can use either platform id or platform group as **platformId** parameter.
## - **Nintendo platform user id**: Append the Environment ID to the NSA ID using a colon separator. e.g kmzwa8awaa:dd1
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
## - platform_id: Third-party platform identifier
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


## Retrieves Justice platform accounts for a user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/justice
##
## Retrieves the list of Justice platform accounts for the specified publisher namespace and user.
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_list_justice_platform_accounts_v3(
	namespace_param: String, user_id: String
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


## Links a platform account and transfers game progression, overriding any existing link.
## POST /iam/v3/public/namespaces/{namespace}/users/{userId}/platforms/linkWithProgression
##
## Force-updates another account's platform account relationship to the current user account. Transfers progression from the third-party platform binding account to the current account.
## Requires the same requestID used to check the async status.
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_force_link_platform_with_progression(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves the publisher account for a user
## GET /iam/v3/public/namespaces/{namespace}/users/{userId}/publisher
##
## **Restriction:**
## Path Parameter **namespace** must be a game namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_publisher_user_v3(namespace_param: String, user_id: String) -> Dictionary:
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


## Validates a user's password
## POST /iam/v3/public/namespaces/{namespace}/users/{userId}/validate
##
## Validates the user's password.
##
## **Authentication:**
## The _**userId**_ parameter should match the one in the access token.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - password: User password
func public_validate_user_by_user_id_and_password_v3(
	namespace_param: String, user_id: String, password: String
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves non-admin roles
## GET /iam/v3/public/roles
##
## Returns all non-admin roles.
##
## Parameters:
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - is_wildcard: - true if the expected result should only returns records with wildcard = true - false if the expected result should only returns records with wildcard = false - empty (omitted) if the expected result should returns records with no wildcard filter at all
## - limit: Number of results to return
func public_get_roles_v3(
	after: String = "", before: String = "", is_wildcard: bool = false, limit: int = -1
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


## Retrieves a non-admin role by ID
## GET /iam/v3/public/roles/{roleId}
##
## Returns the non-admin role for the specified role ID.
##
## Parameters:
## - role_id: IAM role ID
func public_get_role_v3(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Requests a password reset code
## POST /iam/v3/public/users/forgot
##
## The namespace path parameter is not required; the system resolves the namespace automatically:
##
## - Premium environment: uses the publisher namespace.
## - Shared Cloud:
## - Admin Portal: the system looks up the user by email.
## - Other clients: the system resolves the namespace from the client ID.
##
## **Note**:
## - The **clientId** parameter is required in Shared Cloud.
## - The namespace in the response is the publisher/studio namespace.
func public_forgot_password_without_namespace_v3(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/forgot"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the current user's profile
## GET /iam/v3/public/users/me
##
## Get my user data
##
## __Supported 3rd platforms:__
##
## * __PSN(ps4web, ps4, ps5)__
## * account id
## * display name
## * avatar
## * __Xbox(live, xblweb)__
## * xuid or pxuid
## * display name
## * __Steam(steam, steamopenid)__
## * steam id
## * display name
## * avatar
## * __EpicGames(epicgames)__
## * epic account id
## * display name
##
## Parameters:
## - include_all_platforms: Include all linked platform infos
func public_get_my_user_v3(include_all_platforms: bool = false) -> Dictionary:
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


## Sends a verification code using an upgrade token
## POST /iam/v3/public/users/me/code/request/forward
##
## Requires the `upgradeToken` in the request.
## Available contexts:
## 1. **upgradeHeadlessAccount**
## Used when the email address should be automatically verified on upgrading a headless account. Returns 409 if the email address is already in use by another account.
func public_send_code_forward_v3(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/code/request/forward"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves linking conflicts when linking a headless account to a full account
## GET /iam/v3/public/users/me/headless/link/conflict
##
## Note:
## 1. The current account must be a full account.
## 2. The current account must not link to the headless account's third-party platform.
##
## After resolving the conflict, call `/iam/v3/public/users/me/headless/linkWithProgression [POST]`.
##
## Parameters:
## - one_time_link_code: One time linking code
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


## Links a headless account to the current full account
## POST /iam/v3/public/users/me/headless/linkWithProgression
##
## Note:
## 1. My account should be full account
## 2. My account not linked to headless account's third platform.
func link_headless_account_to_my_account_v3(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/headless/linkWithProgression"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the redirect URI after account linking
## GET /iam/v3/public/users/me/link/redirection
##
## Returns the redirect URI after account linking. Returns 404 if the redirect URI is not found.
##
## Parameters:
## - one_time_link_code: One-time code used for the account linking redirect.
func public_get_my_redirection_after_link_v3(one_time_link_code: String) -> Dictionary:
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


## Retrieves profile update status for the current user
## GET /iam/v3/public/users/me/profileStatus
##
## Is for user to get self profile update allow status.
## Note: If the config is not found, this API will return a config with unlimited.
func public_get_my_profile_allow_update_status_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/profileStatus"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Sends a verification link to the current user's email address
## POST /iam/v3/public/users/me/verify_link/request
##
## Sends a verification link to the email address. Does not send if the email address is already verified.
func public_send_verification_link_v3(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/me/verify_link/request"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the current user's OpenID Connect user info
## GET /iam/v3/public/users/userinfo
##
## Returns user info matching the OpenID Connect standard. See: https://openid.net/specs/openid-connect-core-1_0.html#UserInfo
func public_get_openid_user_info_v3() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/public/users/userinfo"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Verifies a user's email using a verification link code
## GET /iam/v3/public/users/verify_link/verify
##
## Verifies a user's email address using the verification code from `/users/me/verify_link/request`.
##
## Parameters:
## - code: Verification code from the `/users/me/verify_link/request` operation.
func public_verify_user_by_link_v3(code: String = "") -> Dictionary:
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


## Authenticates a user via a SAML platform
## POST /iam/v3/sso/saml/platforms/{platformId}/authenticate
##
## Authenticates a user via a SAML platform. Deactivated or login-banned users cannot log in.
## ## Supported platforms:
## - **azure**
## Microsoft login page will redirect to this operation after login success
## as defined in the SAML authentication request.
##
## Parameters:
## - platform_id: Third-party platform identifier
## - code: The authorization code from 3rd party OAuth server
## - error: The error message from Identity Provider (IdP)
## - state: State value containing the authorization request ID, used to match this callback to the original authorization request.
func platform_authenticate_samlv3_handler(
	platform_id: String, state: String, code: String = "", error: String = ""
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


## Starts an SSO login for a platform client.
## GET /iam/v3/sso/{platformId}
##
## Starts the SSO login flow for the specified platform.
##
## Parameters:
## - platform_id: Third-party platform identifier
## - payload: Key-value data received from the SSO client, URL-escaped.
func login_sso_client(platform_id: String, payload: String = "") -> Dictionary:
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


## Logs out from an SSO platform session
## POST /iam/v3/sso/{platformId}/logout
##
## Logout user's session on platform that logged in using SSO.
##
## Supported platforms:
## - discourse
##
## Parameters:
## - platform_id: Third-party platform identifier
func logout_sso_client(platform_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v3/sso/{platformId}/logout"
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Generates a target token by exchanging a code
## POST /iam/v3/token/exchange
##
## Generates a target token by exchanging a code from a previous token request. Requires a basic header with ClientID and Secret matching the ClientID used in `/iam/v3/namespace/{namespace}/token/request`. Generate the code using `/iam/v3/namespace/{namespace}/token/request`.
##
## Parameters:
## - additional_data: Info passed to the login success event.
## - code: Code from request target token response
func request_target_token_response_v3(code: String, additional_data: String = "") -> Dictionary:
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Handles the forward redirect for account upgrade
## POST /iam/v3/upgrade/forward
##
## In login website based flow, after account upgraded, we need this API to handle the forward
##
## Parameters:
## - client_id: OAuth client ID for the upgrade flow.
## - upgrade_success_token: Token returned on successful account upgrade.
func upgrade_and_authenticate_forward_v3(
	client_id: String, upgrade_success_token: String
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists invitation histories for studio namespaces
## GET /iam/v4/admin/invitationHistories
##
## Lists all invitation histories for new studio namespaces in multi-tenant mode. Returns an error when multi-tenant mode is not enabled.
## Accepted query parameters: namespace, offset, limit.
##
## Parameters:
## - limit: Number of results to return
## - namespace_param: Game namespace
## - offset: Number of results to skip for pagination
func admin_list_invitation_histories_v4(
	limit: int = -1, namespace_param: String = "", offset: int = -1
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


## Retrieves devices a user has used to log in
## GET /iam/v4/admin/namespaces/{namespace}/devices
##
## Returns the devices a user has used to log in.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_devices_by_user_v4(namespace_param: String, user_id: String = "") -> Dictionary:
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


## Retrieves banned devices with pagination
## GET /iam/v4/admin/namespaces/{namespace}/devices/banned
##
## Returns banned devices. Supports offset/limit pagination and filtering by device type and date range.
##
## Parameters:
## - namespace_param: Game namespace
## - device_type: The device type to filter by.
## - end_date: Filter bans created on or before this date. Format: ISO 8601.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - start_date: Filter bans created on or after this date. Format: ISO 8601.
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


## Retrieves device bans for a user
## GET /iam/v4/admin/namespaces/{namespace}/devices/bans
##
## Returns device bans for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_device_bans_v4(namespace_param: String, user_id: String) -> Dictionary:
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


## Bans a device
## POST /iam/v4/admin/namespaces/{namespace}/devices/bans
##
## Creates a new device ban.
##
## Parameters:
## - namespace_param: Game namespace
func admin_ban_device_v4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/bans"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a device ban configuration
## GET /iam/v4/admin/namespaces/{namespace}/devices/bans/{banId}
##
## Returns the device ban configuration.
##
## Parameters:
## - ban_id: Identifier of the ban record to retrieve.
## - namespace_param: Game namespace
func admin_get_device_ban_v4(ban_id: String, namespace_param: String) -> Dictionary:
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


## Updates a device ban configuration
## PUT /iam/v4/admin/namespaces/{namespace}/devices/bans/{banId}
##
## Updates an existing device ban configuration.
##
## Parameters:
## - ban_id: Identifier of the ban record to update.
## - namespace_param: Game namespace
func admin_update_device_ban_v4(
	ban_id: String, namespace_param: String, body: Dictionary = {}
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


## Generates a device activity report
## GET /iam/v4/admin/namespaces/{namespace}/devices/report
##
## Generates a report of device activity, filtered by device type and date range.
##
## Parameters:
## - namespace_param: Game namespace
## - end_date: Filter activity on or before this date. Format: ISO 8601.
## - start_date: Filter activity on or after this date. Format: ISO 8601.
## - device_type: The device type to filter by.
func admin_generate_report_v4(
	namespace_param: String, device_type: String, end_date: String = "", start_date: String = ""
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


## Retrieves available device types
## GET /iam/v4/admin/namespaces/{namespace}/devices/types
##
## Returns the list of available device types.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_device_types_v4(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/devices/types"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves ban records for a device
## GET /iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/bans
##
## Returns ban records for the specified device.
##
## Parameters:
## - device_id: Unique identifier for the device.
## - namespace_param: Game namespace
func admin_get_device_bans_v4(device_id: String, namespace_param: String) -> Dictionary:
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


## Unbans a device
## PUT /iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/unban
##
## Removes the ban from the specified device.
##
## Parameters:
## - device_id: Unique identifier for the device.
## - namespace_param: Game namespace
func admin_unban_device_v4(device_id: String, namespace_param: String) -> Dictionary:
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


## Retrieves users who have logged in on a device
## GET /iam/v4/admin/namespaces/{namespace}/devices/{deviceId}/users
##
## Returns users who have logged in on the specified device.
##
## Parameters:
## - device_id: Unique identifier for the device.
## - namespace_param: Game namespace
func admin_get_users_by_device_v4(device_id: String, namespace_param: String) -> Dictionary:
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


## Retrieves invitation history for a specific namespace
## GET /iam/v4/admin/namespaces/{namespace}/invitationHistories
##
## Returns invitation history for a specific new studio namespace in multi-tenant mode. Returns an error when multi-tenant mode is not enabled.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_namespace_invitation_history_v4(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/invitationHistories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves user invitation history for a specific namespace
## GET /iam/v4/admin/namespaces/{namespace}/invitationHistories/users
##
## Returns the list of users' invitation history for a specific new studio namespace in multi-tenant mode. Returns an error when multi-tenant mode is not enabled.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_namespace_user_invitation_history_v4(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Creates test users without sending verification emails
## POST /iam/v4/admin/namespaces/{namespace}/test_users
##
## Creates test users without sending verification code emails.
##
## **Request Body Notes:**
## - **count**: Number of test users to create. Up to 100.
## - **userInfo** (optional):
## - country: ISO3166-1 alpha-2 two letter, e.g. US
## - **`acceptedPolicies`** (optional): List of accepted agreements for the created users.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_test_users_v4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/test_users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Creates a new user account
## POST /iam/v4/admin/namespaces/{namespace}/users
##
## Creates a new user with a unique email address and username.
## **Required attributes:**
## - authType: possible value is EMAILPASSWD
## - emailAddress: Refer to /v3/public/inputValidations for format rules.
## - username: Refer to /v3/public/inputValidations for format rules.
## - password: Refer to /v3/public/inputValidations for format rules.
## - country: ISO3166-1 alpha-2 two letter, e.g. US.
## - dateOfBirth: YYYY-MM-DD, e.g. 1990-01-01. Valid values are between 1905-01-01 and the current date.
## - uniqueDisplayName: Required when uniqueDisplayNameEnabled/UNIQUE_DISPLAY_NAME_ENABLED is true. Refer to /v3/public/inputValidations for format rules.
##
## **Optional attributes:**
## - displayName: Refer to /v3/public/inputValidations for format rules.
## Supports accepting agreements for the created user; supply the accepted agreements in acceptedPolicies.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_user_v4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates user account types in bulk.
## PATCH /iam/v4/admin/namespaces/{namespace}/users/bulk/accountType
##
## Changes the account type for the specified users.
## - set **testAccount** to `true` to mark users as test accounts
## - set **testAccount** to `false` to mark users as default accounts
##
## Parameters:
## - namespace_param: Game namespace
func admin_bulk_update_user_account_type_v4(
	namespace_param: String, body: Dictionary = {}
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


## Checks whether user IDs are valid
## POST /iam/v4/admin/namespaces/{namespace}/users/bulk/validate
##
## Checks whether user IDs exist. Up to 50 user IDs per request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_bulk_check_valid_user_idv4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/namespaces/{namespace}/users/bulk/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates a user's profile
## PUT /iam/v4/admin/namespaces/{namespace}/users/{userId}
##
## Updates a user profile based on the provided fields. A single request can update one or more fields.
## Supported fields: `country`, `displayName`, `languageTag`, `dateOfBirth`, `avatarUrl`, `userName`.
## Country uses ISO3166-1 alpha-2 two letter, e.g. US.
## Date of Birth format: YYYY-MM-DD, e.g. 2019-04-29.
##
## **Response logic when updating email address:**
## - When updating a verified email address, `newEmailAddress` receives the new email address.
## - When updating an unverified email address, `oldEmailAddress` and `emailAddress` hold the new email address.
## - When updating an email address that was previously verified and updated, `oldEmailAddress` and `emailAddress` show the previously verified address; `newEmailAddress` shows the newest address.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_v4(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Updates a user's email address
## PUT /iam/v4/admin/namespaces/{namespace}/users/{userId}/email
##
## Updates a user's email address. Requires a valid admin token to verify the admin's identity before updating.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_email_address_v4(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Disables 2FA for a user
## DELETE /iam/v4/admin/namespaces/{namespace}/users/{userId}/mfa/disable
##
## Disables 2FA for a user. When no factor is given, the operation disables all 2FA methods.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_disable_user_mfav4(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a user's 2FA status
## GET /iam/v4/admin/namespaces/{namespace}/users/{userId}/mfa/status
##
## Returns the 2FA status for a user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_mfa_status_v4(namespace_param: String, user_id: String) -> Dictionary:
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


## Lists roles assigned to a user
## GET /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
##
## List roles assigned to a user
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_list_user_roles_v4(namespace_param: String, user_id: String) -> Dictionary:
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


## Replaces all roles assigned to a user
## PUT /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
##
## Replaces the user's current role assignments with the provided list. An admin user can only assign roles with **assignedNamespaces** if they have the required permission for that role.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_role_v4(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Adds roles to a user's current role assignments.
## POST /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
##
## Appends the specified roles to the user's current role assignments. An admin user can only assign roles with **assignedNamespaces** if they have the required permission for that role.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_add_user_role_v4(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Removes roles from a user
## DELETE /iam/v4/admin/namespaces/{namespace}/users/{userId}/roles
##
## Remove a role from user's roles.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_remove_user_role_v4(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists all roles in the namespace
## GET /iam/v4/admin/roles
##
## Lists admin roles available in the system.
##
## Parameters:
## - admin_role: - true if the expected result should only returns records with adminRole = true - false if the expected result should only returns records with adminRole = false - empty (omitted) if the expected result should returns records with no wildcard filter at all
## - is_wildcard: - true if the expected result should only returns records with wildcard = true - false if the expected result should only returns records with wildcard = false - empty (omitted) if the expected result should returns records with no wildcard filter at all
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_roles_v4(
	admin_role: bool = false, is_wildcard: bool = false, limit: int = -1, offset: int = -1
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


## Creates a new role
## POST /iam/v4/admin/roles
##
## Creates a role with the specified configuration:
## - `roleName`: role name, alphanumeric, no special characters allowed (required)
## - `adminRole`: whether the role is for admin users (default false)
## - `isWildcard`: whether the role is assignable to a wildcard (*) namespace (default false)
## - `deletable`: whether the role is deletable (default true)
func admin_create_role_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a role by ID
## GET /iam/v4/admin/roles/{roleId}
##
## Retrieves the specified admin role.
##
## Parameters:
## - role_id: IAM role ID
func admin_get_role_v4(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a role
## DELETE /iam/v4/admin/roles/{roleId}
##
## Removes role ID from user's Roles and NamespaceRoles before deleting the role.
##
## Parameters:
## - role_id: IAM role ID
func admin_delete_role_v4(role_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a role
## PATCH /iam/v4/admin/roles/{roleId}
##
## Updates a role with the specified configuration:
## - `roleName`: role name, alphanumeric, no special characters allowed (required)
## - `adminRole`: whether the role is for admin users (default false)
## - `isWildcard`: whether the role is assignable to a wildcard (*) namespace (default false)
## - `deletable`: whether the role is deletable (optional)
##
## Parameters:
## - role_id: IAM role ID
func admin_update_role_v4(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Replaces all permissions assigned to a role
## PUT /iam/v4/admin/roles/{roleId}/permissions
##
## Replaces the role's current permissions with the provided list. Permissions can include a schedule using quartz-compatible cron syntax.
##
## Parameters:
## - role_id: IAM role ID
func admin_update_role_permissions_v4(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Adds permissions to a role
## POST /iam/v4/admin/roles/{roleId}/permissions
##
## Attaches the specified permissions to a role.
##
## Permissions can include a schedule as a cron string or UTC date range. Both schedule types accept quartz-compatible cron syntax. In a ranged schedule, the first element is the start date and the second is the end date. When a schedule is defined, the action value must be between 1 and 15, inclusive.
##
## Parameters:
## - role_id: IAM role ID
func admin_add_role_permissions_v4(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes permissions from a role
## DELETE /iam/v4/admin/roles/{roleId}/permissions
##
## Removes the specified permissions from the role.
##
## Parameters:
## - role_id: IAM role ID
func admin_delete_role_permissions_v4(role_id: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/permissions"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists users assigned to a role
## GET /iam/v4/admin/roles/{roleId}/users
##
## Query all users that has the specified role.
##
## Parameters:
## - role_id: IAM role ID
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
func admin_list_assigned_users_v4(
	role_id: String, after: String = "", before: String = "", limit: int = -1
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


## Assigns a user to a role
## POST /iam/v4/admin/roles/{roleId}/users
##
## Assigns a user to the role.
##
## - **userId** (required): the user's ID
## - **namespace** (required): the user's namespace
## - **assignedNamespaces** (required): namespaces to assign to the user for this role
##
## Parameters:
## - role_id: IAM role ID
func admin_assign_user_to_role_v4(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/users"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Revokes a user from a role
## DELETE /iam/v4/admin/roles/{roleId}/users
##
## Current implementation will revoke user from role in all assigned namespaces.
##
## Parameters:
## - userId: string (required)
## - namespace: string (user's namespace) (required)
##
## Parameters:
## - role_id: IAM role ID
func admin_revoke_user_from_role_v4(role_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/roles/{roleId}/users"
	url_path = url_path.replace("{" + "roleId" + "}", role_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Invites a user and assigns a role
## POST /iam/v4/admin/users/invite
##
## Invites users to the namespace and assigns a role to them. The role must target a specific namespace. An admin can only assign roles with **`assignedNamespaces`** if they have the required permission.
##
## - **`emailAddresses`** (required): email addresses to invite
## - **`isAdmin`** (required): whether the invitee should have admin privileges
## - **`namespace`** (optional): target namespace; defaults to the publisher namespace
## - **`roleId`** (optional): role to assign; defaults to the User role
## - **`assignedNamespaces`** (optional): namespaces to assign the role to; only applies when a role is given
##
## Invited admins are also assigned the User role by default.
func admin_invite_user_new_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/invite"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates the current admin user's profile
## PATCH /iam/v4/admin/users/me
##
## This Endpoint support update user based on given data. **Single request can update single field or multi fields.**
## Supported field {country, displayName, languageTag, dateOfBirth, avatarUrl, userName}
## Country use ISO3166-1 alpha-2 two letter, e.g. US.
## Date of Birth format : YYYY-MM-DD, e.g. 2019-04-29.
func admin_update_my_user_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Disables 2FA authenticator for the current user
## DELETE /iam/v4/admin/users/me/mfa/authenticator/disable
##
## Disables the 2FA authenticator for the current user.
##
## **Note**: `mfaToken` is required when all of the following are true:
## - The **SENSITIVE_MFA_AUTH_ENABLED** environment variable is enabled
## - **Two-Factor Authentication** is enabled in the client
## - The user has already enabled MFA
func admin_disable_my_authenticator_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/authenticator/disable"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Enables 2FA authenticator for the current user
## POST /iam/v4/admin/users/me/mfa/authenticator/enable
##
## Enables the 2FA authenticator for the current user.
##
## Prerequisites:
## - Generate a secret key or QR code URI using the authenticator key operation
## - Scan the QR code or enter the secret key in an authenticator app
## - Enter the code shown in the authenticator app
##
## Parameters:
## - code: The time-based one-time password (TOTP) from the authenticator app.
func admin_enable_my_authenticator_v4(code: String) -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Generates a secret key for a 3rd-party authenticator app
## POST /iam/v4/admin/users/me/mfa/authenticator/key
##
## Generates a secret key for a 3rd-party authenticator app. A QR code URI is also returned so that clients can generate a QR code image.
func admin_generate_my_authenticator_key_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/authenticator/key"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Disables 2FA backup codes for the current user
## DELETE /iam/v4/admin/users/me/mfa/backupCode/disable
##
## Disables 2FA backup codes for the current user.
##
## **Note**: `mfaToken` is required when all of the following are true:
## - The **SENSITIVE_MFA_AUTH_ENABLED** environment variable is enabled
## - **Two-Factor Authentication** is enabled in the client
## - The user has already enabled MFA
func admin_disable_my_backup_codes_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/backupCode/disable"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves backup codes and sends them to the registered email
## GET /iam/v4/admin/users/me/mfa/backupCodes
##
## Retrieves 8-digit backup codes for the current user. Each code is a one-time code and expires after use.
##
## Parameters:
## - language_tag: Language tag for email notification
func admin_get_backup_codes_v4(language_tag: String = "") -> Dictionary:
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


## Generates backup codes for the current user
## POST /iam/v4/admin/users/me/mfa/backupCodes
##
## Generates 8-digit backup codes for the current user. Each code is a one-time code and expires after use.
##
## Parameters:
## - language_tag: Language tag for email notification
func admin_generate_backup_codes_v4(language_tag: String = "") -> Dictionary:
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


## Enables 2FA backup codes for the current user
## POST /iam/v4/admin/users/me/mfa/backupCodes/enable
##
## Enables 2FA backup codes for the current user.
##
## Parameters:
## - language_tag: Language tag for email notification
func admin_enable_backup_codes_v4(language_tag: String = "") -> Dictionary:
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


## Verifies a user MFA code and issues an MFA token
## POST /iam/v4/admin/users/me/mfa/challenge/verify
##
## Verifies the user's MFA code and generates an MFA token.
##
## Parameters:
## - code: MFA code
## - factor: MFA factor
func admin_challenge_my_mfav4(code: String = "", factor: String = "") -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Sends a one-time code to the registered email for MFA
## POST /iam/v4/admin/users/me/mfa/email/code
##
## Sends a one-time code to the registered email address. Supported actions:
## - ChangePassword
## - DisableMFAEmail
##
## Parameters:
## - action: Sensitive Action
## - language_tag: BCP 47 language tag used to localize the email content.
func admin_send_my_mfa_email_code_v4(action: String = "", language_tag: String = "") -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Disables 2FA email for the current user
## POST /iam/v4/admin/users/me/mfa/email/disable
##
## Disables 2FA email for the current user.
##
## **Note**: `mfaToken` is required when all of the following are true:
## - The **SENSITIVE_MFA_AUTH_ENABLED** environment variable is enabled
## - **Two-Factor Authentication** is enabled in the client
## - The user has already enabled MFA
func admin_disable_my_email_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/email/disable"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Enables 2FA email for the current user
## POST /iam/v4/admin/users/me/mfa/email/enable
##
## Enables 2FA email for the current user.
##
## Parameters:
## - code: The one-time code sent to the registered email address.
func admin_enable_my_email_v4(code: String) -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists 2FA factors enabled for the current user
## GET /iam/v4/admin/users/me/mfa/factor
##
## Returns the 2FA factors currently enabled for the current user.
func admin_get_my_enabled_factors_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/factor"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Sets the default 2FA factor for the current user
## POST /iam/v4/admin/users/me/mfa/factor
##
## Sets the specified 2FA factor as the default for the current user.
##
## Parameters:
## - factor: Method
func admin_make_factor_my_default_v4(factor: String) -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the current admin user's 2FA status
## GET /iam/v4/admin/users/me/mfa/status
##
## Returns the 2FA status of the current user.
func admin_get_my_own_mfa_status_v4() -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/admin/users/me/mfa/status"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Authenticates a user and links a platform account
## POST /iam/v4/oauth/authenticateWithLink
##
## Authenticates a user account and links a platform account. Validates the user's email or username and password.
##
## If the user has 2FA enabled, verify the returned `mfa_token` using the MFA verify operation.
##
## ## Device Cookie Validation
##
## Device Cookie protects the user account from brute force login attacks, [more detail from OWASP](https://owasp.org/www-community/Slow_Down_Online_Guessing_Attacks_with_Device_Cookies).
## Reads the device cookie from cookie **auth-trust-id**. If no device cookie exists, generates a new one and sets it into the cookie on successful authentication.
##
## Parameters:
## - extend_exp: Whether to extend the refresh token's lifetime.
## - client_id: OAuth client ID.
## - linking_token: Platform linking Token
## - password: Account password
## - username: Account username
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Creates a headless account after platform authentication and returns a token
## POST /iam/v4/oauth/headless/token
##
## Creates a headless account after authenticating with a third-party platform, and returns an access token. The `linkingToken` comes from the platform token operation when the platform account has no linked AccelByte account.
##
## Parameters:
## - additional_data: Supplemental information passed to the login success event.
## - extend_exp: Whether to extend the refresh token's lifetime.
## - linking_token: Platform linking Token
func generate_token_by_new_headless_account_v4(
	linking_token: String, additional_data: String = "", extend_exp: bool = false
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Verifies a 2FA code during login
## POST /iam/v4/oauth/mfa/verify
##
## Verifies the 2FA code during the login flow.
##
## ## 2FA remember device
## To persist device trust for 2FA, provide cookie: device_token or header: Device-Token.
##
## Parameters:
## - code: The 2FA verification code.
## - factor: The 2FA method used.
## - mfa_token: The MFA token received from the login operation.
## - remember_device: Whether to remember this device and skip 2FA on future logins.
func verify2fa_code_v4(
	code: String, factor: String, mfa_token: String, remember_device: bool
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Generates an OAuth2 access token using a third-party platform credential
## POST /iam/v4/oauth/platforms/{platformId}/token
##
## Performs a token grant using a third-party platform credential, e.g. Steam, Justice. Automatically creates an account if the platform has no existing account.
##
## Requires Basic access authentication using client ID and client secret in the Authorization header. For publisher-game namespace schema: specify either platform_token or device_id. Device token grants use the device_id parameter against the game namespace. Other third-party platform token grants use platform_token against the publisher namespace.
##
## ## 2FA remember device
## To remember device for 2FA, provide cookie: device_token or header: Device-Token
## ## Supported platforms:
## - **steam**: The platform_token's value is the binary ticket returned by Steam.
## If this ticket was generated by Steam GetAuthTicketForWebApi with version >= 1.57, then platform token should use this style: `{identity}:{ticket}`, the `{identity}` was the parameter to call GetAuthTicketForWebApi when the ticket was created. Note: Do not contain `:` in this `{identity}`.
## - **steamopenid**: Steam's user authentication method using OpenID 2.0. The platform_token's value is URL generated by Steam on web authentication
## - **facebook**: The platform_token's value is the authorization code returned by Facebook OAuth
## - **google**: The platform_token's value is the authorization code or `idToken` returned by Google OAuth
## - **googleplaygames**: The platform_token's value is the authorization code or `idToken` returned by Google play games OAuth
## - **oculus**: The platform_token's value is a string composed of Oculus's user ID and the nonce separated by a colon (:).
## - **twitch**: The platform_token's value is the authorization code returned by Twitch OAuth.
## - **discord**: The platform_token's value is the authorization code returned by Discord OAuth
## - **android**: The device_id is the Android's device ID
## - **ios**: The device_id is the iOS's device ID.
## - **apple**: The platform_token's value is the authorization code or `idToken` returned by Apple OAuth.(We will use this code to generate APP token)
## - **device**: Every device that does'nt run Android and iOS is categorized as a device. The device_id is the device's ID.
## - **justice**: The platform_token's value is the designated user's access token.
## - **epicgames**: The platform_token's value is an access-token or authorization code obtained from Epicgames EOS Account Service.
## - **ps4**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **ps5**: The platform_token's value is the authorization code returned by Sony OAuth.
## - **nintendo**: The platform_token's value is the id_token returned by Nintendo OAuth.
## - **awscognito**: The platform_token's value is the aws cognito access token or id token (JWT).
## - **live**: The platform_token's value is xbox XSTS token
## - **xblweb**: The platform_token's value is code returned by xbox after login
## - **netflix**: The platform_token's value is GAT (Gamer Access Token) returned by Netflix backend
## - **snapchat**: The platform_token's value is the authorization code returned by Snapchat OAuth.
## - **for specific generic oauth (OIDC)**: The platform_token's value should be the same type as created OIDC auth type whether it is auth code, `idToken`, or `bearerToken`.
##
## ## Account Group
## Platforms are grouped into account groups. The accounts on these platforms have the same platform user id.
## Login using one of these platform will returns the same IAM user.
## Following is the current registered account grouping:
## - Steam group(steamnetwork):
## - steam
## - steamopenid
## - PSN group(psn)
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox)
## - live
## - xblweb
## - Oculus group(oculusgroup)
## - oculus
## - oculusweb
##
## ## Access Token Content
## Following is the access token's content:
## - **namespace**. It is the namespace the token was generated from.
## - **display_name**. The display name of the sub. It is empty if the token is generated from the client credential
## - **roles**. The sub's roles. It is empty if the token is generated from the client credential
## - **namespace_roles**. The sub's roles scoped to namespace. Improvement from roles, which make the role scoped to specific namespace instead of global to publisher namespace
## - **permissions**. The sub or aud' permissions
## - **bans**. The sub's list of bans. The IAM client uses it to validate the token.
## - **jflgs**. It stands for Justice Flags. It is a special flag used for storing additional status information regarding the sub. It is implemented as a bit mask. Following explains what each bit represents:
## - 1: Email Address Verified
## - 2: Phone Number Verified
## - 4: Anonymous
## - 8: Suspicious Login
## - **aud**. The aud is the client ID.
## - **iat**. The time the token issues at. It is in Epoch time format
## - **exp**. The time the token expires. It is in Epoch time format
## - **sub**. The UserID. The sub is omitted if the token is generated from client credential
##
## ## Bans
## The JWT contains user's active bans with its expiry date. List of ban types can be obtained from /bans.
##
## Parameters:
## - platform_id: Third-party platform identifier
## - code_challenge: Value generated by transforming code verifier using code challenge method.
## - code_challenge_method: The method used to transform the code verifier into a code challenge.
## - additional_data: Supplemental information passed to the login success event.
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - client_id: Client ID, only accept UUID version 4 without hyphen
## - code_verifier: RFC 7636 PKCE code verifier. Required when the platform authorization code was requested with a code_challenge, as the Discord Social SDK does by default on Android and Meta Quest. Must be 43 to 128 unreserved characters.
## - create_headless: If directly create new account when not linked yet
## - device_id: Device/hardware identifier
## - mac_address: Mac address of device
## - platform_token: Token from platform auth
## - redirect_uri: The same redirect URI the client used when it requested the platform authorization code. Only read together with code_verifier, and required by platforms that verify the redirect URI at token exchange. Defaults to the redirect URI configured on the platform client when omitted.
## - service_label: Service label used to verify the PSN app when AppId applies to ps5 or ps4.
## - skip_set_cookie: If need skip set cookie. Default is false
func platform_token_grant_v4(
	platform_id: String,
	code_challenge: String = "",
	code_challenge_method: String = "",
	additional_data: String = "",
	app_id: String = "",
	client_id: String = "",
	code_verifier: String = "",
	create_headless: bool = false,
	device_id: String = "",
	mac_address: String = "",
	platform_token: String = "",
	redirect_uri: String = "",
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
	if not app_id.is_empty():
		form_data["appId"] = app_id
	if not client_id.is_empty():
		form_data["client_id"] = client_id
	if not code_verifier.is_empty():
		form_data["code_verifier"] = code_verifier
	form_data["createHeadless"] = "true" if create_headless else "false"
	if not device_id.is_empty():
		form_data["device_id"] = device_id
	if not mac_address.is_empty():
		form_data["macAddress"] = mac_address
	if not platform_token.is_empty():
		form_data["platform_token"] = platform_token
	if not redirect_uri.is_empty():
		form_data["redirect_uri"] = redirect_uri
	if service_label >= 0.0:
		form_data["serviceLabel"] = str(service_label)
	form_data["skipSetCookie"] = "true" if skip_set_cookie else "false"
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var _cid: String = client_id if not client_id.is_empty() else _client_id
	var _csecret: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(_cid, _csecret)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Authenticates using simultaneous platform credentials
## POST /iam/v4/oauth/simultaneousLogin
##
## **This operation is in ALPHA. Do not use it in production; contact AccelByte support for inquiries.**
##
## Simultaneous login flow.
##
## The primary goals of this project are to entitle players to authenticate on a native PC platform (Steam/Epic) and the PlayStation platform,
## link their accounts, and provide support for platform sync with a valid 3rd platform access token.
##
## ## Given a valid native ticket and empty simultaneous ticket, these cases will fail
## - Native ticket's account is not linked to an AGS account yet
## - Native ticket's account is linked to an AGS account, but the AGS account is not linked to the simultaneous platform yet
## - Native ticket's account is linked to an AGS account, the AGS account is linked to the simultaneous platform, but there is no available simultaneous token (only when this platform is configured to store the platform token)
##
## ## Given a valid native ticket and empty simultaneous ticket, this case will succeed
## - Native ticket's account is already linked to an AGS account, this AGS account is already linked to the simultaneous platform, and there is a valid simultaneous token (required only when this platform is configured to cache the platform token)
##
## ## Given a valid native ticket token and valid simultaneous ticket, these cases will fail
## #### Native ticket's account is already linked with AGS account
## - Native linked AGS account is linked to this simultaneous platform but is different from the simultaneous ticket's account
## - Native linked AGS account is not linked with simultaneous but has a linking history with the simultaneous platform and it is different from the simultaneous ticket's account
## #### Native ticket's account is not linked with AGS account and Simultaneous ticket's account is already linked with AGS account
## - Simultaneous linked AGS account is linked to this native platform but is different from the native ticket's account
## - Simultaneous linked AGS account is not linked with native but has a linking history with the native platform and it is different from the native ticket's account
##
## ## Given a valid native ticket and valid simultaneous ticket, these cases will succeed
## - Native ticket's account & Simultaneous ticket's account are both not linked to an AGS account yet
## - Native ticket's account & Simultaneous ticket's account are already linked to the same AGS account
##
## Parameters:
## - code_challenge: Value generated by transforming code verifier using code challenge method.
## - code_challenge_method: The method used to transform the code verifier into a code challenge.
## - app_id: The application ID on the third-party platform that issued the ticket. Accepted only by platforms that authenticate their ticket against an application ID, which today means `steam` alone. Optional while the namespace is configured with a single App ID; mandatory once EnableMultipleAppIds is turned on for that platform's credential, where it must be one of the configured AppIds.
## - simultaneous_platform: Identifier of the simultaneous platform.
## - simultaneous_ticket: Simultaneous ticket, can be authCode,authTicket,authToken
## - native_platform: Identifier of the native PC platform.
## - native_platform_ticket: Authentication ticket from the native PC platform.
func simultaneous_login_v4(
	native_platform: String,
	native_platform_ticket: String,
	code_challenge: String = "",
	code_challenge_method: String = "",
	app_id: String = "",
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
	if not app_id.is_empty():
		form_data["appId"] = app_id
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Generates an OAuth2 access token
## POST /iam/v4/oauth/token
##
## Supports grant type:
## 1. Grant Type == `authorization_code`:
## It generates the user token by given the authorization
## code generated by the authentication flow. It should also pass
## in the redirect_uri, which should be the same as generating the
## authorization code request.
## 2. Grant Type == `password`:
## The grant type to use for authenticating a user, whether it's by email / username and password combination
## or through platform.
## 3. Grant Type == `refresh_token`:
## Used to get a new access token for a valid refresh token.
## 4. Grant Type == `client_credentials`:
## It generates a token by checking the client credentials provided through Authorization header.
## 5. Grant Type == `urn:ietf:params:oauth:grant-type:extend_client_credentials`:
## It generates a token by checking the client credentials provided through Authorization header.
## It only allows publisher/studio namespace client.
## In generated token:
## 1. There will be no roles, namespace_roles & permission.
## 2. The scope defaults to 'extend'.
## 3. There will have a new field 'extend_namespace', the value is from the token request.
## 6. Grant Type == `urn:ietf:params:oauth:grant-type:login_queue_ticket`:
## It generates a token by validating the login queue ticket against login queue service.
##
## ## Access Token Content
## Following is the access token's content:
## - **namespace**. It is the namespace the token was generated from.
## - **display_name**. The display name of the sub. It is empty if the token is generated from the client credential
## - **roles**. The sub's roles. It is empty if the token is generated from the client credential
## - **namespace_roles**. The sub's roles scoped to namespace. Improvement from roles, which make the role scoped to specific namespace instead of global to publisher namespace
## - **permissions**. The sub or aud' permissions
## - **bans**. The sub's list of bans. It is used by the IAM client for validating the token.
## - **jflgs**. It stands for Justice Flags. It is a special flag used for storing additional status information regarding the sub. It is implemented as a bit mask. Following explains what each bit represents:
## - 1: Email Address Verified
## - 2: Phone Number Verified
## - 4: Anonymous
## - 8: Suspicious Login
## - **aud**. The aud is the targeted resource server.
## - **iat**. The time the token issues at. It is in Epoch time format
## - **exp**. The time the token expires. It is in Epoch time format
## - **client_id**. The UserID. The sub is omitted if the token is generated from client credential
## - **scope**. The scope of the access request, expressed as a list of space-delimited, case-sensitive strings
##
## ## Bans
## The JWT contains user's active bans with its expiry date. List of ban types can be obtained from /bans.
## ## Device Cookie Validation
## _**For grant type "password" only**_
## Device Cookie protects the user account from brute force login attacks, more detail from OWASP.
## Reads the device cookie from request header **Auth-Trust-Id**. If no device cookie exists, it generates a new one and sets it into response body **auth_trust_id** when login succeeds.
## ## Track Login History
## Tracks login history to detect suspicious login activity, please provide **Device-Id** (alphanumeric) in request header parameter otherwise it will set to "unknown".
## Align with General Data Protection Regulation in Europe, user login history is retained for up to 28 days by default"
## ## 2FA remember device
## To remember device for 2FA, should provide cookie: device_token or header: Device-Token
## ## Response note
## If it is a user token request and user hasn't accepted required legal policy, the field `is_comply` will be false in response and returned token will have no permission.
##
## Parameters:
## - code_challenge: Value generated by transforming code verifier using code challenge method.
## - code_challenge_method: The method used to transform the code verifier into a code challenge.
## - additional_data: Supplemental information passed to the login success event.
## - client_id: Client Id (used with grant type 'authorization_code')
## - client_secret: Confidential Client Secret (used with grant type 'authorization_code' when using confidential client with client_secret_post authentication method, i.e. not using HTTP Basic authentication)
## - code: The authorization code received from the authorization server (used with grant type 'authorization_code')
## - code_verifier: Code verifier received from the authorization server
## - extend_namespace: Extend namespace, Used on grant type 'urn:ietf:params:oauth:grant-type:extend_client_credentials'.
## - extend_exp: Whether to extend the refresh token's lifetime. Only applies to the password grant type.
## - login_queue_ticket: Login queue ticket(used with grant type `urn:ietf:params:oauth:grant-type:login_queue_ticket`)
## - password: Password (used with grant type 'password')
## - redirect_uri: Redirect URI (used with grant type 'authorization_code')
## - refresh_token: Refresh Token (used with grant type 'refresh_token'). This field is optional if the request header provides the "refresh_token" cookie
## - scope: Scope of the access token when using the `password` or `client_credentials` grant type. Values are space-delimited.
## - username: User Name (used with grant type 'password')
## - grant_type: The OAuth2 grant type.
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
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Generates a target token by exchanging a one-time code
## POST /iam/v4/oauth/token/exchange
##
## Generates a target token by exchanging a one-time code. Requires Basic access authentication using a client ID and secret that matches the one used to request the code.
##
## Parameters:
## - additional_data: Supplemental information passed to the login success event.
## - code: Code from request target token response
func request_target_token_response_v4(code: String, additional_data: String = "") -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	var _result: Dictionary = await _http.request(
		url, AccelbyteHttp.Method.POST, headers, request_body
	)
	if _result.get("success", false) and _token_callback.is_valid():
		# Add endpoint URL for refresh tracking
		_result["_endpoint_url"] = url
		_token_callback.call(_result)
	return _result


## Lists AccelByte user IDs by platform user IDs
## POST /iam/v4/public/namespaces/{namespace}/platforms/{platformId}/users
##
## Lists AccelByte user IDs matching the given platform user IDs in the namespace. Accepts 100 or fewer platform user IDs per request.
##
## Supported platform:
## - steam
## - steamopenid
## - ps4web
## - ps4
## - ps5
## - live
## - xblweb
## - oculus
## - if query by app user id, please set the param `pidType` to `OCULUS_APP_USER_ID`
## - oculusweb
## - facebook
## - google
## - googleplaygames
## - twitch
## - discord
## - apple
## - device
## - justice
## - epicgames
## - nintendo
## - awscognito
## - netflix
## - snapchat
## - oidc platform id
##
## Note:
## **nintendo platform user ID**: Append the Environment ID to the NSA ID using a colon separator. e.g kmzwa8awaa:dd1
## If the request exceeds the maximum size, the max count will be in response body's messageVariables: "messageVariables": {"maxCount": "100"}
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - raw_puid: When true, returns raw platform user IDs. When false, the service returns some platform user IDs in encrypted form.
func public_list_user_id_by_platform_user_i_ds_v4(
	namespace_param: String, platform_id: String, raw_puid: bool = false, body: Dictionary = {}
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


## Retrieves a user by platform user ID
## GET /iam/v4/public/namespaces/{namespace}/platforms/{platformId}/users/{platformUserId}
##
## Returns user information for the given platform ID and platform user ID.
## Platforms form account groups; you can use either platform ID or platform group as platformId path parameter.
## For example, for the Steam network platform, you can use steamnetwork, steam, or steamopenid as the platformId path parameter.
## If the target platform is not linked to the current user, returns only public information.
## ----------
##
## **Supported Platforms:**
## - Steam group (steamnetwork):
## - steam
## - steamopenid
## - PSN group (psn):
## - ps4web
## - ps4
## - ps5
## - XBOX group(xbox):
## - live
## - xblweb
## - Oculus group (oculusgroup):
## - oculus
## - oculusweb
## - Google group (google):
## - google
## - googleplaygames:
## - epicgames
## - facebook
## - twitch
## - discord
## - android
## - ios
## - apple
## - device
## - nintendo
## - awscognito
## - amazon
## - netflix
## - snapchat
## - oidc platform id
##
## Note:
## - You can use either platform id or platform group as **platformId** parameter.
## - **Nintendo platform user id**: Append the Environment ID to the NSA ID using a colon separator. e.g kmzwa8awaa:dd1
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - platform_user_id: User identifier on the third-party platform
func public_get_user_by_platform_user_idv4(
	namespace_param: String, platform_id: String, platform_user_id: String
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


## Creates a test user without sending a verification email
## POST /iam/v4/public/namespaces/{namespace}/test_users
##
## Creates a test user without sending a verification email.
##
## **Required attributes:**
## - verified: whether this new user is verified
## - authType: possible value is EMAILPASSWD
## - emailAddress: must pass the configured input validation rules
## - username: must pass the configured input validation rules
## - password: must pass the configured input validation rules
## - country: ISO3166-1 alpha-2 two letter, e.g. US.
## - dateOfBirth: YYYY-MM-DD, e.g. 1990-01-01. Valid values are between 1905-01-01 and the current date.
##
## **Optional attributes:**
## - displayName: must pass the configured input validation rules
##
## Also accepts agreed policies for the created user via the acceptedPolicies attribute.
##
## Parameters:
## - namespace_param: Game namespace
func public_create_test_user_v4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/test_users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Creates a new user account
## POST /iam/v4/public/namespaces/{namespace}/users
##
## Creates a new user with a unique email address and username.
##
## **Required attributes:**
## - authType: possible value is EMAILPASSWD
## - emailAddress: must pass the configured input validation rules
## - username: must pass the configured input validation rules
## - password: must pass the configured input validation rules
## - country: ISO3166-1 alpha-2 two letter, e.g. US.
## - dateOfBirth: YYYY-MM-DD, e.g. 1990-01-01. Valid values are between 1905-01-01 and the current date.
## - uniqueDisplayName: required when uniqueDisplayNameEnabled/UNIQUE_DISPLAY_NAME_ENABLED is true; must pass the configured input validation rules
## - code: required when mandatoryEmailVerificationEnabled is true
##
## **Optional attributes:**
## - displayName: must pass the configured input validation rules
##
## Also accepts agreed policies for the created user via the acceptedPolicies attribute.
##
## Parameters:
## - namespace_param: Game namespace
func public_create_user_v4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Creates a user account from an invitation
## POST /iam/v4/public/namespaces/{namespace}/users/invite/{invitationId}
##
## Creates a user from the roles saved in the invitation and submits the provided data. The user can log in after completing this operation.
##
## Available authentication types:
##
## EMAILPASSWD: handles new user registration through email.
##
## **Note**: `uniqueDisplayName` applies when `uniqueDisplayNameEnabled`/`UNIQUE_DISPLAY_NAME_ENABLED` is true.
##
## Required attributes:
## - authType: possible value is EMAILPASSWD
## - country: ISO3166-1 alpha-2 two letter, e.g. US.
## - dateOfBirth: YYYY-MM-DD, e.g. 1990-01-01. Valid values are between 1905-01-01 and the current date.
## - displayName: must pass the configured input validation rules
## - password: must pass the configured input validation rules
## - username: must pass the configured input validation rules
##
## Parameters:
## - invitation_id: Invitation ID, should follow UUID version 4 without hyphen
## - namespace_param: Game namespace
func create_user_from_invitation_v4(
	invitation_id: String, namespace_param: String, body: Dictionary = {}
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


## Creates a user account from an invitation and links a platform account
## POST /iam/v4/public/namespaces/{namespace}/users/invite/{invitationId}/platform
##
## Creates the admin account of an invitation created by [PublicCreatePlatformInviteV4], links the platform account of the linking token to it, and finishes the login. It is the platform version of [CreateUserFromInvitationV4]: the account has no password and the email address and display name come from the invitation. Only works in multi-tenant mode for the Admin Portal client, and when admin platform sign up is enabled.
##
## The linking token must come from the authorize flow. The user is logged in by redirecting to the **`redirectUri`** in the response, which carries the authorization code. The linking token is consumed.
##
## If the call fails after the account is created, calling it again with the same linking token and invitation finishes the sign up.
##
## Required attributes:
## - linkingToken: linking token returned by the platform login when the platform account is not linked
## - country: ISO3166-1 alpha-2 two letter, e.g. US.
## - reachMinimumAge: must be true
##
## Parameters:
## - invitation_id: Invitation ID, should follow UUID version 4 without hyphen
## - namespace_param: Accepts alphanumeric, with hyphens allowed between segments
func public_accept_platform_invite_v4(
	invitation_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/invite/{invitationId}/platform"
	url_path = url_path.replace("{" + "invitationId" + "}", invitation_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates the current user's profile
## PATCH /iam/v4/public/namespaces/{namespace}/users/me
##
## Updates the current user's profile. A single request can update one or more fields.
##
## Supported fields: `country`, `displayName`, `languageTag`, `dateOfBirth`, `avatarUrl`, `userName`.
## - country: ISO3166-1 alpha-2 two letter, e.g. US.
## - dateOfBirth: YYYY-MM-DD, e.g. 2019-04-29.
##
## **Email address update response logic:**
## - If the current email has been confirmed, `newEmailAddress` contains the new email address.
## - If the current email is not verified, `emailAddress` and `oldEmailAddress` contain the new email address.
## - If the email was verified and later updated, `emailAddress` and `oldEmailAddress` contain the previously verified email; `newEmailAddress` contains the newest email address.
##
## Parameters:
## - namespace_param: Game namespace
func public_update_user_v4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Updates the current user's email address
## PUT /iam/v4/public/namespaces/{namespace}/users/me/email
##
## Updates the current user's email address. Requires a verification code obtained from the code request operation with the `UpdateEmailAddress` context.
##
## Parameters:
## - namespace_param: Game namespace
func public_update_user_email_address_v4(
	namespace_param: String, body: Dictionary = {}
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


## Upgrades a headless account and verifies the email address
## POST /iam/v4/public/namespaces/{namespace}/users/me/headless/code/verify
##
## Upgrades a headless account by linking it with an email address, username, and password, and verifies the email address in a single call.
##
## To get a verification code, use the send verification code operation.
##
## Optionally updates user data immediately after the upgrade. Supported fields:
## - `displayName`
## - `dateOfBirth`: format YYYY-MM-DD, e.g. 2019-04-29
## - `country`: format ISO3166-1 alpha-2 two letter, e.g. US
##
## Parameters:
## - namespace_param: Game namespace
func public_upgrade_headless_account_with_verification_code_v4(
	namespace_param: String, body: Dictionary = {}
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


## Upgrades a headless account to a full account
## POST /iam/v4/public/namespaces/{namespace}/users/me/headless/verify
##
## Upgrade headless account to full account without verifying email address. Client does not need to provide verification code which sent to email address.
##
## Parameters:
## - namespace_param: Game namespace
func public_upgrade_headless_account_v4(
	namespace_param: String, body: Dictionary = {}
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


## Disables 2FA authenticator for the current user
## DELETE /iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/disable
##
## Disables the 2FA authenticator for the current user.
##
## **Note**: `mfaToken` is required when all of the following are true:
## - The **SENSITIVE_MFA_AUTH_ENABLED** environment variable is enabled
## - **Two-Factor Authentication** is enabled in the client
## - The user has already enabled MFA
##
## Parameters:
## - namespace_param: Game namespace
func public_disable_my_authenticator_v4(
	namespace_param: String, body: Dictionary = {}
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


## Enables 2FA authenticator for the current user
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/enable
##
## Enables the 2FA authenticator for the current user.
##
## Prerequisites:
## - Generate a secret key or QR code URI using the authenticator key operation
## - Scan the QR code or enter the secret key in an authenticator app
## - Enter the code shown in the authenticator app
##
## Parameters:
## - namespace_param: Game namespace
## - code: The time-based one-time password (TOTP) from the authenticator app.
func public_enable_my_authenticator_v4(namespace_param: String, code: String) -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Generates a secret key for a 3rd-party authenticator app
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/key
##
## Generates a secret key for a 3rd-party authenticator app. A QR code URI is also returned so that clients can generate a QR code image.
##
## Parameters:
## - namespace_param: Game namespace
func public_generate_my_authenticator_key_v4(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/authenticator/key"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Disables 2FA backup codes for the current user
## DELETE /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCode/disable
##
## Disables 2FA backup codes for the current user.
##
## **Note**: `mfaToken` is required when all of the following are true:
## - The **SENSITIVE_MFA_AUTH_ENABLED** environment variable is enabled
## - **Two-Factor Authentication** is enabled in the client
## - The user has already enabled MFA
##
## Parameters:
## - namespace_param: Game namespace
func public_disable_my_backup_codes_v4(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves existing backup codes and sends them to the registered email
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes
##
## Retrieves existing 8-digit backup codes for the current user. Each code is a one-time code and expires after use. The service sends the codes to the linked email address.
##
## Parameters:
## - namespace_param: Game namespace
## - language_tag: Language tag for email notification
func public_get_backup_codes_v4(namespace_param: String, language_tag: String = "") -> Dictionary:
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


## Generates new backup codes for the current user
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes
##
## Generates 8-digit backup codes for the current user. Each code is a one-time code and expires after use. The service sends the codes to the linked email address.
##
## Parameters:
## - namespace_param: Game namespace
## - language_tag: Language tag for email notification
func public_generate_backup_codes_v4(
	namespace_param: String, language_tag: String = ""
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


## Enables 2FA backup codes for the current user
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/backupCodes/enable
##
## Enables 2FA backup codes for the current user.
##
## Parameters:
## - namespace_param: Game namespace
## - language_tag: Language tag for email notification
func public_enable_backup_codes_v4(
	namespace_param: String, language_tag: String = ""
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


## Verifies a user MFA code and issues an MFA token
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/challenge/verify
##
## Verifies the user's MFA code and generates an MFA token for the action.
##
## Parameters:
## - namespace_param: Game namespace
## - code: MFA code
## - factor: MFA factor
func public_challenge_my_mfav4(
	namespace_param: String, code: String = "", factor: String = ""
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes the trusted device for the current user
## DELETE /iam/v4/public/namespaces/{namespace}/users/me/mfa/device
##
## (For testing only) Removes the trusted device for the current user. Requires device_token in the cookie.
##
## Parameters:
## - namespace_param: Game namespace
func public_remove_trusted_device_v4(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/device"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Sends a one-time code to the registered email for MFA
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/email/code
##
## Sends a one-time code to the registered email address. Supported actions:
## - ChangePassword
## - DisableMFAEmail
##
## Parameters:
## - namespace_param: Game namespace
## - action: Sensitive Action
## - language_tag: BCP 47 language tag used to localize the email content.
func public_send_my_mfa_email_code_v4(
	namespace_param: String, action: String = "", language_tag: String = ""
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Disables 2FA email for the current user
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/email/disable
##
## Disables 2FA email for the current user.
##
## **Note**: `mfaToken` is required when all of the following are true:
## - The **SENSITIVE_MFA_AUTH_ENABLED** environment variable is enabled
## - **Two-Factor Authentication** is enabled in the client
## - The user has already enabled MFA
##
## Parameters:
## - namespace_param: Game namespace
func public_disable_my_email_v4(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/email/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Enables 2FA email for the current user
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/email/enable
##
## Enables 2FA email for the current user.
##
## Parameters:
## - namespace_param: Game namespace
## - code: The one-time code sent to the registered email address.
func public_enable_my_email_v4(namespace_param: String, code: String) -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists 2FA factors enabled for the current user
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/factor
##
## Returns the 2FA factors currently enabled for the current user.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_my_enabled_factors_v4(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/factor"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Sets the default 2FA factor for the current user
## POST /iam/v4/public/namespaces/{namespace}/users/me/mfa/factor
##
## Sets the specified 2FA factor as the default for the current user.
##
## Parameters:
## - namespace_param: Game namespace
## - factor: The 2FA method to set as default.
func public_make_factor_my_default_v4(namespace_param: String, factor: String) -> Dictionary:
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
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the current user's 2FA status
## GET /iam/v4/public/namespaces/{namespace}/users/me/mfa/status
##
## Returns the 2FA status of the current user.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_my_own_mfa_status_v4(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/namespaces/{namespace}/users/me/mfa/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves public information for a user
## GET /iam/v4/public/namespaces/{namespace}/users/{userId}
##
## Returns only the user's public profile information.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_user_public_info_by_user_id_v4(
	namespace_param: String, user_id: String
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


## Invites a game studio admin user to a new namespace
## POST /iam/v4/public/users/invite
##
## Invites a game studio admin user to a new namespace in multi-tenant mode. Returns an error when multi-tenant mode is not enabled.
##
## - **`emailAddress`**: email address of the user receiving the invitation
## - **`namespace`**: new namespace to create for the user
## - **`namespaceDisplayName`**: display name of the new namespace
## - **`additionalData`** (optional): UTM parameter data
##
## Invited users are also assigned the User role by default.
func public_invite_user_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/users/invite"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Creates a game studio invitation from a platform account
## POST /iam/v4/public/users/invite/platform
##
## Creates the invitation for a new game studio namespace from a verified platform account. It is the platform version of [PublicInviteUserV4]: the email address comes from the linking token and no invitation email is sent. Only works in multi-tenant mode for the Admin Portal client, and when admin platform sign up is enabled. The call does not consume the linking token.
##
## - **`linkingToken`**: linking token returned by the platform login when the platform account is not linked
## - **`namespace`**: new namespace to create for the user
## - **`namespaceDisplayName`**: display name of the new namespace
## - **`displayName`** (optional): display name of the user, the name of the platform account is used when empty
## - **`additionalData`** (optional): extra data as a JSON object string, such as UTM parameters
##
## The display name must pass the input validation rules, and be unique when unique display name is enabled. When it does not, the error carries the checked name in **`messageVariables.displayName`**, so the caller can ask for another one.
##
## Calling again with the same namespace and the same platform account returns the existing invitation. A platform account keeps one pending invitation: calling with another namespace replaces the earlier invitation and frees its namespace. The invitation can only be accepted with the platform account that created it.
func public_create_platform_invite_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/users/invite/platform"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Checks the account state of a platform account before studio sign up
## POST /iam/v4/public/users/invite/platform/check
##
## Checks what the Admin Portal login website should do with a platform account that is not linked to any account. Only works in multi-tenant mode for the Admin Portal client, and when admin platform sign up is enabled. The call has no side effect and does not consume the linking token.
##
## - **`linkingToken`**: linking token returned by the platform login when the platform account is not linked
##
## Result **`status`**:
## - **`new`**: no account uses the email address, the user can sign up a new studio
## - **`link`**: an admin account uses the email address, the user can link the platform account to it by logging in with the password
## - **`taken`**: a non-admin account (for example a player) uses the email address, so sign up is not possible. The email address is not returned.
func public_check_platform_invite_v4(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/users/invite/platform/check"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Upgrades a headless account and verifies the email address with redirect
## POST /iam/v4/public/users/me/headless/code/verify/forward
##
## Forward version of the headless account upgrade. Upgrades a headless account by linking it with an email address, username, and password, and verifies the email address in a single call.
##
## To get a verification code, use the send verification code operation.
##
## Optionally updates user data immediately after the upgrade when profile fields are included.
func public_upgrade_headless_with_code_v4_forward(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/iam/v4/public/users/me/headless/code/verify/forward"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
