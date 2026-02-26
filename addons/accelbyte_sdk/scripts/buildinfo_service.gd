## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## buildinfo_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-buildinfo-service
## Version: 3.28.16
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(BuildinfoService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name BuildinfoService
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

## Start Multipart File Upload
## POST /buildinfo/admin/namespaces/{namespace}/blocks/multipart
func start_multipart_file_upload(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/blocks/multipart"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Abort Multipart File Upload
## DELETE /buildinfo/admin/namespaces/{namespace}/blocks/multipart/{hash}
func abort_multipart_file_upload(
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/blocks/multipart/{hash}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Commit Multipart File Upload
## PATCH /buildinfo/admin/namespaces/{namespace}/blocks/multipart/{hash}
func commit_multipart_file_upload(
	hash: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/blocks/multipart/{hash}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## <s>Cancel Build Deletion</s>
## DELETE /buildinfo/admin/namespaces/{namespace}/builddeletion/{buildId}/cancel
func cancel_build_deletion(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/builddeletion/{buildId}/cancel"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## <s>Retry Failed Build Deletion</s>
## PUT /buildinfo/admin/namespaces/{namespace}/builddeletion/{buildId}/retry
func retry_build_deletion(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/builddeletion/{buildId}/retry"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get committed builds by appId
## GET /buildinfo/admin/namespaces/{namespace}/builds/byAppId
func get_build_by_app_id(
	namespace_param: String,
	app_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/builds/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get committed builds by namespace
## GET /buildinfo/admin/namespaces/{namespace}/builds/byNamespace
func get_build_by_namespace(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/builds/byNamespace"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Build Manifest
## GET /buildinfo/admin/namespaces/{namespace}/builds/{buildId}
func get_build(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/builds/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Delete Build</s>
## DELETE /buildinfo/admin/namespaces/{namespace}/builds/{buildId}
## @deprecated
func delete_build_manifest(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/builds/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Generate Block Download URLs
## POST /buildinfo/admin/namespaces/{namespace}/builds/{buildId}/blocks/urls
func admin_generate_blocks_download_urls(
	build_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/builds/{buildId}/blocks/urls"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get builds deletion by appId
## GET /buildinfo/admin/namespaces/{namespace}/buildsdeletion/byAppId
func get_build_deletion_by_app_id(
	namespace_param: String,
	app_id: String,
	deletion_status: int = -1,
	platform_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/buildsdeletion/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if deletion_status >= 0:
		query_params["deletionStatus"] = deletion_status
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Buildinfo Cleaner Configurations
## GET /buildinfo/admin/namespaces/{namespace}/cleanerConfigurations
func get_build_info_cleaner_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/cleanerConfigurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Commit Build Manifest</s>
## POST /buildinfo/admin/namespaces/{namespace}/commitbuildmanifest
## @deprecated
func commit_build_manifest(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/commitbuildmanifest"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## <s>Commit Chunk Upload</s>
## POST /buildinfo/admin/namespaces/{namespace}/commitchunkupload/{hash}/{uuid}/{offset}
## @deprecated
func commit_chunk_upload(
	hash: String,
	namespace_param: String,
	offset: int,
	uuid: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/commitchunkupload/{hash}/{uuid}/{offset}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "offset" + "}", str(offset).uri_encode())
	url_path = url_path.replace("{" + "uuid" + "}", uuid.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## <s>Commit Chunk Upload</s>
## POST /buildinfo/admin/namespaces/{namespace}/commitchunkupload/{hash}/{uuid}/{offset}/{blockSize}
## @deprecated
func commit_chunk_upload_with_size(
	block_size: int,
	hash: String,
	namespace_param: String,
	offset: int,
	uuid: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/commitchunkupload/{hash}/{uuid}/{offset}/{blockSize}"
	url_path = url_path.replace("{" + "blockSize" + "}", str(block_size).uri_encode())
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "offset" + "}", str(offset).uri_encode())
	url_path = url_path.replace("{" + "uuid" + "}", uuid.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Configurations
## GET /buildinfo/admin/namespaces/{namespace}/configurations
func get_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Configurations
## PATCH /buildinfo/admin/namespaces/{namespace}/configurations
func update_configuration(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Diff Cache Completion
## PUT /buildinfo/admin/namespaces/{namespace}/diff/cache
func commit_cache(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/diff/cache"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Save Diff Cache
## POST /buildinfo/admin/namespaces/{namespace}/diff/cache
func create_cache(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/diff/cache"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Dispatch Diff Caching Request
## POST /buildinfo/admin/namespaces/{namespace}/diff/calculate
func caching_request(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/diff/calculate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk Dispatch Diff Caching Requests
## POST /buildinfo/admin/namespaces/{namespace}/diff/calculate/bulk
func bulk_caching_requests(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/diff/calculate/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Trigger diff request message
## POST /buildinfo/admin/namespaces/{namespace}/diff/send
func send_diff_request_message(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/diff/send"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Link DLC
## PUT /buildinfo/admin/namespaces/{namespace}/dlc/link
func link_dependencies(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/dlc/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Retrieve DLC Link
## GET /buildinfo/admin/namespaces/{namespace}/dlc/{buildId}/link
func retrieve_dependencies(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/dlc/{buildId}/link"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## GDPR Compliant - Delete
## DELETE /buildinfo/admin/namespaces/{namespace}/gdpr/remove
func gdpr_remove_pii(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/gdpr/remove"
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
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## GDPR Compliant - Retrieve
## GET /buildinfo/admin/namespaces/{namespace}/gdpr/retrieve
func gdpr_retrieve_pii(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/gdpr/retrieve"
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

## Listen diff status
## POST /buildinfo/admin/namespaces/{namespace}/listenDiffStatus
func listen_diff_status(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/listenDiffStatus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Listen patch status
## POST /buildinfo/admin/namespaces/{namespace}/listenPatchStatus
func listen_patch_status(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/listenPatchStatus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Trigger patch request message
## POST /buildinfo/admin/namespaces/{namespace}/patch/send
func send_patch_request_message(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/patch/send"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Ping Differ
## GET /buildinfo/admin/namespaces/{namespace}/ping/differ
func ping_differ(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/ping/differ"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get release note manifest
## GET /buildinfo/admin/namespaces/{namespace}/releasenote/manifest/get/{appId}/{platformId}
func get_release_note(
	app_id: String,
	namespace_param: String,
	platform_id: String,
	version: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/releasenote/manifest/get/{appId}/{platformId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not version.is_empty():
		query_params["version"] = version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Save release note manifest
## POST /buildinfo/admin/namespaces/{namespace}/releasenote/manifest/save/{uploadMode}
func save_release_note(
	namespace_param: String,
	upload_mode: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/releasenote/manifest/save/{uploadMode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "uploadMode" + "}", upload_mode.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Commit Release Note Upload
## PATCH /buildinfo/admin/namespaces/{namespace}/releasenote/upload/commit/{hash}
func commit_release_note_upload(
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/releasenote/upload/commit/{hash}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Start Release Note Upload
## POST /buildinfo/admin/namespaces/{namespace}/releasenote/upload/start/{uploaderId}
func start_release_note_upload(
	namespace_param: String,
	uploader_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/releasenote/upload/start/{uploaderId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "uploaderId" + "}", uploader_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve Chunk by Hash
## GET /buildinfo/admin/namespaces/{namespace}/retrievechunkbyhash/{hash}
func retrieve_chunk_by_hash(
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/retrievechunkbyhash/{hash}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Set Current Build</s>
## PUT /buildinfo/admin/namespaces/{namespace}/setcurrentbuild/{appId}/{version}
## @deprecated
func set_current_build(
	app_id: String,
	namespace_param: String,
	version: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/setcurrentbuild/{appId}/{version}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "version" + "}", version.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Set Current Build
## PUT /buildinfo/admin/namespaces/{namespace}/setcurrentbuild/{buildId}
func set_current_build_by_build_id(
	build_id: String,
	namespace_param: String,
	send_notification: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/setcurrentbuild/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sendNotification"] = send_notification
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## <s>Start Build Upload</s>
## POST /buildinfo/admin/namespaces/{namespace}/startbuildupload/{appId}/{version}
## @deprecated
func start_build_upload(
	app_id: String,
	namespace_param: String,
	version: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/startbuildupload/{appId}/{version}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "version" + "}", version.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## <s>Start Chunk Upload</s>
## POST /buildinfo/admin/namespaces/{namespace}/startchunkupload
## @deprecated
func start_chunk_upload(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/startchunkupload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get committed builds by appId (v2)
## GET /buildinfo/admin/namespaces/{namespace}/v2/builds/byAppId
func get_build_by_app_id_1(
	namespace_param: String,
	app_id: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/builds/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Build Manifest v2
## GET /buildinfo/admin/namespaces/{namespace}/v2/builds/{buildId}
func get_build_1(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/builds/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Delete Build v2</s>
## DELETE /buildinfo/admin/namespaces/{namespace}/v2/builds/{buildId}
func delete_build_manifest_1(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/builds/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Edit Launch Arguments
## PATCH /buildinfo/admin/namespaces/{namespace}/v2/builds/{buildId}
func update_build_metadata(
	build_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/builds/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit Build Manifest (v2)
## POST /buildinfo/admin/namespaces/{namespace}/v2/commitbuildmanifest
func commit_build_manifest_1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/commitbuildmanifest"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Commit DLC Build Manifest (v2)
## POST /buildinfo/admin/namespaces/{namespace}/v2/commitdlcbuildmanifest
func commit_dlc_build_manifest(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/commitdlcbuildmanifest"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Commit File Upload (v2)
## PATCH /buildinfo/admin/namespaces/{namespace}/v2/commitfileupload/{buildId}/{hash}
func commit_file_upload(
	build_id: String,
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/commitfileupload/{buildId}/{hash}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit ZsyncFile Upload (v2)
## PATCH /buildinfo/admin/namespaces/{namespace}/v2/commitzsyncfileupload/{buildId}/{hash}
func commit_zsync_file_upload(
	build_id: String,
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/commitzsyncfileupload/{buildId}/{hash}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit Zsync File Upload v2
## PATCH /buildinfo/admin/namespaces/{namespace}/v2/commitzsyncfileupload/{buildId}/{hash}/{blockSize}
func commit_zsync_file_upload_with_size(
	block_size: int,
	build_id: String,
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/commitzsyncfileupload/{buildId}/{hash}/{blockSize}"
	url_path = url_path.replace("{" + "blockSize" + "}", str(block_size).uri_encode())
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit Diff Manifest
## PATCH /buildinfo/admin/namespaces/{namespace}/v2/diff/commit/{sourceBuildId}/{destinationBuildId}
func commit_diff_manifest(
	destination_build_id: String,
	namespace_param: String,
	source_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/diff/commit/{sourceBuildId}/{destinationBuildId}"
	url_path = url_path.replace("{" + "destinationBuildId" + "}", destination_build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Request Presigned Url for Diff Manifest Upload
## POST /buildinfo/admin/namespaces/{namespace}/v2/diff/signedurl/{sourceBuildId}/{destinationBuildId}
func request_presigned_url_diff_upload(
	destination_build_id: String,
	namespace_param: String,
	source_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/diff/signedurl/{sourceBuildId}/{destinationBuildId}"
	url_path = url_path.replace("{" + "destinationBuildId" + "}", destination_build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start Diff Upload
## POST /buildinfo/admin/namespaces/{namespace}/v2/diff/start/{sourceBuildId}/{destinationBuildId}
func start_diff_upload(
	destination_build_id: String,
	namespace_param: String,
	source_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/diff/start/{sourceBuildId}/{destinationBuildId}"
	url_path = url_path.replace("{" + "destinationBuildId" + "}", destination_build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Diff Trigger Status
## GET /buildinfo/admin/namespaces/{namespace}/v2/difftrigger/status
func get_diff_trigger_status(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/difftrigger/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Toggle Diff Trigger Status
## PATCH /buildinfo/admin/namespaces/{namespace}/v2/difftrigger/status/{value}
func toggle_diff_trigger_status(
	namespace_param: String,
	value: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/difftrigger/status/{value}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "value" + "}", value.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get committed DLC build by appId (v2)
## GET /buildinfo/admin/namespaces/{namespace}/v2/dlc/byGameAppId
func get_dlc_build_by_app_id(
	namespace_param: String,
	app_id: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/dlc/byGameAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not platform_id.is_empty():
		query_params["platformId"] = platform_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Set Current Build (v2)</s>
## PUT /buildinfo/admin/namespaces/{namespace}/v2/setcurrentbuild/{appId}/{version}/{platformId}
func set_current_build_1(
	app_id: String,
	namespace_param: String,
	platform_id: String,
	version: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/setcurrentbuild/{appId}/{version}/{platformId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "version" + "}", version.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Start Build Upload v2
## POST /buildinfo/admin/namespaces/{namespace}/v2/startbuildupload
func start_build_upload_1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/startbuildupload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start Build Upload v2
## POST /buildinfo/admin/namespaces/{namespace}/v2/startbuildupload/{sourceBuildId}
func start_build_upload_2(
	namespace_param: String,
	source_build_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/startbuildupload/{sourceBuildId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start DLC Build Upload
## POST /buildinfo/admin/namespaces/{namespace}/v2/startdlcbuildupload
func start_dlc_build_upload(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/startdlcbuildupload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start DLC Build Upload
## POST /buildinfo/admin/namespaces/{namespace}/v2/startdlcbuildupload/{sourceBuildId}
func start_dlc_build_upload_1(
	namespace_param: String,
	source_build_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/startdlcbuildupload/{sourceBuildId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start File Upload (v2)
## POST /buildinfo/admin/namespaces/{namespace}/v2/startfileupload/{uploaderId}
func start_file_upload(
	namespace_param: String,
	uploader_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/startfileupload/{uploaderId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "uploaderId" + "}", uploader_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start ZsyncFile Upload (v2)
## POST /buildinfo/admin/namespaces/{namespace}/v2/startzsyncfileupload/{fileHash}
func start_zsync_file_upload(
	file_hash: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v2/startzsyncfileupload/{fileHash}"
	url_path = url_path.replace("{" + "fileHash" + "}", file_hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Commit Build Manifest (v3)
## POST /buildinfo/admin/namespaces/{namespace}/v3/commitbuildmanifest/{sourceBuildId}
func commit_build_manifest_2(
	namespace_param: String,
	source_build_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/commitbuildmanifest/{sourceBuildId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Commit File Upload v3
## PATCH /buildinfo/admin/namespaces/{namespace}/v3/commitfileupload/{buildId}/{hash}
func commit_file_upload_1(
	build_id: String,
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/commitfileupload/{buildId}/{hash}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit Missing Bytes File Upload (v3)
## PATCH /buildinfo/admin/namespaces/{namespace}/v3/commitmissingbytesfileupload/{hash}
func commit_missing_bytes_file_upload_with_size(
	hash: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/commitmissingbytesfileupload/{hash}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit ZsyncFile Upload v3
## PATCH /buildinfo/admin/namespaces/{namespace}/v3/commitzsyncfileupload/{buildId}/{hash}
func commit_zsync_file_upload_1(
	build_id: String,
	hash: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/commitzsyncfileupload/{buildId}/{hash}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit Zsync File Upload v3
## PATCH /buildinfo/admin/namespaces/{namespace}/v3/commitzsyncfileupload/{buildId}/{hash}/{blockSize}
func commit_zsync_file_upload_with_size_1(
	block_size: int,
	build_id: String,
	hash: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/commitzsyncfileupload/{buildId}/{hash}/{blockSize}"
	url_path = url_path.replace("{" + "blockSize" + "}", str(block_size).uri_encode())
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get most current build
## GET /buildinfo/admin/namespaces/{namespace}/v3/current/{appId}/{platformId}
func get_most_current_build(
	app_id: String,
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/current/{appId}/{platformId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get diff status manifest
## GET /buildinfo/admin/namespaces/{namespace}/v3/diff/status/{sourceBuildId}/{destinationBuildId}/{destinationFilePath}
func get_diff_status_of_file(
	destination_build_id: String,
	destination_file_path: String,
	namespace_param: String,
	source_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/diff/status/{sourceBuildId}/{destinationBuildId}/{destinationFilePath}"
	url_path = url_path.replace("{" + "destinationBuildId" + "}", destination_build_id.uri_encode())
	url_path = url_path.replace("{" + "destinationFilePath" + "}", destination_file_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Pre check differential upload
## POST /buildinfo/admin/namespaces/{namespace}/v3/prezsyncupload
func pre_zsync_upload(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/prezsyncupload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Set Current Build v3
## PUT /buildinfo/admin/namespaces/{namespace}/v3/setcurrentbuild/{appId}/{version}/{platformId}
func set_current_build_2(
	app_id: String,
	namespace_param: String,
	platform_id: String,
	version: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/setcurrentbuild/{appId}/{version}/{platformId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "version" + "}", version.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Start Build Upload v3
## POST /buildinfo/admin/namespaces/{namespace}/v3/startbuildupload
func start_build_upload_3(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/startbuildupload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start Build Upload v3
## POST /buildinfo/admin/namespaces/{namespace}/v3/startbuildupload/{sourceBuildId}
func start_build_upload_4(
	namespace_param: String,
	source_build_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/startbuildupload/{sourceBuildId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start File Upload v3
## POST /buildinfo/admin/namespaces/{namespace}/v3/startfileupload/{uploaderId}
func start_file_upload_1(
	namespace_param: String,
	uploader_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/startfileupload/{uploaderId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "uploaderId" + "}", uploader_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Start ZsyncFile Upload v3
## POST /buildinfo/admin/namespaces/{namespace}/v3/startzsyncfileupload/{fileHash}
func start_zsync_file_upload_1(
	file_hash: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/startzsyncfileupload/{fileHash}"
	url_path = url_path.replace("{" + "fileHash" + "}", file_hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get differential upload activation status
## GET /buildinfo/admin/namespaces/{namespace}/v3/uploadmode/{appId}/{platformId}
func determine_upload_mode(
	app_id: String,
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/uploadmode/{appId}/{platformId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Check validity of clientId and redirectUri from SDK Config
## GET /buildinfo/admin/namespaces/{namespace}/validateSDKConfig
func get_build_by_namespace_1(
	namespace_param: String,
	client_id: String,
	redirect_uri: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/validateSDKConfig"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
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

## Retrieve DLC by DLC AppId
## GET /buildinfo/public/namespaces/{namespace}/apps/latest/byDLCAppId/{dlcAppId}
func latest_base_game_by_dlc(
	dlc_app_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/apps/latest/byDLCAppId/{dlcAppId}"
	url_path = url_path.replace("{" + "dlcAppId" + "}", dlc_app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Simple build manifest
## GET /buildinfo/public/namespaces/{namespace}/availablebuilds/{appId}
func get_simple_manifest(
	app_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/availablebuilds/{appId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate Block Download URLs
## POST /buildinfo/public/namespaces/{namespace}/builds/{buildId}/blocks/urls
func generate_blocks_download_urls(
	build_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/builds/{buildId}/blocks/urls"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check latest build existence
## GET /buildinfo/public/namespaces/{namespace}/bulkCheckLatest
func check_latest_build_existence(
	namespace_param: String,
	app_ids: Array
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/bulkCheckLatest"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if app_ids.size() > 0:
		query_params["appIds"] = app_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Diff Cache
## GET /buildinfo/public/namespaces/{namespace}/diff/cache/source/{sourceBuildId}/dest/{destinationBuildId}
func retrieve_cache(
	destination_build_id: String,
	namespace_param: String,
	source_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/diff/cache/source/{sourceBuildId}/dest/{destinationBuildId}"
	url_path = url_path.replace("{" + "destinationBuildId" + "}", destination_build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Diff Status from Two Builds
## GET /buildinfo/public/namespaces/{namespace}/diff/{sourceBuildId}/{destinationBuildId}
func fetch_diff_status(
	destination_build_id: String,
	namespace_param: String,
	source_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/diff/{sourceBuildId}/{destinationBuildId}"
	url_path = url_path.replace("{" + "destinationBuildId" + "}", destination_build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sourceBuildId" + "}", source_build_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve DLC Compatibility
## GET /buildinfo/public/namespaces/{namespace}/dlc/{buildId}/compatibility
func retrieve_compatibility(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/dlc/{buildId}/compatibility"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve DLC Link
## GET /buildinfo/public/namespaces/{namespace}/dlc/{buildId}/link
func retrieve_dependencies_1(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/dlc/{buildId}/link"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve DLC by Game AppId
## GET /buildinfo/public/namespaces/{namespace}/dlcs/latest/byGameAppId/{appId}
func latest_dlc_by_app_id(
	app_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/dlcs/latest/byGameAppId/{appId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## DRM License Encryption
## GET /buildinfo/public/namespaces/{namespace}/drmlicense/encrypt
func license(
	namespace_param: String,
	app_id: String,
	machine_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/drmlicense/encrypt"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not machine_id.is_empty():
		query_params["machineId"] = machine_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Public Key
## GET /buildinfo/public/namespaces/{namespace}/drmlicense/retrievePublicKey
func retrieve_key(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/drmlicense/retrievePublicKey"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Update game</s>
## GET /buildinfo/public/namespaces/{namespace}/updategame/builds/{buildId}
## @deprecated
func update_game_2(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/updategame/builds/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Download game</s>
## GET /buildinfo/public/namespaces/{namespace}/updategame/{appId}
## @deprecated
func initial_update_game(
	app_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/updategame/{appId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## <s>Update game</s>
## GET /buildinfo/public/namespaces/{namespace}/updategame/{appId}/{version}
## @deprecated
func update_game(
	app_id: String,
	namespace_param: String,
	version: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/updategame/{appId}/{version}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "version" + "}", version.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update game v2
## GET /buildinfo/public/namespaces/{namespace}/v2/updategame/builds/{buildId}
func update_game_v2(
	build_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/v2/updategame/builds/{buildId}"
	url_path = url_path.replace("{" + "buildId" + "}", build_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Download game v2
## GET /buildinfo/public/namespaces/{namespace}/v2/updategame/{appId}/{platformId}
func initial_update_game_1(
	app_id: String,
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/v2/updategame/{appId}/{platformId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update game v2
## GET /buildinfo/public/namespaces/{namespace}/v2/updategame/{appId}/{version}/{platformId}
func update_game_1(
	app_id: String,
	namespace_param: String,
	platform_id: String,
	version: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/v2/updategame/{appId}/{version}/{platformId}"
	url_path = url_path.replace("{" + "appId" + "}", app_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	url_path = url_path.replace("{" + "version" + "}", version.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get version history
## GET /buildinfo/public/namespaces/{namespace}/versionHistory
func version_history(
	namespace_param: String,
	app_id: String,
	compared_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/versionHistory"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not compared_build_id.is_empty():
		query_params["comparedBuildId"] = compared_build_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Start Resumable Multipart File Upload
## POST /buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart
func start_resumable_multipart_file_upload(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Abort Resumable Multipart File Upload
## DELETE /buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart/{hash}
func abort_multipart_file_upload_1(
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart/{hash}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Commit Resumable Multipart File Upload
## PATCH /buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart/{hash}
func commit_resumable_multipart_file_upload(
	hash: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart/{hash}"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Commit Resumable Multipart File Upload's Part
## POST /buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart/{hash}/part
func commit_resumable_multipart_file_upload_part(
	hash: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/v2/admin/namespaces/{namespace}/blocks/multipart/{hash}/part"
	url_path = url_path.replace("{" + "hash" + "}", hash.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
