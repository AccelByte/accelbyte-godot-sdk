## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## platform_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-platform-service
## Version: 6.11.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(PlatformService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name PlatformService
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

## List all fulfillment scripts
## GET /platform/admin/fulfillment/scripts
func list_fulfillment_scripts() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get fulfillment script by id
## GET /platform/admin/fulfillment/scripts/{id}
func get_fulfillment_script(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create fulfillment script
## POST /platform/admin/fulfillment/scripts/{id}
func create_fulfillment_script(
	id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete fulfillment script
## DELETE /platform/admin/fulfillment/scripts/{id}
func delete_fulfillment_script(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update fulfillment script
## PATCH /platform/admin/fulfillment/scripts/{id}
func update_fulfillment_script(
	id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get all item type configs
## GET /platform/admin/items/configs
func list_item_type_configs() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create an Item Type Config
## POST /platform/admin/items/configs
func create_item_type_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get an item type config
## GET /platform/admin/items/configs/search
func search_item_type_config(
	item_type: String,
	clazz: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs/search"
	# Build query parameters
	var query_params: Dictionary = {}
	if not clazz.is_empty():
		query_params["clazz"] = clazz
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get an item type config
## GET /platform/admin/items/configs/{id}
func get_item_type_config(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update an Item Type Config
## PUT /platform/admin/items/configs/{id}
func update_item_type_config(
	id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete an item type config
## DELETE /platform/admin/items/configs/{id}
func delete_item_type_config(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Query campaigns
## GET /platform/admin/namespaces/{namespace}/campaigns
func query_campaigns(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns"
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
	if not tag.is_empty():
		query_params["tag"] = tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create campaign
## POST /platform/admin/namespaces/{namespace}/campaigns
func create_campaign(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get campaign
## GET /platform/admin/namespaces/{namespace}/campaigns/{campaignId}
func get_campaign(
	campaign_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns/{campaignId}"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update campaign
## PUT /platform/admin/namespaces/{namespace}/campaigns/{campaignId}
func update_campaign(
	campaign_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns/{campaignId}"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Rename batch
## PUT /platform/admin/namespaces/{namespace}/campaigns/{campaignId}/batchName
func rename_batch(
	campaign_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns/{campaignId}/batchName"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query campaign batch names
## GET /platform/admin/namespaces/{namespace}/campaigns/{campaignId}/batchNames
func query_campaign_batch_names(
	campaign_id: String,
	namespace_param: String,
	batch_name: String = "",
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns/{campaignId}/batchNames"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not batch_name.is_empty():
		query_params["batchName"] = batch_name
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get campaign dynamic
## GET /platform/admin/namespaces/{namespace}/campaigns/{campaignId}/dynamic
func get_campaign_dynamic(
	campaign_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns/{campaignId}/dynamic"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get catalog config
## GET /platform/admin/namespaces/{namespace}/catalog/configs
func get_catalog_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/configs"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update catalog config
## PUT /platform/admin/namespaces/{namespace}/catalog/configs
func update_catalog_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/configs"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get lootbox plugin config
## GET /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox
func get_loot_box_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update lootbox plugin config
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox
func update_loot_box_plugin_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete lootbox plugin config
## DELETE /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox
func delete_loot_box_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload lootbox plugin custom config tls cert
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox/customConfig/cert
func uplod_loot_box_plugin_config_cert(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox/customConfig/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get lootbox plugin gRPC info
## GET /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox/grpcInfo
func get_loot_box_grpc_info(
	namespace_param: String,
	force: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox/grpcInfo"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["force"] = force
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get section plugin config
## GET /platform/admin/namespaces/{namespace}/catalog/plugins/section
func get_section_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update section plugin config
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/section
func update_section_plugin_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete section plugin config
## DELETE /platform/admin/namespaces/{namespace}/catalog/plugins/section
func delete_section_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload section plugin custom config tls cert
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/section/customConfig/cert
func upload_section_plugin_config_cert(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section/customConfig/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get root categories
## GET /platform/admin/namespaces/{namespace}/categories
func get_root_categories(
	namespace_param: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create category
## POST /platform/admin/namespaces/{namespace}/categories
func create_category(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List categories' basic info
## GET /platform/admin/namespaces/{namespace}/categories/basic
func list_categories_basic(
	namespace_param: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories/basic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get category
## GET /platform/admin/namespaces/{namespace}/categories/{categoryPath}
func get_category(
	category_path: String,
	namespace_param: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories/{categoryPath}"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update category
## PUT /platform/admin/namespaces/{namespace}/categories/{categoryPath}
func update_category(
	category_path: String,
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories/{categoryPath}"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete category
## DELETE /platform/admin/namespaces/{namespace}/categories/{categoryPath}
func delete_category(
	category_path: String,
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories/{categoryPath}"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get child categories
## GET /platform/admin/namespaces/{namespace}/categories/{categoryPath}/children
func get_child_categories(
	category_path: String,
	namespace_param: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories/{categoryPath}/children"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get descendant categories
## GET /platform/admin/namespaces/{namespace}/categories/{categoryPath}/descendants
func get_descendant_categories(
	category_path: String,
	namespace_param: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/categories/{categoryPath}/descendants"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query codes
## GET /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}
func query_codes(
	campaign_id: String,
	namespace_param: String,
	active_only: bool = false,
	batch_name: String = "",
	batch_no: Array = [],
	code: String = "",
	limit: int = -1,
	offset: int = -1,
	with_batch_name: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not batch_name.is_empty():
		query_params["batchName"] = batch_name
	if batch_no.size() > 0:
		query_params["batchNo"] = batch_no
	if not code.is_empty():
		query_params["code"] = code
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	query_params["withBatchName"] = with_batch_name
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create campaign codes
## POST /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}
func create_codes(
	campaign_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Download codes
## GET /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/codes.csv
func download(
	campaign_id: String,
	namespace_param: String,
	batch_name: String = "",
	batch_no: Array = [],
	with_batch_name: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/codes.csv"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not batch_name.is_empty():
		query_params["batchName"] = batch_name
	if batch_no.size() > 0:
		query_params["batchNo"] = batch_no
	query_params["withBatchName"] = with_batch_name
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk disable codes
## PUT /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/disable/bulk
func bulk_disable_codes(
	campaign_id: String,
	namespace_param: String,
	batch_name: String = "",
	batch_no: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/disable/bulk"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not batch_name.is_empty():
		query_params["batchName"] = batch_name
	if batch_no.size() > 0:
		query_params["batchNo"] = batch_no
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Bulk enable codes
## PUT /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/enable/bulk
func bulk_enable_codes(
	campaign_id: String,
	namespace_param: String,
	batch_name: String = "",
	batch_no: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/enable/bulk"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not batch_name.is_empty():
		query_params["batchName"] = batch_name
	if batch_no.size() > 0:
		query_params["batchNo"] = batch_no
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query redeem history
## GET /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/history
func query_redeem_history(
	campaign_id: String,
	namespace_param: String,
	code: String = "",
	limit: int = -1,
	offset: int = -1,
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/history"
	url_path = url_path.replace("{" + "campaignId" + "}", campaign_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not code.is_empty():
		query_params["code"] = code
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get code info
## GET /platform/admin/namespaces/{namespace}/codes/{code}
func get_code(
	code: String,
	namespace_param: String,
	redeemable: bool = false,
	with_batch_name: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/{code}"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["redeemable"] = redeemable
	query_params["withBatchName"] = with_batch_name
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Disable code
## PUT /platform/admin/namespaces/{namespace}/codes/{code}/disable
func disable_code(
	code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/{code}/disable"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Enable code
## PUT /platform/admin/namespaces/{namespace}/codes/{code}/enable
func enable_code(
	code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/codes/{code}/enable"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get service plugin config
## GET /platform/admin/namespaces/{namespace}/configs/servicePlugin
## @deprecated
func get_service_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/configs/servicePlugin"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update service plugin config service
## PUT /platform/admin/namespaces/{namespace}/configs/servicePlugin
## @deprecated
func update_service_plugin_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/configs/servicePlugin"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete service plugin config
## DELETE /platform/admin/namespaces/{namespace}/configs/servicePlugin
## @deprecated
func delete_service_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/configs/servicePlugin"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List currencies
## GET /platform/admin/namespaces/{namespace}/currencies
func list_currencies(
	namespace_param: String,
	currency_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/currencies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not currency_type.is_empty():
		query_params["currencyType"] = currency_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a currency
## POST /platform/admin/namespaces/{namespace}/currencies
func create_currency(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/currencies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update a currency
## PUT /platform/admin/namespaces/{namespace}/currencies/{currencyCode}
func update_currency(
	currency_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/currencies/{currencyCode}"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a currency
## DELETE /platform/admin/namespaces/{namespace}/currencies/{currencyCode}
func delete_currency(
	currency_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/currencies/{currencyCode}"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get currency config
## GET /platform/admin/namespaces/{namespace}/currencies/{currencyCode}/config
func get_currency_config(
	currency_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/currencies/{currencyCode}/config"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get currency summary
## GET /platform/admin/namespaces/{namespace}/currencies/{currencyCode}/summary
func get_currency_summary(
	currency_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/currencies/{currencyCode}/summary"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get DLC item config history
## GET /platform/admin/namespaces/{namespace}/dlc/config/history
func get_dlc_item_config_history(
	namespace_param: String,
	dlc_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not dlc_id.is_empty():
		query_params["dlcId"] = dlc_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Restore DLC item config history
## POST /platform/admin/namespaces/{namespace}/dlc/config/history/{id}/restore
func restore_dlc_item_config_history(
	id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/history/{id}/restore"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get DLC item config
## GET /platform/admin/namespaces/{namespace}/dlc/config/item
func get_dlc_item_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update DLC item config
## PUT /platform/admin/namespaces/{namespace}/dlc/config/item
func update_dlc_item_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete a DLC item config
## DELETE /platform/admin/namespaces/{namespace}/dlc/config/item
func delete_dlc_item_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Platform DLC config
## GET /platform/admin/namespaces/{namespace}/dlc/config/platformMap
func get_platform_dlc_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/platformMap"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Platform DLC config
## PUT /platform/admin/namespaces/{namespace}/dlc/config/platformMap
func update_platform_dlc_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/platformMap"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete a Platform DLC config
## DELETE /platform/admin/namespaces/{namespace}/dlc/config/platformMap
func delete_platform_dlc_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/platformMap"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Query entitlements
## GET /platform/admin/namespaces/{namespace}/entitlements
func query_entitlements(
	namespace_param: String,
	active_only: bool = false,
	app_type: String = "",
	entitlement_clazz: String = "",
	entitlement_name: String = "",
	item_id: Array = [],
	limit: int = -1,
	offset: int = -1,
	origin: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not app_type.is_empty():
		query_params["appType"] = app_type
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not entitlement_name.is_empty():
		query_params["entitlementName"] = entitlement_name
	if item_id.size() > 0:
		query_params["itemId"] = item_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not origin.is_empty():
		query_params["origin"] = origin
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query entitlements by Item Ids
## GET /platform/admin/namespaces/{namespace}/entitlements/byItemIds
func query_entitlements_by_item_ids(
	namespace_param: String,
	active_only: bool = false,
	item_ids: Array = [],
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/byItemIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if item_ids.size() > 0:
		query_params["itemIds"] = item_ids
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

## Enable entitlement origin feature
## PUT /platform/admin/namespaces/{namespace}/entitlements/config/entitlementOrigin/enable
func enable_entitlement_origin_feature(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/config/entitlementOrigin/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get entitlement config info
## GET /platform/admin/namespaces/{namespace}/entitlements/config/info
func get_entitlement_config_info(
	namespace_param: String,
	without_cache: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/config/info"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["withoutCache"] = without_cache
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Grant entitlements to different users
## POST /platform/admin/namespaces/{namespace}/entitlements/grant
func grant_entitlements(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/grant"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Revoke entitlements by Ids
## POST /platform/admin/namespaces/{namespace}/entitlements/revoke
func revoke_entitlements(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/revoke"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get entitlement
## GET /platform/admin/namespaces/{namespace}/entitlements/{entitlementId}
func get_entitlement(
	entitlement_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/{entitlementId}"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query fulfillment histories
## GET /platform/admin/namespaces/{namespace}/fulfillment/history
func query_fulfillment_histories(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	status: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/fulfillment/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not status.is_empty():
		query_params["status"] = status
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query clawback history
## GET /platform/admin/namespaces/{namespace}/iap/clawback/histories
func query_iap_clawback_history(
	namespace_param: String,
	end_time: String = "",
	event_type: String = "",
	external_order_id: String = "",
	limit: int = -1,
	offset: int = -1,
	start_time: String = "",
	status: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/clawback/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if not event_type.is_empty():
		query_params["eventType"] = event_type
	if not external_order_id.is_empty():
		query_params["externalOrderId"] = external_order_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not status.is_empty():
		query_params["status"] = status
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Mock Sync PlayStation Clawback event.
## POST /platform/admin/namespaces/{namespace}/iap/clawback/playstation/mock
func mock_play_station_stream_event(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/clawback/playstation/mock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Mock Sync XBox Clawback event.
## POST /platform/admin/namespaces/{namespace}/iap/clawback/xbl/mock
func mock_xbl_clawback_event(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/clawback/xbl/mock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get apple iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/apple
func get_apple_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update apple iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/apple
func update_apple_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete apple iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/apple
func delete_apple_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload Apple Store p8 file
## PUT /platform/admin/namespaces/{namespace}/iap/config/apple/cert
func update_apple_p8_file(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get epicgames iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/epicgames
func get_epic_games_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/epicgames"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update epic games iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/epicgames
func update_epic_games_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/epicgames"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete epic games iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/epicgames
func delete_epic_games_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/epicgames"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get google iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/google
func get_google_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update google iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/google
func update_google_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete google iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/google
func delete_google_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload google play p12 file
## PUT /platform/admin/namespaces/{namespace}/iap/config/google/cert
func update_google_p12_file(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get iap item config
## GET /platform/admin/namespaces/{namespace}/iap/config/item
func get_iap_item_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update iap item config
## PUT /platform/admin/namespaces/{namespace}/iap/config/item
func update_iap_item_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## delete a iap item config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/item
func delete_iap_item_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get oculus iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/oculus
func get_oculus_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update oculus iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/oculus
func update_oculus_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete oculus iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/oculus
func delete_oculus_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List All of AGS Meta Quest(Oculus) subscriptions group
## GET /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group
func list_oculus_subscription_groups(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create AGS Meta Quest(Oculus) subscriptions group
## POST /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group
func create_oculus_subscription_group(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete an AGS Meta Quest(Oculus) subscriptions group
## DELETE /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group/{sku}
func delete_oculus_subscription_group(
	namespace_param: String,
	sku: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group/{sku}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sku" + "}", sku.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List All Tier of AGS Meta Quest(Oculus) subscriptions group
## GET /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group/{sku}/tiers
func list_oculus_subscription_group_tier(
	namespace_param: String,
	sku: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group/{sku}/tiers"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sku" + "}", sku.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create Meta quest(Oculus) subscriptions tier
## POST /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/tier
func add_tier_into_meta_quest_subscription_group(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/tier"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete an AGS Meta Quest(Oculus) subscriptions tier
## DELETE /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/tier/{sku}
func delete_oculus_subscription_tier(
	namespace_param: String,
	sku: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/tier/{sku}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sku" + "}", sku.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get playstation iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/playstation
func get_play_station_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update playstation iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/playstation
func update_playstation_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete playstation iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/playstation
func delete_playstation_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Validate existed playstation iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/playstation/validate
func validate_existed_playstation_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Validate playstation iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/playstation/validate
func validate_playstation_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get steam iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/steam
func get_steam_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update steam iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/steam
func update_steam_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete steam iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/steam
func delete_steam_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get twitch iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/twitch
func get_twitch_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/twitch"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update twitch iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/twitch
func update_twitch_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/twitch"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete twitch iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/twitch
func delete_twitch_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/twitch"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get xbox iap config
## GET /platform/admin/namespaces/{namespace}/iap/config/xbl
func get_xbl_iap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update xbl iap config
## PUT /platform/admin/namespaces/{namespace}/iap/config/xbl
func update_xbl_iap_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete xbl iap config
## DELETE /platform/admin/namespaces/{namespace}/iap/config/xbl
func delete_xbl_ap_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload xbl business partner cert file
## PUT /platform/admin/namespaces/{namespace}/iap/config/xbl/cert
func update_xbl_bp_cert_file(
	namespace_param: String,
	file: String = "",
	password: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/xbl/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query third party notifications
## GET /platform/admin/namespaces/{namespace}/iap/notifications
func query_third_party_notifications(
	namespace_param: String,
	end_date: String = "",
	external_id: String = "",
	limit: int = -1,
	offset: int = -1,
	source: String = "",
	start_date: String = "",
	status: String = "",
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/notifications"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not external_id.is_empty():
		query_params["externalId"] = external_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not source.is_empty():
		query_params["source"] = source
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not status.is_empty():
		query_params["status"] = status
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query steam abnormal transactions
## GET /platform/admin/namespaces/{namespace}/iap/steam/abnormal_transactions
func query_abnormal_transactions(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	order_id: String = "",
	steam_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/steam/abnormal_transactions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order_id.is_empty():
		query_params["orderId"] = order_id
	if not steam_id.is_empty():
		query_params["steamId"] = steam_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query steam report job info
## GET /platform/admin/namespaces/{namespace}/iap/steam/job
func admin_get_steam_job_info(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/steam/job"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Reset steam report job with a special time
## PUT /platform/admin/namespaces/{namespace}/iap/steam/job/reset
func admin_reset_steam_job_time(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/steam/job/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Refund IAP Order
## PUT /platform/admin/namespaces/{namespace}/iap/steam/orders/{iapOrderNo}/refund
func admin_refund_iap_order(
	iap_order_no: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/steam/orders/{iapOrderNo}/refund"
	url_path = url_path.replace("{" + "iapOrderNo" + "}", iap_order_no.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get IAP steam report process histories, default sort by created at
## GET /platform/admin/namespaces/{namespace}/iap/steam/report/histories
func query_steam_report_histories(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	order_id: String = "",
	process_status: String = "",
	steam_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/steam/report/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order_id.is_empty():
		query_params["orderId"] = order_id
	if not process_status.is_empty():
		query_params["processStatus"] = process_status
	if not steam_id.is_empty():
		query_params["steamId"] = steam_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query subscriptions.
## GET /platform/admin/namespaces/{namespace}/iap/subscriptions
func query_third_party_subscription(
	namespace_param: String,
	active_only: bool = false,
	group_id: String = "",
	limit: int = -1,
	offset: int = -1,
	platform: String = "",
	product_id: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/subscriptions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not group_id.is_empty():
		query_params["groupId"] = group_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not platform.is_empty():
		query_params["platform"] = platform
	if not product_id.is_empty():
		query_params["productId"] = product_id
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get IAP Order Consume Details by IAP Order Number.
## GET /platform/admin/namespaces/{namespace}/iap/{iapOrderNo}/consumedetails
func get_iap_order_consume_details(
	iap_order_no: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/{iapOrderNo}/consumedetails"
	url_path = url_path.replace("{" + "iapOrderNo" + "}", iap_order_no.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Download invoice details
## GET /platform/admin/namespaces/{namespace}/invoice/details.csv
func download_invoice_details(
	namespace_param: String,
	end_time: String,
	feature: String,
	item_id: String,
	item_type: String,
	start_time: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/invoice/details.csv"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if not feature.is_empty():
		query_params["feature"] = feature
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Generate invoice summary
## GET /platform/admin/namespaces/{namespace}/invoice/summary
func generate_invoice_summary(
	namespace_param: String,
	end_time: String,
	feature: String,
	item_id: String,
	item_type: String,
	start_time: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/invoice/summary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if not feature.is_empty():
		query_params["feature"] = feature
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync an in game item
## PUT /platform/admin/namespaces/{namespace}/items
func sync_in_game_item(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create an Item
## POST /platform/admin/namespaces/{namespace}/items
func create_item(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get item by appId
## GET /platform/admin/namespaces/{namespace}/items/byAppId
func get_item_by_app_id(
	namespace_param: String,
	app_id: String,
	active_only: bool = false,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query items by criteria
## GET /platform/admin/namespaces/{namespace}/items/byCriteria
func query_items(
	namespace_param: String,
	active_only: bool = false,
	app_type: String = "",
	available_date: String = "",
	base_app_id: String = "",
	category_path: String = "",
	features: String = "",
	include_sub_category_item: bool = false,
	item_type: String = "",
	limit: int = -1,
	offset: int = -1,
	region: String = "",
	sort_by: Array = [],
	store_id: String = "",
	tags: String = "",
	target_namespace: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/byCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not app_type.is_empty():
		query_params["appType"] = app_type
	if not available_date.is_empty():
		query_params["availableDate"] = available_date
	if not base_app_id.is_empty():
		query_params["baseAppId"] = base_app_id
	if not category_path.is_empty():
		query_params["categoryPath"] = category_path
	if not features.is_empty():
		query_params["features"] = features
	query_params["includeSubCategoryItem"] = include_sub_category_item
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if sort_by.size() > 0:
		query_params["sortBy"] = sort_by
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not tags.is_empty():
		query_params["tags"] = tags
	if not target_namespace.is_empty():
		query_params["targetNamespace"] = target_namespace
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List basic items by features
## GET /platform/admin/namespaces/{namespace}/items/byFeatures/basic
func list_basic_items_by_features(
	namespace_param: String,
	active_only: bool = false,
	features: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/byFeatures/basic"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if features.size() > 0:
		query_params["features"] = features
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get items
## GET /platform/admin/namespaces/{namespace}/items/byIds
func get_items(
	namespace_param: String,
	item_ids: String,
	active_only: bool = false,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/byIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not item_ids.is_empty():
		query_params["itemIds"] = item_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get item by sku
## GET /platform/admin/namespaces/{namespace}/items/bySku
func get_item_by_sku(
	namespace_param: String,
	sku: String,
	active_only: bool = false,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get an item by sku in locale
## GET /platform/admin/namespaces/{namespace}/items/bySku/locale
func get_locale_item_by_sku(
	namespace_param: String,
	sku: String,
	active_only: bool = false,
	language: String = "",
	populate_bundle: bool = false,
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/bySku/locale"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not language.is_empty():
		query_params["language"] = language
	query_params["populateBundle"] = populate_bundle
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get estimated price
## GET /platform/admin/namespaces/{namespace}/items/estimatedPrice
func get_estimated_price(
	namespace_param: String,
	item_ids: String,
	user_id: String,
	platform: String = "",
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/estimatedPrice"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not platform.is_empty():
		query_params["platform"] = platform
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not item_ids.is_empty():
		query_params["itemIds"] = item_ids
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get itemId by sku
## GET /platform/admin/namespaces/{namespace}/items/itemId/bySku
func get_item_id_by_sku(
	namespace_param: String,
	sku: String,
	active_only: bool = false,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/itemId/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get multiple itemId by sku
## GET /platform/admin/namespaces/{namespace}/items/itemId/bySkus
func get_bulk_item_id_by_skus(
	namespace_param: String,
	sku: Array = [],
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/itemId/bySkus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if sku.size() > 0:
		query_params["sku"] = sku
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get locale items
## GET /platform/admin/namespaces/{namespace}/items/locale/byIds
func bulk_get_locale_items(
	namespace_param: String,
	item_ids: String,
	active_only: bool = false,
	language: String = "",
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/locale/byIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not language.is_empty():
		query_params["language"] = language
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not item_ids.is_empty():
		query_params["itemIds"] = item_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get available predicate types
## GET /platform/admin/namespaces/{namespace}/items/predicate/types
func get_available_predicate_types(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/predicate/types"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Validate user purchase condition
## POST /platform/admin/namespaces/{namespace}/items/purchase/conditions/validate
func validate_item_purchase_condition(
	namespace_param: String,
	user_id: String,
	platform: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/purchase/conditions/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not platform.is_empty():
		query_params["platform"] = platform
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update item's region data in bulk
## PUT /platform/admin/namespaces/{namespace}/items/regiondata
func bulk_update_region_data(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/regiondata"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Search items by keyword
## GET /platform/admin/namespaces/{namespace}/items/search
func search_items(
	namespace_param: String,
	keyword: String,
	language: String,
	active_only: bool = false,
	item_type: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if not language.is_empty():
		query_params["language"] = language
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query uncategorized items
## GET /platform/admin/namespaces/{namespace}/items/uncategorized
func query_uncategorized_items(
	namespace_param: String,
	active_only: bool = false,
	limit: int = -1,
	offset: int = -1,
	sort_by: Array = [],
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/uncategorized"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if sort_by.size() > 0:
		query_params["sortBy"] = sort_by
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get an item
## GET /platform/admin/namespaces/{namespace}/items/{itemId}
func get_item(
	item_id: String,
	namespace_param: String,
	active_only: bool = false,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update an item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}
func update_item(
	item_id: String,
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete an item
## DELETE /platform/admin/namespaces/{namespace}/items/{itemId}
func delete_item(
	item_id: String,
	namespace_param: String,
	features_to_check: Array = [],
	force: bool = false,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if features_to_check.size() > 0:
		query_params["featuresToCheck"] = features_to_check
	query_params["force"] = force
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Acquire item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/acquire
func acquire_item(
	item_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/acquire"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get an app info
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/app
func get_app(
	item_id: String,
	namespace_param: String,
	active_only: bool = false,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/app"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update an app
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/app
func update_app(
	item_id: String,
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/app"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Disable an item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/disable
func disable_item(
	item_id: String,
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/disable"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get item dynamic data
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/dynamic
func get_item_dynamic_data(
	item_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/dynamic"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Enable an item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/enable
func enable_item(
	item_id: String,
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/enable"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Feature an item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/features/{feature}
func feature_item(
	feature: String,
	item_id: String,
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/features/{feature}"
	url_path = url_path.replace("{" + "feature" + "}", feature.uri_encode())
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Defeature an item
## DELETE /platform/admin/namespaces/{namespace}/items/{itemId}/features/{feature}
func defeature_item(
	feature: String,
	item_id: String,
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/features/{feature}"
	url_path = url_path.replace("{" + "feature" + "}", feature.uri_encode())
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get an item in locale
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/locale
func get_locale_item(
	item_id: String,
	namespace_param: String,
	active_only: bool = false,
	language: String = "",
	populate_bundle: bool = false,
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/locale"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not language.is_empty():
		query_params["language"] = language
	query_params["populateBundle"] = populate_bundle
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update item purchase condition
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/purchase/condition
func update_item_purchase_condition(
	item_id: String,
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/purchase/condition"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get item references
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/references
func query_item_references(
	item_id: String,
	namespace_param: String,
	features_to_check: Array = [],
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/references"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if features_to_check.size() > 0:
		query_params["featuresToCheck"] = features_to_check
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Return item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/return
func return_item(
	item_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/{itemId}/return"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query key groups
## GET /platform/admin/namespaces/{namespace}/keygroups
func query_key_groups(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups"
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
	if not tag.is_empty():
		query_params["tag"] = tag
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create key group
## POST /platform/admin/namespaces/{namespace}/keygroups
func create_key_group(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get key group by booth name
## GET /platform/admin/namespaces/{namespace}/keygroups/byBoothName
## @deprecated
func get_key_group_by_booth_name(
	namespace_param: String,
	booth_name: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups/byBoothName"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not booth_name.is_empty():
		query_params["boothName"] = booth_name
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get key group
## GET /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}
func get_key_group(
	key_group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}"
	url_path = url_path.replace("{" + "keyGroupId" + "}", key_group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update key group
## PUT /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}
func update_key_group(
	key_group_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}"
	url_path = url_path.replace("{" + "keyGroupId" + "}", key_group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get key group dynamic
## GET /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/dynamic
func get_key_group_dynamic(
	key_group_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/dynamic"
	url_path = url_path.replace("{" + "keyGroupId" + "}", key_group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List keys of a key group
## GET /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/keys
func list_keys(
	key_group_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/keys"
	url_path = url_path.replace("{" + "keyGroupId" + "}", key_group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Upload keys to key group
## POST /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/keys
func upload_keys(
	key_group_id: String,
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/keys"
	url_path = url_path.replace("{" + "keyGroupId" + "}", key_group_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query orders
## GET /platform/admin/namespaces/{namespace}/orders
func query_orders(
	namespace_param: String,
	end_time: String = "",
	limit: int = -1,
	offset: int = -1,
	order_nos: Array = [],
	sort_by: String = "",
	start_time: String = "",
	status: String = "",
	with_total: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if order_nos.size() > 0:
		query_params["orderNos"] = order_nos
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not status.is_empty():
		query_params["status"] = status
	query_params["withTotal"] = with_total
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Order Statistics
## GET /platform/admin/namespaces/{namespace}/orders/stats
func get_order_statistics(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/orders/stats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get order
## GET /platform/admin/namespaces/{namespace}/orders/{orderNo}
func get_order(
	namespace_param: String,
	order_no: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/orders/{orderNo}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Refund order
## PUT /platform/admin/namespaces/{namespace}/orders/{orderNo}/refund
func refund_order(
	namespace_param: String,
	order_no: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/orders/{orderNo}/refund"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get payment callback configuration
## GET /platform/admin/namespaces/{namespace}/payment/config/callback
## @deprecated
func get_payment_callback_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/config/callback"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update payment callback configuration
## PUT /platform/admin/namespaces/{namespace}/payment/config/callback
## @deprecated
func update_payment_callback_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/config/callback"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get payment domain whitelist config
## GET /platform/admin/namespaces/{namespace}/payment/config/domains
func get_payment_merchant_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/config/domains"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update payment domain whitelist config
## PUT /platform/admin/namespaces/{namespace}/payment/config/domains
func update_payment_domain_whitelist_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/config/domains"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query payment notifications
## GET /platform/admin/namespaces/{namespace}/payment/notifications
func query_payment_notifications(
	namespace_param: String,
	end_date: String = "",
	external_id: String = "",
	limit: int = -1,
	notification_source: String = "",
	notification_type: String = "",
	offset: int = -1,
	payment_order_no: String = "",
	start_date: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/notifications"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not external_id.is_empty():
		query_params["externalId"] = external_id
	if limit >= 0:
		query_params["limit"] = limit
	if not notification_source.is_empty():
		query_params["notificationSource"] = notification_source
	if not notification_type.is_empty():
		query_params["notificationType"] = notification_type
	if offset >= 0:
		query_params["offset"] = offset
	if not payment_order_no.is_empty():
		query_params["paymentOrderNo"] = payment_order_no
	if not start_date.is_empty():
		query_params["startDate"] = start_date
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query payment orders
## GET /platform/admin/namespaces/{namespace}/payment/orders
func query_payment_orders(
	namespace_param: String,
	channel: String = "",
	ext_tx_id: String = "",
	limit: int = -1,
	offset: int = -1,
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not channel.is_empty():
		query_params["channel"] = channel
	if not ext_tx_id.is_empty():
		query_params["extTxId"] = ext_tx_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create payment order by dedicated server
## POST /platform/admin/namespaces/{namespace}/payment/orders
func create_payment_order_by_dedicated(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List external order No by external transaction id
## GET /platform/admin/namespaces/{namespace}/payment/orders/byExtTxId
func list_ext_order_no_by_ext_tx_id(
	namespace_param: String,
	ext_tx_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders/byExtTxId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not ext_tx_id.is_empty():
		query_params["extTxId"] = ext_tx_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get payment order
## GET /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}
func get_payment_order(
	namespace_param: String,
	payment_order_no: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Charge payment order without payment flow
## PUT /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}
func charge_payment_order(
	namespace_param: String,
	payment_order_no: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Refund payment order by dedicated server
## PUT /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/refund
func refund_payment_order_by_dedicated(
	namespace_param: String,
	payment_order_no: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/refund"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Simulate payment notification
## PUT /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/simulate-notification
func simulate_payment_order_notification(
	namespace_param: String,
	payment_order_no: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/simulate-notification"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get payment order charge status
## GET /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/status
func get_payment_order_charge_status(
	namespace_param: String,
	payment_order_no: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user psn entitlement ownership by entitlement label
## POST /platform/admin/namespaces/{namespace}/platforms/psn/entitlements/{entitlementLabel}/ownership
func get_psn_entitlement_ownership(
	entitlement_label: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/platforms/psn/entitlements/{entitlementLabel}/ownership"
	url_path = url_path.replace("{" + "entitlementLabel" + "}", entitlement_label.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Xbox entitlement ownership by product sku.
## POST /platform/admin/namespaces/{namespace}/platforms/xbl/entitlements/{productSku}/ownership
func get_xbox_entitlement_ownership(
	namespace_param: String,
	product_sku: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/platforms/xbl/entitlements/{productSku}/ownership"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "productSku" + "}", product_sku.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get platform entitlement config list
## GET /platform/admin/namespaces/{namespace}/platforms/{platform}/entitlement/config
func get_platform_entitlement_config(
	namespace_param: String,
	platform: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/platforms/{platform}/entitlement/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update platform entitlement config
## PUT /platform/admin/namespaces/{namespace}/platforms/{platform}/entitlement/config
func update_platform_entitlement_config(
	namespace_param: String,
	platform: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/platforms/{platform}/entitlement/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get platform wallet config list
## GET /platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config
func get_platform_wallet_config(
	namespace_param: String,
	platform: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update platform wallet config
## PUT /platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config
func update_platform_wallet_config(
	namespace_param: String,
	platform: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Reset platform wallet config
## PUT /platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config/reset
func reset_platform_wallet_config(
	namespace_param: String,
	platform: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get revocation configuration
## GET /platform/admin/namespaces/{namespace}/revocation/config
func get_revocation_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update revocation configuration
## PUT /platform/admin/namespaces/{namespace}/revocation/config
func update_revocation_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete revocation config
## DELETE /platform/admin/namespaces/{namespace}/revocation/config
func delete_revocation_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Query revocation histories
## GET /platform/admin/namespaces/{namespace}/revocation/history
func query_revocation_histories(
	namespace_param: String,
	end_time: String = "",
	limit: int = -1,
	offset: int = -1,
	source: String = "",
	start_time: String = "",
	status: String = "",
	transaction_id: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not source.is_empty():
		query_params["source"] = source
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not status.is_empty():
		query_params["status"] = status
	if not transaction_id.is_empty():
		query_params["transactionId"] = transaction_id
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get revocation plugin config
## GET /platform/admin/namespaces/{namespace}/revocation/plugins/revocation
func get_revocation_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/plugins/revocation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update revocation plugin config
## PUT /platform/admin/namespaces/{namespace}/revocation/plugins/revocation
func update_revocation_plugin_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/plugins/revocation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete revocation plugin config
## DELETE /platform/admin/namespaces/{namespace}/revocation/plugins/revocation
func delete_revocation_plugin_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/plugins/revocation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload revocation plugin custom config tls cert
## PUT /platform/admin/namespaces/{namespace}/revocation/plugins/revocation/customConfig/cert
func upload_revocation_plugin_config_cert_v2(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/plugins/revocation/customConfig/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## [Deprecated]Upload revocation plugin custom config tls cert
## PUT /platform/admin/namespaces/{namespace}/revocation/plugins/revocation/revocation/customConfig/cert
## @deprecated
func upload_revocation_plugin_config_cert(
	namespace_param: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/plugins/revocation/revocation/customConfig/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create a reward
## POST /platform/admin/namespaces/{namespace}/rewards
func create_reward(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query rewards by criteria
## GET /platform/admin/namespaces/{namespace}/rewards/byCriteria
func query_rewards(
	namespace_param: String,
	event_topic: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/byCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not event_topic.is_empty():
		query_params["eventTopic"] = event_topic
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if sort_by.size() > 0:
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Export all reward configurations
## GET /platform/admin/namespaces/{namespace}/rewards/export
func export_rewards(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Import reward configurations
## POST /platform/admin/namespaces/{namespace}/rewards/import
func import_rewards(
	namespace_param: String,
	replace_existing: bool,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["replaceExisting"] = replace_existing
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a reward
## GET /platform/admin/namespaces/{namespace}/rewards/{rewardId}
func get_reward(
	namespace_param: String,
	reward_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/{rewardId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "rewardId" + "}", reward_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a reward
## PUT /platform/admin/namespaces/{namespace}/rewards/{rewardId}
func update_reward(
	namespace_param: String,
	reward_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/{rewardId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "rewardId" + "}", reward_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a reward
## DELETE /platform/admin/namespaces/{namespace}/rewards/{rewardId}
func delete_reward(
	namespace_param: String,
	reward_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/{rewardId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "rewardId" + "}", reward_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Check if event payload match reward condition
## PUT /platform/admin/namespaces/{namespace}/rewards/{rewardId}/match
func check_event_condition(
	namespace_param: String,
	reward_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/{rewardId}/match"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "rewardId" + "}", reward_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a reward condition record
## DELETE /platform/admin/namespaces/{namespace}/rewards/{rewardId}/record
func delete_reward_condition_record(
	namespace_param: String,
	reward_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/{rewardId}/record"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "rewardId" + "}", reward_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List sections
## GET /platform/admin/namespaces/{namespace}/sections
func query_sections(
	namespace_param: String,
	end: String = "",
	limit: int = -1,
	offset: int = -1,
	start: String = "",
	store_id: String = "",
	view_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/sections"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end.is_empty():
		query_params["end"] = end
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not start.is_empty():
		query_params["start"] = start
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not view_id.is_empty():
		query_params["viewId"] = view_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a section
## POST /platform/admin/namespaces/{namespace}/sections
func create_section(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/sections"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## purge expired section
## DELETE /platform/admin/namespaces/{namespace}/sections/purge/expired
func purge_expired_section(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/sections/purge/expired"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get a section
## GET /platform/admin/namespaces/{namespace}/sections/{sectionId}
func get_section(
	namespace_param: String,
	section_id: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/sections/{sectionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sectionId" + "}", section_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a section
## PUT /platform/admin/namespaces/{namespace}/sections/{sectionId}
func update_section(
	namespace_param: String,
	section_id: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/sections/{sectionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sectionId" + "}", section_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a section
## DELETE /platform/admin/namespaces/{namespace}/sections/{sectionId}
func delete_section(
	namespace_param: String,
	section_id: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/sections/{sectionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sectionId" + "}", section_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List stores
## GET /platform/admin/namespaces/{namespace}/stores
func list_stores(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a store
## POST /platform/admin/namespaces/{namespace}/stores
func create_store(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get catalog definition
## GET /platform/admin/namespaces/{namespace}/stores/catalogDefinition
func get_catalog_definition(
	namespace_param: String,
	catalog_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/catalogDefinition"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not catalog_type.is_empty():
		query_params["catalogType"] = catalog_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Download store csv templates
## GET /platform/admin/namespaces/{namespace}/stores/downloadCSVTemplates
func download_csv_templates(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/downloadCSVTemplates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Export a store to CSV format
## POST /platform/admin/namespaces/{namespace}/stores/exportByCSV
func export_store_by_csv(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/exportByCSV"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Import a store
## PUT /platform/admin/namespaces/{namespace}/stores/import
## @deprecated
func import_store(
	namespace_param: String,
	store_id: String = "",
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get published store
## GET /platform/admin/namespaces/{namespace}/stores/published
func get_published_store(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete published store
## DELETE /platform/admin/namespaces/{namespace}/stores/published
func delete_published_store(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get a published store's backup
## GET /platform/admin/namespaces/{namespace}/stores/published/backup
func get_published_store_backup(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published/backup"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Rollback a published store
## PUT /platform/admin/namespaces/{namespace}/stores/published/rollback
func rollback_published_store(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published/rollback"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get a store
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}
func get_store(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a store
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}
func update_store(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a store
## DELETE /platform/admin/namespaces/{namespace}/stores/{storeId}
func delete_store(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Query catalog changes
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/byCriteria
func query_changes(
	namespace_param: String,
	store_id: String,
	action: String = "",
	item_sku: String = "",
	item_type: String = "",
	limit: int = -1,
	offset: int = -1,
	selected: bool = false,
	sort_by: Array = [],
	status: String = "",
	type_param: String = "",
	updated_at_end: String = "",
	updated_at_start: String = "",
	with_total: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/byCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not action.is_empty():
		query_params["action"] = action
	if not item_sku.is_empty():
		query_params["itemSku"] = item_sku
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	query_params["selected"] = selected
	if sort_by.size() > 0:
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not updated_at_end.is_empty():
		query_params["updatedAtEnd"] = updated_at_end
	if not updated_at_start.is_empty():
		query_params["updatedAtStart"] = updated_at_start
	query_params["withTotal"] = with_total
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Publish all unpublished changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/publishAll
func publish_all(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/publishAll"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Publish selected unpublished changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/publishSelected
func publish_selected(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/publishSelected"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Select all changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/selectAll
func select_all_records(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/selectAll"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Select all changes by criteria
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/selectAllByCriteria
func select_all_records_by_criteria(
	namespace_param: String,
	store_id: String,
	action: String = "",
	item_sku: String = "",
	item_type: String = "",
	selected: bool = false,
	type_param: String = "",
	updated_at_end: String = "",
	updated_at_start: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/selectAllByCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not action.is_empty():
		query_params["action"] = action
	if not item_sku.is_empty():
		query_params["itemSku"] = item_sku
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	query_params["selected"] = selected
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not updated_at_end.is_empty():
		query_params["updatedAtEnd"] = updated_at_end
	if not updated_at_start.is_empty():
		query_params["updatedAtStart"] = updated_at_start
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get catalog changes statistics
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/statistics
func get_statistic(
	namespace_param: String,
	store_id: String,
	action: String = "",
	item_sku: String = "",
	item_type: String = "",
	type_param: String = "",
	updated_at_end: String = "",
	updated_at_start: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/statistics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not action.is_empty():
		query_params["action"] = action
	if not item_sku.is_empty():
		query_params["itemSku"] = item_sku
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not updated_at_end.is_empty():
		query_params["updatedAtEnd"] = updated_at_end
	if not updated_at_start.is_empty():
		query_params["updatedAtStart"] = updated_at_start
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Unselect all changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/unselectAll
func unselect_all_records(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/unselectAll"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Select a change
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/{changeId}/select
func select_record(
	change_id: String,
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/{changeId}/select"
	url_path = url_path.replace("{" + "changeId" + "}", change_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Unselect a change
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/{changeId}/unselect
func unselect_record(
	change_id: String,
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/{changeId}/unselect"
	url_path = url_path.replace("{" + "changeId" + "}", change_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Clone a store
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/clone
func clone_store(
	namespace_param: String,
	store_id: String,
	target_store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/clone"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not target_store_id.is_empty():
		query_params["targetStoreId"] = target_store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Export a store
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}/export
## @deprecated
func export_store(
	namespace_param: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query import store history
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}/import/history
func query_import_history(
	namespace_param: String,
	store_id: String,
	end: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	start: String = "",
	success: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/import/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end.is_empty():
		query_params["end"] = end
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not start.is_empty():
		query_params["start"] = start
	query_params["success"] = success
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Import store using CSV format
## POST /platform/admin/namespaces/{namespace}/stores/{storeId}/importByCSV
func import_store_by_csv(
	namespace_param: String,
	store_id: String,
	category: String = "",
	display: String = "",
	item: String = "",
	notes: String = "",
	section: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/{storeId}/importByCSV"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query subscriptions
## GET /platform/admin/namespaces/{namespace}/subscriptions
func query_subscriptions(
	namespace_param: String,
	charge_status: String = "",
	item_id: String = "",
	limit: int = -1,
	offset: int = -1,
	sku: String = "",
	status: String = "",
	subscribed_by: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/subscriptions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not charge_status.is_empty():
		query_params["chargeStatus"] = charge_status
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sku.is_empty():
		query_params["sku"] = sku
	if not status.is_empty():
		query_params["status"] = status
	if not subscribed_by.is_empty():
		query_params["subscribedBy"] = subscribed_by
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Recurring charge subscription
## PUT /platform/admin/namespaces/{namespace}/subscriptions/{subscriptionId}/recurring
func recurring_charge_subscription(
	namespace_param: String,
	subscription_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/subscriptions/{subscriptionId}/recurring"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get ticket dynamic
## GET /platform/admin/namespaces/{namespace}/tickets/{boothName}
func get_ticket_dynamic(
	booth_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/tickets/{boothName}"
	url_path = url_path.replace("{" + "boothName" + "}", booth_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Decrease ticket sale
## PUT /platform/admin/namespaces/{namespace}/tickets/{boothName}/decrement
func decrease_ticket_sale(
	booth_name: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/tickets/{boothName}/decrement"
	url_path = url_path.replace("{" + "boothName" + "}", booth_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get ticket booth ID
## GET /platform/admin/namespaces/{namespace}/tickets/{boothName}/id
func get_ticket_booth_id(
	booth_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/tickets/{boothName}/id"
	url_path = url_path.replace("{" + "boothName" + "}", booth_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Increase ticket sale
## PUT /platform/admin/namespaces/{namespace}/tickets/{boothName}/increment
func increase_ticket_sale(
	booth_name: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/tickets/{boothName}/increment"
	url_path = url_path.replace("{" + "boothName" + "}", booth_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## commit a chain of actions or operations
## POST /platform/admin/namespaces/{namespace}/trade/commit
func commit(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/trade/commit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve trade history by criteria
## GET /platform/admin/namespaces/{namespace}/trade/history/byCriteria
func get_trade_history_by_criteria(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	status: String = "",
	type_param: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/trade/history/byCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not status.is_empty():
		query_params["status"] = status
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

## Retrieve trade history by transaction ID
## GET /platform/admin/namespaces/{namespace}/trade/{transactionId}
func get_trade_history_by_transaction_id(
	namespace_param: String,
	transaction_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/trade/{transactionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Unlock steam achievement.
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/achievement/steam
func unlock_steam_user_achievement(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/achievement/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get xbox live user achievements.
## GET /platform/admin/namespaces/{namespace}/users/{userId}/achievement/xbl
func get_xbl_user_achievements(
	namespace_param: String,
	user_id: String,
	xbox_user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/achievement/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not xbox_user_id.is_empty():
		query_params["xboxUserId"] = xbox_user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update xbox live achievements.
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/achievement/xbl
func update_xbl_user_achievement(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/achievement/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Anonymize campaign
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/campaign
func anonymize_campaign(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/campaign"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize entitlement
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/entitlements
func anonymize_entitlement(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/entitlements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize fulfillment
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/fulfillment
func anonymize_fulfillment(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/fulfillment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize integrations
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/integrations
func anonymize_integration(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/integrations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize order
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/orders
func anonymize_order(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize payment
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/payment
func anonymize_payment(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/payment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize revocation
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/revocation
func anonymize_revocation(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/revocation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize subscription
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/subscriptions
func anonymize_subscription(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/subscriptions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## anonymize wallet
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/wallets
func anonymize_wallet(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/anonymization/wallets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get user dlc by platform
## GET /platform/admin/namespaces/{namespace}/users/{userId}/dlc
func get_user_dlc_by_platform(
	namespace_param: String,
	user_id: String,
	type_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/dlc"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user dlc records
## GET /platform/admin/namespaces/{namespace}/users/{userId}/dlc/records
func get_user_dlc(
	namespace_param: String,
	user_id: String,
	include_all_namespaces: bool = false,
	status: String = "",
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/dlc/records"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["includeAllNamespaces"] = include_all_namespaces
	if not status.is_empty():
		query_params["status"] = status
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query user entitlements
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements
func query_user_entitlements(
	namespace_param: String,
	user_id: String,
	active_only: bool = false,
	app_type: String = "",
	collection_id: String = "",
	entitlement_clazz: String = "",
	entitlement_name: String = "",
	features: Array = [],
	fuzzy_match_name: bool = false,
	ignore_active_date: bool = false,
	item_id: Array = [],
	limit: int = -1,
	offset: int = -1,
	origin: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not app_type.is_empty():
		query_params["appType"] = app_type
	if not collection_id.is_empty():
		query_params["collectionId"] = collection_id
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not entitlement_name.is_empty():
		query_params["entitlementName"] = entitlement_name
	if features.size() > 0:
		query_params["features"] = features
	query_params["fuzzyMatchName"] = fuzzy_match_name
	query_params["ignoreActiveDate"] = ignore_active_date
	if item_id.size() > 0:
		query_params["itemId"] = item_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not origin.is_empty():
		query_params["origin"] = origin
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Grant user entitlement
## POST /platform/admin/namespaces/{namespace}/users/{userId}/entitlements
func grant_user_entitlement(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user app entitlement by appId
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byAppId
func get_user_app_entitlement_by_app_id(
	namespace_param: String,
	user_id: String,
	app_id: String,
	active_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query app entitlements by appType
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byAppType
func query_user_entitlements_by_app_type(
	namespace_param: String,
	user_id: String,
	app_type: String,
	active_only: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byAppType"
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
	if not app_type.is_empty():
		query_params["appType"] = app_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlements by ids.
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byIds
func get_user_entitlements_by_ids(
	namespace_param: String,
	user_id: String,
	ids: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if ids.size() > 0:
		query_params["ids"] = ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement by itemId
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byItemId
func get_user_entitlement_by_item_id(
	namespace_param: String,
	user_id: String,
	item_id: String,
	active_only: bool = false,
	entitlement_clazz: String = "",
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byItemId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not platform.is_empty():
		query_params["platform"] = platform
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlements by itemIds
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byItemIds
func get_user_active_entitlements_by_item_ids(
	namespace_param: String,
	user_id: String,
	ids: Array = [],
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byItemIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if ids.size() > 0:
		query_params["ids"] = ids
	if not platform.is_empty():
		query_params["platform"] = platform
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement by sku
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/bySku
func get_user_entitlement_by_sku(
	namespace_param: String,
	user_id: String,
	sku: String,
	active_only: bool = false,
	entitlement_clazz: String = "",
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not platform.is_empty():
		query_params["platform"] = platform
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Exists any user active entitlement
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/any
func exists_any_user_active_entitlement(
	namespace_param: String,
	user_id: String,
	app_ids: Array = [],
	item_ids: Array = [],
	platform: String = "",
	skus: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/any"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if app_ids.size() > 0:
		query_params["appIds"] = app_ids
	if item_ids.size() > 0:
		query_params["itemIds"] = item_ids
	if not platform.is_empty():
		query_params["platform"] = platform
	if skus.size() > 0:
		query_params["skus"] = skus
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Exists any user active entitlement
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/anyOf
func exists_any_user_active_entitlement_by_item_ids(
	namespace_param: String,
	user_id: String,
	item_ids: Array,
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/anyOf"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not platform.is_empty():
		query_params["platform"] = platform
	if item_ids.size() > 0:
		query_params["itemIds"] = item_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user app entitlement ownership by appId
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byAppId
func get_user_app_entitlement_ownership_by_app_id(
	namespace_param: String,
	user_id: String,
	app_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
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

## Get user entitlement ownership by itemId
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemId
func get_user_entitlement_ownership_by_item_id(
	namespace_param: String,
	user_id: String,
	item_id: String,
	entitlement_clazz: String = "",
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not platform.is_empty():
		query_params["platform"] = platform
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement ownership by itemIds
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemIds
func get_user_entitlement_ownership_by_item_ids(
	namespace_param: String,
	user_id: String,
	ids: Array = [],
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if ids.size() > 0:
		query_params["ids"] = ids
	if not platform.is_empty():
		query_params["platform"] = platform
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement ownership by sku
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/bySku
func get_user_entitlement_ownership_by_sku(
	namespace_param: String,
	user_id: String,
	sku: String,
	entitlement_clazz: String = "",
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not platform.is_empty():
		query_params["platform"] = platform
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Revoke all entitlements of a user (This API is for testing purpose only)
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/revoke
func revoke_all_entitlements(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/revoke"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Revoke user's entitlements by ids
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/revoke/byIds
func revoke_user_entitlements(
	namespace_param: String,
	user_id: String,
	entitlement_ids: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/revoke/byIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_ids.is_empty():
		query_params["entitlementIds"] = entitlement_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user entitlement
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}
func get_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}
func update_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Consume user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/decrement
func consume_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/decrement"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Disable user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/disable
func disable_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/disable"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Enable user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/enable
func enable_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/enable"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user entitlement history
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/history
func get_user_entitlement_histories(
	entitlement_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/history"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Revoke user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke
func revoke_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Revoke specified count of user entitlement.
## POST /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke/byUseCount
func revoke_user_entitlement_by_use_count(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke/byUseCount"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check if specified count of user entitlement can be revoked
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke/byUseCount/preCheck
func pre_check_revoke_user_entitlement_by_use_count(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	quantity: int
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke/byUseCount/preCheck"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if quantity >= 0:
		query_params["quantity"] = quantity
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Revoke specified use count of user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revokeByUseCount
## @deprecated
func revoke_use_count(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revokeByUseCount"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sell user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/sell
func sell_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/sell"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Fulfill item
## POST /platform/admin/namespaces/{namespace}/users/{userId}/fulfillment
func fulfill_item(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/fulfillment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Redeem campaign code
## POST /platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/code
func redeem_code(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Pre check fulfillment items
## POST /platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/preCheck
func pre_check_fulfill_item(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/preCheck"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Fulfill rewards without content
## POST /platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/rewards
func fulfill_rewards(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query IAP orders
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap
func query_user_iap_orders(
	namespace_param: String,
	user_id: String,
	end_time: String = "",
	limit: int = -1,
	offset: int = -1,
	product_id: String = "",
	start_time: String = "",
	status: String = "",
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not product_id.is_empty():
		query_params["productId"] = product_id
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not status.is_empty():
		query_params["status"] = status
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query all user IAP orders
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/all
func query_all_user_iap_orders(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/all"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query IAP consume history
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/consume/history
func query_user_iap_consume_history(
	namespace_param: String,
	user_id: String,
	end_time: String = "",
	limit: int = -1,
	offset: int = -1,
	start_time: String = "",
	status: String = "",
	type_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/consume/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not status.is_empty():
		query_params["status"] = status
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Mock fulfill iap item.
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/mock/receipt
func mock_fulfill_iap_item(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/mock/receipt"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync Meta Quest(Oculus) subscription
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/oculus/subscription/sync
func admin_sync_oculus_subscriptions(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/oculus/subscription/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query IAP order line items
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/orders/{iapOrderNo}/line_items
func admin_get_iap_order_line_items(
	iap_order_no: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/orders/{iapOrderNo}/line_items"
	url_path = url_path.replace("{" + "iapOrderNo" + "}", iap_order_no.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync Abnormal transaction, Sync steam order by transaction. only...
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/steam/syncAbnormalTransaction
func admin_sync_steam_abnormal_transaction(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/steam/syncAbnormalTransaction"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Manual sync steam transaction. only works when steam sync mode is...
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/steam/syncByTransaction
func admin_sync_steam_iap_by_transaction(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/steam/syncByTransaction"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query user subscription.
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions
func query_user_third_party_subscription(
	namespace_param: String,
	user_id: String,
	active_only: bool = false,
	group_id: String = "",
	limit: int = -1,
	offset: int = -1,
	platform: String = "",
	product_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not group_id.is_empty():
		query_params["groupId"] = group_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not platform.is_empty():
		query_params["platform"] = platform
	if not product_id.is_empty():
		query_params["productId"] = product_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user third party platform subscription ownership by...
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}/ownership/byGroupId
func get_third_party_platform_subscription_ownership_by_group_id(
	namespace_param: String,
	platform: String,
	user_id: String,
	group_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}/ownership/byGroupId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not group_id.is_empty():
		query_params["groupId"] = group_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user third party platform subscription ownership by...
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}/ownership/byProductId
func get_third_party_platform_subscription_ownership_by_product_id(
	namespace_param: String,
	platform: String,
	user_id: String,
	product_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}/ownership/byProductId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not product_id.is_empty():
		query_params["productId"] = product_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin query user subscription transactions.
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions
func query_user_third_party_subscription_transactions(
	namespace_param: String,
	user_id: String,
	active_only: bool = false,
	group_id: String = "",
	limit: int = -1,
	offset: int = -1,
	platform: String = "",
	product_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not group_id.is_empty():
		query_params["groupId"] = group_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not platform.is_empty():
		query_params["platform"] = platform
	if not product_id.is_empty():
		query_params["productId"] = product_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get user subscription transaction details.
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}
func get_third_party_subscription_details(
	id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get User Subscription Transaction Update History
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}/histories
func get_subscription_history(
	id: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}/histories"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
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

## Sync Subscription transaction
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}/sync
func sync_subscription_transaction(
	id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}/sync"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Admin get user subscription details.
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/{id}
func get_third_party_user_subscription_details(
	id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync Subscription Status
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/{id}/sync
func sync_subscription(
	id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/{id}/sync"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query user orders
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders
func query_user_orders(
	namespace_param: String,
	user_id: String,
	discounted: bool = false,
	item_id: String = "",
	limit: int = -1,
	offset: int = -1,
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["discounted"] = discounted
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin Create an order
## POST /platform/admin/namespaces/{namespace}/users/{userId}/orders
func admin_create_user_order(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get the count of purchased item
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/countOfItem
func count_of_purchased_item(
	namespace_param: String,
	user_id: String,
	item_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/countOfItem"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get an order
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}
func get_user_order(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update order status
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}
func update_user_order_status(
	namespace_param: String,
	order_no: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Fulfill an order
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/fulfill
func fulfill_user_order(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/fulfill"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user order grant
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/grant
## @deprecated
func get_user_order_grant(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/grant"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user order histories
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/history
func get_user_order_histories(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Web hook for payment notification
## POST /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/notifications
func process_user_order_notification(
	namespace_param: String,
	order_no: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/notifications"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Download user order receipt
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/receipt.pdf
func download_user_order_receipt(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/receipt.pdf"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create payment order
## POST /platform/admin/namespaces/{namespace}/users/{userId}/payment/orders
func create_user_payment_order(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/payment/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Refund payment order
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/payment/orders/{paymentOrderNo}/refund
func refund_user_payment_order(
	namespace_param: String,
	payment_order_no: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/payment/orders/{paymentOrderNo}/refund"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user platform account closure history
## GET /platform/admin/namespaces/{namespace}/users/{userId}/platform/closure/history
func get_user_platform_account_closure_histories(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/platform/closure/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Redeem code
## POST /platform/admin/namespaces/{namespace}/users/{userId}/redemption
func apply_user_redemption(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/redemption"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Do revocation.
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/revocation
func do_revocation(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/revocation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Register/Update a session
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/session/xbl
func register_xbl_sessions(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/session/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query user subscriptions
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions
func query_user_subscriptions(
	namespace_param: String,
	user_id: String,
	charge_status: String = "",
	item_id: String = "",
	limit: int = -1,
	offset: int = -1,
	sku: String = "",
	status: String = "",
	subscribed_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not charge_status.is_empty():
		query_params["chargeStatus"] = charge_status
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sku.is_empty():
		query_params["sku"] = sku
	if not status.is_empty():
		query_params["status"] = status
	if not subscribed_by.is_empty():
		query_params["subscribedBy"] = subscribed_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user subscription activity
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/activities
func get_user_subscription_activities(
	namespace_param: String,
	user_id: String,
	exclude_system: bool = false,
	limit: int = -1,
	offset: int = -1,
	subscription_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/activities"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["excludeSystem"] = exclude_system
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not subscription_id.is_empty():
		query_params["subscriptionId"] = subscription_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Free subscribe by platform
## POST /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/platformSubscribe
func platform_subscribe_subscription(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/platformSubscribe"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check user subscription subscribable
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/subscribable/byItemId
func check_user_subscription_subscribable_by_item_id(
	namespace_param: String,
	user_id: String,
	item_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/subscribable/byItemId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user subscription
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}
func get_user_subscription(
	namespace_param: String,
	subscription_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete user subscription
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}
func delete_user_subscription(
	namespace_param: String,
	subscription_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Cancel a subscription
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/cancel
func cancel_subscription(
	namespace_param: String,
	subscription_id: String,
	user_id: String,
	force: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["force"] = force
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Grant days to a subscription
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/grant
func grant_days_to_subscription(
	namespace_param: String,
	subscription_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/grant"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user subscription billing histories
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/history
func get_user_subscription_billing_histories(
	namespace_param: String,
	subscription_id: String,
	user_id: String,
	exclude_free: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["excludeFree"] = exclude_free
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

## Web hook for payment notification
## POST /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/notifications
func process_user_subscription_notification(
	namespace_param: String,
	subscription_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/notifications"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Acquire ticket
## POST /platform/admin/namespaces/{namespace}/users/{userId}/tickets/{boothName}
func acquire_user_ticket(
	booth_name: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/tickets/{boothName}"
	url_path = url_path.replace("{" + "boothName" + "}", booth_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user currency wallet summary
## GET /platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/summary
func query_user_currency_wallets(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/summary"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Debit a user wallet by currency code
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/{currencyCode}/debit
func debit_user_wallet_by_currency_code(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/{currencyCode}/debit"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## List user currency transactions
## GET /platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/{currencyCode}/transactions
func list_user_currency_transactions(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/{currencyCode}/transactions"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
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

## Check if a user has enough balance
## POST /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/balanceCheck
func check_balance(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/balanceCheck"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check wallet by balance origin and currency code
## GET /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/check
## @deprecated
func check_wallet(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	origin: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/check"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not origin.is_empty():
		query_params["origin"] = origin
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Credit a user wallet by currency code and balance origin
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/credit
func credit_user_wallet(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/credit"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Debit user wallet by currency code and client platform
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/debitByWalletPlatform
func debit_by_wallet_platform(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/debitByWalletPlatform"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Pay with user wallet by currency code and client platform
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/payment
func pay_with_user_wallet(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/payment"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get a user wallet
## GET /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}
## @deprecated
func get_user_wallet(
	namespace_param: String,
	user_id: String,
	wallet_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	url_path = url_path.replace("{" + "walletId" + "}", wallet_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Debit a user wallet
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/debit
## @deprecated
func debit_user_wallet(
	namespace_param: String,
	user_id: String,
	wallet_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/debit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	url_path = url_path.replace("{" + "walletId" + "}", wallet_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Disable a user wallet
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/disable
## @deprecated
func disable_user_wallet(
	namespace_param: String,
	user_id: String,
	wallet_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/disable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	url_path = url_path.replace("{" + "walletId" + "}", wallet_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Enable a user wallet
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/enable
## @deprecated
func enable_user_wallet(
	namespace_param: String,
	user_id: String,
	wallet_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	url_path = url_path.replace("{" + "walletId" + "}", wallet_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## List user wallet transactions
## GET /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/transactions
## @deprecated
func list_user_wallet_transactions(
	namespace_param: String,
	user_id: String,
	wallet_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/wallets/{walletId}/transactions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	url_path = url_path.replace("{" + "walletId" + "}", wallet_id.uri_encode())
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

## List all views
## GET /platform/admin/namespaces/{namespace}/views
func list_views(
	namespace_param: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/views"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a view
## POST /platform/admin/namespaces/{namespace}/views
func create_view(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/views"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a view
## GET /platform/admin/namespaces/{namespace}/views/{viewId}
func get_view(
	namespace_param: String,
	view_id: String,
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/views/{viewId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "viewId" + "}", view_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a view
## PUT /platform/admin/namespaces/{namespace}/views/{viewId}
func update_view(
	namespace_param: String,
	view_id: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/views/{viewId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "viewId" + "}", view_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a view
## DELETE /platform/admin/namespaces/{namespace}/views/{viewId}
func delete_view(
	namespace_param: String,
	view_id: String,
	store_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/views/{viewId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "viewId" + "}", view_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get wallet config of a namespace
## GET /platform/admin/namespaces/{namespace}/wallet/config
func get_wallet_config(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallet/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update wallet config
## PUT /platform/admin/namespaces/{namespace}/wallet/config
func update_wallet_config(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallet/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query wallets
## GET /platform/admin/namespaces/{namespace}/wallets
## @deprecated
func query_wallets(
	namespace_param: String,
	currency_code: String = "",
	limit: int = -1,
	offset: int = -1,
	origin: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not currency_code.is_empty():
		query_params["currencyCode"] = currency_code
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not origin.is_empty():
		query_params["origin"] = origin
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Credit different users' wallets
## POST /platform/admin/namespaces/{namespace}/wallets/credit
func bulk_credit(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallets/credit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Debit different users' wallets
## POST /platform/admin/namespaces/{namespace}/wallets/debit
func bulk_debit(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallets/debit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a wallet by wallet id
## GET /platform/admin/namespaces/{namespace}/wallets/{walletId}
## @deprecated
func get_wallet(
	namespace_param: String,
	wallet_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallets/{walletId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "walletId" + "}", wallet_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync orders
## GET /platform/admin/orders
func sync_orders(
	end: String,
	start: String,
	next_evaluated_key: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/orders"
	# Build query parameters
	var query_params: Dictionary = {}
	if not next_evaluated_key.is_empty():
		query_params["nextEvaluatedKey"] = next_evaluated_key
	if not end.is_empty():
		query_params["end"] = end
	if not start.is_empty():
		query_params["start"] = start
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Test adyen configuration
## POST /platform/admin/payment/config/merchant/adyenconfig/test
func test_adyen_config(
	sandbox: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/adyenconfig/test"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Test Alipay configuration
## POST /platform/admin/payment/config/merchant/alipayconfig/test
func test_ali_pay_config(
	sandbox: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/alipayconfig/test"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Test checkout.com configuration
## POST /platform/admin/payment/config/merchant/checkoutconfig/test
func test_checkout_config(
	sandbox: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/checkoutconfig/test"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Debug matched payment merchant config(internal)
## GET /platform/admin/payment/config/merchant/matched
func debug_matched_payment_merchant_config(
	namespace_param: String = "",
	region: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/matched"
	# Build query parameters
	var query_params: Dictionary = {}
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not region.is_empty():
		query_params["region"] = region
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Test Neon Pay configuration
## POST /platform/admin/payment/config/merchant/neonpayconfig/test
func test_neon_pay_config(
	sandbox: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/neonpayconfig/test"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Test PayPal configuration
## POST /platform/admin/payment/config/merchant/paypalconfig/test
func test_pay_pal_config(
	sandbox: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/paypalconfig/test"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Test stripe configuration
## POST /platform/admin/payment/config/merchant/stripeconfig/test
func test_stripe_config(
	sandbox: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/stripeconfig/test"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Test wxPay configuration
## POST /platform/admin/payment/config/merchant/wxpayconfig/test
func test_wx_pay_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/wxpayconfig/test"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Test xsolla configuration
## POST /platform/admin/payment/config/merchant/xsollaconfig/test
func test_xsolla_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/xsollaconfig/test"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get payment merchant config
## GET /platform/admin/payment/config/merchant/{id}
func get_payment_merchant_config_1(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update adyen config
## PUT /platform/admin/payment/config/merchant/{id}/adyenconfig
func update_adyen_config(
	id: String,
	sandbox: bool = false,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/adyenconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test adyen configuration by id
## GET /platform/admin/payment/config/merchant/{id}/adyenconfig/test
func test_adyen_config_by_id(
	id: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/adyenconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update alipay configuration
## PUT /platform/admin/payment/config/merchant/{id}/alipayconfig
func update_ali_pay_config(
	id: String,
	sandbox: bool = false,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/alipayconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test Alipay configuration by id
## GET /platform/admin/payment/config/merchant/{id}/alipayconfig/test
func test_ali_pay_config_by_id(
	id: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/alipayconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update checkout.com config
## PUT /platform/admin/payment/config/merchant/{id}/checkoutconfig
func update_checkout_config(
	id: String,
	sandbox: bool = false,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/checkoutconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test checkout.com configuration by id
## GET /platform/admin/payment/config/merchant/{id}/checkoutconfig/test
func test_checkout_config_by_id(
	id: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/checkoutconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Neon Pay config
## PUT /platform/admin/payment/config/merchant/{id}/neonpayconfig
func update_neon_pay_config(
	id: String,
	sandbox: bool = false,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/neonpayconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test Neon Pay configuration by id
## GET /platform/admin/payment/config/merchant/{id}/neonpayconfig/test
func test_neon_pay_config_by_id(
	id: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/neonpayconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update PayPal config
## PUT /platform/admin/payment/config/merchant/{id}/paypalconfig
func update_pay_pal_config(
	id: String,
	sandbox: bool = false,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/paypalconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test PayPal configuration by id
## GET /platform/admin/payment/config/merchant/{id}/paypalconfig/test
func test_pay_pal_config_by_id(
	id: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/paypalconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update stripe config
## PUT /platform/admin/payment/config/merchant/{id}/stripeconfig
func update_stripe_config(
	id: String,
	sandbox: bool = false,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/stripeconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test stripe configuration by id
## GET /platform/admin/payment/config/merchant/{id}/stripeconfig/test
func test_stripe_config_by_id(
	id: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/stripeconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update wxpay configuration
## PUT /platform/admin/payment/config/merchant/{id}/wxpayconfig
func update_wx_pay_config(
	id: String,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/wxpayconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Upload wxpay cert file
## PUT /platform/admin/payment/config/merchant/{id}/wxpayconfig/cert
func update_wx_pay_config_cert(
	id: String,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/wxpayconfig/cert"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test wxPay configuration by id
## GET /platform/admin/payment/config/merchant/{id}/wxpayconfig/test
func test_wx_pay_config_by_id(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/wxpayconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update xsolla configuration
## PUT /platform/admin/payment/config/merchant/{id}/xsollaconfig
func update_xsolla_config(
	id: String,
	validate: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/xsollaconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["validate"] = validate
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Test xsolla configuration by id
## GET /platform/admin/payment/config/merchant/{id}/xsollaconfig/test
func test_xsolla_config_by_id(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/xsollaconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update xsolla UI configuration
## PUT /platform/admin/payment/config/merchant/{id}/xsollauiconfig
func update_xsolla_ui_config(
	id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/xsollauiconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query payment provider config
## GET /platform/admin/payment/config/provider
func query_payment_provider_config(
	limit: int = -1,
	namespace_param: String = "",
	offset: int = -1,
	region: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider"
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create payment provider config
## POST /platform/admin/payment/config/provider
func create_payment_provider_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get aggregate payment providers
## GET /platform/admin/payment/config/provider/aggregate
func get_aggregate_payment_providers() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/aggregate"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Debug matched payment provider config(internal)
## GET /platform/admin/payment/config/provider/matched
func debug_matched_payment_provider_config(
	namespace_param: String = "",
	region: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/matched"
	# Build query parameters
	var query_params: Dictionary = {}
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not region.is_empty():
		query_params["region"] = region
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get special payment providers
## GET /platform/admin/payment/config/provider/special
func get_special_payment_providers() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/special"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update payment provider config
## PUT /platform/admin/payment/config/provider/{id}
func update_payment_provider_config(
	id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete payment provider config
## DELETE /platform/admin/payment/config/provider/{id}
func delete_payment_provider_config(
	id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get payment global tax config
## GET /platform/admin/payment/config/tax
func get_payment_tax_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/tax"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update payment global tax config
## PUT /platform/admin/payment/config/tax
func update_payment_tax_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/tax"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync payment orders
## GET /platform/admin/payment/orders
func sync_payment_orders(
	end: String,
	start: String,
	next_evaluated_key: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/orders"
	# Build query parameters
	var query_params: Dictionary = {}
	if not next_evaluated_key.is_empty():
		query_params["nextEvaluatedKey"] = next_evaluated_key
	if not end.is_empty():
		query_params["end"] = end
	if not start.is_empty():
		query_params["start"] = start
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Root Categories
## GET /platform/public/namespaces/{namespace}/categories
func public_get_root_categories(
	namespace_param: String,
	language: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/categories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Download store's structured categories
## GET /platform/public/namespaces/{namespace}/categories/download
func download_categories(
	namespace_param: String,
	language: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/categories/download"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Category
## GET /platform/public/namespaces/{namespace}/categories/{categoryPath}
func public_get_category(
	category_path: String,
	namespace_param: String,
	language: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/categories/{categoryPath}"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Child Categories
## GET /platform/public/namespaces/{namespace}/categories/{categoryPath}/children
func public_get_child_categories(
	category_path: String,
	namespace_param: String,
	language: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/categories/{categoryPath}/children"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Descendant Categories
## GET /platform/public/namespaces/{namespace}/categories/{categoryPath}/descendants
func public_get_descendant_categories(
	category_path: String,
	namespace_param: String,
	language: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/categories/{categoryPath}/descendants"
	url_path = url_path.replace("{" + "categoryPath" + "}", category_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## list currencies
## GET /platform/public/namespaces/{namespace}/currencies
func public_list_currencies(
	namespace_param: String,
	currency_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/currencies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not currency_type.is_empty():
		query_params["currencyType"] = currency_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get dlc durable reward simple map
## GET /platform/public/namespaces/{namespace}/dlc/rewards/durable/map
func ge_dlc_durable_reward_short_map(
	namespace_param: String,
	dlc_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/dlc/rewards/durable/map"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not dlc_type.is_empty():
		query_params["dlcType"] = dlc_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get apple config version
## GET /platform/public/namespaces/{namespace}/iap/apple/config/version
func get_apple_config_version(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/iap/apple/config/version"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get iap item mapping
## GET /platform/public/namespaces/{namespace}/iap/item/mapping
func get_iap_item_mapping(
	namespace_param: String,
	platform: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/iap/item/mapping"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not platform.is_empty():
		query_params["platform"] = platform
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get item by appId
## GET /platform/public/namespaces/{namespace}/items/byAppId
func public_get_item_by_app_id(
	namespace_param: String,
	app_id: String,
	language: String = "",
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not app_id.is_empty():
		query_params["appId"] = app_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query items by criteria
## GET /platform/public/namespaces/{namespace}/items/byCriteria
func public_query_items(
	namespace_param: String,
	app_type: String = "",
	auto_calc_estimated_price: bool = false,
	base_app_id: String = "",
	category_path: String = "",
	features: String = "",
	include_sub_category_item: bool = false,
	item_type: String = "",
	language: String = "",
	limit: int = -1,
	offset: int = -1,
	region: String = "",
	sort_by: Array = [],
	store_id: String = "",
	tags: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/byCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_type.is_empty():
		query_params["appType"] = app_type
	query_params["autoCalcEstimatedPrice"] = auto_calc_estimated_price
	if not base_app_id.is_empty():
		query_params["baseAppId"] = base_app_id
	if not category_path.is_empty():
		query_params["categoryPath"] = category_path
	if not features.is_empty():
		query_params["features"] = features
	query_params["includeSubCategoryItem"] = include_sub_category_item
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if not language.is_empty():
		query_params["language"] = language
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if sort_by.size() > 0:
		query_params["sortBy"] = sort_by
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not tags.is_empty():
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get item by sku
## GET /platform/public/namespaces/{namespace}/items/bySku
func public_get_item_by_sku(
	namespace_param: String,
	sku: String,
	auto_calc_estimated_price: bool = false,
	language: String = "",
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["autoCalcEstimatedPrice"] = auto_calc_estimated_price
	if not language.is_empty():
		query_params["language"] = language
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get estimated price
## GET /platform/public/namespaces/{namespace}/items/estimatedPrice
func public_get_estimated_price(
	namespace_param: String,
	item_ids: String,
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/estimatedPrice"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not item_ids.is_empty():
		query_params["itemIds"] = item_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get locale items
## GET /platform/public/namespaces/{namespace}/items/locale/byIds
func public_bulk_get_items(
	namespace_param: String,
	item_ids: String,
	auto_calc_estimated_price: bool = false,
	language: String = "",
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/locale/byIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["autoCalcEstimatedPrice"] = auto_calc_estimated_price
	if not language.is_empty():
		query_params["language"] = language
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not item_ids.is_empty():
		query_params["itemIds"] = item_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Validate user item purchase condition
## POST /platform/public/namespaces/{namespace}/items/purchase/conditions/validate
func public_validate_item_purchase_condition(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/purchase/conditions/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Search items by keyword
## GET /platform/public/namespaces/{namespace}/items/search
func public_search_items(
	namespace_param: String,
	keyword: String,
	language: String,
	auto_calc_estimated_price: bool = false,
	item_type: String = "",
	limit: int = -1,
	offset: int = -1,
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["autoCalcEstimatedPrice"] = auto_calc_estimated_price
	if not item_type.is_empty():
		query_params["itemType"] = item_type
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if not language.is_empty():
		query_params["language"] = language
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get an app in locale
## GET /platform/public/namespaces/{namespace}/items/{itemId}/app/locale
func public_get_app(
	item_id: String,
	namespace_param: String,
	language: String = "",
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/{itemId}/app/locale"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get item dynamic data
## GET /platform/public/namespaces/{namespace}/items/{itemId}/dynamic
func public_get_item_dynamic_data(
	item_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/{itemId}/dynamic"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get an item in locale
## GET /platform/public/namespaces/{namespace}/items/{itemId}/locale
func public_get_item(
	item_id: String,
	namespace_param: String,
	auto_calc_estimated_price: bool = false,
	language: String = "",
	populate_bundle: bool = false,
	region: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/items/{itemId}/locale"
	url_path = url_path.replace("{" + "itemId" + "}", item_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["autoCalcEstimatedPrice"] = auto_calc_estimated_price
	if not language.is_empty():
		query_params["language"] = language
	query_params["populateBundle"] = populate_bundle
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get payment provider customization
## GET /platform/public/namespaces/{namespace}/payment/customization
## @deprecated
func get_payment_customization(
	namespace_param: String,
	payment_provider: String,
	region: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/customization"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not payment_provider.is_empty():
		query_params["paymentProvider"] = payment_provider
	if not region.is_empty():
		query_params["region"] = region
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get payment url
## POST /platform/public/namespaces/{namespace}/payment/link
func public_get_payment_url(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get payment methods
## GET /platform/public/namespaces/{namespace}/payment/methods
func public_get_payment_methods(
	namespace_param: String,
	payment_order_no: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/methods"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not payment_order_no.is_empty():
		query_params["paymentOrderNo"] = payment_order_no
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get payment order info
## GET /platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/info
func public_get_unpaid_payment_order(
	namespace_param: String,
	payment_order_no: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/info"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Do payment
## POST /platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/pay
func pay(
	namespace_param: String,
	payment_order_no: String,
	payment_provider: String = "",
	zip_code: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/pay"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not payment_provider.is_empty():
		query_params["paymentProvider"] = payment_provider
	if not zip_code.is_empty():
		query_params["zipCode"] = zip_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check payment order paid status
## GET /platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/status
func public_check_payment_order_paid_status(
	namespace_param: String,
	payment_order_no: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "paymentOrderNo" + "}", payment_order_no.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get payment provider public config
## GET /platform/public/namespaces/{namespace}/payment/publicconfig
func get_payment_public_config(
	namespace_param: String,
	payment_provider: String,
	region: String,
	sandbox: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/publicconfig"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["sandbox"] = sandbox
	if not payment_provider.is_empty():
		query_params["paymentProvider"] = payment_provider
	if not region.is_empty():
		query_params["region"] = region
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get qrcode
## GET /platform/public/namespaces/{namespace}/payment/qrcode
func public_get_qr_code(
	namespace_param: String,
	code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/qrcode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
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

## Normalize payment return url
## GET /platform/public/namespaces/{namespace}/payment/returnurl
func public_normalize_payment_return_url(
	namespace_param: String,
	order_no: String,
	payment_order_no: String,
	payment_provider: String,
	return_url: String,
	payer_id: String = "",
	foreinginvoice: String = "",
	invoice_id: String = "",
	payload: String = "",
	redirect_result: String = "",
	result_code: String = "",
	session_id: String = "",
	status: String = "",
	token: String = "",
	type_param: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/returnurl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not payer_id.is_empty():
		query_params["PayerID"] = payer_id
	if not foreinginvoice.is_empty():
		query_params["foreinginvoice"] = foreinginvoice
	if not invoice_id.is_empty():
		query_params["invoice_id"] = invoice_id
	if not payload.is_empty():
		query_params["payload"] = payload
	if not redirect_result.is_empty():
		query_params["redirectResult"] = redirect_result
	if not result_code.is_empty():
		query_params["resultCode"] = result_code
	if not session_id.is_empty():
		query_params["sessionId"] = session_id
	if not status.is_empty():
		query_params["status"] = status
	if not token.is_empty():
		query_params["token"] = token
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not user_id.is_empty():
		query_params["user_id"] = user_id
	if not order_no.is_empty():
		query_params["orderNo"] = order_no
	if not payment_order_no.is_empty():
		query_params["paymentOrderNo"] = payment_order_no
	if not payment_provider.is_empty():
		query_params["paymentProvider"] = payment_provider
	if not return_url.is_empty():
		query_params["returnUrl"] = return_url
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get tax result of a payment order
## GET /platform/public/namespaces/{namespace}/payment/tax
func get_payment_tax_value(
	namespace_param: String,
	payment_order_no: String,
	payment_provider: String,
	zip_code: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/tax"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not zip_code.is_empty():
		query_params["zipCode"] = zip_code
	if not payment_order_no.is_empty():
		query_params["paymentOrderNo"] = payment_order_no
	if not payment_provider.is_empty():
		query_params["paymentProvider"] = payment_provider
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a reward by code
## GET /platform/public/namespaces/{namespace}/rewards/byCode
func get_reward_by_code(
	namespace_param: String,
	reward_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/rewards/byCode"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not reward_code.is_empty():
		query_params["rewardCode"] = reward_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query rewards by criteria
## GET /platform/public/namespaces/{namespace}/rewards/byCriteria
func query_rewards_1(
	namespace_param: String,
	event_topic: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/rewards/byCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not event_topic.is_empty():
		query_params["eventTopic"] = event_topic
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if sort_by.size() > 0:
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a reward
## GET /platform/public/namespaces/{namespace}/rewards/{rewardId}
func get_reward_1(
	namespace_param: String,
	reward_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/rewards/{rewardId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "rewardId" + "}", reward_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List all stores
## GET /platform/public/namespaces/{namespace}/stores
func public_list_stores(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/stores"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Exists any my active entitlement
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownership/any
func public_exists_any_my_active_entitlement(
	namespace_param: String,
	app_ids: Array = [],
	item_ids: Array = [],
	skus: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/entitlements/ownership/any"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if app_ids.size() > 0:
		query_params["appIds"] = app_ids
	if item_ids.size() > 0:
		query_params["itemIds"] = item_ids
	if skus.size() > 0:
		query_params["skus"] = skus
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get my app entitlement ownership by appId
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownership/byAppId
func public_get_my_app_entitlement_ownership_by_app_id(
	namespace_param: String,
	app_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/entitlements/ownership/byAppId"
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

## Get my entitlement ownership by itemId
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownership/byItemId
func public_get_my_entitlement_ownership_by_item_id(
	namespace_param: String,
	item_id: String,
	entitlement_clazz: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/entitlements/ownership/byItemId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get my entitlement ownership by sku
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownership/bySku
func public_get_my_entitlement_ownership_by_sku(
	namespace_param: String,
	sku: String,
	entitlement_clazz: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/entitlements/ownership/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Gets an entitlement ownership token
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownershipToken
func public_get_entitlement_ownership_token(
	namespace_param: String,
	app_ids: Array = [],
	item_ids: Array = [],
	skus: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/entitlements/ownershipToken"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if app_ids.size() > 0:
		query_params["appIds"] = app_ids
	if item_ids.size() > 0:
		query_params["itemIds"] = item_ids
	if skus.size() > 0:
		query_params["skus"] = skus
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync my game twitch drops entitlements.
## PUT /platform/public/namespaces/{namespace}/users/me/iap/twitch/sync
func sync_twitch_drops_entitlement(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/iap/twitch/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get my wallet by currency code and namespace
## GET /platform/public/namespaces/{namespace}/users/me/wallets/{currencyCode}
func public_get_my_wallet(
	currency_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/wallets/{currencyCode}"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync epic games dlc items
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/epicgames/sync
func sync_epic_game_dlc(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/dlc/epicgames/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync oculus dlc.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/oculus/sync
func sync_oculus_dlc(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/dlc/oculus/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Synchronize with dlc entitlements in PSN Store.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/psn/sync
func public_sync_psn_dlc_inventory(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/dlc/psn/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Synchronize with dlc entitlements in PSN Store with multiple...
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/psn/sync/multiServiceLabels
func public_sync_psn_dlc_inventory_with_multiple_service_labels(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/dlc/psn/sync/multiServiceLabels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync steam dlc.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/steam/sync
func sync_steam_dlc(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/dlc/steam/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync Xbox dlc items.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/xbl/sync
func sync_xbox_dlc(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/dlc/xbl/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query user entitlements
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements
func public_query_user_entitlements(
	namespace_param: String,
	user_id: String,
	app_type: String = "",
	entitlement_clazz: String = "",
	entitlement_name: String = "",
	features: Array = [],
	item_id: Array = [],
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_type.is_empty():
		query_params["appType"] = app_type
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not entitlement_name.is_empty():
		query_params["entitlementName"] = entitlement_name
	if features.size() > 0:
		query_params["features"] = features
	if item_id.size() > 0:
		query_params["itemId"] = item_id
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

## Get user app entitlement by appId
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/byAppId
func public_get_user_app_entitlement_by_app_id(
	namespace_param: String,
	user_id: String,
	app_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
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

## Query app entitlements by appType
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/byAppType
func public_query_user_entitlements_by_app_type(
	namespace_param: String,
	user_id: String,
	app_type: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/byAppType"
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
	if not app_type.is_empty():
		query_params["appType"] = app_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlements by ids.
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/byIds
func public_get_user_entitlements_by_ids(
	namespace_param: String,
	user_id: String,
	available_platform_only: bool = false,
	ids: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/byIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["availablePlatformOnly"] = available_platform_only
	if ids.size() > 0:
		query_params["ids"] = ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement by itemId
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/byItemId
## @deprecated
func public_get_user_entitlement_by_item_id(
	namespace_param: String,
	user_id: String,
	item_id: String,
	entitlement_clazz: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/byItemId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement by sku
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/bySku
## @deprecated
func public_get_user_entitlement_by_sku(
	namespace_param: String,
	user_id: String,
	sku: String,
	entitlement_clazz: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlements histories.
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/history
func public_user_entitlement_history(
	namespace_param: String,
	user_id: String,
	end_date: String = "",
	entitlement_clazz: String = "",
	limit: int = -1,
	offset: int = -1,
	start_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
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

## Exists any user active entitlement
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/any
func public_exists_any_user_active_entitlement(
	namespace_param: String,
	user_id: String,
	app_ids: Array = [],
	item_ids: Array = [],
	skus: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/any"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if app_ids.size() > 0:
		query_params["appIds"] = app_ids
	if item_ids.size() > 0:
		query_params["itemIds"] = item_ids
	if skus.size() > 0:
		query_params["skus"] = skus
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user app entitlement ownership by appId
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byAppId
func public_get_user_app_entitlement_ownership_by_app_id(
	namespace_param: String,
	user_id: String,
	app_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byAppId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
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

## Get user entitlement ownership by itemId
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemId
func public_get_user_entitlement_ownership_by_item_id(
	namespace_param: String,
	user_id: String,
	item_id: String,
	entitlement_clazz: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement ownership by itemIds
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemIds
func public_get_user_entitlement_ownership_by_item_ids(
	namespace_param: String,
	user_id: String,
	ids: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemIds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if ids.size() > 0:
		query_params["ids"] = ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement ownership by sku
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/bySku
func public_get_user_entitlement_ownership_by_sku(
	namespace_param: String,
	user_id: String,
	sku: String,
	entitlement_clazz: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/bySku"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not entitlement_clazz.is_empty():
		query_params["entitlementClazz"] = entitlement_clazz
	if not sku.is_empty():
		query_params["sku"] = sku
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user entitlement
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}
func public_get_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Consume user entitlement
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/decrement
func public_consume_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/decrement"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sell user entitlement
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/sell
func public_sell_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/sell"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Split user entitlement
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/split
func public_split_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/split"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Transfer user entitlement
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/transfer
func public_transfer_user_entitlement(
	entitlement_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/transfer"
	url_path = url_path.replace("{" + "entitlementId" + "}", entitlement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Redeem campaign code
## POST /platform/public/namespaces/{namespace}/users/{userId}/fulfillment/code
func public_redeem_code(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/fulfillment/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Fulfill apple iap item.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/apple/receipt
func public_fulfill_apple_iap_item(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/apple/receipt"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync epic games inventory.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/epicgames/sync
func sync_epic_games_inventory(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/epicgames/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Fulfill google iap item.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/google/receipt
func public_fulfill_google_iap_item(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/google/receipt"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync Meta Quest(Oculus) subscription
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/oculus/subscription/sync
func sync_oculus_subscriptions(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/oculus/subscription/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync Oculus entitlements.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/oculus/sync
func sync_oculus_consumable_entitlements(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/oculus/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Synchronize with entitlements in PSN Store.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/psn/sync
func public_reconcile_play_station_store(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/psn/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Synchronize with entitlements in PSN Store with multiple service labels.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/psn/sync/multiServiceLabels
func public_reconcile_play_station_store_with_multiple_service_labels(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/psn/sync/multiServiceLabels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync steam inventory.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/steam/sync
func sync_steam_inventory(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/steam/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync Abnormal transaction, Sync steam order by transaction. only...
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/steam/syncAbnormalTransaction
func sync_steam_abnormal_transaction(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/steam/syncAbnormalTransaction"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync steam in app purchase by transaction.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/steam/syncByTransaction
func sync_steam_iap_by_transaction(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/steam/syncByTransaction"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query user subscription.
## GET /platform/public/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}
func public_query_user_third_party_subscription(
	namespace_param: String,
	platform: String,
	user_id: String,
	active_only: bool = false,
	group_id: String = "",
	limit: int = -1,
	offset: int = -1,
	product_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["activeOnly"] = active_only
	if not group_id.is_empty():
		query_params["groupId"] = group_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not product_id.is_empty():
		query_params["productId"] = product_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync twitch drops entitlements.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/twitch/sync
func sync_twitch_drops_entitlement_1(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/twitch/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Sync Xbox inventory.
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/xbl/sync
func sync_xbox_inventory(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/iap/xbl/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query user orders
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders
func public_query_user_orders(
	namespace_param: String,
	user_id: String,
	discounted: bool = false,
	item_id: String = "",
	limit: int = -1,
	offset: int = -1,
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["discounted"] = discounted
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create an order
## POST /platform/public/namespaces/{namespace}/users/{userId}/orders
func public_create_user_order(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/orders"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Preview order price with discount code.
## POST /platform/public/namespaces/{namespace}/users/{userId}/orders/discount/preview
func public_preview_order_price(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/orders/discount/preview"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get user order
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}
func public_get_user_order(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Cancel user order
## PUT /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/cancel
func public_cancel_user_order(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user order histories
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/history
func public_get_user_order_histories(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Download user order receipt
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/receipt.pdf
func public_download_user_order_receipt(
	namespace_param: String,
	order_no: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/receipt.pdf"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "orderNo" + "}", order_no.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get payment accounts
## GET /platform/public/namespaces/{namespace}/users/{userId}/payment/accounts
func public_get_payment_accounts(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/payment/accounts"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete payment account
## DELETE /platform/public/namespaces/{namespace}/users/{userId}/payment/accounts/{type}/{id}
func public_delete_payment_account(
	id: String,
	namespace_param: String,
	type_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/payment/accounts/{type}/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "type" + "}", type_param.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List active section contents
## GET /platform/public/namespaces/{namespace}/users/{userId}/sections
func public_list_active_sections(
	namespace_param: String,
	user_id: String,
	auto_calc_estimated_price: bool = false,
	language: String = "",
	region: String = "",
	store_id: String = "",
	view_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/sections"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["autoCalcEstimatedPrice"] = auto_calc_estimated_price
	if not language.is_empty():
		query_params["language"] = language
	if not region.is_empty():
		query_params["region"] = region
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not view_id.is_empty():
		query_params["viewId"] = view_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query user subscriptions
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions
func public_query_user_subscriptions(
	namespace_param: String,
	user_id: String,
	charge_status: String = "",
	item_id: String = "",
	limit: int = -1,
	offset: int = -1,
	sku: String = "",
	status: String = "",
	subscribed_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/subscriptions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not charge_status.is_empty():
		query_params["chargeStatus"] = charge_status
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sku.is_empty():
		query_params["sku"] = sku
	if not status.is_empty():
		query_params["status"] = status
	if not subscribed_by.is_empty():
		query_params["subscribedBy"] = subscribed_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Subscribe a subscription
## POST /platform/public/namespaces/{namespace}/users/{userId}/subscriptions
func public_subscribe_subscription(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/subscriptions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check user subscription subscribable
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/subscribable/byItemId
func public_check_user_subscription_subscribable_by_item_id(
	namespace_param: String,
	user_id: String,
	item_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/subscriptions/subscribable/byItemId"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user subscription
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}
func public_get_user_subscription(
	namespace_param: String,
	subscription_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Request to change a subscription billing account
## PUT /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/billingAccount
func public_change_subscription_billing_account(
	namespace_param: String,
	subscription_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/billingAccount"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Cancel a subscription
## PUT /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/cancel
func public_cancel_subscription(
	namespace_param: String,
	subscription_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get user subscription billing histories
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/history
func public_get_user_subscription_billing_histories(
	namespace_param: String,
	subscription_id: String,
	user_id: String,
	exclude_free: bool = false,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["excludeFree"] = exclude_free
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

## Get all views
## GET /platform/public/namespaces/{namespace}/users/{userId}/views
func public_list_views(
	namespace_param: String,
	user_id: String,
	language: String = "",
	store_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/views"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a wallet by currency code
## GET /platform/public/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}
func public_get_wallet(
	currency_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List wallet transactions by currency code
## GET /platform/public/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/transactions
func public_list_user_wallet_transactions(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/transactions"
	url_path = url_path.replace("{" + "currencyCode" + "}", currency_code.uri_encode())
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

## Get user dlc reward contents
## GET /platform/public/users/me/dlc/content
func public_get_my_dlc_content(
	type_param: String,
	include_all_namespaces: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/users/me/dlc/content"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["includeAllNamespaces"] = include_all_namespaces
	if not type_param.is_empty():
		query_params["type"] = type_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query fulfillments
## GET /platform/v2/admin/namespaces/{namespace}/fulfillments
func query_fulfillments(
	namespace_param: String,
	end_time: String = "",
	limit: int = -1,
	offset: int = -1,
	start_time: String = "",
	state: String = "",
	transaction_id: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/fulfillments"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end_time.is_empty():
		query_params["endTime"] = end_time
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not start_time.is_empty():
		query_params["startTime"] = start_time
	if not state.is_empty():
		query_params["state"] = state
	if not transaction_id.is_empty():
		query_params["transactionId"] = transaction_id
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query items by criteria
## GET /platform/v2/admin/namespaces/{namespace}/items/byCriteria
func query_items_v2(
	namespace_param: String,
	app_type: String = "",
	available_date: String = "",
	base_app_id: String = "",
	category_path: String = "",
	features: String = "",
	include_sub_category_item: bool = false,
	item_name: String = "",
	item_status: String = "",
	item_type: Array = [],
	limit: int = -1,
	offset: int = -1,
	region: String = "",
	section_exclusive: bool = false,
	sort_by: Array = [],
	store_id: String = "",
	tags: String = "",
	target_namespace: String = "",
	with_total: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/items/byCriteria"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_type.is_empty():
		query_params["appType"] = app_type
	if not available_date.is_empty():
		query_params["availableDate"] = available_date
	if not base_app_id.is_empty():
		query_params["baseAppId"] = base_app_id
	if not category_path.is_empty():
		query_params["categoryPath"] = category_path
	if not features.is_empty():
		query_params["features"] = features
	query_params["includeSubCategoryItem"] = include_sub_category_item
	if not item_name.is_empty():
		query_params["itemName"] = item_name
	if not item_status.is_empty():
		query_params["itemStatus"] = item_status
	if item_type.size() > 0:
		query_params["itemType"] = item_type
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	query_params["sectionExclusive"] = section_exclusive
	if sort_by.size() > 0:
		query_params["sortBy"] = sort_by
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	if not tags.is_empty():
		query_params["tags"] = tags
	if not target_namespace.is_empty():
		query_params["targetNamespace"] = target_namespace
	query_params["withTotal"] = with_total
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Import a store
## PUT /platform/v2/admin/namespaces/{namespace}/stores/import
func import_store_1(
	namespace_param: String,
	store_id: String = "",
	strict_mode: bool = false,
	file: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/stores/import"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not store_id.is_empty():
		query_params["storeId"] = store_id
	query_params["strictMode"] = strict_mode
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Export a store
## POST /platform/v2/admin/namespaces/{namespace}/stores/{storeId}/export
func export_store_1(
	namespace_param: String,
	store_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/stores/{storeId}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "storeId" + "}", store_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Fulfill rewards
## POST /platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillment/rewards
func fulfill_rewards_v2(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillment/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Fulfill items by transactionId
## PUT /platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}
## @deprecated
func fulfill_items(
	namespace_param: String,
	transaction_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Retry fulfill items by transactionId
## PUT /platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/retry
## @deprecated
func retry_fulfill_items(
	namespace_param: String,
	transaction_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/retry"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Revoke items by transactionId
## PUT /platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/revoke
## @deprecated
func revoke_items(
	namespace_param: String,
	transaction_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/revoke"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Fulfill apple iap item V2.
## PUT /platform/v2/public/namespaces/{namespace}/users/{userId}/iap/apple/receipt
func v2_public_fulfill_apple_iap_item(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v2/public/namespaces/{namespace}/users/{userId}/iap/apple/receipt"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Fulfill multiple transactions
## PUT /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/bulk
func bulk_fulfill_items_v3(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Fulfill items by transactionId
## PUT /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}
func fulfill_items_v3(
	namespace_param: String,
	transaction_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Retry fulfill items by transactionId
## PUT /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/retry
func retry_fulfill_items_v3(
	namespace_param: String,
	transaction_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/retry"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Revoke items by transactionId
## PUT /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/revoke
func revoke_items_v3(
	namespace_param: String,
	transaction_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/revoke"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)
