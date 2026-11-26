## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## cloudsave_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-cloudsave-service
## Version: 1.2.0
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


## Lists admin game record keys
## GET /cloudsave/v1/admin/namespaces/{namespace}/adminrecords
##
## Lists admin game record keys for the specified namespace. Supports pagination using the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - query: Query, search game records by key
## - tags: Filter list by tags, max 5 tags per request
func admin_list_admin_game_record_v1(
	namespace_param: String, limit: int = -1, offset: int = -1, query: String = "", tags: Array = []
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


## Retrieves admin game records by keys in bulk
## POST /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/bulk
##
## Retrieves admin game records by keys in bulk. Accepts up to 20 keys per request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_bulk_get_admin_game_record_v1(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves an admin game record by key
## GET /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
##
## Get a record by its key in namespace-level.
##
## Parameters:
## - key: Unique key identifying the admin game record.
## - namespace_param: Game namespace
func admin_get_admin_game_record_v1(key: String, namespace_param: String) -> Dictionary:
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


## Creates or replaces an admin game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
##
## Creates a new admin game record or replaces an existing one for the specified namespace. Replace behavior overwrites the entire record with the new JSON.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `tags`: Array of strings for categorising the record.
## - `ttl_config`: TTL configuration; set `action` to `DELETE` to remove the record when it expires.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the admin game record.
## - namespace_param: Game namespace
func admin_put_admin_game_record_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Creates or appends an admin game record
## POST /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
##
## Creates a new admin game record or appends to an existing one for the specified namespace. Append behavior merges JSON objects recursively: the merge preserves existing keys and adds new ones.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `tags`: Array of strings for categorising the record.
## - `ttl_config`: TTL configuration; set `action` to `DELETE` to remove the record when it expires.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the admin game record.
## - namespace_param: Game namespace
func admin_post_admin_game_record_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Deletes an admin game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}
##
## Permanently deletes the specified admin game record from the namespace. This action cannot be undone.
##
## Parameters:
## - key: Unique key identifying the admin game record.
## - namespace_param: Game namespace
func admin_delete_admin_game_record_v1(key: String, namespace_param: String) -> Dictionary:
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


## Deletes the TTL configuration for an admin game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/adminrecords/{key}/ttl
##
## Removes the TTL configuration for the specified admin game record. Once removed, the record will no longer expire automatically.
##
## Parameters:
## - key: Unique key identifying the admin game record.
## - namespace_param: Game namespace
func delete_admin_game_record_ttl_config(key: String, namespace_param: String) -> Dictionary:
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


## Lists game binary records
## GET /cloudsave/v1/admin/namespaces/{namespace}/binaries
##
## Lists game binary records for the specified namespace. Supports pagination using the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - query: Query, search game records by key
## - tags: Filter list by tags, max 5 tags per request
func admin_list_game_binary_records_v1(
	namespace_param: String, limit: int = -1, offset: int = -1, query: String = "", tags: Array = []
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


## Creates a game binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/binaries
##
## Creates a game binary record for the specified namespace.
##
## The record key must start and end with a letter or number, may contain letters, numbers, hyphens (`-`), underscores (`_`), and dots (`.`), and must not contain spaces or consecutive separators.
##
## Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - namespace_param: Game namespace
func admin_post_game_binary_record_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a game binary record by key
## GET /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
##
## Get a game binary record by its key.
##
## Parameters:
## - key: Unique key identifying the game binary record.
## - namespace_param: Game namespace
func admin_get_game_binary_record_v1(key: String, namespace_param: String) -> Dictionary:
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


## Updates a game binary record file
## PUT /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
##
## Updates a game binary record file by its key.
##
## Parameters:
## - key: Unique key identifying the game binary record.
## - namespace_param: Game namespace
func admin_put_game_binary_record_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a game binary record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}
##
## Delete a game binary record.
##
## Parameters:
## - key: Unique key identifying the game binary record.
## - namespace_param: Game namespace
func admin_delete_game_binary_record_v1(key: String, namespace_param: String) -> Dictionary:
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


