## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## cloudsave_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-cloudsave-service
## Version: 3.30.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(CloudsaveService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name CloudsaveService
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

## List key of admin game record
## GET /cloudsave/v1/admin/namespaces/{namespace}/adminrecords
func admin_list_admin_game_record_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get admin game records
## POST /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/bulk
func admin_bulk_get_admin_game_record_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get admin game record
## GET /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_get_admin_game_record_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace admin game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_put_admin_game_record_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append admin game record
## POST /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_post_admin_game_record_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete admin game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
func admin_delete_admin_game_record_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete admin game record TTL config
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}/ttl
func delete_admin_game_record_ttl_config(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}/ttl"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Query game binary records
## GET /cloudsave/v1/admin/namespaces/{namespace}/binaries
func admin_list_game_binary_records_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create game binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/binaries
func admin_post_game_binary_record_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get game binary record
## GET /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
func admin_get_game_binary_record_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update game binary record file
## PUT /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
func admin_put_game_binary_record_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete game binary record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
func admin_delete_game_binary_record_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update game binary record metadata
## PUT /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/metadata
func admin_put_game_binary_recor_metadata_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/metadata"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Request presigned URL for upload game binary records
## POST /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/presigned
func admin_post_game_binary_presigned_urlv1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete game binary record TTL config
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/ttl
func delete_game_binary_record_ttl_config(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/ttl"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Create or replace admin game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/concurrent/adminrecords/{key}
func admin_put_admin_game_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/concurrent/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/concurrent/records/{key}
func admin_put_game_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get plugin configuration
## GET /cloudsave/v1/admin/namespaces/{namespace}/plugins
func get_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create plugin configuration
## POST /cloudsave/v1/admin/namespaces/{namespace}/plugins
func create_plugin_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete plugin configuration
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/plugins
func delete_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update plugin configuration
## PATCH /cloudsave/v1/admin/namespaces/{namespace}/plugins
func update_plugin_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Query game records
## GET /cloudsave/v1/admin/namespaces/{namespace}/records
func list_game_records_handler_v1(
	namespace_param: String,
	limit: int,
	offset: int,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
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

## Get game record
## GET /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_get_game_record_handler_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_put_game_record_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append game record
## POST /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_post_game_record_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
func admin_delete_game_record_handler_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete game record TTL config
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/records/{key}/ttl
func delete_game_record_ttl_config(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/records/{key}/ttl"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List tags
## GET /cloudsave/v1/admin/namespaces/{namespace}/tags
func admin_list_tags_handler_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/tags"
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

## Create a tag
## POST /cloudsave/v1/admin/namespaces/{namespace}/tags
func admin_post_tag_handler_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete a tag
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/tags/{tag}
func admin_delete_tag_handler_v1(
	namespace_param: String,
	tag: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/tags/{tag}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "tag" + "}", tag.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Bulk get admin player record by multiple user ID
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/adminrecords/{key}/bulk
func bulk_get_admin_player_record_by_user_ids_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/adminrecords/{key}/bulk"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk get player records size
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/bulk/records/size
func bulk_get_player_record_size_handler_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/bulk/records/size"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve list of public player records
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/records
## @deprecated
func list_player_record_handler_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	query: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/records"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk update player records by key
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk
func admin_bulk_put_player_records_by_key_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Bulk get player records by multiple user ids
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk
func admin_bulk_get_player_records_by_user_i_ds_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List key of admin player record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords
func admin_list_admin_user_records_v1(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get admin player records
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/bulk
func admin_bulk_get_admin_player_record_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get admin player record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_get_admin_player_record_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace admin player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_put_admin_player_record_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append admin player record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_post_player_admin_record_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete admin player record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
func admin_delete_admin_player_record_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Query player binary records
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries
func admin_list_player_binary_records_v1(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create player binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries
func admin_post_player_binary_record_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get player binary record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
func admin_get_player_binary_record_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update player binary record file
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
func admin_put_player_binary_record_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete player binary record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
func admin_delete_player_binary_record_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update player binary record metadata
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata
func admin_put_player_binary_recor_metadata_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Request presigned URL for upload player binary records
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned
func admin_post_player_binary_presigned_urlv1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create or replace admin player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/adminrecords/{key}
func admin_put_admin_player_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	response_body: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/adminrecords/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or replace player private record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}
func admin_put_player_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	response_body: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public
func admin_put_player_public_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	response_body: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query player records
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records
func admin_retrieve_player_records(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records"
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
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk update player records
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk
func admin_put_player_records_handler_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Bulk get player records by multiple record keys
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk
func admin_get_player_records_handler_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get player record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_get_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_put_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append player record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_post_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete player record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
func admin_delete_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get player public record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_get_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_put_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append player public record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_post_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete player public record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
func admin_delete_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get player record size
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/size
func admin_get_player_record_size_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/size"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query game binary records
## GET /cloudsave/v1/namespaces/{namespace}/binaries
func list_game_binary_records_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create game binary record
## POST /cloudsave/v1/namespaces/{namespace}/binaries
func post_game_binary_record_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk get game binary records
## POST /cloudsave/v1/namespaces/{namespace}/binaries/bulk
func bulk_get_game_binary_record_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get game binary record
## GET /cloudsave/v1/namespaces/{namespace}/binaries/{key}
func get_game_binary_record_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update game binary record file
## PUT /cloudsave/v1/namespaces/{namespace}/binaries/{key}
func put_game_binary_record_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete game binary record
## DELETE /cloudsave/v1/namespaces/{namespace}/binaries/{key}
func delete_game_binary_record_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Request presigned URL for upload game binary records
## POST /cloudsave/v1/namespaces/{namespace}/binaries/{key}/presigned
func post_game_binary_presigned_urlv1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/namespaces/{namespace}/concurrent/records/{key}
func put_game_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Bulk get game records
## POST /cloudsave/v1/namespaces/{namespace}/records/bulk
func get_game_records_bulk(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get game record
## GET /cloudsave/v1/namespaces/{namespace}/records/{key}
func get_game_record_handler_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace game record
## PUT /cloudsave/v1/namespaces/{namespace}/records/{key}
func put_game_record_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append game record
## POST /cloudsave/v1/namespaces/{namespace}/records/{key}
func post_game_record_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete game record
## DELETE /cloudsave/v1/namespaces/{namespace}/records/{key}
func delete_game_record_handler_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List tags
## GET /cloudsave/v1/namespaces/{namespace}/tags
func public_list_tags_handler_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/tags"
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

## Bulk get player public records
## POST /cloudsave/v1/namespaces/{namespace}/users/bulk/binaries/{key}/public
func bulk_get_player_public_binary_records_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/bulk/binaries/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk get player public records
## POST /cloudsave/v1/namespaces/{namespace}/users/bulk/records/{key}/public
func bulk_get_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/bulk/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query my binary records
## GET /cloudsave/v1/namespaces/{namespace}/users/me/binaries
func list_my_binary_records_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	query: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not query.is_empty():
		query_params["query"] = query
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get player records bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/me/binaries/bulk
func bulk_get_my_binary_record_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/binaries/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query player records key
## GET /cloudsave/v1/namespaces/{namespace}/users/me/records
func retrieve_player_records(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/records"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get player records bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/me/records/bulk
func get_player_records_bulk_handler_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/records/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete player public record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/me/records/{key}/public
func public_delete_player_public_record_handler_v1(
	key: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Create player binary record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries
func post_player_binary_record_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query other player public binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public
func list_other_player_public_binary_records_v1(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public"
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
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get other player public binary record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public/bulk
func bulk_get_other_player_public_binary_records_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get player binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
func get_player_binary_record_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update player binary record file
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
func put_player_binary_record_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete player binary record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
func delete_player_binary_record_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update player binary record metadata
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata
func put_player_binary_recor_metadata_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Request presigned URL for upload player binary records
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned
func post_player_binary_presigned_urlv1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get player public binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/public
func get_player_public_binary_records_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace player private record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}
func put_player_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	response_body: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public
func put_player_public_record_concurrent_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	response_body: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["responseBody"] = response_body
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query other player public record key
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public
func get_other_player_public_record_key_handler_v1(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public"
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
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get other player public record bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public/bulk
func get_other_player_public_record_handler_v1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get player record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func get_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace player record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func put_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append player record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func post_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete player record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
func delete_player_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get player public record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
func get_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create or replace player public record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
func put_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create or append player public record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
func post_player_public_record_handler_v1(
	key: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
