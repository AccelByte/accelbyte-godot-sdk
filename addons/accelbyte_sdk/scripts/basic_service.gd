## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## basic_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-basic-service
## Version: 4.4.4
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(BasicService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name BasicService
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


## Retrieves all namespaces
## GET /basic/v1/admin/namespaces
##
## Retrieves all game namespaces. Use the `activeOnly` query parameter to filter results to active namespaces only.
##
## Parameters:
## - active_only: Only retrieves active namespaces
## - is_testing: filter namespaces by testing flag (true, false, or empty for all)
func get_namespaces(active_only: bool = false, is_testing: bool = false) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	query_params["isTesting"] = is_testing
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a namespace
## POST /basic/v1/admin/namespaces
##
## Creates a new namespace, enabled by default. In multi-tenant mode, AccelByte fills `parentNamespace` automatically: studio or publisher tokens use the requester's namespace, game tokens use the studio namespace. The operation also creates an OAuth client and returns its ID. `displayName` rules: alphanumeric characters (upper and lowercase) and the special characters `'`, `,`, `.`, `-`. Must start and end with an alphanumeric character. Spaces and special characters cannot appear consecutively.
func create_namespace(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a namespace
## GET /basic/v1/admin/namespaces/{namespace}
##
## Retrieves the specified namespace. In multi-tenant mode, the response includes the `parentNamespace` field.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Only retrieves active namespaces
func get_namespace(namespace_param: String, active_only: bool = false) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a namespace
## DELETE /basic/v1/admin/namespaces/{namespace}
##
## Deletes the specified namespace and returns its details.
##
## Parameters:
## - namespace_param: Game namespace
func delete_namespace(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates namespace basic info
## PATCH /basic/v1/admin/namespaces/{namespace}/basic
##
## Updates the display name of the specified namespace. `displayName` rules: alphanumeric characters (upper and lowercase) and the special characters `'`, `,`, `.`, `-`. Must start and end with an alphanumeric character. Spaces and special characters cannot appear consecutively.
##
## Parameters:
## - namespace_param: Game namespace
func update_namespace(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/basic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves child namespaces
## GET /basic/v1/admin/namespaces/{namespace}/child
##
## Retrieves the child namespaces of the specified namespace. Publisher namespaces return their studio namespaces; studio namespaces return their game namespaces. Use the `activeOnly` parameter to filter results to active namespaces only.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Only retrieves active namespaces
func get_child_namespaces(namespace_param: String, active_only: bool = false) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/child"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a config
## POST /basic/v1/admin/namespaces/{namespace}/configs
##
## Creates a namespace configuration entry with a key-value pair.
##
## Parameters:
## - namespace_param: Game namespace
func create_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/configs"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a config
## GET /basic/v1/admin/namespaces/{namespace}/configs/{configKey}
##
## Retrieves a configuration entry by key from the specified namespace.
##
## Parameters:
## - config_key: Configuration key to retrieve.
## - namespace_param: Game namespace
func get_config(config_key: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/configs/{configKey}"
	url_path = url_path.replace("{" + "configKey" + "}", config_key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a config
## DELETE /basic/v1/admin/namespaces/{namespace}/configs/{configKey}
##
## Deletes the specified configuration entry from the namespace.
##
## Parameters:
## - config_key: Configuration key to delete.
## - namespace_param: Game namespace
func delete_config(config_key: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/configs/{configKey}"
	url_path = url_path.replace("{" + "configKey" + "}", config_key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a config
## PATCH /basic/v1/admin/namespaces/{namespace}/configs/{configKey}
##
## Updates the value of the specified configuration entry in the namespace.
##
## Parameters:
## - config_key: Configuration key to update.
## - namespace_param: Game namespace
func update_config(
	config_key: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/configs/{configKey}"
	url_path = url_path.replace("{" + "configKey" + "}", config_key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves context of namespace
## GET /basic/v1/admin/namespaces/{namespace}/context
##
## Retrieves contextual metadata for the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - refresh_on_cache_miss: Whether to refresh the context when absent from the cache.
func get_namespace_context(
	namespace_param: String, refresh_on_cache_miss: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/context"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["refreshOnCacheMiss"] = refresh_on_cache_miss
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Generates an upload URL
## POST /basic/v1/admin/namespaces/{namespace}/folders/{folder}/files
##
## Generates a pre-signed upload URL for the specified folder. The URL is valid for 10 minutes.
##
## Parameters:
## - folder: Destination folder for the uploaded file. Must be 1â6 characters; `` and `<>` are not allowed.
## - namespace_param: Game namespace
## - file_type: One of the these types: jpeg, jpg, png, bmp, gif, mp3, bin, webp, mp4, webm
func generated_upload_url(folder: String, namespace_param: String, file_type: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/folders/{folder}/files"
	url_path = url_path.replace("{" + "folder" + "}", folder.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not file_type.is_empty():
		query_params["fileType"] = file_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves game namespaces
## GET /basic/v1/admin/namespaces/{namespace}/game
##
## Retrieves game namespaces. In multi-tenant mode, a super admin namespace returns all game namespaces across its studio namespaces. Use `activeOnly` to filter results to active namespaces.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Only retrieves active namespaces
func get_game_namespaces(namespace_param: String, active_only: bool = false) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/game"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists country groups
## GET /basic/v1/admin/namespaces/{namespace}/misc/countrygroups
##
## Lists country groups in the namespace. Returns all country groups if `groupCode` is not specified.
##
## Parameters:
## - namespace_param: Game namespace
## - group_code: GroupCode, only accept alphabet and whitespace
func get_country_groups(namespace_param: String, group_code: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/countrygroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not group_code.is_empty():
		query_params["groupCode"] = group_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Adds a country group
## POST /basic/v1/admin/namespaces/{namespace}/misc/countrygroups
##
## Adds a new country group to the namespace. Country codes must follow ISO 3166-1 alpha-2.
##
## Parameters:
## - namespace_param: Game namespace
func add_country_group(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/countrygroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates a country group
## PUT /basic/v1/admin/namespaces/{namespace}/misc/countrygroups/{countryGroupCode}
##
## Updates a country group. The group identified by `countryGroupCode` must already exist. To update only `countryGroupName`, omit `countries` or pass an empty array. To update only `countries`, omit `countryGroupName` or pass a blank value.
##
## Parameters:
## - country_group_code: GroupCode, only accept alphabet and whitespace
## - namespace_param: Game namespace
func update_country_group(
	country_group_code: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/countrygroups/{countryGroupCode}"
	url_path = url_path.replace("{" + "countryGroupCode" + "}", country_group_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes a country group
## DELETE /basic/v1/admin/namespaces/{namespace}/misc/countrygroups/{countryGroupCode}
##
## Deletes a country group by its country group code. Typically used to remove test data.
##
## Parameters:
## - country_group_code: GroupCode, only accept alphabet and whitespace
## - namespace_param: Game namespace
func delete_country_group(country_group_code: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/countrygroups/{countryGroupCode}"
	url_path = url_path.replace("{" + "countryGroupCode" + "}", country_group_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists languages
## GET /basic/v1/admin/namespaces/{namespace}/misc/languages
##
## Lists all supported languages available in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func get_languages(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/languages"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists time zones
## GET /basic/v1/admin/namespaces/{namespace}/misc/timezones
##
## Lists all supported time zones available in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func get_time_zones(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/timezones"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves user profile by public ID
## GET /basic/v1/admin/namespaces/{namespace}/profiles/byPublicId
##
## Retrieves a user profile by its public ID.
##
## Parameters:
## - namespace_param: Game namespace
## - public_id: User public id
func get_user_profile_info_by_public_id(namespace_param: String, public_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/profiles/byPublicId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not public_id.is_empty():
		query_params["publicId"] = public_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves public user profile info by user IDs
## POST /basic/v1/admin/namespaces/{namespace}/profiles/public
##
## Retrieves public user profile information for a list of user IDs. Accepts up to 100 user IDs per request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_user_profile_public_info_by_ids(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/profiles/public"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves publisher namespace info for a namespace
## GET /basic/v1/admin/namespaces/{namespace}/publisher
##
## Retrieves information about the publisher namespace associated with the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func get_namespace_publisher(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/publisher"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a publisher config
## GET /basic/v1/admin/namespaces/{namespace}/publisher/configs/{configKey}
##
## Retrieves a configuration entry from the publisher namespace by key.
##
## Parameters:
## - config_key: Configuration key to retrieve.
## - namespace_param: Game namespace
func get_publisher_config(config_key: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/publisher/configs/{configKey}"
	url_path = url_path.replace("{" + "configKey" + "}", config_key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the active status of a namespace
## PATCH /basic/v1/admin/namespaces/{namespace}/status
##
## Changes the status of the specified namespace to `ACTIVE` or `INACTIVE`.
##
## Parameters:
## - namespace_param: Game namespace
func change_namespace_status(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Update namespace testing flag
## PATCH /basic/v1/admin/namespaces/{namespace}/testingFlag
##
## Update namespace testing flag.
## In multi-tenant mode, this is only applicable for studio namespaces, not game namespaces.
## Other detail info:
##
## * Returns : updated namespace
##
## Parameters:
## - namespace_param: namespace, only accept alphabet and numeric
func update_testing_flag(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/testingFlag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Deletes user profile data for anonymization
## DELETE /basic/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/profiles
##
## Anonymizes the user profile by removing or obfuscating personally identifiable information.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_user_profile(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Generates an upload URL for user content
## POST /basic/v1/admin/namespaces/{namespace}/users/{userId}/files
##
## Generates a pre-signed upload URL for user content. The URL is valid for 10 minutes.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - category: Upload category. Supported categories: default, reporting
## - file_type: One of the these types: jpeg, jpg, png, bmp, gif, mp3, bin, webp, mp4, webm
func generated_user_upload_content_url(
	namespace_param: String, user_id: String, file_type: String, category: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/files"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not category.is_empty():
		query_params["category"] = category
	if not file_type.is_empty():
		query_params["fileType"] = file_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves user profile
## GET /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles
##
## Retrieves the profile of the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_profile_info(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates user profile
## PUT /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles
##
## Updates the profile of the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_user_profile(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes user profile
## DELETE /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles
##
## Deletes the profile of the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_user_profile(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves user custom attributes
## GET /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/customAttributes
##
## Retrieves the custom attributes of the specified user's profile.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_custom_attributes_info(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/customAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates custom attributes for a user
## PUT /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/customAttributes
##
## Updates the custom attributes of the specified user's profile. The body must be a JSON object.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_custom_attributes_partially(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/customAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves user private custom attributes
## GET /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/privateCustomAttributes
##
## Retrieves the private custom attributes of the specified user's profile.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_private_custom_attributes_info(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/privateCustomAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates private custom attributes for a user
## PUT /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/privateCustomAttributes
##
## Updates the private custom attributes of the specified user's profile. The body must be a JSON object.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_private_custom_attributes_partially(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/privateCustomAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates user profile status
## PATCH /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/status
##
## Updates the status of the specified user's profile to `ACTIVE` or `INACTIVE`.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_user_profile_status(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves server time
## GET /basic/v1/public/misc/time
##
## Returns the current server time as an ISO 8601 timestamp. Useful for clock synchronisation and validating time-sensitive operations.
func public_get_time() -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/misc/time"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves all namespaces
## GET /basic/v1/public/namespaces
##
## Retrieves all game namespaces. Use the `activeOnly` query parameter to filter results to active namespaces only.
##
## Parameters:
## - active_only: Only retrieves active namespaces
func public_get_namespaces(active_only: bool = false) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves namespace info
## GET /basic/v1/public/namespaces/{namespace}
##
## Retrieves information about the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func get_namespace_1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Generates an upload URL
## POST /basic/v1/public/namespaces/{namespace}/folders/{folder}/files
##
## Generates a pre-signed upload URL for the specified folder. The URL is valid for 10 minutes.
##
## Parameters:
## - folder: Destination folder for the uploaded file. Must be 1â6 characters; `` and `<>` are not allowed.
## - namespace_param: Game namespace
## - file_type: One of the these types: jpeg, jpg, png, bmp, gif, mp3, bin, webp
func public_generated_upload_url(
	folder: String, namespace_param: String, file_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/folders/{folder}/files"
	url_path = url_path.replace("{" + "folder" + "}", folder.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not file_type.is_empty():
		query_params["fileType"] = file_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists languages
## GET /basic/v1/public/namespaces/{namespace}/misc/languages
##
## Lists all supported languages available in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_languages(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/misc/languages"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists time zones
## GET /basic/v1/public/namespaces/{namespace}/misc/timezones
##
## Lists all supported time zones available in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_time_zones(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/misc/timezones"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves public user profile info by user IDs
## GET /basic/v1/public/namespaces/{namespace}/profiles/public
##
## Retrieves public profile information for the specified user IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - user_ids: User IDs, should follow UUID version 4 without hyphen, separate the IDs using comma
func public_get_user_profile_public_info_by_ids(
	namespace_param: String, user_ids: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/profiles/public"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not user_ids.is_empty():
		query_params["userIds"] = user_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves public user profile info in bulk by user IDs
## POST /basic/v1/public/namespaces/{namespace}/profiles/public
##
## Retrieves public profile information for a list of user IDs.
##
## Parameters:
## - namespace_param: Game namespace
func public_bulk_get_user_profile_public_info(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/profiles/public"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves public user profile by public ID
## GET /basic/v1/public/namespaces/{namespace}/profiles/public/byPublicId
##
## Retrieves the public user profile associated with the given public ID.
##
## Parameters:
## - namespace_param: Game namespace
## - public_id: User public id
func public_get_user_profile_info_by_public_id(
	namespace_param: String, public_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/profiles/public/byPublicId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not public_id.is_empty():
		query_params["publicId"] = public_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves publisher namespace info for a namespace
## GET /basic/v1/public/namespaces/{namespace}/publisher
##
## Retrieves information about the publisher namespace associated with the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_namespace_publisher(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/publisher"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves my profile
## GET /basic/v1/public/namespaces/{namespace}/users/me/profiles
##
## Retrieves the profile of the authenticated user in the specified namespace. Use the publisher namespace to get the publisher user profile, or the game namespace to get the game user profile. Language format: `en`, `en-US`. Timezone: IANA format, e.g. `Asia/Shanghai`.
##
## Parameters:
## - namespace_param: Game namespace
func get_my_profile_info(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates my profile
## PUT /basic/v1/public/namespaces/{namespace}/users/me/profiles
##
## Updates the authenticated user's profile in the target namespace. If the token's namespace differs from the target namespace, AccelByte automatically maps the user ID. Language format: `en`, `en-US`. Timezone: IANA format, e.g. `Asia/Shanghai`.
##
## Parameters:
## - namespace_param: Game namespace
func update_my_profile(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates my profile
## POST /basic/v1/public/namespaces/{namespace}/users/me/profiles
##
## Creates the authenticated user's profile in the specified namespace. Use the publisher namespace to create a publisher user profile, or the game namespace for a game user profile. Language format: `en`, `en-US`. Timezone: IANA format, e.g. `Asia/Shanghai`.
##
## Parameters:
## - namespace_param: Game namespace
func create_my_profile(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves my private custom attributes
## GET /basic/v1/public/namespaces/{namespace}/users/me/profiles/privateCustomAttributes
##
## Retrieves the private custom attributes of the authenticated user's profile.
##
## Parameters:
## - namespace_param: Game namespace
func get_my_private_custom_attributes_info(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles/privateCustomAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates my private custom attributes
## PUT /basic/v1/public/namespaces/{namespace}/users/me/profiles/privateCustomAttributes
##
## Updates the private custom attributes of the authenticated user's profile. The body must be a JSON object.
##
## Parameters:
## - namespace_param: Game namespace
func update_my_private_custom_attributes_partially(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles/privateCustomAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves my zip code
## GET /basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode
##
## Retrieves the zip code from the authenticated user's profile.
##
## Parameters:
## - namespace_param: Game namespace
func get_my_zip_code(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates my zip code
## PATCH /basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode
##
## Updates the zip code in the authenticated user's profile.
##
## Parameters:
## - namespace_param: Game namespace
func update_my_zip_code(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Generates an upload URL for user content
## POST /basic/v1/public/namespaces/{namespace}/users/{userId}/files
##
## Generates a pre-signed upload URL for user content. The URL is valid for 10 minutes. Storage limits vary by upload category:
##
## - **Default**: 10 files and 100 MB per user.
## - **Reporting**: 3 files and 30 MB per user per hour.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - category: Upload category. Supported categories: default, reporting
## - file_type: One of the these types: jpeg, jpg, png, bmp, gif, mp3, bin, webp
func public_generated_user_upload_content_url(
	namespace_param: String, user_id: String, file_type: String, category: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/files"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not category.is_empty():
		query_params["category"] = category
	if not file_type.is_empty():
		query_params["fileType"] = file_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves user profile
## GET /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles
##
## Retrieves the profile of the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_user_profile_info(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates user profile
## PUT /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles
##
## Updates the profile of the specified user. Language format: `en`, `en-US`. Timezone: IANA format, e.g. `Asia/Shanghai`.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_update_user_profile(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates user profile
## POST /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles
##
## Creates a profile for the specified user. Language format: `en`, `en-US`. Timezone: IANA format, e.g. `Asia/Shanghai`.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_create_user_profile(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves user custom attributes
## GET /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/customAttributes
##
## Retrieves the custom attributes of the specified user's profile.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_custom_attributes_info(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/customAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates custom attributes for a user
## PUT /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/customAttributes
##
## Updates the custom attributes of the specified user's profile. The body must be a JSON object.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_update_custom_attributes_partially(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/customAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves public user profile info
## GET /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/public
##
## Retrieves the public profile of the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_user_profile_public_info(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/public"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates user profile status
## PATCH /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/status
##
## Updates the status of the specified user's profile to `ACTIVE` or `INACTIVE`.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_update_user_profile_status(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)