## Updates game binary record metadata
## PUT /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/metadata
##
## Updates a game binary record's metadata by its key.
##
## Parameters:
## - key: Unique key identifying the game binary record.
## - namespace_param: Game namespace
func admin_put_game_binary_recor_metadata_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Generates a presigned URL for uploading a game binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/presigned
##
## Request presigned URL to upload the binary record to s3.
##
## Other detail info:
##
## Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - key: Unique key identifying the game binary record.
## - namespace_param: Game namespace
func admin_post_game_binary_presigned_urlv1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Deletes the TTL configuration for a game binary record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/binaries/{key}/ttl
##
## Removes the TTL configuration for the specified game binary record. Once removed, the record will no longer expire automatically.
##
## Parameters:
## - key: Unique key identifying the game binary record.
## - namespace_param: Game namespace
func delete_game_binary_record_ttl_config(key: String, namespace_param: String) -> Dictionary:
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


## Creates or replaces an admin game record with optimistic concurrency control
## PUT /cloudsave/v1/admin/namespaces/{namespace}/concurrent/adminrecords/{key}
##
## Creates a new admin game record or replaces an existing one for the specified namespace. Uses optimistic concurrency control: include the `updatedAt` timestamp from the latest fetch; if the record has changed since then, the server returns 412 and the client must re-fetch and retry.
##
## `__META` is a reserved field name; do not use it in record values.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the admin game record.
## - namespace_param: Game namespace
func admin_put_admin_game_record_concurrent_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Creates or replaces a game record with optimistic concurrency control
## PUT /cloudsave/v1/admin/namespaces/{namespace}/concurrent/records/{key}
##
## Creates a new game record or replaces an existing one for the specified namespace. Uses optimistic concurrency control: include the `updatedAt` timestamp from the latest fetch; if the record has changed since then, the server returns 412 and the client must re-fetch and retry.
##
## The `set_by` field controls which party can update the record: `SERVER` allows only server-side writes; `CLIENT` allows both client and server writes. Defaults to `CLIENT`.
##
## `__META` is a reserved field name; do not use it in record values.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func admin_put_game_record_concurrent_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves the plugin configuration
## GET /cloudsave/v1/admin/namespaces/{namespace}/plugins
##
## Returns the gRPC plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func get_plugin_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates the plugin configuration
## POST /cloudsave/v1/admin/namespaces/{namespace}/plugins
##
## Creates a new gRPC plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func create_plugin_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes the plugin configuration
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/plugins
##
## Removes the gRPC plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func delete_plugin_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates the plugin configuration
## PATCH /cloudsave/v1/admin/namespaces/{namespace}/plugins
##
## Updates the gRPC plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func update_plugin_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/plugins"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists game record keys
## GET /cloudsave/v1/admin/namespaces/{namespace}/records
##
## Lists game record keys for the specified namespace. Supports pagination using the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - query: Query, search game records by key
## - tags: Filter list by tags, max 5 tags per request
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func list_game_records_handler_v1(
	namespace_param: String, limit: int, offset: int, query: String = "", tags: Array = []
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


## Retrieves a game record by key
## GET /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
##
## Get a record by its key in namespace-level.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func admin_get_game_record_handler_v1(key: String, namespace_param: String) -> Dictionary:
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


## Creates or replaces a game record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
##
## Creates a new game record or replaces an existing one for the specified namespace. Replace behavior overwrites the entire record with the new JSON.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `set_by`: Controls which party can update the record. `SERVER` allows only server-side writes; `CLIENT` allows both. Defaults to `CLIENT`.
## - `ttl_config`: TTL configuration; set `action` to `DELETE` to remove the record when it expires.
## - `tags`: Array of strings for categorising the record.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func admin_put_game_record_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Creates or appends a game record
## POST /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
##
## Creates a new game record or appends to an existing one for the specified namespace. Append behavior merges JSON objects recursively: the merge preserves existing keys and adds new ones.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `set_by`: Controls which party can update the record. `SERVER` allows only server-side writes; `CLIENT` allows both. Defaults to `CLIENT`.
## - `ttl_config`: TTL configuration; set `action` to `DELETE` to remove the record when it expires.
## - `tags`: Array of strings for categorising the record.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func admin_post_game_record_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/records/{key}
##
## Permanently deletes the specified game record from the namespace. This action cannot be undone.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func admin_delete_game_record_handler_v1(key: String, namespace_param: String) -> Dictionary:
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


## Deletes the TTL configuration for a game record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/records/{key}/ttl
##
## Removes the TTL configuration for the specified game record. Once removed, the record will no longer expire automatically.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func delete_game_record_ttl_config(key: String, namespace_param: String) -> Dictionary:
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


## Lists available tags
## GET /cloudsave/v1/admin/namespaces/{namespace}/tags
##
## Lists available tags for the specified namespace. Supports pagination using the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_list_tags_handler_v1(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Creates a tag
## POST /cloudsave/v1/admin/namespaces/{namespace}/tags
##
## Creates a new tag for the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_post_tag_handler_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes a tag
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/tags/{tag}
##
## Deletes a tag by name from the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - tag: Tag name
func admin_delete_tag_handler_v1(namespace_param: String, tag: String) -> Dictionary:
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


## Retrieves admin player records by user IDs in bulk
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/adminrecords/{key}/bulk
##
## Bulk get admin player record by userIds, max allowed 20 at a time.
##
## Parameters:
## - key: Unique key identifying the admin player record.
## - namespace_param: Game namespace
func bulk_get_admin_player_record_by_user_ids_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves player record sizes in bulk
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/bulk/records/size
##
## Retrieves record sizes for players by user ID and key in bulk, up to 20 entries per request.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_get_player_record_size_handler_v1(
	namespace_param: String, body: Dictionary = {}
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


## Creates or replaces player records in bulk
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk
##
## Creates new player records or replaces existing ones in bulk for the specified namespace. Accepts up to 10 user IDs per request, with a total request size limit of 5 MB. For optimal performance, keep the request under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
func admin_bulk_put_player_records_by_key_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves player records by user IDs in bulk
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/records/{key}/bulk
##
## Retrieves player record keys and values in bulk for the specified namespace. Accepts up to 20 user IDs per request.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
func admin_bulk_get_player_records_by_user_i_ds_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Lists admin player record keys
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords
##
## Lists admin player record keys for a user in the specified namespace. Supports pagination using the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - query: Query, search admin player records by key
## - tags: Filter list by tags, max 5 tags per request
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


## Retrieves admin player records by key in bulk
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/bulk
##
## Retrieves admin player records by key for a user in bulk. Accepts up to 20 keys per request.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_get_admin_player_record_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves an admin player record by key
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
##
## Get a admin record in user-level (arbitrary JSON data) by its key.
##
## Parameters:
## - key: Unique key identifying the admin player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_admin_player_record_v1(
	key: String, namespace_param: String, user_id: String
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


## Creates or replaces an admin player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
##
## Creates a new admin player record or replaces an existing one for the specified user. Replace behavior overwrites the entire record with the new JSON.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `tags`: Array of strings for categorising the record.
## - `ttl_config`: TTL configuration; set `action` to `DELETE` to remove the record when it expires.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the admin player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_put_admin_player_record_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Creates or appends an admin player record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
##
## Creates a new admin player record or appends to an existing one for the specified user. Append behavior merges JSON objects recursively: the merge preserves existing keys and adds new ones.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `tags`: Array of strings for categorising the record.
## - `ttl_config`: TTL configuration; set `action` to `DELETE` to remove the record when it expires.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the admin player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_post_player_admin_record_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes an admin player record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/adminrecords/{key}
##
## Delete a record (arbitrary JSON data) in user-level with given key.
##
## Parameters:
## - key: Unique key identifying the admin player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_admin_player_record_v1(
	key: String, namespace_param: String, user_id: String
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


## Lists player binary records
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries
##
## Lists player binary records for a user in the specified namespace. Supports pagination using the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - query: Query, search player records by key
## - tags: Filter list by tags, max 5 tags per request
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


## Creates a player binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries
##
## Creates a player binary record for the specified user.
##
## The record key must start and end with a letter or number, may contain letters, numbers, hyphens (`-`), underscores (`_`), and dots (`.`), and must not contain spaces or consecutive separators.
##
## Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_post_player_binary_record_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a player binary record by key
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
##
## Get a player binary record by its key.
##
## Parameters:
## - key: Unique key identifying the player binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_binary_record_v1(
	key: String, namespace_param: String, user_id: String
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


## Updates a player binary record file
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
##
## Updates a player binary record file by its key.
##
## Parameters:
## - key: Unique key identifying the player binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_put_player_binary_record_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a player binary record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}
##
## Delete a player binary record.
##
## Parameters:
## - key: Unique key identifying the player binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_player_binary_record_v1(
	key: String, namespace_param: String, user_id: String
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


## Updates player binary record metadata
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata
##
## Updates a player binary record's metadata by its key.
##
## Parameters:
## - key: Unique key identifying the player binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_put_player_binary_recor_metadata_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Generates a presigned URL for uploading a player binary record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned
##
## Request presigned URL to upload the binary record to s3.
##
## Other detail info:
##
## Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - key: Unique key identifying the player binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_post_player_binary_presigned_urlv1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Creates or replaces an admin player record with optimistic concurrency control
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/adminrecords/{key}
##
## Creates a new admin player record or replaces an existing one for the specified user. Uses optimistic concurrency control: include the `updatedAt` timestamp from the latest fetch; if the record has changed since then, the server returns 412 and the client must re-fetch and retry.
##
## `__META` is a reserved field name; do not use it in record values.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the admin player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - response_body: Flag to tell the service to return non empty response
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


## Creates or replaces a player private record with optimistic concurrency control
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}
##
## Creates a new player private record or replaces an existing one for the specified user. Uses optimistic concurrency control: include the `updatedAt` timestamp from the latest fetch; if the record has changed since then, the server returns 412 and the client must re-fetch and retry.
##
## The `set_by` field controls which party can update the record: `SERVER` allows only server-side writes; `CLIENT` allows both. Defaults to `CLIENT`.
##
## `__META` is a reserved field name; do not use it in record values.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - response_body: Flag to tell the service to return non empty response
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


