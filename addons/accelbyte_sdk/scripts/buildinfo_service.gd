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
##
## This API is used to start multipart file upload. The service will returns the list of presigned urls that will be used to upload the Parts.
## Make sure to upload the Parts in-order based on the presigned urls order.The size of each Part should above or equals to 5MB, except the last one.
##
## Parameters:
## - namespace_param: Namespace
func start_multipart_file_upload(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to abort multipart file upload. The aborted multipart file upload cannot be continued again.
##
## Parameters:
## - hash: Hash
## - namespace_param: Namespace
func abort_multipart_file_upload(hash: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to commit multipart file upload to signal the upload completion.
## The request should contains list of PartNumber along with its ETag value. The list should be in-order.
##
## Parameters:
## - hash: Hash
## - namespace_param: Namespace
func commit_multipart_file_upload(
	hash: String, namespace_param: String, body: Dictionary = {}
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


## Cancel Build Deletion
## DELETE /buildinfo/admin/namespaces/{namespace}/builddeletion/{buildId}/cancel
##
## This API is used to cancel build deletion.
##
## Other detail info:
##
## * Required permission : resource="ADMIN:NAMESPACE:{namespace}:BUILDINFO", action=8 (DELETE)
## *  Returns : none
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func cancel_build_deletion(build_id: String, namespace_param: String) -> Dictionary:
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


## Retry Failed Build Deletion
## PUT /buildinfo/admin/namespaces/{namespace}/builddeletion/{buildId}/retry
##
## This API is used to retry build deletion.
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func retry_build_deletion(build_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to get basic build manifests. Only committed build will be retrieved.
##
## Parameters:
## - namespace_param: Namespace
## - app_id: Application Id
func get_build_by_app_id(namespace_param: String, app_id: String) -> Dictionary:
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
##
## This API is used to get basic build manifests. Only committed build will be retrieved.
##
## Parameters:
## - namespace_param: Namespace
func get_build_by_namespace(namespace_param: String) -> Dictionary:
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
##
## This API is used to get build manifest.
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func get_build(build_id: String, namespace_param: String) -> Dictionary:
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


## Generate Block Download URLs
## POST /buildinfo/admin/namespaces/{namespace}/builds/{buildId}/blocks/urls
##
## This API is used to Generate Download URLs for the requested blocks inside the specified buildId.
## The download URL generation may returns Signed URL or Public URL, depends on service configurations.
##
## Parameters:
## - build_id: Build ID of the blocks
## - namespace_param: Namespace
func admin_generate_blocks_download_urls(
	build_id: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to get build deletion. Only deleted build will be retrieved.
##
## Parameters:
## - namespace_param: Namespace
## - deletion_status: Deletion Status
## - platform_id: Platform ID
## - app_id: Application Id
func get_build_deletion_by_app_id(
	namespace_param: String, app_id: String, deletion_status: int = -1, platform_id: String = ""
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
##
## This API is used to retrieve grace period of buildinfo cleaner.
##
## Other detail info:
##
## * Returns : Buildinfo Grace Period Time
##
## Parameters:
## - namespace_param: Namespace
func get_build_info_cleaner_configuration(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/cleanerConfigurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Get Configurations
## GET /buildinfo/admin/namespaces/{namespace}/configurations
##
## This API is used to get the BuildInfo configurations.
##
## 1. Entitlement Validation
## Entitlement Validation is utilized in download and update game/application flow.
## It will check whether the user is entitled for the game/application or not through Justice Entitlement Service.
## If user is entitled, it will process the request, otherwise the request will rejected.
##
## Other detail info:
##
## * Returns : Configuration Info
##
## Parameters:
## - namespace_param: namespace
func get_configuration(namespace_param: String) -> Dictionary:
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
##
## This API is used to update the BuildInfo configurations.
## This API support update configuration based on given data. Single request can update single field or multi fields.
##
## 1. Entitlement Validation
## Entitlement Validation is utilized in download and update game/application flow.
## It will check whether the user is entitled for the game/application or not through Justice Entitlement Service.
## If user is entitled, it will process the request, otherwise the request will rejected.
##
## Other detail info:
##
## * Returns : Configuration Info
##
## Parameters:
## - namespace_param: Namespace
func update_configuration(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to mark that the diff caching is complete and diff summary file uploaded to s3. Only used by differ. Not to be used directly.
##
## Parameters:
## - namespace_param: Namespace
func commit_cache(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to save detailed diff cache. Only used by differ. Not to be used directly.
##
## Parameters:
## - namespace_param: Namespace
func create_cache(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to dispatch diff caching request.
##
## Parameters:
## - namespace_param: Namespace
func caching_request(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to bulk dispatch diff caching requests to differ instance.
## The processing order will follow the order of the array.
## The priority flag means that request will be set as priority inside the queue and always served first even if thereâs existing non-priority request(s) beforehand.
##
## Other detail info:
##
## * Request is skipped if the source and destination versions is same
## * Request is skipped if the source version is not found
## * Request is skipped if the destination version is not found
##
## Parameters:
## - namespace_param: Namespace
func bulk_caching_requests(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to send diff request to MQ.
##
## Other detail info:
##
## * Returns : diff status
##
## Parameters:
## - namespace_param: Namespace
func send_diff_request_message(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to link DLC version(s) against the game version.
##
## Parameters:
## - namespace_param: Namespace
func link_dependencies(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to retrieve DLC versions against the game version.
##
## Parameters:
## - build_id: Build Id
## - namespace_param: Namespace
func retrieve_dependencies(build_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to remove all stored data that relates to supplied machineId.
##
## Other detail info:
##
## * Returns : list of data related to machineId
##
## Parameters:
## - namespace_param: Namespace
## - user_id: User Id
func gdpr_remove_pii(namespace_param: String, user_id: String) -> Dictionary:
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
##
## This API is used to get all stored data that relates to supplied machineId.
##
## Other detail info:
##
## * Returns : list of data related to machineId
##
## Parameters:
## - namespace_param: Namespace
## - user_id: User Id
func gdpr_retrieve_pii(namespace_param: String, user_id: String) -> Dictionary:
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
##
## This API is used to listen diff status.
##
## Other detail info:
##
## * Returns : diff status
##
## Parameters:
## - namespace_param: Namespace
func listen_diff_status(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to listen patch status from source file and missing bytes file to destination file.
##
## Other detail info:
##
## * Returns : diff status
##
## Parameters:
## - namespace_param: Namespace
func listen_patch_status(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to send patch request to MQ.
##
## Other detail info:
##
## * Returns : diff status
##
## Parameters:
## - namespace_param: Namespace
func send_patch_request_message(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to manually checks the readiness of differ.
##
## Other detail info:
##
## * Returns : ping result
##
## Parameters:
## - namespace_param: Namespace
func ping_differ(namespace_param: String) -> Dictionary:
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
##
## This API is used to get release note manifest.
##
## Parameters:
## - app_id: App Id
## - namespace_param: Namespace
## - platform_id: Platform Id
## - version: Version
func get_release_note(
	app_id: String, namespace_param: String, platform_id: String, version: String = ""
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
##
## This API is used to save release note manifest.
##
## It will update the existing release note manifest if exist (based on namespace, appId, platformId and version).
## Otherwise, it will create a new release note manifest.
##
## Upload Mode for existing release note manifest:
## 0 = update, will merge the old localizations with the new localizations.
## 1 = replace, will replace the old localizations with the new localizations.
##
## Parameters:
## - namespace_param: Namespace
## - upload_mode: Upload Mode (0: update, 1: replace)
func save_release_note(
	namespace_param: String, upload_mode: String, body: Dictionary = {}
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
##
## This API is used to commit release note file that has been uploaded to signal completion.
##
## Parameters:
## - hash: Hash
## - namespace_param: Namespace
func commit_release_note_upload(hash: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to start release note upload and get the presigned URL.
##
## Parameters:
## - namespace_param: Namespace
## - uploader_id: Uploader Id
func start_release_note_upload(
	namespace_param: String, uploader_id: String, body: Dictionary = {}
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
##
## This API is used to retrieve chunk by hash.
##
## Parameters:
## - hash: Hash
## - namespace_param: Namespace
func retrieve_chunk_by_hash(hash: String, namespace_param: String) -> Dictionary:
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


## Set Current Build
## PUT /buildinfo/admin/namespaces/{namespace}/setcurrentbuild/{buildId}
##
## This API is used to set current build as release version.
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
## - send_notification: Is send latest game notification
func set_current_build_by_build_id(
	build_id: String, namespace_param: String, send_notification: bool = false
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


## Get committed builds by appId (v2)
## GET /buildinfo/admin/namespaces/{namespace}/v2/builds/byAppId
##
## This API is used to get basic build manifests. Only committed build will be retrieved.
##
## Parameters:
## - namespace_param: Namespace
## - app_id: Application ID
## - platform_id: Platform ID
func get_build_by_app_id_1(
	namespace_param: String, app_id: String, platform_id: String
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
##
## This API is used to get build manifest for build uploaded with BuildInfo v2.
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func get_build_1(build_id: String, namespace_param: String) -> Dictionary:
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


## Delete Build v2
## DELETE /buildinfo/admin/namespaces/{namespace}/v2/builds/{buildId}
##
## This API is used to delete build manifest.
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func delete_build_manifest_1(build_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to edit build's launchArgument.
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func update_build_metadata(
	build_id: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to commit build manifest.
##
## Parameters:
## - namespace_param: Namespace
func commit_build_manifest_1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to commit build manifest.
##
## Parameters:
## - namespace_param: Namespace
func commit_dlc_build_manifest(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to commit file that has been uploaded to signal completion.
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func commit_file_upload(build_id: String, hash: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to commit file that has been uploaded to signal completion
##
## Parameters:
## - build_id: Build ID
## - hash: Hash
## - namespace_param: Namespace
func commit_zsync_file_upload(
	build_id: String, hash: String, namespace_param: String
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
##
## This API is used to commit chunk that has been uploaded.
##
## Previous API:
##
## * /v2/startzsyncfileupload
##
## Next API:
## * /v2/startfileupload/{uploaderId}
##
## Parameters:
## - block_size: Block Size
## - build_id: Build ID
## - hash: Hash
## - namespace_param: Namespace
func commit_zsync_file_upload_with_size(
	block_size: int, build_id: String, hash: String, namespace_param: String
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
##
## This API is used to commit diff manifest.
##
## Parameters:
## - destination_build_id: DestinationBuildId
## - namespace_param: Namespace
## - source_build_id: SourceBuildId
func commit_diff_manifest(
	destination_build_id: String, namespace_param: String, source_build_id: String
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
##
## Use this API to get the presigned url to upload the diff manifest.
##
## Other detail info:
##
## * Required permission : resource="ADMIN:NAMESPACE:{namespace}:BUILDINFO", action=1 (CREATE)
## *  Returns : build id
##
## Parameters:
## - destination_build_id: DestinationBuildId
## - namespace_param: Namespace
## - source_build_id: SourceBuildId
func request_presigned_url_diff_upload(
	destination_build_id: String, namespace_param: String, source_build_id: String
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
##
## This API is used to start diff manifest upload.
##
## Parameters:
## - destination_build_id: DestinationBuildId
## - namespace_param: Namespace
## - source_build_id: SourceBuildId
func start_diff_upload(
	destination_build_id: String, namespace_param: String, source_build_id: String
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
##
## This API is used to get diff trigger status.
##
## Parameters:
## - namespace_param: Namespace
func get_diff_trigger_status(namespace_param: String) -> Dictionary:
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
##
## This API is used to toggle diff trigger status. Use 0 to turn off and 1 to turn on. Any values other than 0 will be regarded as 1.
##
## Parameters:
## - namespace_param: Namespace
## - value: Value
func toggle_diff_trigger_status(namespace_param: String, value: String) -> Dictionary:
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
##
## This API is used to get basic DLC build manifests. Only committed build will be retrieved.
##
## Parameters:
## - namespace_param: Namespace
## - app_id: Application ID
## - platform_id: Platform ID
func get_dlc_build_by_app_id(
	namespace_param: String, app_id: String, platform_id: String
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


## Set Current Build (v2)
## PUT /buildinfo/admin/namespaces/{namespace}/v2/setcurrentbuild/{appId}/{version}/{platformId}
##
## This API is used to set current build as release version.
##
## Parameters:
## - app_id: Application ID
## - namespace_param: Namespace
## - platform_id: Platform ID
## - version: Version
func set_current_build_1(
	app_id: String, namespace_param: String, platform_id: String, version: String
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
##
## This API is used to start build upload.
##
## Previous API:
##
## * none
##
## Next API:
## * /v2/startfileupload/{uploaderId}
##
## Parameters:
## - namespace_param: Namespace
func start_build_upload_1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to start incremental build upload. This endpoint used for incremental build upload, where developer update the files from existing build version (that hasn't yet set as latest).
##
## Parameters:
## - namespace_param: Namespace
## - source_build_id: Source Build ID
func start_build_upload_2(
	namespace_param: String, source_build_id: String, body: Dictionary = {}
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
##
## This API is used to start DLC build upload.
##
## Previous API:
##
## * none
##
## Next API:
## * /v2/startfileupload/{uploaderId} for normal (non-differential) upload
## * /v3/prezsyncupload for differential upload
##
## Parameters:
## - namespace_param: Namespace
func start_dlc_build_upload(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to start DLC build upload. This endpoint used for incremental build upload, where developer update the files from existing build version (that hasn't yet set as latest).
##
## Parameters:
## - namespace_param: Namespace
## - source_build_id: Source Build ID
func start_dlc_build_upload_1(
	namespace_param: String, source_build_id: String, body: Dictionary = {}
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
##
## This API is used to start file upload and retrieve upload url.
##
## Parameters:
## - namespace_param: Namespace
## - uploader_id: The build id of this file
func start_file_upload(
	namespace_param: String, uploader_id: String, body: Dictionary = {}
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
##
## This API is used to start zsync control file upload and retrieve upload url.
##
## Parameters:
## - file_hash: File Hash
## - namespace_param: Namespace
func start_zsync_file_upload(
	file_hash: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to commit build manifest.
##
## Previous API:
##
## * /listenPatchStatus in case needs to patch file
## * /v3/commitzsyncfileupload/{buildId}/{hash} in case of normal non-differential upload
## * /v3/commitzsyncfileupload/{buildId}/{hash}/{blockSize} to also specify the blocksize in case of normal non-differential upload
##
## Next API:
## * none
##
## Other detail info:
## * Returns : none
##
## Parameters:
## - namespace_param: Namespace
## - source_build_id: Source Build ID
func commit_build_manifest_2(
	namespace_param: String, source_build_id: String, body: Dictionary = {}
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
##
## This API is used to commit file that has been uploaded to signal completion.
##
## Previous API:
##
## * /v3/startfileupload/{uploaderId}
##
## Next API:
## * /v3/startzsyncfileupload/{fileHash} for non-differential (normal) upload
## * /v3/prezsyncupload for differential upload
##
## Parameters:
## - build_id: Build ID
## - hash: Hash
## - namespace_param: Namespace
func commit_file_upload_1(build_id: String, hash: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to commit missing bytes file that has been uploaded to S3.
##
## Previous API:
##
## * /v3/startzsyncfileupload
##
## Next API:
## * /v3/startfileupload/{uploaderId}
##
## Other detail info:
## * Returns : chunk data
##
## Parameters:
## - hash: Hash
## - namespace_param: Namespace
func commit_missing_bytes_file_upload_with_size(
	hash: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to commit file that has been uploaded to signal completion.
##
## Mandatory fields for body: sourceBuildId, destinationBuildId, destinationFilePath, destinationFileChecksum, destinationControlFileUuid, destinationControlFileChecksumPrevious API:
##
## * /v3/startzsyncfileupload
##
## Next API:
## * /v3/startfileupload/{uploaderId} for normal (non-differential) upload
## * /v3/listendiffstatus for differential upload
##
## Parameters:
## - build_id: Build ID
## - hash: Hash of the zsync file
## - namespace_param: Namespace
func commit_zsync_file_upload_1(
	build_id: String, hash: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to commit chunk that has been uploaded. By commiting the file, it means flag the file as already uploaded.
##
## Mandatory fields for body: sourceBuildId, destinationBuildId, destinationFilePath, destinationFileChecksum, destinationControlFileUuid, destinationControlFileChecksumPrevious API:
##
## * /v3/startzsyncfileupload
##
## Next API:
## * /v3/startfileupload/{uploaderId}
##
## Parameters:
## - block_size: Block Size
## - build_id: Build ID
## - hash: Hash
## - namespace_param: Namespace
func commit_zsync_file_upload_with_size_1(
	block_size: int, build_id: String, hash: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to the current build from particular appId. This is a utility API used by BuildUtil to determine whether there's an older build set as current. If it does, the BuildUtil will proceed the upload as differential upload.
##
## Previous API:
##
## * none
##
## Next API:
## * none
##
## Other detail info:
## * Returns : Diff File Status Manifest
##
## Parameters:
## - app_id: appId
## - namespace_param: Namespace
## - platform_id: Platform ID
func get_most_current_build(
	app_id: String, namespace_param: String, platform_id: String
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
##
## This API is used to get diff status manifests.
##
## Previous API:
##
## * none
##
## Next API:
## * none
##
## Other detail info:
## * Returns : Diff File Status Manifest
##
## Parameters:
## - destination_build_id: Destination Build ID
## - destination_file_path: Destination File Path
## - namespace_param: Namespace
## - source_build_id: Source Build IDd
func get_diff_status_of_file(
	destination_build_id: String,
	destination_file_path: String,
	namespace_param: String,
	source_build_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/admin/namespaces/{namespace}/v3/diff/status/{sourceBuildId}/{destinationBuildId}/{destinationFilePath}"
	url_path = url_path.replace("{" + "destinationBuildId" + "}", destination_build_id.uri_encode())
	url_path = url_path.replace(
		"{" + "destinationFilePath" + "}", destination_file_path.uri_encode()
	)
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
##
## This API is used to check the diff status (not yet diff'ed, diff'ed, patched) of a file before upload its control file.
##
## Previous API:
##
## * /v3/startbuildupload
## * /v3/startbuildupload/{sourceBuildId}
##
## Next API:
## * /v3/startzsyncfileupload/{fileHash}
##
## Other detail info:
## * Returns : upload data
##
## Parameters:
## - namespace_param: Namespace
func pre_zsync_upload(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to set current build as release version. Every build set as current will be recorded in version history as chain of history.
##
## Previous API:
##
## * //TODO previous api
##
## Next API:
## * none
##
## Other detail info:
## * Returns : none
##
## Parameters:
## - app_id: Application ID
## - namespace_param: Namespace
## - platform_id: Platform ID
## - version: Version
func set_current_build_2(
	app_id: String, namespace_param: String, platform_id: String, version: String
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
##
## This API is used to start build upload for v3 upload (Differential Upload). This endpoint is the startpoint of upload.
##
## Previous API:
##
## * none
##
## Next API:
## * /v3/prezsyncupload
##
## Other detail info:
## * Returns : build id
##
## Parameters:
## - namespace_param: Namespace
func start_build_upload_3(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## This API is used to start build upload. This endpoint used for incremental build upload, where the developer update the files from existing build version (that hasn't yet set as latest).
##
## Previous API:
##
## * none
##
## Next API:
## * /v3/prezsyncupload
##
## Other detail info:
## * Returns : build id
##
## Parameters:
## - namespace_param: Namespace
## - source_build_id: Source Build ID
func start_build_upload_4(
	namespace_param: String, source_build_id: String, body: Dictionary = {}
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
##
## This API is used to start file upload, which in turn will response with presigned URL for upload target.
##
## Previous API:
##
## * /v3/startbuildupload in the case of normal (non-differential) upload
## * /v3/startbuildupload/{sourceBuildId} in the case of normal (non-differential) incremental upload
## * /v3/commitzsyncfileupload/{buildId}/{hash} in the case of differential upload
## * /v3/commitzsyncfileupload/{buildId}/{hash}/{blockSize} to also specify the blocksize in the case of differential upload
##
## Next API:
## * /v3/commitfileupload//{buildId}/{hash}
##
## Parameters:
## - namespace_param: Namespace
## - uploader_id: The BuildUtil uploader Id. For testing purpose, use random but consistent id
func start_file_upload_1(
	namespace_param: String, uploader_id: String, body: Dictionary = {}
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
##
## This API is used to start zsync control file upload, which in turn will respond with presigned url for the upload target.
##
## Mandatory fields for body: sourceBuildId, destinationBuildId, destinationFilePath, destinationFileChecksum, binaryUpload{contentMd5, contentLength, hash}Previous API:
##
## * /v3/prezsyncupload
##
## Next API:
## * /v3/commitzsyncfileupload/{buildId}/{hash}
## * /v3/commitzsyncfileupload/{buildId}/{hash}/{blockSize} to also specify the blocksize
##
## Other detail info:
## * Returns : upload data
##
## Parameters:
## - file_hash: Hash of the original file (not the zsync file)
## - namespace_param: Namespace
func start_zsync_file_upload_1(
	file_hash: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to see whether BuildUtil should upload in differential mode or normal mode.
##
## Other detail info:
##
## * Returns : Diff File Status Manifest
##
## Parameters:
## - app_id: appId
## - namespace_param: Namespace
## - platform_id: Platform ID
func determine_upload_mode(
	app_id: String, namespace_param: String, platform_id: String
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
##
## This API is used to validate clientId and redirectUri from SDK Config.
##
## Other detail info:
##
## * Returns : Basic Build Manifest
##
## Parameters:
## - namespace_param: Namespace
## - client_id: ClientId
## - redirect_uri: RedirectUri
func get_build_by_namespace_1(
	namespace_param: String, client_id: String, redirect_uri: String
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
##
## Retrieve the list of DLC available on specific game. Use DLC's appId to query.
##
## Parameters:
## - dlc_app_id: DLC AppId
## - namespace_param: Namespace
func latest_base_game_by_dlc(dlc_app_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to get simple build manifest that contains list of current build in various platform.
##
## Other detail info:
##
## * Returns : build manifest
##
## Parameters:
## - app_id: Application ID
## - namespace_param: Namespace
func get_simple_manifest(app_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to Generate Download URLs for the requested blocks inside the specified buildId.
## The download URL generation may returns Signed URL or Public URL, depends on service configurations.
## Before processing the URL generation, it will validate the user entitlement first, if not entitled then the request will be refused.
##
## Other detail info:
##
## * Returns : Block Download URLs
##
## Parameters:
## - build_id: Build ID of the blocks
## - namespace_param: Namespace
func generate_blocks_download_urls(
	build_id: String, namespace_param: String, body: Dictionary = {}
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
##
## This API is used to check whether supplied list of appId has valid buildmanifest and at least one of its build set as latest.
##
## Other detail info:
##
## * Returns : list of build availability
##
## Parameters:
## - namespace_param: Namespace
## - app_ids: Application IDs
func check_latest_build_existence(namespace_param: String, app_ids: Array) -> Dictionary:
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
##
## This API is used to retrieve detailed diff cache.
## The response will contains list of diff cache files along with its download url.
##
## Parameters:
## - destination_build_id: DestinationBuildId
## - namespace_param: Namespace
## - source_build_id: SourceBuildId
func retrieve_cache(
	destination_build_id: String, namespace_param: String, source_build_id: String
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
##
## This API fetch the diff status between two builds. The diff generated by diff wrapper and saved in the database. Return 404 if no diff found.
##
## Other detail info:
##
## * Returns : Simple diff status containing where to fetch diff manifest
##
## Parameters:
## - destination_build_id: Destination Build ID
## - namespace_param: Namespace
## - source_build_id: Source Build ID
func fetch_diff_status(
	destination_build_id: String, namespace_param: String, source_build_id: String
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
##
## This API is used to retrieve compatibility of specific DLC versions against the game version.
##
## Parameters:
## - build_id: Build Id
## - namespace_param: Namespace
func retrieve_compatibility(build_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to retrieve DLC versions against the game version.
##
## Parameters:
## - build_id: Build Id
## - namespace_param: Namespace
func retrieve_dependencies_1(build_id: String, namespace_param: String) -> Dictionary:
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
##
## Retrieve the list of DLC available on specific game. Use game's appId to query.
##
## Parameters:
## - app_id: Base Game App Id
## - namespace_param: Namespace
func latest_dlc_by_app_id(app_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to get encrypted userId and machineId for entitled user.
##
## Other detail info:
##
## * Returns : data field containing encrypted userId and machineId separated by comma
##
## Parameters:
## - namespace_param: Namespace
## - app_id: App Id
## - machine_id: Machine Id
func license(namespace_param: String, app_id: String, machine_id: String) -> Dictionary:
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
##
## This API is used to get public key.
##
## Other detail info:
##
## * Returns : url to download the key
##
## Parameters:
## - namespace_param: Namespace
func retrieve_key(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/buildinfo/public/namespaces/{namespace}/drmlicense/retrievePublicKey"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Update game v2
## GET /buildinfo/public/namespaces/{namespace}/v2/updategame/builds/{buildId}
##
## This API is used to get build manifest of release version of the application. Supply it with source buildId and BuildInfo will output release build and obsolete files list between two version. Only works for builds uploaded with BuildInfo v2
##
## Other detail info:
##
## * Returns : build manifest
##
## Parameters:
## - build_id: Build ID
## - namespace_param: Namespace
func update_game_v2(build_id: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to get build manifest of release version of the application.
##
## Other detail info:
##
## * Returns : build manifest
##
## Parameters:
## - app_id: Application ID
## - namespace_param: Namespace
## - platform_id: Platform ID
func initial_update_game_1(
	app_id: String, namespace_param: String, platform_id: String
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
##
## This API is used to get build manifest. The binary diff will be calculated in the client side, while obsolete file list will be generated by server side.
##
## Other detail info:
##
## * Returns : build manifest
##
## Parameters:
## - app_id: Application ID
## - namespace_param: Namespace
## - platform_id: Platform ID
## - version: Version
func update_game_1(
	app_id: String, namespace_param: String, platform_id: String, version: String
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
##
## This API is used to get version history.
##
## Other detail info:
##
## * Returns : version chain from specified build
##
## Parameters:
## - namespace_param: Namespace
## - app_id: AppId
## - compared_build_id: BuildId to compare
func version_history(
	namespace_param: String, app_id: String, compared_build_id: String
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
##
## This API is used to start resumable multipart file upload.
## The service will returns the list of presigned urls that will be used to upload the Parts.
## If there's a missing Part in the presigned urls list, it indicates that the Part already uploaded previously, so it can be skipped.
## The size of each Part should above or equals to 5MB, except the last Part.
##
## Parameters:
## - namespace_param: Namespace
func start_resumable_multipart_file_upload(
	namespace_param: String, body: Dictionary = {}
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
##
## This API is used to abort resumable multipart file upload.
## The aborted multipart file upload cannot be continued again.
##
## Parameters:
## - hash: Hash
## - namespace_param: Namespace
func abort_multipart_file_upload_1(hash: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to commit resumable multipart file upload to signal the upload completion.
## If there's a missing Part that not uploaded yet, then the multipart file upload cannot be committed.
##
## Parameters:
## - hash: File Hash
## - namespace_param: Namespace
func commit_resumable_multipart_file_upload(hash: String, namespace_param: String) -> Dictionary:
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
##
## This API is used to commit the Part of multipart upload.
## The committed Part will be marked as completed, so in case the multipart file upload retries, it won't be included in the list of unuploaded parts.
##
## Parameters:
## - hash: Original File Hash
## - namespace_param: Namespace
func commit_resumable_multipart_file_upload_part(
	hash: String, namespace_param: String, body: Dictionary = {}
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
