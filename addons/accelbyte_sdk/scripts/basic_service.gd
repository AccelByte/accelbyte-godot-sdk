## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## basic_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-basic-service
## Version: 4.2.2
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

## Get all namespaces
## GET /basic/v1/admin/namespaces
func get_namespaces(
	active_only: bool = false,
	is_testing: bool = false
) -> Dictionary:
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

## Create a namespace
## POST /basic/v1/admin/namespaces
func create_namespace(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a namespace
## GET /basic/v1/admin/namespaces/{namespace}
func get_namespace(
	namespace_param: String,
	active_only: bool = false
) -> Dictionary:
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

## Delete a namespace
## DELETE /basic/v1/admin/namespaces/{namespace}
func delete_namespace(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update namespace basic info
## PATCH /basic/v1/admin/namespaces/{namespace}/basic
func update_namespace(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/basic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get child namespaces
## GET /basic/v1/admin/namespaces/{namespace}/child
func get_child_namespaces(
	namespace_param: String,
	active_only: bool = false
) -> Dictionary:
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

## Create a config
## POST /basic/v1/admin/namespaces/{namespace}/configs
func create_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/configs"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a config
## GET /basic/v1/admin/namespaces/{namespace}/configs/{configKey}
func get_config(
	config_key: String,
	namespace_param: String
) -> Dictionary:
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

## Delete a config
## DELETE /basic/v1/admin/namespaces/{namespace}/configs/{configKey}
func delete_config(
	config_key: String,
	namespace_param: String
) -> Dictionary:
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

## Update a config
## PATCH /basic/v1/admin/namespaces/{namespace}/configs/{configKey}
func update_config(
	config_key: String,
	namespace_param: String,
	body: Dictionary = {}
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

## Get context of namespace
## GET /basic/v1/admin/namespaces/{namespace}/context
func get_namespace_context(
	namespace_param: String,
	refresh_on_cache_miss: bool = false
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

## Generate Upload URL
## POST /basic/v1/admin/namespaces/{namespace}/folders/{folder}/files
func generated_upload_url(
	folder: String,
	namespace_param: String,
	file_type: String
) -> Dictionary:
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

## Get game namespaces
## GET /basic/v1/admin/namespaces/{namespace}/game
func get_game_namespaces(
	namespace_param: String,
	active_only: bool = false
) -> Dictionary:
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

## List countries
## GET /basic/v1/admin/namespaces/{namespace}/misc/countries
## @deprecated
func get_countries(
	namespace_param: String,
	lang: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/countries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not lang.is_empty():
		query_params["lang"] = lang
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List country groups
## GET /basic/v1/admin/namespaces/{namespace}/misc/countrygroups
func get_country_groups(
	namespace_param: String,
	group_code: String = ""
) -> Dictionary:
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

## Add a country group
## POST /basic/v1/admin/namespaces/{namespace}/misc/countrygroups
func add_country_group(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/countrygroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update a country group
## PUT /basic/v1/admin/namespaces/{namespace}/misc/countrygroups/{countryGroupCode}
func update_country_group(
	country_group_code: String,
	namespace_param: String,
	body: Dictionary = {}
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

## Delete a country group
## DELETE /basic/v1/admin/namespaces/{namespace}/misc/countrygroups/{countryGroupCode}
func delete_country_group(
	country_group_code: String,
	namespace_param: String
) -> Dictionary:
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

## List languages.
## GET /basic/v1/admin/namespaces/{namespace}/misc/languages
func get_languages(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/languages"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List time zones
## GET /basic/v1/admin/namespaces/{namespace}/misc/timezones
func get_time_zones(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/misc/timezones"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user profile info by public id
## GET /basic/v1/admin/namespaces/{namespace}/profiles/byPublicId
func get_user_profile_info_by_public_id(
	namespace_param: String,
	public_id: String
) -> Dictionary:
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

## Admin get user profile public info by ids
## POST /basic/v1/admin/namespaces/{namespace}/profiles/public
func admin_get_user_profile_public_info_by_ids(
	namespace_param: String,
	body: Dictionary = {}
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

## Get namespace info related publisher namespace
## GET /basic/v1/admin/namespaces/{namespace}/publisher
func get_namespace_publisher(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/publisher"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a publisher config
## GET /basic/v1/admin/namespaces/{namespace}/publisher/configs/{configKey}
func get_publisher_config(
	config_key: String,
	namespace_param: String
) -> Dictionary:
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

## Change namespace status
## PATCH /basic/v1/admin/namespaces/{namespace}/status
func change_namespace_status(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
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
func update_testing_flag(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/admin/namespaces/{namespace}/testingFlag"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## anonymize user profile
## DELETE /basic/v1/admin/namespaces/{namespace}/users/{userId}/anonymization/profiles
func anonymize_user_profile(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Generate Upload URL For User Content
## POST /basic/v1/admin/namespaces/{namespace}/users/{userId}/files
func generated_user_upload_content_url(
	namespace_param: String,
	user_id: String,
	file_type: String,
	category: String = ""
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

## Get user profile
## GET /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles
func get_user_profile_info(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Update user profile
## PUT /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles
func update_user_profile(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Delete user profile
## DELETE /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles
func delete_user_profile(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Get user custom attributes
## GET /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/customAttributes
func get_custom_attributes_info(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Update partially custom attributes tied to the user id
## PUT /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/customAttributes
func update_custom_attributes_partially(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Get user private custom attributes
## GET /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/privateCustomAttributes
func get_private_custom_attributes_info(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Update partially private custom attributes tied to the user id
## PUT /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/privateCustomAttributes
func update_private_custom_attributes_partially(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Update user profile status
## PATCH /basic/v1/admin/namespaces/{namespace}/users/{userId}/profiles/status
func update_user_profile_status(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Get server time
## GET /basic/v1/public/misc/time
func public_get_time() -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/misc/time"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all namespaces
## GET /basic/v1/public/namespaces
func public_get_namespaces(
	active_only: bool = false
) -> Dictionary:
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

## Get a namespace info
## GET /basic/v1/public/namespaces/{namespace}
func get_namespace_1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate Upload URL
## POST /basic/v1/public/namespaces/{namespace}/folders/{folder}/files
func public_generated_upload_url(
	folder: String,
	namespace_param: String,
	file_type: String
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

## List countries
## GET /basic/v1/public/namespaces/{namespace}/misc/countries
## @deprecated
func public_get_countries(
	namespace_param: String,
	lang: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/misc/countries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not lang.is_empty():
		query_params["lang"] = lang
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List languages.
## GET /basic/v1/public/namespaces/{namespace}/misc/languages
func public_get_languages(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/misc/languages"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List time zones
## GET /basic/v1/public/namespaces/{namespace}/misc/timezones
func public_get_time_zones(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/misc/timezones"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user profile public info by ids
## GET /basic/v1/public/namespaces/{namespace}/profiles/public
func public_get_user_profile_public_info_by_ids(
	namespace_param: String,
	user_ids: String
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

## Bulk get user profile public info by ids
## POST /basic/v1/public/namespaces/{namespace}/profiles/public
func public_bulk_get_user_profile_public_info(
	namespace_param: String,
	body: Dictionary = {}
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

## Get user profile public info by public id
## GET /basic/v1/public/namespaces/{namespace}/profiles/public/byPublicId
func public_get_user_profile_info_by_public_id(
	namespace_param: String,
	public_id: String
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

## Get namespace info related publisher namespace
## GET /basic/v1/public/namespaces/{namespace}/publisher
func public_get_namespace_publisher(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/publisher"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get my profile
## GET /basic/v1/public/namespaces/{namespace}/users/me/profiles
func get_my_profile_info(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update my profile
## PUT /basic/v1/public/namespaces/{namespace}/users/me/profiles
func update_my_profile(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create my profile
## POST /basic/v1/public/namespaces/{namespace}/users/me/profiles
func create_my_profile(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get my private custom attributes
## GET /basic/v1/public/namespaces/{namespace}/users/me/profiles/privateCustomAttributes
func get_my_private_custom_attributes_info(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles/privateCustomAttributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update partially private custom attributes tied to me
## PUT /basic/v1/public/namespaces/{namespace}/users/me/profiles/privateCustomAttributes
func update_my_private_custom_attributes_partially(
	namespace_param: String,
	body: Dictionary = {}
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

## Get my zip code
## GET /basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode
func get_my_zip_code(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update my zip code
## PATCH /basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode
func update_my_zip_code(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/basic/v1/public/namespaces/{namespace}/users/me/profiles/zipCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Generate Upload URL For User Content
## POST /basic/v1/public/namespaces/{namespace}/users/{userId}/files
func public_generated_user_upload_content_url(
	namespace_param: String,
	user_id: String,
	file_type: String,
	category: String = ""
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

## Get user profile
## GET /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles
func public_get_user_profile_info(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Update user profile
## PUT /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles
func public_update_user_profile(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Create user profile
## POST /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles
func public_create_user_profile(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Get custom attributes info
## GET /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/customAttributes
func public_get_custom_attributes_info(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Update partially custom attributes tied to user id
## PUT /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/customAttributes
func public_update_custom_attributes_partially(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Get user profile public info
## GET /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/public
func public_get_user_profile_public_info(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Update user profile status
## PATCH /basic/v1/public/namespaces/{namespace}/users/{userId}/profiles/status
func public_update_user_profile_status(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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