## Creates or replaces a player public record with optimistic concurrency control
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public
##
## Creates a new player public record or replaces an existing one for the specified user. Uses optimistic concurrency control: include the `updatedAt` timestamp from the latest fetch; if the record has changed since then, the server returns 412 and the client must re-fetch and retry.
##
## The `set_by` field controls which party can update the record: `SERVER` allows only server-side writes; `CLIENT` allows both. Defaults to `CLIENT`.
##
## `__META` is a reserved field name; do not use it in record values.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - response_body: Flag to tell the service to return non empty response
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


## Lists player record keys
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records
##
## Lists player record keys for a user in the specified namespace. Supports pagination using the `limit` and `offset` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - query: Query, search player records by key
## - tags: Filter list by tags, max 5 tags per request
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


## Creates or replaces player records in bulk
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk
##
## Creates new player records or replaces existing ones in bulk for the specified user. Accepts up to 10 records per request, with a total request size limit of 5 MB. For optimal performance, keep the request under 250 KB.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_put_player_records_handler_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves player records by record keys in bulk
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/bulk
##
## Retrieves player record keys and values in bulk for the specified user. Accepts up to 20 keys per request.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_records_handler_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a player record by key
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
##
## Get a record in user-level (arbitrary JSON data) by its key.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Creates or replaces a player record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
##
## Creates a new player record or replaces an existing one for the specified user. Replace behavior overwrites the entire record with the new JSON.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `set_by`: Controls which party can update the record. `SERVER` allows only server-side writes; `CLIENT` allows both. Defaults to `CLIENT`.
## - `is_public`: Whether the record is publicly readable. Defaults to `false`.
## - `tags`: Array of strings for categorising the record.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_put_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Creates or appends a player record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
##
## Creates a new player record or appends to an existing one for the specified user. Append behavior merges JSON objects recursively: the merge preserves existing keys and adds new ones.
##
## Include record metadata using the `__META` field in the record object. Supported metadata:
## - `set_by`: Controls which party can update the record. `SERVER` allows only server-side writes; `CLIENT` allows both. Defaults to `CLIENT`.
## - `is_public`: Whether the record is publicly readable. Defaults to `false`.
## - `tags`: Array of strings for categorising the record.
##
## For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_post_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a player record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}
##
## Delete a record (arbitrary JSON data) in user-level with given key.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Retrieves a player public record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
##
## Get a record in user-level (arbitrary JSON data) by its key.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_public_record_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Creates or replaces a player public record
## PUT /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
##
## Creates a new player public record or replaces an existing one. Replace behavior overwrites the entire record with the new JSON. Deprecated. Use the POST or PUT player record operations with `__META` instead.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_put_player_public_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Creates or appends a player public record
## POST /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
##
## Creates a new player public record or appends to an existing one. Append behavior merges new JSON keys into the existing record without removing existing keys. Deprecated. Use the POST or PUT player record operations with `__META` instead.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_post_player_public_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a player public record
## DELETE /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/public
##
## Deletes a player public record. Deprecated. Use the POST or PUT player record operations with `__META` instead.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_player_public_record_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Retrieves the size of a player record
## GET /cloudsave/v1/admin/namespaces/{namespace}/users/{userId}/records/{key}/size
##
## Returns the storage size in bytes of the specified player record. Useful for quota management and storage monitoring.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_record_size_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Lists game binary records
## GET /cloudsave/v1/namespaces/{namespace}/binaries
##
## Lists game binary records in the namespace. Supports pagination using `offset` and `limit`, and filtering by tag or key substring using `tags` and `query`.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - query: Query, search game records by key
## - tags: Filter list by tags, max 5 tags per request
func list_game_binary_records_v1(
	namespace_param: String, limit: int = -1, offset: int = -1, query: String = "", tags: Array = []
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


## Creates a game binary record
## POST /cloudsave/v1/namespaces/{namespace}/binaries
##
## Creates a game binary record with an associated file. The `key` must start and end with a letter or number, may contain hyphens, underscores, and dots as separators (not consecutive), and must not contain spaces. Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - namespace_param: Game namespace
func post_game_binary_record_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves game binary records in bulk
## POST /cloudsave/v1/namespaces/{namespace}/binaries/bulk
##
## Retrieves up to 20 game binary records by key in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_get_game_binary_record_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/binaries/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a game binary record
## GET /cloudsave/v1/namespaces/{namespace}/binaries/{key}
##
## Get a game binary record by its key.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
func get_game_binary_record_v1(key: String, namespace_param: String) -> Dictionary:
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


## Updates a game binary record file
## PUT /cloudsave/v1/namespaces/{namespace}/binaries/{key}
##
## Updates a game binary record file by its key.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
func put_game_binary_record_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a game binary record
## DELETE /cloudsave/v1/namespaces/{namespace}/binaries/{key}
##
## Delete a game binary record.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
func delete_game_binary_record_v1(key: String, namespace_param: String) -> Dictionary:
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


## Generates a presigned URL for uploading a game binary record
## POST /cloudsave/v1/namespaces/{namespace}/binaries/{key}/presigned
##
## Request presigned URL to upload the binary record to s3.
##
## Other detail info:
##
## Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
func post_game_binary_presigned_urlv1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Creates or replaces a game record with optimistic concurrency control
## PUT /cloudsave/v1/namespaces/{namespace}/concurrent/records/{key}
##
## Creates a new game record or replaces an existing one. Replace behavior overwrites the entire record with the new JSON. Uses optimistic concurrency control: include `updatedAt` from the current record; the server returns 412 if the record has changed since the last fetch. `__META` is a reserved field; the server ignores it if included. For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func put_game_record_concurrent_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves game records in bulk
## POST /cloudsave/v1/namespaces/{namespace}/records/bulk
##
## Retrieves up to 20 game records by key in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func get_game_records_bulk(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/records/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a game record
## GET /cloudsave/v1/namespaces/{namespace}/records/{key}
##
## Get game record by its key.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func get_game_record_handler_v1(key: String, namespace_param: String) -> Dictionary:
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


## Creates or replaces a game record
## PUT /cloudsave/v1/namespaces/{namespace}/records/{key}
##
## Creates a new game record or replaces an existing one. Replace behavior overwrites the entire record with the new JSON. `__META` is a reserved field; the server ignores it if included. For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func put_game_record_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Creates or appends a game record
## POST /cloudsave/v1/namespaces/{namespace}/records/{key}
##
## Creates a new game record or appends to an existing one. Append behavior merges new JSON keys into the existing record without removing existing keys. `__META` is a reserved field; the server ignores it if included. For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func post_game_record_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a game record
## DELETE /cloudsave/v1/namespaces/{namespace}/records/{key}
##
## Deletes a game record by its key.
##
## Parameters:
## - key: Unique key identifying the game record.
## - namespace_param: Game namespace
func delete_game_record_handler_v1(key: String, namespace_param: String) -> Dictionary:
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


## Lists available tags
## GET /cloudsave/v1/namespaces/{namespace}/tags
##
## Lists available record tags in the namespace. Supports pagination using `offset` and `limit`.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func public_list_tags_handler_v1(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves public binary records for players in bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/bulk/binaries/{key}/public
##
## Retrieves a public binary record for up to 20 players by user ID. The response includes only records with `is_public=true`.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
func bulk_get_player_public_binary_records_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves public records for players in bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/bulk/records/{key}/public
##
## Retrieves a public player record for up to 20 players by user ID. The response includes only records with `is_public=true`.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
func bulk_get_player_public_record_handler_v1(
	key: String, namespace_param: String, body: Dictionary = {}
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


## Lists my binary records
## GET /cloudsave/v1/namespaces/{namespace}/users/me/binaries
##
## Lists the current user's binary records in the namespace. Supports pagination using `offset` and `limit`.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - query: Query, search player records by key
## - tags: Filter list by tags, max 5 tags per request
func list_my_binary_records_v1(
	namespace_param: String, limit: int = -1, offset: int = -1, query: String = "", tags: Array = []
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


## Retrieves binary records for the current user in bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/me/binaries/bulk
##
## Retrieves up to 20 binary records for the current user by key in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_get_my_binary_record_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/cloudsave/v1/namespaces/{namespace}/users/me/binaries/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists the current user's record keys
## GET /cloudsave/v1/namespaces/{namespace}/users/me/records
##
## Lists record keys belonging to the current user in the namespace. Supports pagination using `offset` and `limit`.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - tags: Filter list by tags, max 5 tags per request
func retrieve_player_records(
	namespace_param: String, limit: int = -1, offset: int = -1, tags: Array = []
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


## Retrieves records for the current user in bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/me/records/bulk
##
## Retrieves up to 20 records for the current user by key in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func get_player_records_bulk_handler_v1(
	namespace_param: String, body: Dictionary = {}
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


## Deletes a player public record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/me/records/{key}/public
##
## Deletes a player public record. Deprecated. Use the POST or PUT player record operations with `__META` instead.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
func public_delete_player_public_record_handler_v1(
	key: String, namespace_param: String
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


## Creates a player binary record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries
##
## Creates a player binary record with an associated file. The `key` must start and end with a letter or number, may contain hyphens, underscores, and dots as separators (not consecutive), and must not contain spaces. Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func post_player_binary_record_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists another player's public binary records
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public
##
## Lists the public binary records of the specified player. The response includes only records with `is_public=true`. Supports pagination using `offset` and `limit`.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - tags: Filter list by tags, max 5 tags per request
func list_other_player_public_binary_records_v1(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1, tags: Array = []
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


## Retrieves public binary records for a player in bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/public/bulk
##
## Retrieves up to 20 public binary records for the specified player by key in a single request.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func bulk_get_other_player_public_binary_records_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a player binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
##
## Returns a player binary record by its key.
##
## **Private Record**: Only the user who owns the record can retrieve it.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_player_binary_record_v1(
	key: String, namespace_param: String, user_id: String
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


## Updates a player binary record file
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
##
## Updates a player binary record file by its key.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func put_player_binary_record_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a player binary record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}
##
## Deletes a player binary record by its key. Only the player who owns the record can delete it.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_player_binary_record_v1(
	key: String, namespace_param: String, user_id: String
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


## Updates the metadata of a player binary record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/metadata
##
## Updates a player binary record's metadata by its key.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func put_player_binary_recor_metadata_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Generates a presigned URL for uploading a player binary record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/presigned
##
## Request presigned URL to upload the binary record to s3.
##
## Other detail info:
##
## Supported file types: jpeg, jpg, png, bmp, gif, mp3, webp, and bin.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func post_player_binary_presigned_urlv1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a player's public binary record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/binaries/{key}/public
##
## Retrieves a single public binary record of the specified player. Only records with `is_public=true` are accessible.
##
## Parameters:
## - key: Unique key identifying the binary record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_player_public_binary_records_v1(
	key: String, namespace_param: String, user_id: String
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


## Creates or replaces a player record with optimistic concurrency control
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}
##
## Creates a new player record or replaces an existing one. Replace behavior overwrites the entire record with the new JSON. Uses optimistic concurrency control: include `updatedAt` from the current record; the server returns 412 if the record has changed since the last fetch. `__META` is a reserved field; the server ignores it if included. For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - response_body: Flag to tell the service to return non empty response
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


## Creates or replaces a public player record with optimistic concurrency control
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/concurrent/records/{key}/public
##
## Creates a new public player record or replaces an existing one. Replace behavior overwrites the entire record with the new JSON. Uses optimistic concurrency control: include `updatedAt` from the current record; the server returns 412 if the record has changed since the last fetch. `__META` is a reserved field; the server ignores it if included. For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - response_body: Flag to tell the service to return non empty response
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


## Lists public record keys for a player
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public
##
## Lists public record keys for the specified player. Supports offset-based pagination using the `limit` and `offset` parameters. Use the `tags` parameter to filter results (up to 5 tags per request).
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - tags: Filter list by tags, max 5 tags per request
func get_other_player_public_record_key_handler_v1(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1, tags: Array = []
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


## Retrieves public records for a player in bulk
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/public/bulk
##
## Retrieves public record keys and payloads for the specified player in bulk. Each call supports up to 20 keys.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_other_player_public_record_handler_v1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a player record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
##
## Returns a player record by its key.
##
## **Private Record**: Only the user who owns the record can retrieve it.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Creates or replaces a player record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
##
## Creates a new player record or replaces an existing one. Replace behavior overwrites the entire record with the new JSON. Only the record owner can update an existing record. The `__META` field controls visibility: set `is_public` to `true` to make the record publicly readable (default: `false`). For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func put_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Creates or appends to a player record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
##
## Creates a new player record or appends fields to an existing one. Append merges new JSON into the existing record recursively â the merge preserves existing fields. Only the record owner can update an existing record. The `__META` field controls visibility: set `is_public` to `true` to make the record publicly readable (default: `false`). For optimal performance, keep the record under 250 KB.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func post_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a player record
## DELETE /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}
##
## Delete player record by its key.
## Only user that own the player record could delete it.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_player_record_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Retrieves a player's public record
## GET /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
##
## Retrieves a publicly visible record for the specified player. Only records with `is_public` set to `true` are accessible through this operation.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_player_public_record_handler_v1(
	key: String, namespace_param: String, user_id: String
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


## Creates or replaces a public player record
## PUT /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
##
## Creates a new public player record or replaces an existing one. Replace behavior overwrites the entire record with the new JSON. `__META` is a reserved field; the server ignores it if included. **Deprecated**: use PUT `/records/{key}` with `__META.is_public: true` instead.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func put_player_public_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Creates or appends to a public player record
## POST /cloudsave/v1/namespaces/{namespace}/users/{userId}/records/{key}/public
##
## Creates a new public player record or appends fields to an existing one. Append merges new JSON into the existing record recursively â the merge preserves existing fields. `__META` is a reserved field; the server ignores it if included. **Deprecated**: use POST or PUT to `/records/{key}` with `__META.is_public: true` instead.
##
## Parameters:
## - key: Unique key identifying the player record.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func post_player_public_record_handler_v1(
	key: String, namespace_param: String, user_id: String, body: Dictionary = {}
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
