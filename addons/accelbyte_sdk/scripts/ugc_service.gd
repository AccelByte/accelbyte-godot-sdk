## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## ugc_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-ugc-service
## Version: 2.29.1
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


## Lists channels in the namespace
## GET /ugc/v1/admin/namespaces/{namespace}/channels
##
## Get official channel paginated
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func single_admin_get_channel(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Creates a channel in the namespace
## POST /ugc/v1/admin/namespaces/{namespace}/channels
##
## Create official channel
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_channel(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/channels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates a channel in the namespace
## PUT /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}
##
## Update official channel
##
## Parameters:
## - channel_id: Unique identifier of the channel to update.
## - namespace_param: Game namespace
func single_admin_update_channel(
	channel_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a channel from the namespace
## DELETE /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}
##
## Delete official channel
##
## Parameters:
## - channel_id: Unique identifier of the channel to delete.
## - namespace_param: Game namespace
func single_admin_delete_channel(channel_id: String, namespace_param: String) -> Dictionary:
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


## Uploads UGC content to S3 for a channel
## POST /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/s3
##
## Uploads UGC content to S3 for the specified channel and creates the content record. The `contentType` field sets the Content-Type header for the S3 presigned upload URL; if omitted, the service uses `fileExtension` instead. The `shareCode`, if provided, must be 7 characters using only `abcdefhkpqrstuxyz`.
##
## Parameters:
## - channel_id: Unique identifier of the channel to upload content to.
## - namespace_param: Game namespace
func admin_upload_content_s3(
	channel_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates UGC content in S3 for a channel
## PUT /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/s3/{contentId}
##
## Updates UGC content in S3 for the specified channel. To replace the content file, set `updateContentFile` to `true` and upload via the URL in `payloadURL.url`. The `contentType` field sets the Content-Type header for the S3 presigned upload URL; if omitted, the service uses `fileExtension`. The `shareCode`, if provided, must be at most 7 characters using only `abcdefhkpqrstuxyz`.
##
## Parameters:
## - channel_id: Unique identifier of the channel containing the content.
## - content_id: Unique identifier of the content to update.
## - namespace_param: Game namespace
func single_admin_update_content_s3(
	channel_id: String, content_id: String, namespace_param: String, body: Dictionary = {}
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


## Searches contents within a channel
## GET /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/search
##
## Searches UGC content within a channel. Supports advanced tag filtering with `&` (AND) and `|` (OR) operators and parentheses for priority; for example, `tags=red&(animal|wild)`. AND takes precedence over OR when parentheses are absent. Operands may be alphanumeric, underscore `_`, or dash `-`; operators are `&`, `|`, `(`, `)`. Tag values must be URL-encoded. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - channel_id: Unique identifier of the channel to search within.
## - namespace_param: Game namespace
## - creator: Creator name
## - ishidden: Set to true to list only hidden contents, false to list only non-hidden contents
## - isofficial: Filter only official contents (boolean)
## - limit: Number of results to return
## - name_param: Content name
## - offset: Number of results to skip for pagination
## - orderby: Sorting order: asc, desc. default=desc
## - sortby: Sorting criteria: name,download,like,date,updatedTime. default=date
## - subtype: Content subtype
## - tags: Content tag
## - type_param: Content type
## - user_id: AccelByte user ID
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


## Deletes a content entry from a channel
## DELETE /ugc/v1/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}
##
## Deletes a content entry from the specified channel, including its associated likes.
##
## Parameters:
## - channel_id: Unique identifier of the channel containing the content.
## - content_id: Unique identifier of the content to delete.
## - namespace_param: Game namespace
func single_admin_delete_content(
	channel_id: String, content_id: String, namespace_param: String
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


## Lists user-generated contents in a namespace
## GET /ugc/v1/admin/namespaces/{namespace}/contents
##
## Lists UGC entries in the namespace. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func single_admin_get_content(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Retrieves content entries by ID
## POST /ugc/v1/admin/namespaces/{namespace}/contents/bulk
##
## Retrieves up to 100 content entries by their IDs in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_content_bulk(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/contents/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Searches contents in a namespace
## GET /ugc/v1/admin/namespaces/{namespace}/contents/search
##
## Searches UGC content in the namespace. Supports advanced tag filtering with `&` (AND) and `|` (OR) operators and parentheses for priority; for example, `tags=red&(animal|wild)`. AND takes precedence over OR when parentheses are absent. Operands may be alphanumeric, underscore `_`, or dash `-`; operators are `&`, `|`, `(`, `)`. Tag values must be URL-encoded. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - creator: Creator name
## - ishidden: Set to true to list only hidden contents, false to list only non-hidden contents
## - isofficial: Filter only official contents (boolean)
## - limit: Number of results to return
## - name_param: Content name
## - offset: Number of results to skip for pagination
## - orderby: Sorting order: asc, desc. default=desc
## - sortby: Sorting criteria: name,download,like,date,updatedTime. default=date
## - subtype: Content subtype
## - tags: Content tag
## - type_param: Content type
## - user_id: AccelByte user ID
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


## Retrieves content entries by share code
## POST /ugc/v1/admin/namespaces/{namespace}/contents/sharecodes/bulk
##
## Retrieves up to 100 content entries by their sharecodes in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_content_bulk_by_share_codes(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves a content entry by its sharecode
## GET /ugc/v1/admin/namespaces/{namespace}/contents/sharecodes/{shareCode}
##
## Retrieves a UGC content entry using its sharecode.
##
## Parameters:
## - namespace_param: Game namespace
## - share_code: Content sharecode
func admin_get_user_content_by_share_code(
	namespace_param: String, share_code: String
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


## Retrieves a content entry by ID
## GET /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}
##
## Retrieves a UGC content entry by its ID.
##
## Parameters:
## - content_id: Unique identifier of the content to retrieve.
## - namespace_param: Game namespace
func admin_get_specific_content(content_id: String, namespace_param: String) -> Dictionary:
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


## Retrieves the preview for a content entry
## GET /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/preview
##
## Retrieves the preview for a UGC content entry. Preview is a legacy feature; use Screenshots for a better content preview experience.
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
func admin_download_content_preview(content_id: String, namespace_param: String) -> Dictionary:
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


## Restores a content entry to a previous file version
## PUT /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/rollback/{versionId}
##
## Rolls back a content entry's file to the specified previous version.
##
## Parameters:
## - content_id: Unique identifier of the content to roll back.
## - namespace_param: Game namespace
## - version_id: Unique identifier of the version to restore.
func rollback_content_version(
	content_id: String, namespace_param: String, version_id: String
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


## Updates screenshots for a content entry
## PUT /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots
##
## Updates screenshots for the specified content. Screenshot descriptions must not exceed 1024 characters.
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
func admin_update_screenshots(
	content_id: String, namespace_param: String, body: Dictionary = {}
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


## Uploads screenshots for a content entry
## POST /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots
##
## Uploads screenshots for the specified content. Provide all fields except `contentType`, which sets the Content-Type header for the presigned upload URL; if omitted, the service uses `fileExtension`. Supported file extensions: `pjp`, `jpg`, `jpeg`, `jfif`, `bmp`, `png`. Screenshot descriptions must not exceed 1024 characters.
##
## Parameters:
## - content_id: Unique identifier of the content to add screenshots to.
## - namespace_param: Game namespace
func admin_upload_content_screenshot(
	content_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a screenshot from a content entry
## DELETE /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/screenshots/{screenshotId}
##
## Delete existing screenshot from a content
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
## - screenshot_id: Unique identifier of the screenshot to delete.
func admin_delete_content_screenshot(
	content_id: String, namespace_param: String, screenshot_id: String
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


## Lists file versions for a content entry
## GET /ugc/v1/admin/namespaces/{namespace}/contents/{contentId}/versions
##
## Lists file versions for the specified content. The service creates a version on content creation and on each update where `updateContentFile` is `true`. Returns only the 10 most recent versions.
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
func list_content_versions(content_id: String, namespace_param: String) -> Dictionary:
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


## Lists all user groups in a namespace
## GET /ugc/v1/admin/namespaces/{namespace}/groups
##
## Get user group paginated
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func single_admin_get_all_groups(
	namespace_param: String, limit: int = -1, offset: int = -1
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


## Creates a group in the namespace
## POST /ugc/v1/admin/namespaces/{namespace}/groups
##
## Create group
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_group(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/groups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a specific user group by ID
## GET /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}
##
## Get user group by group ID
##
## Parameters:
## - group_id: Unique identifier of the group.
## - namespace_param: Game namespace
func single_admin_get_group(group_id: String, namespace_param: String) -> Dictionary:
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


## Updates a group by replacing its name and contents
## PUT /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}
##
## Replace group name and contents with new ones.
##
## Parameters:
## - group_id: Unique identifier of the group to update.
## - namespace_param: Game namespace
func single_admin_update_group(
	group_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a group by ID
## DELETE /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}
##
## Delete group by group ID
##
## Parameters:
## - group_id: Unique identifier of the group to delete.
## - namespace_param: Game namespace
func single_admin_delete_group(group_id: String, namespace_param: String) -> Dictionary:
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


## Lists contents belonging to a group (legacy)
## GET /ugc/v1/admin/namespaces/{namespace}/groups/{groupId}/contents
##
## Lists contents belonging to the specified group. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - group_id: Unique identifier of the group.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func single_admin_get_group_contents(
	group_id: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists available tags in a namespace
## GET /ugc/v1/admin/namespaces/{namespace}/tags
##
## Get available tags paginated
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_tag(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Creates a tag in the namespace
## POST /ugc/v1/admin/namespaces/{namespace}/tags
##
## Creates a new tag
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_tag(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates an existing tag
## PUT /ugc/v1/admin/namespaces/{namespace}/tags/{tagId}
##
## Update existing tag
##
## Parameters:
## - namespace_param: Game namespace
## - tag_id: Unique identifier of the tag to update.
func admin_update_tag(namespace_param: String, tag_id: String, body: Dictionary = {}) -> Dictionary:
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


## Deletes a tag by ID
## DELETE /ugc/v1/admin/namespaces/{namespace}/tags/{tagId}
##
## Delete existing tag
##
## Parameters:
## - namespace_param: Game namespace
## - tag_id: Unique identifier of the tag to delete.
func admin_delete_tag(namespace_param: String, tag_id: String) -> Dictionary:
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


## Lists available content types in a namespace
## GET /ugc/v1/admin/namespaces/{namespace}/types
##
## Get available types paginated
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_type(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Creates a type and subtype in the namespace
## POST /ugc/v1/admin/namespaces/{namespace}/types
##
## Creates a new type and subtype
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_type(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/admin/namespaces/{namespace}/types"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates a type and its subtypes
## PUT /ugc/v1/admin/namespaces/{namespace}/types/{typeId}
##
## Updates a type and subtype
##
## Parameters:
## - namespace_param: Game namespace
## - type_id: Unique identifier of the type to update.
func admin_update_type(
	namespace_param: String, type_id: String, body: Dictionary = {}
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


## Deletes a type by ID
## DELETE /ugc/v1/admin/namespaces/{namespace}/types/{typeId}
##
## Delete existing type
##
## Parameters:
## - namespace_param: Game namespace
## - type_id: Unique identifier of the type to delete.
func admin_delete_type(namespace_param: String, type_id: String) -> Dictionary:
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


## Lists channels for a user
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels
##
## Get user channel paginated
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - name_param: Likes filter by channel name
## - offset: Number of results to skip for pagination
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


## Deletes all channels for a user
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels
##
## Delete all user channel
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_all_user_channels(namespace_param: String, user_id: String) -> Dictionary:
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


## Updates a user's channel
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}
##
## Update user channel
##
## Parameters:
## - channel_id: Unique identifier of the channel to update.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_channel(
	channel_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a channel for a user
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}
##
## Delete user channel
##
## Parameters:
## - channel_id: Unique identifier of the channel to delete.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_channel(
	channel_id: String, namespace_param: String, user_id: String
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


## Updates UGC content in S3 by sharecode
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
##
## Updates UGC content in S3 identified by its share code. To replace the content file, set `updateContentFile` to `true` and upload via the URL in `payloadURL.url`. The `contentType` field sets the Content-Type header for the S3 presigned upload URL; if omitted, the service uses `fileExtension`.
##
## Parameters:
## - channel_id: Unique identifier of the channel containing the content.
## - namespace_param: Game namespace
## - share_code: Sharecode identifying the content to update.
## - user_id: AccelByte user ID
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


## Updates UGC content in S3 for a user's channel
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/{contentId}
##
## Updates UGC content in S3 for the specified user's channel. To replace the content file, set `updateContentFile` to `true` and upload via the URL in `payloadURL.url`. The `contentType` field sets the Content-Type header for the S3 presigned upload URL; if omitted, the service uses `fileExtension`. The `shareCode`, if provided, must be at most 7 characters using only `abcdefhkpqrstuxyz`.
##
## Parameters:
## - channel_id: Unique identifier of the channel containing the content.
## - content_id: Unique identifier of the content to update.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Deletes a content entry by sharecode
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
##
## Deletes a content entry identified by its sharecode, including its associated likes.
##
## Parameters:
## - channel_id: Unique identifier of the channel containing the content.
## - namespace_param: Game namespace
## - share_code: Sharecode of the content to delete.
## - user_id: AccelByte user ID
func delete_content_by_share_code(
	channel_id: String, namespace_param: String, share_code: String, user_id: String
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


## Deletes a content entry by ID
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
##
## Deletes a content entry by its ID, including its associated likes.
##
## Parameters:
## - channel_id: Unique identifier of the channel containing the content.
## - content_id: Unique identifier of the content to delete.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_content(
	channel_id: String, content_id: String, namespace_param: String, user_id: String
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


## Lists user-generated contents for a specific user
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents
##
## Lists UGC entries for the specified user. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_content(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Deletes all content entries for a user
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents
##
## Deletes all content entries for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_all_user_contents(namespace_param: String, user_id: String) -> Dictionary:
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


## Updates the hidden status of a user's content
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/contents/{contentId}/hide
##
## Updates the hidden status of the specified content, toggling its visibility in listings.
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_hide_user_content(
	content_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists all groups for a user
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups
##
## Get user group paginated
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_all_groups(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Deletes all groups for a user
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups
##
## Delete all user group
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_all_user_group(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves a specific group for a user
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}
##
## Get user group by group ID
##
## Parameters:
## - group_id: Unique identifier of the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_group(group_id: String, namespace_param: String, user_id: String) -> Dictionary:
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


## Updates a group for a user
## PUT /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}
##
## Replace group name and contents with new ones.
##
## Parameters:
## - group_id: Unique identifier of the group to update.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_group(
	group_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a group for a user
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}
##
## Delete group
##
## Parameters:
## - group_id: Unique identifier of the group to delete.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_group(group_id: String, namespace_param: String, user_id: String) -> Dictionary:
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


## Lists contents belonging to a group for a user (legacy)
## GET /ugc/v1/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
##
## Lists contents belonging to the specified group for a user. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - group_id: Unique identifier of the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_group_contents(
	group_id: String, namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Removes all user state including likes, downloads, and follows
## DELETE /ugc/v1/admin/namespaces/{namespace}/users/{userId}/states
##
## Removes all state for the specified user, including likes, downloads, followers, and following relationships.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_all_user_states(namespace_param: String, user_id: String) -> Dictionary:
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


## Searches contents within a channel
## GET /ugc/v1/public/namespaces/{namespace}/channels/{channelId}/contents
##
## Lists UGC content in the specified channel. Supports advanced tag filtering with `&` (AND) and `|` (OR) operators and parentheses for priority; for example, `tags=red&(animal|wild)`. AND takes precedence over OR when parentheses are absent. Operands may be alphanumeric, underscore `_`, or dash `-`; operators are `&`, `|`, `(`, `)`. Tag values must be URL-encoded. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - channel_id: Unique identifier of the channel to search within.
## - namespace_param: Game namespace
## - creator: Creator name
## - ishidden: Set to true to list only hidden contents, false to list only non-hidden contents
## - isofficial: Filter only official contents (boolean)
## - limit: Number of results to return
## - name_param: Content name
## - offset: Number of results to skip for pagination
## - orderby: Sorting order: asc, desc. default=desc
## - sortby: Sorting criteria: name,download,like,date,updatedTime. default=date
## - subtype: Content subtype
## - tags: Content tag. max number of tags: -1 tags (-1 means unlimited).
## - type_param: Content type
## - user_id: AccelByte user ID
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


## Searches contents in a namespace
## GET /ugc/v1/public/namespaces/{namespace}/contents
##
## Lists UGC content in the namespace. Accessible without a token or with a valid user token. Supports advanced tag filtering with `&` (AND) and `|` (OR) operators and parentheses for priority; for example, `tags=red&(animal|wild)`. AND takes precedence over OR when parentheses are absent. Operands may be alphanumeric, underscore `_`, or dash `-`; operators are `&`, `|`, `(`, `)`. Tag values must be URL-encoded. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - creator: Creator name
## - ishidden: Set to true to list only hidden contents, false to list only non-hidden contents
## - isofficial: Filter only official contents (boolean)
## - limit: Number of results to return
## - name_param: Content name
## - offset: Number of results to skip for pagination
## - orderby: Sorting order: asc, desc. default=desc
## - sortby: Sorting criteria: name,download,like,date,updatedTime. default=date
## - subtype: Content subtype
## - tags: Content tag. max number of tags: -1 tags (-1 means unlimited).
## - type_param: Content type
## - user_id: AccelByte user ID
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


## Retrieves content entries by ID
## POST /ugc/v1/public/namespaces/{namespace}/contents/bulk
##
## Retrieves up to 100 content entries by content ID. Accessible without a token or with a valid user token.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_content_bulk(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v1/public/namespaces/{namespace}/contents/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists contents from followed creators
## GET /ugc/v1/public/namespaces/{namespace}/contents/followed
##
## Lists content from users the current user follows. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_followed_content(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Lists liked contents
## GET /ugc/v1/public/namespaces/{namespace}/contents/liked
##
## Lists UGC content liked by the current user. Supports advanced tag filtering with `&` (AND) and `|` (OR) operators and parentheses for priority; for example, `tags=red&(animal|wild)`. AND takes precedence over OR when parentheses are absent. Operands may be alphanumeric, underscore `_`, or dash `-`; operators are `&`, `|`, `(`, `)`. Tag values must be URL-encoded. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - isofficial: Filter content by official or community
## - limit: Number of results to return
## - name_param: Content name
## - offset: Number of results to skip for pagination
## - orderby: Sorting order: asc, desc. default=desc
## - sortby: Sorting criteria: name,download,like,date. default=date
## - subtype: Content subtype to filter by.
## - tags: Content tags to filter by.
## - type_param: Content type to filter by.
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


## Retrieves content entries by share code
## POST /ugc/v1/public/namespaces/{namespace}/contents/sharecodes/bulk
##
## Retrieves up to 100 content entries by share code. Requires a valid user token.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_content_bulk_by_share_codes(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves a content entry by its sharecode
## GET /ugc/v1/public/namespaces/{namespace}/contents/sharecodes/{shareCode}
##
## Public user can access without token or if token specified, requires valid user token
##
## Parameters:
## - namespace_param: Game namespace
## - share_code: Content sharecode
func public_download_content_by_share_code(
	namespace_param: String, share_code: String
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


## Retrieves a content entry by ID
## GET /ugc/v1/public/namespaces/{namespace}/contents/{contentId}
##
## Public user can access without token or if token specified, requires valid user token
##
## Parameters:
## - content_id: Unique identifier of the content to retrieve.
## - namespace_param: Game namespace
func public_download_content_by_content_id(
	content_id: String, namespace_param: String
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


## Adds a unique download count to a content entry
## POST /ugc/v1/public/namespaces/{namespace}/contents/{contentId}/downloadcount
##
## Records a unique download event for the specified content.
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
func add_download_count(content_id: String, namespace_param: String) -> Dictionary:
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


## Updates the like status for a content entry
## PUT /ugc/v1/public/namespaces/{namespace}/contents/{contentId}/like
##
## Updates the like or unlike state for the specified content.
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
func update_content_like_status(
	content_id: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves the preview for a content entry
## GET /ugc/v1/public/namespaces/{namespace}/contents/{contentId}/preview
##
## Retrieves the preview for a UGC content entry. Preview is a legacy feature; use Screenshots for a better content preview experience.
##
## Parameters:
## - content_id: Unique identifier of the content.
## - namespace_param: Game namespace
func public_download_content_preview(content_id: String, namespace_param: String) -> Dictionary:
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


## Lists available tags in a namespace
## GET /ugc/v1/public/namespaces/{namespace}/tags
##
## Get available tags paginated
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_tag(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Lists available content types in a namespace
## GET /ugc/v1/public/namespaces/{namespace}/types
##
## Get available types paginated
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_type(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Searches for creators in a namespace
## GET /ugc/v1/public/namespaces/{namespace}/users
##
## Searches for creators in the namespace. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - orderby: Sorting order: asc, desc. default=desc
## - sortby: Sorting criteria: followCount, totalLikedContent. default=object id
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


## Lists followed creators
## GET /ugc/v1/public/namespaces/{namespace}/users/followed
##
## Lists users followed by the current user. Use `limit` and `offset` to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_followed_users(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Retrieves stats for a creator including likes, followers, and following counts
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}
##
## Public user can access without token or if token specified, requires valid user token
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_creator(namespace_param: String, user_id: String) -> Dictionary:
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


## Lists channels for a user
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels
##
## Get user channel paginated
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - name_param: Likes filter by channel name
## - offset: Number of results to skip for pagination
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


## Creates a channel for a user
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels
##
## Create user channel
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_create_channel(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes all channels for a user
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels
##
## Delete all user channel
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_all_user_channel(namespace_param: String, user_id: String) -> Dictionary:
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


## Updates a user's channel
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}
##
## Update user channel
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_channel(
	channel_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a channel for a user
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}
##
## Delete user channel
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_channel(channel_id: String, namespace_param: String, user_id: String) -> Dictionary:
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


## Uploads UGC content to S3 for a user's channel
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3
##
## Uploads UGC content to S3 for a user's channel. All fields except `payload`, `preview`, `tags`, `contentType`, and `customAttributes` are mandatory. The `contentType` field sets the Content-Type header for the S3 pre-signed URL upload; if omitted, the service uses `fileExtension`.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func create_content_s3(
	channel_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Updates UGC content in S3 by sharecode
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
##
## Updates UGC content in S3 for a user's channel, identified by share code. All fields except `payload`, `preview`, `tags`, `contentType`, `updateContentFile`, `customAttributes`, and `shareCode` are mandatory. The `contentType` field sets the Content-Type header for the S3 pre-signed URL upload; if omitted, the service uses `fileExtension`. To update the content file, set `updateContentFile` to `true` and use the URL in `payloadURL.url` from the response.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - share_code: Share code identifying the content to update.
## - user_id: AccelByte user ID
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


## Updates UGC content in S3 for a user's channel
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/{contentId}
##
## Updates UGC content in S3 for a user's channel, identified by content ID. All fields except `payload`, `preview`, `tags`, `contentType`, `updateContentFile`, and `customAttributes` are mandatory. The `contentType` field sets the Content-Type header for the S3 pre-signed URL upload; if omitted, the service uses `fileExtension`. To update the content file, set `updateContentFile` to `true` and use the URL in `payloadURL.url` from the response.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Deletes a content entry by sharecode
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
##
## Deletes a content entry for a user, identified by share code.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - share_code: Share code identifying the content to delete.
## - user_id: AccelByte user ID
func public_delete_content_by_share_code(
	channel_id: String, namespace_param: String, share_code: String, user_id: String
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


## Deletes a content entry for a user
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
##
## Deletes a content entry for a user, identified by content ID.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_content(
	channel_id: String, content_id: String, namespace_param: String, user_id: String
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


## Updates the sharecode for a content entry
## PATCH /ugc/v1/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/sharecode
##
## Modifies the sharecode of a content entry. The shareCode must be at most 7 characters and may only contain: abcdefhkpqrstuxyz.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Lists content created by a user
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents
##
## Lists UGC contents created by a user. Supports offset-based pagination using the offset and limit parameters. Accessible without a token; authenticated requests require read permission.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func public_get_user_content(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Deletes all content entries for a user
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents
##
## Deletes all content entries for a user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_all_user_contents(namespace_param: String, user_id: String) -> Dictionary:
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


## Updates screenshots for a content entry
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
##
## Updates screenshots for a content entry. Screenshot descriptions must not exceed 1024 characters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_screenshots(
	content_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Uploads screenshots for a content entry
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
##
## Uploads screenshots for a content entry. All fields except `contentType` are mandatory. The `contentType` field sets the Content-Type header for the pre-signed URL upload; if omitted, the service uses `fileExtension`. Supported file extensions: `pjp`, `jpg`, `jpeg`, `jfif`, `bmp`, `png`. Screenshot descriptions must not exceed 1024 characters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func upload_content_screenshot(
	content_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a screenshot from a content entry
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots/{screenshotId}
##
## Delete existing screenshot from a content
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - screenshot_id: Unique identifier for the screenshot.
## - user_id: AccelByte user ID
func delete_content_screenshot(
	content_id: String, namespace_param: String, screenshot_id: String, user_id: String
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


## Updates the follow status for a user
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/follow
##
## Requires valid user token
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_user_follow_status(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists followers of a user
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/followers
##
## Lists users who follow the specified creator. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_public_followers(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Lists users followed by a user
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/following
##
## Lists users that the specified user follows. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_public_following(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Lists all groups for a user
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups
##
## Get user groups paginated
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_groups(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Creates a content group for a user
## POST /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups
##
## Create group
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func create_group(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
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


## Deletes all groups for a user
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups
##
## Delete all user group
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_all_user_group(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves a content group for a user
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}
##
## Get user groups by group ID
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_group(group_id: String, namespace_param: String, user_id: String) -> Dictionary:
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


## Updates a content group for a user
## PUT /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}
##
## Replace group name and contents with new ones
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_group(
	group_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a content group for a user
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}
##
## Delete user group by group ID
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_group(group_id: String, namespace_param: String, user_id: String) -> Dictionary:
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


## Lists content in a group (legacy)
## GET /ugc/v1/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
##
## Lists content entries belonging to a group. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_group_content(
	group_id: String, namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Removes all activity state for a user, including likes, downloads, followers, and follows
## DELETE /ugc/v1/public/namespaces/{namespace}/users/{userId}/states
##
## Required permission NAMESPACE:{namespace}:USER:{userId}" [DELETE]
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_all_user_states(namespace_param: String, user_id: String) -> Dictionary:
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


## Lists official content in a channel
## GET /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents
##
## Lists official content entries in a channel. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Content name
## - offset: Number of results to skip for pagination
## - sort_by: Available values: - *createdTime* - *createdTime:desc* - *createdTime:asc* - *updatedTime* - *updatedTime:desc* - *updatedTime:asc*
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


## Creates official content in a channel
## POST /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents
##
## Create official content
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
func admin_create_content_v2(
	channel_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes an official content entry
## DELETE /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}
##
## Delete existing official content
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func admin_delete_official_content_v2(
	channel_id: String, content_id: String, namespace_param: String
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


## Updates an official content entry
## PATCH /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}
##
## Update existing official content
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func admin_update_official_content_v2(
	channel_id: String, content_id: String, namespace_param: String, body: Dictionary = {}
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


## Copies a content entry to another channel
## POST /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/copy
##
## Copy existing content from source channel to target channel.
##
## Parameters:
## - channel_id: Source channel id
## - content_id: Source content id
## - namespace_param: Game namespace
func admin_copy_content(
	channel_id: String, content_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates the file location for an official content entry
## PATCH /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/fileLocation
##
## Commits the file location for an official content entry after uploading via the generated upload URL.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func admin_update_official_content_file_location(
	channel_id: String, content_id: String, namespace_param: String, body: Dictionary = {}
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


## Generates an upload URL for an official content entry
## PATCH /ugc/v2/admin/namespaces/{namespace}/channels/{channelId}/contents/{contentId}/uploadUrl
##
## Generate official content upload URL
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func admin_generate_official_content_upload_urlv2(
	channel_id: String, content_id: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves configuration settings paginated
## GET /ugc/v2/admin/namespaces/{namespace}/configs
##
## Get config paginated
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_configs(namespace_param: String, limit: int = -1, offset: int = -1) -> Dictionary:
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


## Updates a configuration value
## PATCH /ugc/v2/admin/namespaces/{namespace}/configs/{key}
##
## Updates a configuration value, creating the key if it does not exist. Allowed keys: contentReview (values: enabled, disabled).
##
## Parameters:
## - key: Configuration key to update.
## - namespace_param: Game namespace
func admin_update_config(key: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
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


## Lists official content in the namespace
## GET /ugc/v2/admin/namespaces/{namespace}/contents
##
## Lists all official content across the namespace. Supports offset-based pagination using offset and limit. For advanced tag filtering, use & for AND, | for OR, and ( ) for grouping. Operator precedence: AND > OR. Allowed operand characters: alphanumeric, underscore, and dash. Tag values must be URL-encoded.
##
## Parameters:
## - namespace_param: Game namespace
## - is_official: Filter by is official
## - limit: Number of results to return
## - name_param: Filter by content name
## - offset: Number of results to skip for pagination
## - sort_by: Sort order of query result available value: - *createdTime* - *createdTime:desc* - *createdTime:asc* - *download* - *download:desc* - *download:asc* - *name* - *name:desc* - *name:asc* - *updatedTime* - *updatedTime:desc* - *updatedTime:asc*
## - sub_type: Filter by content subType
## - tags: Content tag
## - type_param: Filter by content type
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


## Retrieves content entries by ID
## POST /ugc/v2/admin/namespaces/{namespace}/contents/bulk
##
## Retrieves up to 100 content entries per request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_bulk_get_content_by_i_ds_v2(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves content entries by share code
## POST /ugc/v2/admin/namespaces/{namespace}/contents/sharecodes/bulk
##
## Retrieves up to 100 content entries per request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_content_bulk_by_share_codes_v2(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves content by sharecode
## GET /ugc/v2/admin/namespaces/{namespace}/contents/sharecodes/{shareCode}
##
## Get content by share code
##
## Parameters:
## - namespace_param: Game namespace
## - share_code: Content sharecode
func admin_get_content_by_share_code_v2(namespace_param: String, share_code: String) -> Dictionary:
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


## Retrieves a content entry by ID
## GET /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}
##
## Get content by content ID
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func admin_get_content_by_content_idv2(content_id: String, namespace_param: String) -> Dictionary:
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


## Restores a content entry to a specific file version
## PUT /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/rollback/{versionId}
##
## Restores a content entry to a specified file version.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - version_id: Unique identifier for the file version to restore.
func rollback_content_version_v2(
	content_id: String, namespace_param: String, version_id: String
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


## Updates screenshots for an official content entry
## PUT /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots
##
## Updates screenshots for an official content entry. Screenshot descriptions must not exceed 1024 characters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func admin_update_screenshots_v2(
	content_id: String, namespace_param: String, body: Dictionary = {}
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


## Uploads screenshots for an official content entry
## POST /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots
##
## Uploads screenshots for an official content entry. The `contentType` field sets the Content-Type header for upload; if omitted, the service uses `fileExtension`. Supported file extensions: `pjp`, `jpg`, `jpeg`, `jfif`, `bmp`, `png`. Screenshot descriptions must not exceed 1024 characters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func admin_upload_content_screenshot_v2(
	content_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a screenshot from a content entry
## DELETE /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/screenshots/{screenshotId}
##
## Delete screenshot from a content
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - screenshot_id: Unique identifier for the screenshot.
func admin_delete_content_screenshot_v2(
	content_id: String, namespace_param: String, screenshot_id: String
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


## Lists file versions for a content entry
## GET /ugc/v2/admin/namespaces/{namespace}/contents/{contentId}/versions
##
## Lists file versions for a content entry. The service creates a version each time a user uploads content with `updateContentFile` set to `true`. Returns up to the 10 most recent versions.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func list_content_versions_v2(content_id: String, namespace_param: String) -> Dictionary:
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


## Lists content in a group
## GET /ugc/v2/admin/namespaces/{namespace}/groups/{groupId}/contents
##
## Lists content entries belonging to a group. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_official_group_contents_v2(
	group_id: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists staging content pending approval
## GET /ugc/v2/admin/namespaces/{namespace}/staging-contents
##
## Lists staging content that requires admin approval. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort query result available value: - createdTime - createdTime:desc - createdTime:asc - updatedTime - updatedTime:desc - updatedTime:asc
## - status: Filter by content status [*PENDING*, *REJECTED*]
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


## Retrieves a staging content entry by ID
## GET /ugc/v2/admin/namespaces/{namespace}/staging-contents/{contentId}
##
## Get staging content by ID
##
## Parameters:
## - content_id: Unique identifier for the staging content.
## - namespace_param: Game namespace
func admin_get_staging_content_by_id(content_id: String, namespace_param: String) -> Dictionary:
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


## Approves or rejects a staging content entry
## POST /ugc/v2/admin/namespaces/{namespace}/staging-contents/{contentId}/approve
##
## Approves or rejects a staging content entry. Approved content is visible to all players; rejected content remains in the staging area.
##
## Parameters:
## - content_id: Unique identifier for the staging content.
## - namespace_param: Game namespace
func admin_approve_staging_content(
	content_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates official content in S3 by sharecode
## PUT /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
##
## *shareCode* format should follows:
##
## "Max length: 7
## "Available characters: abcdefhkpqrstuxyz
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - share_code: Share code identifying the content to update.
## - user_id: AccelByte user ID
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


## Deletes an official content entry by sharecode
## DELETE /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
##
## Delete content by share code
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - share_code: Share code identifying the content to delete.
## - user_id: AccelByte user ID
func admin_delete_content_by_share_code_v2(
	channel_id: String, namespace_param: String, share_code: String, user_id: String
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


## Deletes a user content entry
## DELETE /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
##
## Delete user content by content ID
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_delete_user_content_v2(
	channel_id: String, content_id: String, namespace_param: String, user_id: String
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


## Updates a user content entry
## PATCH /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
##
## Update existing user content
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Updates the file location for a user content entry
## PATCH /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/fileLocation
##
## Commits the file location for a user content entry after uploading via the generated upload URL.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Generates an upload URL for a user content entry
## PATCH /ugc/v2/admin/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/uploadUrl
##
## Generate user content upload URL
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Lists content created by a user
## GET /ugc/v2/admin/namespaces/{namespace}/users/{userId}/contents
##
## Lists content entries created by a user. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Available values: - *createdTime* - *createdTime:desc* - *createdTime:asc*
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


## Sets the visibility of a user content entry
## PUT /ugc/v2/admin/namespaces/{namespace}/users/{userId}/contents/{contentId}/hide
##
## Hide/Unhide user's generated contents
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_content_hide_status_v2(
	content_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists content in a group for a user
## GET /ugc/v2/admin/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
##
## Lists content entries belonging to a group. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_user_group_contents_v2(
	group_id: String, namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Lists staging content for a user pending approval
## GET /ugc/v2/admin/namespaces/{namespace}/users/{userId}/staging-contents
##
## Lists a user's staging content that requires admin approval. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort query result available value: - createdTime - createdTime:desc - createdTime:asc - updatedTime - updatedTime:desc - updatedTime:asc
## - status: Filter by content status [*PENDING*, *REJECTED*]
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


## Lists content in a channel
## GET /ugc/v2/public/namespaces/{namespace}/channels/{channelId}/contents
##
## Lists content entries in a channel. Supports offset-based pagination using the offset and limit parameters. Accessible without a token; authenticated requests require a valid user token.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Content name
## - offset: Number of results to skip for pagination
## - sort_by: Available values: - *createdTime* - *createdTime:desc* - *createdTime:asc* - *updatedTime* - *updatedTime:desc* - *updatedTime:asc*
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


## Lists public content in the namespace
## GET /ugc/v2/public/namespaces/{namespace}/contents
##
## Lists public content across the namespace. Supports offset-based pagination using offset and limit. For advanced tag filtering, use & for AND, | for OR, and ( ) for grouping. Operator precedence: AND > OR. Allowed operand characters: alphanumeric, underscore, and dash. Tag values must be URL-encoded.
##
## Parameters:
## - namespace_param: Game namespace
## - is_official: Filter by is official
## - limit: Number of results to return
## - name_param: Filter by content name
## - offset: Number of results to skip for pagination
## - sort_by: Sort order of query result available value: - *createdTime* - *createdTime:desc* - *createdTime:asc* - *download* - *download:desc* - *download:asc* - *name* - *name:desc* - *name:asc* - *updatedTime* - *updatedTime:desc* - *updatedTime:asc*
## - sub_type: Filter by content subType
## - tags: Content tag. max number of tags: -1 tags (-1 means unlimited).
## - type_param: Filter by content type
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


## Retrieves content entries by ID
## POST /ugc/v2/public/namespaces/{namespace}/contents/bulk
##
## Retrieves up to 100 content entries per request. Accessible without authentication; authenticated requests require a valid user token.
##
## Parameters:
## - namespace_param: Game namespace
func public_bulk_get_content_by_idv2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ugc/v2/public/namespaces/{namespace}/contents/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves content entries by share code
## POST /ugc/v2/public/namespaces/{namespace}/contents/sharecodes/bulk
##
## Retrieves up to 100 content entries by sharecode per request. Requires a valid user token.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_content_bulk_by_share_codes_v2(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves content by sharecode
## GET /ugc/v2/public/namespaces/{namespace}/contents/sharecodes/{shareCode}
##
## Public user can access without token or if token specified, requires valid user token
##
## Parameters:
## - namespace_param: Game namespace
## - share_code: Content sharecode
func public_get_content_by_share_code_v2(namespace_param: String, share_code: String) -> Dictionary:
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


## Retrieves a content entry by ID
## GET /ugc/v2/public/namespaces/{namespace}/contents/{contentId}
##
## Public user can access without token or if token specified, requires valid user token
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func public_get_content_by_idv2(content_id: String, namespace_param: String) -> Dictionary:
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


## Adds a download count to a content entry
## POST /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/downloadcount
##
## Increments the download count for a content entry.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func public_add_download_count_v2(content_id: String, namespace_param: String) -> Dictionary:
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


## Lists users who downloaded a content entry
## GET /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/downloader
##
## Lists users who have downloaded the content using the v2 operation. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort the result.  available value: - *createdTime* - *createdTime:desc* - *createdTime:asc*
## - user_id: AccelByte user ID
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


## Lists users who have liked a content entry
## GET /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/like
##
## Lists users who have liked the content using the v2 operation. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order of query result available value: - *createdTime* - *createdTime:desc* - *createdTime:asc*
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


## Updates the like status for a content entry
## PUT /ugc/v2/public/namespaces/{namespace}/contents/{contentId}/like
##
## Updates the like status for a content entry. Set to true to like or false to unlike.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
func update_content_like_status_v2(
	content_id: String, namespace_param: String, body: Dictionary = {}
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


## Creates content in a user's channel
## POST /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents
##
## Create a new content
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_create_content_v2(
	channel_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Updates UGC content in S3 by sharecode
## PUT /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/s3/sharecodes/{shareCode}
##
## Update content by share code
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - share_code: Share code identifying the content to update.
## - user_id: AccelByte user ID
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


## Deletes content by sharecode
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/sharecodes/{shareCode}
##
## Delete existing content by share code
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - namespace_param: Game namespace
## - share_code: Share code identifying the content to delete.
## - user_id: AccelByte user ID
func public_delete_content_by_share_code_v2(
	channel_id: String, namespace_param: String, share_code: String, user_id: String
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


## Deletes a content entry
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
##
## Delete existing content
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_delete_content_v2(
	channel_id: String, content_id: String, namespace_param: String, user_id: String
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


## Updates a content entry
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}
##
## Update existing content
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Updates the file location for a content entry
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/fileLocation
##
## Commits the content file upload after generating an upload URL, updating the file location for the content entry.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Updates the sharecode for a content entry
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/sharecode
##
## Modifies the share code for a content entry. The operation requires explicit permission and defaults to disabled. The share code must be at most 7 characters, using only: abcdefhkpqrstuxyz.
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Generates an upload URL for a content entry
## PATCH /ugc/v2/public/namespaces/{namespace}/users/{userId}/channels/{channelId}/contents/{contentId}/uploadUrl
##
## Generate content upload URL
##
## Parameters:
## - channel_id: Unique identifier for the channel.
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
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


## Lists content created by a user
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents
##
## Lists content created by a user. Accessible without authentication; authenticated requests require a valid user token. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Available values: - *createdTime* - *createdTime:desc* - *createdTime:asc*
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


## Updates screenshots for a content entry
## PUT /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
##
## Updates the screenshot metadata for a content entry. The description field accepts up to 1024 characters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_screenshots_v2(
	content_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Creates screenshot upload URLs for a content entry
## POST /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots
##
## Creates upload URLs for screenshots of a content entry. Omit *contentType* to let *fileExtension* determine the format. Supported extensions: pjp, jpg, jpeg, jfif, bmp, png. The description field accepts up to 1024 characters.
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func upload_content_screenshot_v2(
	content_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a screenshot from a content entry
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/contents/{contentId}/screenshots/{screenshotId}
##
## Delete screenshot from a content
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - screenshot_id: Unique identifier for the screenshot.
## - user_id: AccelByte user ID
func delete_content_screenshot_v2(
	content_id: String, namespace_param: String, screenshot_id: String, user_id: String
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


## Lists content entries belonging to a group
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/groups/{groupId}/contents
##
## Lists content entries belonging to a group. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - group_id: Unique identifier for the group.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func public_get_group_contents_v2(
	group_id: String, namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Lists staging content for a user
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents
##
## Lists staging content for a user. Supports offset-based pagination using the offset and limit parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort query result available value: - createdTime - createdTime:desc - createdTime:asc - updatedTime - updatedTime:desc - updatedTime:asc
## - status: Filter by content status [*PENDING*, *REJECTED*]
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


## Retrieves a staging content entry by ID
## GET /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}
##
## Get user staging content by ID
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_staging_content_by_id(
	content_id: String, namespace_param: String, user_id: String
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


## Updates a staging content entry
## PUT /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}
##
## Update staging content
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_staging_content(
	content_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Deletes a user staging content entry by ID
## DELETE /ugc/v2/public/namespaces/{namespace}/users/{userId}/staging-contents/{contentId}
##
## Delete user staging content by ID
##
## Parameters:
## - content_id: Unique identifier for the content.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func delete_user_staging_content_by_id(
	content_id: String, namespace_param: String, user_id: String
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
