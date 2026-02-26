## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## ugc_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-ugc-service
## Version: 2.26.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(UgcService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name UgcService
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

## Get Channels
## GET /ugc/v1/admin/namespaces/{namespace}/channels
func single_admin_get_channel(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels"
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

## Create Channel
## POST /ugc/v1/admin/namespaces/{namespace}/channels
func admin_create_channel(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update Channel
## PUT /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}
func single_admin_update_channel(
	channel_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Channel
## DELETE /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}
func single_admin_delete_channel(
	channel_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload content to a channel
## POST /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents
## @deprecated
func admin_upload_content_direct(
	channel_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Upload content to S3 bucket
## POST /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/s3
func admin_upload_content_s3(
	channel_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/s3"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update content to S3 bucket
## PUT /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/s3/{contentId}
func single_admin_update_content_s3(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/s3/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Search contents specific to a channel
## GET /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/search
func admin_search_channel_specific_content(
	channel_id: String,
	namespace_param: String,
	creator: String = "",
	ishidden: String = "",
	isofficial: String = "",
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	orderby: String = "",
	sortby: String = "",
	subtype: String = "",
	tags: Array = [],
	type_param: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/search"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not creator.is_empty():
		query_params["creator"] = creator
	if not ishidden.is_empty():
		query_params["ishidden"] = ishidden
	if not isofficial.is_empty():
		query_params["isofficial"] = isofficial
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not orderby.is_empty():
		query_params["orderby"] = orderby
	if not sortby.is_empty():
		query_params["sortby"] = sortby
	if not subtype.is_empty():
		query_params["subtype"] = subtype
	if tags.size() > 0:
		query_params["tags"] = tags
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update content to a channel
## PUT /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}
## @deprecated
func single_admin_update_content_direct(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete content
## DELETE /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}
func single_admin_delete_content(
	channel_id: String,
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get user's generated contents
## GET /ugc/v1/admin/namespaces/{namespace}/contents
func single_admin_get_content(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents"
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

## Bulk get content by content IDs
## POST /ugc/v1/admin/namespaces/{namespace}/contents/bulk
func admin_get_content_bulk(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Search contents
## GET /ugc/v1/admin/namespaces/{namespace}/contents/search
func admin_search_content(
	namespace_param: String,
	creator: String = "",
	ishidden: String = "",
	isofficial: String = "",
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	orderby: String = "",
	sortby: String = "",
	subtype: String = "",
	tags: Array = [],
	type_param: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not creator.is_empty():
		query_params["creator"] = creator
	if not ishidden.is_empty():
		query_params["ishidden"] = ishidden
	if not isofficial.is_empty():
		query_params["isofficial"] = isofficial
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not orderby.is_empty():
		query_params["orderby"] = orderby
	if not sortby.is_empty():
		query_params["sortby"] = sortby
	if not subtype.is_empty():
		query_params["subtype"] = subtype
	if tags.size() > 0:
		query_params["tags"] = tags
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get content by content sharecodes
## POST /ugc/v1/admin/namespaces/{namespace}/contents/sharecodes/bulk
func admin_get_content_bulk_by_share_codes(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/sharecodes/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get content by sharecode
## GET /ugc/v1/admin/namespaces/{namespace}/contents/sharecodes/{shareCode}
func admin_get_user_content_by_share_code(
	namespace_param: String,
	share_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/sharecodes/{shareCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user specific content
## GET /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}
func admin_get_specific_content(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get content preview
## GET /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/preview
func admin_download_content_preview(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/preview"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Rollback content's payload version
## PUT /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/rollback/{versionId}
func rollback_content_version(
	content_id: String,
	namespace_param: String,
	version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/rollback/{versionId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "versionId" + "}", version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update screenshot of content
## PUT /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots
func admin_update_screenshots(
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Upload screenshots for official content
## POST /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots
func admin_upload_content_screenshot(
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete content's screenshot
## DELETE /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots/{screenshotId}
func admin_delete_content_screenshot(
	content_id: String,
	namespace_param: String,
	screenshot_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots/{screenshotId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "screenshotId" + "}", screenshot_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List content's payload versions
## GET /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/versions
func list_content_versions(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/versions"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all user groups
## GET /ugc/v1/admin/namespaces/{namespace}/groups
func single_admin_get_all_groups(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/groups"
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

## Create groups
## POST /ugc/v1/admin/namespaces/{namespace}/groups
func admin_create_group(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get specific user group
## GET /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}
func single_admin_get_group(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update group
## PUT /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}
func single_admin_update_group(
	group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete group
## DELETE /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}
func single_admin_delete_group(
	group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## (Legacy) Get contents belong to a group
## GET /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}/contents
func single_admin_get_group_contents(
	group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/groups/{groupId}/contents"
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

## Get tags
## GET /ugc/v1/admin/namespaces/{namespace}/tags
func admin_get_tag(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/tags"
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

## Create tags
## POST /ugc/v1/admin/namespaces/{namespace}/tags
func admin_create_tag(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update tag
## PUT /ugc/v1/admin/namespaces/{namespace}/tags/{tagId}
func admin_update_tag(
	namespace_param: String,
	tag_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/tags/{tagId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "tagId" + "}", tag_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete tags
## DELETE /ugc/v1/admin/namespaces/{namespace}/tags/{tagId}
func admin_delete_tag(
	namespace_param: String,
	tag_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/tags/{tagId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "tagId" + "}", tag_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get types
## GET /ugc/v1/admin/namespaces/{namespace}/types
func admin_get_type(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/types"
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

## Create types
## POST /ugc/v1/admin/namespaces/{namespace}/types
func admin_create_type(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/types"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update types
## PUT /ugc/v1/admin/namespaces/{namespace}/types/{typeId}
func admin_update_type(
	namespace_param: String,
	type_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/types/{typeId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "typeId" + "}", type_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete type
## DELETE /ugc/v1/admin/namespaces/{namespace}/types/{typeId}
func admin_delete_type(
	namespace_param: String,
	type_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/types/{typeId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "typeId" + "}", type_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Channels
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels
func admin_get_channel(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete all user channel
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels
func admin_delete_all_user_channels(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Channel
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}
func admin_update_channel(
	channel_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Channel
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}
func admin_delete_channel(
	channel_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update content to S3 bucket by share code
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
func admin_update_content_s3_by_share_code(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update content to S3 bucket
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/{contentId}
func admin_update_content_s3(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete content by share code
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
func delete_content_by_share_code(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update content to a channel
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
## @deprecated
func admin_update_content_direct(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete content
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
func admin_delete_content(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get user's generated contents
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents
func admin_get_content(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents"
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

## Delete all user content
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents
func admin_delete_all_user_contents(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Hide/Unhide user's generated contents
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents/{contentId}/hide
func admin_hide_user_content(
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents/{contentId}/hide"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get all user groups
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups
func admin_get_all_groups(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups"
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

## Delete all user group
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups
func admin_delete_all_user_group(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get specific user group
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}
func admin_get_group(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update group
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}
func admin_update_group(
	group_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete group
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}
func admin_delete_group(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## (Legacy) Get contents belong to a group
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
func admin_get_group_contents(
	group_id: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
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

## Remove all user related state: likes, downloads, followers, following
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/states
func admin_delete_all_user_states(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/users/{userId}/states"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Search contents specific to a channel
## GET /ugc/v1/public/namespaces/{namespace}/channels/{channelId}/contents
func search_channel_specific_content(
	channel_id: String,
	namespace_param: String,
	creator: String = "",
	ishidden: String = "",
	isofficial: String = "",
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	orderby: String = "",
	sortby: String = "",
	subtype: String = "",
	tags: Array = [],
	type_param: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/channels/{channelId}/contents"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not creator.is_empty():
		query_params["creator"] = creator
	if not ishidden.is_empty():
		query_params["ishidden"] = ishidden
	if not isofficial.is_empty():
		query_params["isofficial"] = isofficial
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not orderby.is_empty():
		query_params["orderby"] = orderby
	if not sortby.is_empty():
		query_params["sortby"] = sortby
	if not subtype.is_empty():
		query_params["subtype"] = subtype
	if tags.size() > 0:
		query_params["tags"] = tags
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Search contents
## GET /ugc/v1/public/namespaces/{namespace}/contents
func public_search_content(
	namespace_param: String,
	creator: String = "",
	ishidden: String = "",
	isofficial: String = "",
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	orderby: String = "",
	sortby: String = "",
	subtype: String = "",
	tags: Array = [],
	type_param: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not creator.is_empty():
		query_params["creator"] = creator
	if not ishidden.is_empty():
		query_params["ishidden"] = ishidden
	if not isofficial.is_empty():
		query_params["isofficial"] = isofficial
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not orderby.is_empty():
		query_params["orderby"] = orderby
	if not sortby.is_empty():
		query_params["sortby"] = sortby
	if not subtype.is_empty():
		query_params["subtype"] = subtype
	if tags.size() > 0:
		query_params["tags"] = tags
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get contents by content Ids 
## POST /ugc/v1/public/namespaces/{namespace}/contents/bulk
func public_get_content_bulk(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get contents from followed creators
## GET /ugc/v1/public/namespaces/{namespace}/contents/followed
func get_followed_content(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/followed"
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

## Get liked contents
## GET /ugc/v1/public/namespaces/{namespace}/contents/liked
func get_liked_content(
	namespace_param: String,
	isofficial: bool = false,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	orderby: String = "",
	sortby: String = "",
	subtype: String = "",
	tags: Array = [],
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/liked"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isofficial"] = isofficial
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not orderby.is_empty():
		query_params["orderby"] = orderby
	if not sortby.is_empty():
		query_params["sortby"] = sortby
	if not subtype.is_empty():
		query_params["subtype"] = subtype
	if tags.size() > 0:
		query_params["tags"] = tags
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get content by content sharecodes
## POST /ugc/v1/public/namespaces/{namespace}/contents/sharecodes/bulk
func public_get_content_bulk_by_share_codes(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/sharecodes/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get content by sharecode
## GET /ugc/v1/public/namespaces/{namespace}/contents/sharecodes/{shareCode}
func public_download_content_by_share_code(
	namespace_param: String,
	share_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/sharecodes/{shareCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user specific content
## GET /ugc/v1/public/namespaces/{namespace}/contents/{contentId}
func public_download_content_by_content_id(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add unique download count to a content
## POST /ugc/v1/public/namespaces/{namespace}/contents/{contentId}/downloadcount
func add_download_count(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/{contentId}/downloadcount"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update like/unlike status to a content
## PUT /ugc/v1/public/namespaces/{namespace}/contents/{contentId}/like
func update_content_like_status(
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/{contentId}/like"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get content preview
## GET /ugc/v1/public/namespaces/{namespace}/contents/{contentId}/preview
func public_download_content_preview(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/{contentId}/preview"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get tags
## GET /ugc/v1/public/namespaces/{namespace}/tags
func get_tag(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/tags"
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

## Get types
## GET /ugc/v1/public/namespaces/{namespace}/types
func get_type(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/types"
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

## Search creator
## GET /ugc/v1/public/namespaces/{namespace}/users
func public_search_creator(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	orderby: String = "",
	sortby: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not orderby.is_empty():
		query_params["orderby"] = orderby
	if not sortby.is_empty():
		query_params["sortby"] = sortby
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get followed creators
## GET /ugc/v1/public/namespaces/{namespace}/users/followed
func get_followed_users(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/followed"
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

## Get creator stats: number of total like by other user, number of...
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}
func public_get_creator(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Channels
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels
func get_channels(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Channel
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels
func public_create_channel(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete all user channel
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels
func delete_all_user_channel(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Channel
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}
func update_channel(
	channel_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Channel
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}
func delete_channel(
	channel_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload content to a channel
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents
## @deprecated
func create_content_direct(
	channel_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Upload content to S3 bucket
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3
func create_content_s3(
	channel_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update content to S3 bucket by share code
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
func public_update_content_by_share_code(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update content to S3 bucket
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/{contentId}
func update_content_s3(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete content by share code
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
func public_delete_content_by_share_code(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update content to a channel
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
## @deprecated
func update_content_direct(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete content
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
func delete_content(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update content sharecode
## PATCH /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/sharecode
func update_content_share_code(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/sharecode"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get user's generated contents
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents
func public_get_user_content(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/contents"
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

## Delete all user content
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents
func delete_all_user_contents(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/contents"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update screenshot of content
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
func update_screenshots(
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Upload screenshots for content
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
func upload_content_screenshot(
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete content's screenshot
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots/{screenshotId}
func delete_content_screenshot(
	content_id: String,
	namespace_param: String,
	screenshot_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots/{screenshotId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "screenshotId" + "}", screenshot_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update follow/unfollow status to a user
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/follow
func update_user_follow_status(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/follow"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get list of followers
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/followers
func get_public_followers(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/followers"
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

## Get list of following
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/following
func get_public_following(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/following"
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

## Get all user groups
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups
func get_groups(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/groups"
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

## Create groups
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups
func create_group(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete all user group
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups
func delete_all_user_group(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get user's groups
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}
func get_group(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update group
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}
func update_group(
	group_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete group
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}
func delete_group(
	group_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## (Legacy) Get contents belong to a group
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
func get_group_content(
	group_id: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
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

## Remove all user related state: likes, downloads, followers, following
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/states
func delete_all_user_states(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/users/{userId}/states"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List contents specific to a channel
## GET /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents
func admin_get_content_by_channel_idv2(
	channel_id: String,
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a content
## POST /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents
func admin_create_content_v2(
	channel_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete official content
## DELETE /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}
func admin_delete_official_content_v2(
	channel_id: String,
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update official content
## PATCH /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}
func admin_update_official_content_v2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Copy contents from a channel to another
## POST /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/copy
func admin_copy_content(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/copy"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update content file location
## PATCH /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/fileLocation
func admin_update_official_content_file_location(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/fileLocation"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Generate official content upload URL
## PATCH /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/uploadUrl
func admin_generate_official_content_upload_urlv2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/uploadUrl"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get configs
## GET /ugc/v2/admin/namespaces/{namespace}/configs
func admin_get_configs(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/configs"
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

## Update config
## PATCH /ugc/v2/admin/namespaces/{namespace}/configs/{key}
func admin_update_config(
	key: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/configs/{key}"
	url_path = url_path.replace("{" + "key" + "}", key.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## List contents
## GET /ugc/v2/admin/namespaces/{namespace}/contents
func admin_list_content_v2(
	namespace_param: String,
	is_official: bool = false,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = "",
	sub_type: String = "",
	tags: Array = [],
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isOfficial"] = is_official
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sub_type.is_empty():
		query_params["subType"] = sub_type
	if tags.size() > 0:
		query_params["tags"] = tags
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get content by content IDs
## POST /ugc/v2/admin/namespaces/{namespace}/contents/bulk
func admin_bulk_get_content_by_i_ds_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk get content by content sharecodes
## POST /ugc/v2/admin/namespaces/{namespace}/contents/sharecodes/bulk
func admin_get_content_bulk_by_share_codes_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/sharecodes/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get content by sharecode
## GET /ugc/v2/admin/namespaces/{namespace}/contents/sharecodes/{shareCode}
func admin_get_content_by_share_code_v2(
	namespace_param: String,
	share_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/sharecodes/{shareCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get content by content ID
## GET /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}
func admin_get_content_by_content_idv2(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Rollback content's payload version
## PUT /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/rollback/{versionId}
func rollback_content_version_v2(
	content_id: String,
	namespace_param: String,
	version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/rollback/{versionId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "versionId" + "}", version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update screenshot of content
## PUT /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots
func admin_update_screenshots_v2(
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Upload screenshots for content
## POST /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots
func admin_upload_content_screenshot_v2(
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete screenshots content
## DELETE /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots/{screenshotId}
func admin_delete_content_screenshot_v2(
	content_id: String,
	namespace_param: String,
	screenshot_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots/{screenshotId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "screenshotId" + "}", screenshot_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List content's payload versions
## GET /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/versions
func list_content_versions_v2(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/versions"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get contents belong to a group
## GET /ugc/v2/admin/namespaces/{namespace}/groups/{groupId}/contents
func admin_get_official_group_contents_v2(
	group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/groups/{groupId}/contents"
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

## List staging contents
## GET /ugc/v2/admin/namespaces/{namespace}/staging-contents
func admin_list_staging_contents(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/staging-contents"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get staging content by id
## GET /ugc/v2/admin/namespaces/{namespace}/staging-contents/{contentId}
func admin_get_staging_content_by_id(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/staging-contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Approve or reject content
## POST /ugc/v2/admin/namespaces/{namespace}/staging-contents/{contentId}/approve
func admin_approve_staging_content(
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/staging-contents/{contentId}/approve"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update content to S3 bucket by share code
## PUT /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
func admin_update_content_by_share_code_v2(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete content by share code
## DELETE /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
func admin_delete_content_by_share_code_v2(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete user content
## DELETE /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
func admin_delete_user_content_v2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update user content
## PATCH /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
func admin_update_user_content_v2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update user content file location
## PATCH /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/fileLocation
func admin_update_user_content_file_location(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/fileLocation"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Generate user content upload URL
## PATCH /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/uploadUrl
func admin_generate_user_content_upload_urlv2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/uploadUrl"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get user's generated contents
## GET /ugc/v2/admin/namespaces/{namespace}/users/{userId}/contents
func admin_get_content_by_user_idv2(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/contents"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Hide/Unhide user's generated contents
## PUT /ugc/v2/admin/namespaces/{namespace}/users/{userId}/contents/{contentId}/hide
func admin_update_content_hide_status_v2(
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/contents/{contentId}/hide"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get contents belong to a group
## GET /ugc/v2/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
func admin_get_user_group_contents_v2(
	group_id: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
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

## List user staging contents
## GET /ugc/v2/admin/namespaces/{namespace}/users/{userId}/staging-contents
func admin_list_user_staging_contents(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/admin/namespaces/{namespace}/users/{userId}/staging-contents"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List contents specific to a channel
## GET /ugc/v2/public/namespaces/{namespace}/channels/{channelId}/contents
func public_get_content_by_channel_idv2(
	channel_id: String,
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/channels/{channelId}/contents"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List contents
## GET /ugc/v2/public/namespaces/{namespace}/contents
func public_list_content_v2(
	namespace_param: String,
	is_official: bool = false,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = "",
	sub_type: String = "",
	tags: Array = [],
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["isOfficial"] = is_official
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sub_type.is_empty():
		query_params["subType"] = sub_type
	if tags.size() > 0:
		query_params["tags"] = tags
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get contents by content Ids 
## POST /ugc/v2/public/namespaces/{namespace}/contents/bulk
func public_bulk_get_content_by_idv2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk get content by content sharecodes
## POST /ugc/v2/public/namespaces/{namespace}/contents/sharecodes/bulk
func public_get_content_bulk_by_share_codes_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/sharecodes/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get content by sharecode
## GET /ugc/v2/public/namespaces/{namespace}/contents/sharecodes/{shareCode}
func public_get_content_by_share_code_v2(
	namespace_param: String,
	share_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/sharecodes/{shareCode}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get content by content ID
## GET /ugc/v2/public/namespaces/{namespace}/contents/{contentId}
func public_get_content_by_idv2(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add unique download count to a content
## POST /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/downloadcount
func public_add_download_count_v2(
	content_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/{contentId}/downloadcount"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List content downloader
## GET /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/downloader
func public_list_content_downloader_v2(
	content_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/{contentId}/downloader"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve list of user that like specified content.
## GET /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/like
func public_list_content_like_v2(
	content_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/{contentId}/like"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update like/unlike status to a content
## PUT /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/like
func update_content_like_status_v2(
	content_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/{contentId}/like"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create a content
## POST /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents
func public_create_content_v2(
	channel_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update content to S3 bucket by share code
## PUT /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
func public_update_content_by_share_code_v2(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete content by share code
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
func public_delete_content_by_share_code_v2(
	channel_id: String,
	namespace_param: String,
	share_code: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "shareCode" + "}", share_code.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete content
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
func public_delete_content_v2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update content
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
func public_update_content_v2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update content file location
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/fileLocation
func public_update_content_file_location(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/fileLocation"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update content share code
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/sharecode
func update_content_share_code_v2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/sharecode"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Generate content upload URL
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/uploadUrl
func public_generate_content_upload_urlv2(
	channel_id: String,
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/uploadUrl"
	url_path = url_path.replace("{" + "channelId" + "}", channel_id.uri_encode())
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get content by user ID
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents
func public_get_content_by_user_idv2(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/contents"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update screenshot of content
## PUT /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
func update_screenshots_v2(
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Upload screenshots for content
## POST /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
func upload_content_screenshot_v2(
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete screenshots content
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots/{screenshotId}
func delete_content_screenshot_v2(
	content_id: String,
	namespace_param: String,
	screenshot_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots/{screenshotId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "screenshotId" + "}", screenshot_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get contents belong to a group
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
func public_get_group_contents_v2(
	group_id: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents"
	url_path = url_path.replace("{" + "groupId" + "}", group_id.uri_encode())
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

## List user staging contents
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents
func list_user_staging_contents(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user staging content by id
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}
func get_user_staging_content_by_id(
	content_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update staging content
## PUT /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}
func update_staging_content(
	content_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete user staging content by id
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}
func delete_user_staging_content_by_id(
	content_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}"
	url_path = url_path.replace("{" + "contentId" + "}", content_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)
