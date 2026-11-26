## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## platform_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-platform-service
## Version: 6.17.0
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


## Lists all fulfillment scripts
## GET /platform/admin/fulfillment/scripts
##
## [Not supported yet in AGS Shared Cloud] List all fulfillment scripts.
func list_fulfillment_scripts() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a fulfillment script by ID
## GET /platform/admin/fulfillment/scripts/{id}
##
## [Not supported yet in AGS Shared Cloud] Get fulfillment script by id. Other detail info: Returns: get fulfillment script
##
## Parameters:
## - id: Fulfillment script ID.
func get_fulfillment_script(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a fulfillment script
## POST /platform/admin/fulfillment/scripts/{id}
##
## [Not supported yet in AGS Shared Cloud] Create fulfillment script. Other detail info: Fulfillment scripts add custom fulfillment logic based on ITEM_TYPE: [MEDIA,INGAMEITEM] for now, and the custom scripts only cover `grantDays`. Example for `grantDays`: `order && ((order.currency && order.currency.currencyCode) == 'LP' || order.isFree) ? 30 : -1`
##
## Parameters:
## - id: Fulfillment script ID.
func create_fulfillment_script(id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes a fulfillment script
## DELETE /platform/admin/fulfillment/scripts/{id}
##
## [Not supported yet in AGS Shared Cloud] Delete fulfillment script.
##
## Parameters:
## - id: Fulfillment script ID.
func delete_fulfillment_script(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a fulfillment script
## PATCH /platform/admin/fulfillment/scripts/{id}
##
## [Not supported yet in AGS Shared Cloud] Update fulfillment script.
##
## Parameters:
## - id: Fulfillment script ID.
func update_fulfillment_script(id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/fulfillment/scripts/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists all item type configurations
## GET /platform/admin/items/configs
##
## [Not supported yet in AGS Shared Cloud] Retrieves all item type configurations.
func list_item_type_configs() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates an item type configuration
## POST /platform/admin/items/configs
##
## [Not supported yet in AGS Shared Cloud] Creates an item type configuration.
func create_item_type_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Searches for an item type configuration by item type and class
## GET /platform/admin/items/configs/search
##
## [Not supported yet in AGS Shared Cloud] Retrieves an item type configuration matching the specified item type and optional class.
##
## Parameters:
## - clazz: Custom item class to filter by.
## - item_type: Item type to search for. Valid values: APP, BUNDLE, CODE, COINS, EXTENSION, INGAMEITEM, LOOTBOX, MEDIA, OPTIONBOX, SEASON, SUBSCRIPTION.
func search_item_type_config(item_type: String, clazz: String = "") -> Dictionary:
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


## Retrieves an item type configuration by ID
## GET /platform/admin/items/configs/{id}
##
## [Not supported yet in AGS Shared Cloud] Retrieves an item type configuration by its ID.
##
## Parameters:
## - id: Item type configuration ID.
func get_item_type_config(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates an item type configuration
## PUT /platform/admin/items/configs/{id}
##
## [Not supported yet in AGS Shared Cloud] Updates an item type configuration.
##
## Parameters:
## - id: Item type configuration ID.
func update_item_type_config(id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes an item type configuration permanently
## DELETE /platform/admin/items/configs/{id}
##
## [Not supported yet in AGS Shared Cloud] Deletes an item type configuration permanently.
##
## Parameters:
## - id: Item type configuration ID.
func delete_item_type_config(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/items/configs/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Queries campaigns
## GET /platform/admin/namespaces/{namespace}/campaigns
##
## Queries campaigns with optional name (fuzzy match) and tag filters. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Campaign name filter. Supports fuzzy match.
## - offset: Number of results to skip for pagination
## - tag: Campaign tag filter.
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


## Creates a campaign
## POST /platform/admin/namespaces/{namespace}/campaigns
##
## Create campaign. Other detail info: Returns: created campaign
##
## Parameters:
## - namespace_param: Game namespace
func create_campaign(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/campaigns"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a campaign by ID
## GET /platform/admin/namespaces/{namespace}/campaigns/{campaignId}
##
## Get campaign info. Other detail info: Returns: campaign info
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
func get_campaign(campaign_id: String, namespace_param: String) -> Dictionary:
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


## Updates a campaign
## PUT /platform/admin/namespaces/{namespace}/campaigns/{campaignId}
##
## Update campaign. Other detail info: Returns: updated campaign
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
func update_campaign(
	campaign_id: String, namespace_param: String, body: Dictionary = {}
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


## Updates the batch name for a campaign
## PUT /platform/admin/namespaces/{namespace}/campaigns/{campaignId}/batchName
##
## Change campaign batch name. Other detail info:
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
func rename_batch(
	campaign_id: String, namespace_param: String, body: Dictionary = {}
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


## Queries campaign batch names
## GET /platform/admin/namespaces/{namespace}/campaigns/{campaignId}/batchNames
##
## Query campaign batch name by fuzzy match. Other detail info: Returns: list of campaign batch names
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
## - batch_name: Batch name filter. Supports fuzzy match.
## - limit: Number of results to return
func query_campaign_batch_names(
	campaign_id: String, namespace_param: String, batch_name: String = "", limit: int = -1
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


## Retrieves dynamic campaign statistics
## GET /platform/admin/namespaces/{namespace}/campaigns/{campaignId}/dynamic
##
## Get campaign dynamic. Other detail info: Returns: campaign dynamic
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
func get_campaign_dynamic(campaign_id: String, namespace_param: String) -> Dictionary:
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


## Retrieves the catalog configuration
## GET /platform/admin/namespaces/{namespace}/catalog/configs
##
## Get catalog config.
##
## Parameters:
## - namespace_param: Game namespace
func get_catalog_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/configs"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the catalog configuration
## PUT /platform/admin/namespaces/{namespace}/catalog/configs
##
## Update catalog config. Other detail info: Returns: updated catalog config
##
## Parameters:
## - namespace_param: Game namespace
func update_catalog_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/configs"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves the lootbox plugin configuration
## GET /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox
##
## Get lootbox plugin config.
##
## Parameters:
## - namespace_param: Game namespace
func get_loot_box_plugin_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the lootbox plugin configuration
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox
##
## Update lootbox plugin config. Other detail info: Returns: updated service plugin config
##
## Parameters:
## - namespace_param: Game namespace
func update_loot_box_plugin_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the lootbox plugin configuration
## DELETE /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox
##
## Deletes the lootbox plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func delete_loot_box_plugin_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Uploads the lootbox plugin TLS certificate
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox/customConfig/cert
##
## Uploads a TLS certificate for the lootbox plugin custom configuration. Returns the updated plugin configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - file: TLS certificate file (PEM format) for the lootbox plugin's custom gRPC connection.
func uplod_loot_box_plugin_config_cert(namespace_param: String, file: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/lootbox/customConfig/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves lootbox plugin gRPC server information
## GET /platform/admin/namespaces/{namespace}/catalog/plugins/lootbox/grpcInfo
##
## Get lootbox plugin gRPC info.
##
## Parameters:
## - namespace_param: Game namespace
## - force: When true, forces a fresh connection check rather than returning cached information.
func get_loot_box_grpc_info(namespace_param: String, force: bool = false) -> Dictionary:
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


## Retrieves the section plugin configuration
## GET /platform/admin/namespaces/{namespace}/catalog/plugins/section
##
## Get section plugin config.
##
## Parameters:
## - namespace_param: Game namespace
func get_section_plugin_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the section plugin configuration
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/section
##
## Update section config. Other detail info: Returns: updated service plugin config
##
## Parameters:
## - namespace_param: Game namespace
func update_section_plugin_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the section plugin configuration
## DELETE /platform/admin/namespaces/{namespace}/catalog/plugins/section
##
## Delete section plugin config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_section_plugin_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Uploads the section plugin TLS certificate
## PUT /platform/admin/namespaces/{namespace}/catalog/plugins/section/customConfig/cert
##
## Uploads a TLS certificate for the section plugin custom configuration. Returns the updated plugin configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - file: TLS certificate file (PEM format) for the section plugin's custom gRPC connection.
func upload_section_plugin_config_cert(namespace_param: String, file: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/catalog/plugins/section/customConfig/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves root categories
## GET /platform/admin/namespaces/{namespace}/categories
##
## Retrieves root categories for the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store ID to query. Defaults to the published store ID when not specified.
func get_root_categories(namespace_param: String, store_id: String = "") -> Dictionary:
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


## Creates a category
## POST /platform/admin/namespaces/{namespace}/categories
##
## Creates a category identified by a slash-delimited path. Categories support localized display names.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store ID to add the category to. Defaults to the published store ID when not specified.
func create_category(
	namespace_param: String, store_id: String, body: Dictionary = {}
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


## Lists all categories with basic information
## GET /platform/admin/namespaces/{namespace}/categories/basic
##
## Lists all categories in the store ordered by category path.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store ID to query. Defaults to the published store ID when not specified.
func list_categories_basic(namespace_param: String, store_id: String = "") -> Dictionary:
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


## Retrieves a category by path
## GET /platform/admin/namespaces/{namespace}/categories/{categoryPath}
##
## Retrieves a category by its path.
##
## Parameters:
## - category_path: URL-encoded category path.
## - namespace_param: Game namespace
## - store_id: Store ID to query. Defaults to the published store ID when not specified.
func get_category(
	category_path: String, namespace_param: String, store_id: String = ""
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


## Updates a category
## PUT /platform/admin/namespaces/{namespace}/categories/{categoryPath}
##
## Updates a category's localized display names.
##
## Parameters:
## - category_path: URL-encoded category path.
## - namespace_param: Game namespace
## - store_id: Store ID to update in. Defaults to the published store ID when not specified.
func update_category(
	category_path: String, namespace_param: String, store_id: String, body: Dictionary = {}
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


## Deletes a category by path
## DELETE /platform/admin/namespaces/{namespace}/categories/{categoryPath}
##
## Deletes a category by its path.
##
## Parameters:
## - category_path: URL-encoded category path.
## - namespace_param: Game namespace
## - store_id: Store ID to delete from. Defaults to the published store ID when not specified.
func delete_category(
	category_path: String, namespace_param: String, store_id: String
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


## Retrieves child categories by parent path
## GET /platform/admin/namespaces/{namespace}/categories/{categoryPath}/children
##
## Retrieves direct child categories of the specified parent category path.
##
## Parameters:
## - category_path: URL-encoded parent category path.
## - namespace_param: Game namespace
## - store_id: Store ID to query. Defaults to the published store ID when not specified.
func get_child_categories(
	category_path: String, namespace_param: String, store_id: String = ""
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


## Retrieves all descendant categories by path
## GET /platform/admin/namespaces/{namespace}/categories/{categoryPath}/descendants
##
## Retrieves all descendant categories of the specified ancestor category path.
##
## Parameters:
## - category_path: URL-encoded ancestor category path.
## - namespace_param: Game namespace
## - store_id: Store ID to query. Defaults to the published store ID when not specified.
func get_descendant_categories(
	category_path: String, namespace_param: String, store_id: String = ""
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


## Queries campaign codes
## GET /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}
##
## Queries campaign codes with optional filters. Supports offset/limit pagination.
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
## - active_only: When true, returns only active (non-redeemed, non-disabled) codes.
## - batch_name: Filter by batch name.
## - batch_no: Batch numbers to filter by.
## - code: Filter by code value.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - with_batch_name: When true, includes the batch name in each code result.
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


## Creates campaign codes
## POST /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}
##
## Creates campaign codes in a new batch. The batch number increments automatically based on the last creation.
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
func create_codes(
	campaign_id: String, namespace_param: String, body: Dictionary = {}
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


## Downloads campaign codes as a CSV file
## GET /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/codes.csv
##
## Downloads all or a filtered batch of campaign codes as a CSV file.
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
## - batch_name: Filter by batch name.
## - batch_no: Filter by batch number.
## - with_batch_name: When true, includes batch names in the CSV output.
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


## Disables campaign codes in bulk
## PUT /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/disable/bulk
##
## Disables all campaign codes matching the filter except those already redeemed.
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
## - batch_name: Filter by batch name. Matches all batches when not specified.
## - batch_no: If not present will match all except 0
func bulk_disable_codes(
	campaign_id: String, namespace_param: String, batch_name: String = "", batch_no: Array = []
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


## Enables campaign codes in bulk
## PUT /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/enable/bulk
##
## Bulk enable campaign codes. Other detail info: Returns: the number of code actually enabled
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
## - batch_name: Filter by batch name. Matches all batches when not specified.
## - batch_no: If not present will match all except 0
func bulk_enable_codes(
	campaign_id: String, namespace_param: String, batch_name: String = "", batch_no: Array = []
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


## Queries campaign code redemption history
## GET /platform/admin/namespaces/{namespace}/codes/campaigns/{campaignId}/history
##
## Queries the redemption history for campaign codes with optional filters. Supports offset/limit pagination.
##
## Parameters:
## - campaign_id: Campaign ID.
## - namespace_param: Game namespace
## - code: Filter by code value.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - user_id: AccelByte user ID
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


## Retrieves campaign code information
## GET /platform/admin/namespaces/{namespace}/codes/{code}
##
## Get campaign code, it will check code whether available to redeem if redeemable true. Other detail info: Returns: code info
##
## Parameters:
## - code: Campaign code value.
## - namespace_param: Game namespace
## - redeemable: When true, checks whether the code is available to redeem.
## - with_batch_name: When true, includes the batch name in the response.
func get_code(
	code: String, namespace_param: String, redeemable: bool = false, with_batch_name: bool = false
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


## Disables a campaign code
## PUT /platform/admin/namespaces/{namespace}/codes/{code}/disable
##
## Disables an active code. The service rejects the request if a user already redeemed it.
##
## Parameters:
## - code: Campaign code value.
## - namespace_param: Game namespace
func disable_code(code: String, namespace_param: String) -> Dictionary:
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


## Enables a campaign code
## PUT /platform/admin/namespaces/{namespace}/codes/{code}/enable
##
## Enable code. Other detail info: Returns: enabled code
##
## Parameters:
## - code: Campaign code value.
## - namespace_param: Game namespace
func enable_code(code: String, namespace_param: String) -> Dictionary:
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


## Lists currencies
## GET /platform/admin/namespaces/{namespace}/currencies
##
## List currencies of a namespace. Other detail info: Returns: Currency List
##
## Parameters:
## - namespace_param: Game namespace
## - currency_type: Currency type to filter by. Valid values: REAL (real money), VIRTUAL (in-game currency).
func list_currencies(namespace_param: String, currency_type: String = "") -> Dictionary:
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


## Creates a currency
## POST /platform/admin/namespaces/{namespace}/currencies
##
## Create a currency. Other detail info: Returns: created currency
##
## Parameters:
## - namespace_param: Game namespace
func create_currency(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/currencies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates a currency
## PUT /platform/admin/namespaces/{namespace}/currencies/{currencyCode}
##
## Update a currency by currency code. Other detail info: Returns: updated currency
##
## Parameters:
## - currency_code: Currency code identifying the currency to update.
## - namespace_param: Game namespace
func update_currency(
	currency_code: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a currency
## DELETE /platform/admin/namespaces/{namespace}/currencies/{currencyCode}
##
## Deletes a currency by its currency code.
##
## Parameters:
## - currency_code: Currency code identifying the currency to delete.
## - namespace_param: Game namespace
func delete_currency(currency_code: String, namespace_param: String) -> Dictionary:
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


## Retrieves the configuration for a specific currency
## GET /platform/admin/namespaces/{namespace}/currencies/{currencyCode}/config
##
## [SERVICE COMMUNICATION ONLY] Get currency config by code. Other detail info: Returns: simplified Currency
##
## Parameters:
## - currency_code: Currency code identifying the currency whose configuration to retrieve.
## - namespace_param: Game namespace
func get_currency_config(currency_code: String, namespace_param: String) -> Dictionary:
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


## Retrieves a summary of a specific currency
## GET /platform/admin/namespaces/{namespace}/currencies/{currencyCode}/summary
##
## Get currency summary by code. Other detail info: Returns: simplified Currency
##
## Parameters:
## - currency_code: Currency code identifying the currency to summarise.
## - namespace_param: Game namespace
func get_currency_summary(currency_code: String, namespace_param: String) -> Dictionary:
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


## Retrieves the DLC item configuration history
## GET /platform/admin/namespaces/{namespace}/dlc/config/history
##
## Get DLC item config history.
##
## Parameters:
## - namespace_param: Game namespace
## - dlc_id: DLC item identifier to filter the configuration history.
func get_dlc_item_config_history(namespace_param: String, dlc_id: String) -> Dictionary:
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


## Restores a DLC item configuration from a historical snapshot
## POST /platform/admin/namespaces/{namespace}/dlc/config/history/{id}/restore
##
## Restore DLC item config history.
##
## Parameters:
## - id: Identifier of the historical configuration record to restore.
## - namespace_param: Game namespace
func restore_dlc_item_config_history(id: String, namespace_param: String) -> Dictionary:
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


## Retrieves the DLC item configuration
## GET /platform/admin/namespaces/{namespace}/dlc/config/item
##
## Get DLC item config.
##
## Parameters:
## - namespace_param: Game namespace
func get_dlc_item_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the DLC item configuration
## PUT /platform/admin/namespaces/{namespace}/dlc/config/item
##
## Update DLC item config. Other detail info: Returns: updated DLC item config
##
## Parameters:
## - namespace_param: Game namespace
func update_dlc_item_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes a DLC item configuration
## DELETE /platform/admin/namespaces/{namespace}/dlc/config/item
##
## Delete a DLC item config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_dlc_item_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the platform DLC configuration
## GET /platform/admin/namespaces/{namespace}/dlc/config/platformMap
##
## Get Platform DLC config.
##
## Parameters:
## - namespace_param: Game namespace
func get_platform_dlc_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/platformMap"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the platform DLC configuration
## PUT /platform/admin/namespaces/{namespace}/dlc/config/platformMap
##
## Updates the platform DLC configuration. Key names cannot contain "." (for example, data.2) or start with "$" (for example, $data).
##
## Parameters:
## - namespace_param: Game namespace
func update_platform_dlc_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/platformMap"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes a platform DLC configuration
## DELETE /platform/admin/namespaces/{namespace}/dlc/config/platformMap
##
## Delete a Platform DLC config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_platform_dlc_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/dlc/config/platformMap"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Queries entitlements across the namespace
## GET /platform/admin/namespaces/{namespace}/entitlements
##
## Lists entitlements across the namespace. Supports filtering by user, item, entitlement class, and origin. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active entitlements only when true.
## - app_type: Application type to filter entitlements by.
## - entitlement_clazz: Entitlement class to filter results by.
## - entitlement_name: Entitlement name to filter results by.
## - item_id: Item identifier to filter entitlements by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - origin: Platform origin to filter entitlements by.
## - user_id: AccelByte user ID
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


## Queries entitlements filtered by item identifiers
## GET /platform/admin/namespaces/{namespace}/entitlements/byItemIds
##
## Lists entitlements matching one or more item identifiers. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active entitlements only when true.
## - item_ids: Comma-separated list of item identifiers to filter by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Enables the entitlement origin tracking feature
## PUT /platform/admin/namespaces/{namespace}/entitlements/config/entitlementOrigin/enable
##
## Enable Entitlement origin feature. Other detail info: Returns: entitlement info
##
## Parameters:
## - namespace_param: Game namespace
func enable_entitlement_origin_feature(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/config/entitlementOrigin/enable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves entitlement configuration information
## GET /platform/admin/namespaces/{namespace}/entitlements/config/info
##
## Get entitlement config info. Other detail info: Returns: entitlement info
##
## Parameters:
## - namespace_param: Game namespace
## - without_cache: When true, bypasses the cache and fetches the latest configuration directly.
func get_entitlement_config_info(
	namespace_param: String, without_cache: bool = false
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


## Grants entitlements to multiple users in bulk
## POST /platform/admin/namespaces/{namespace}/entitlements/grant
##
## Grants entitlements to multiple users in a single request. Any skipped grant counts as a failure. Supports APP, INGAMEITEM, CODE, SUBSCRIPTION, MEDIA, OPTIONBOX, and LOOTBOX item types.
##
## Parameters:
## - namespace_param: Game namespace
func grant_entitlements(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/grant"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Revokes entitlements in bulk by their identifiers
## POST /platform/admin/namespaces/{namespace}/entitlements/revoke
##
## Revokes entitlements in bulk by their identifiers. Skipped revocations count as failures.
##
## Parameters:
## - namespace_param: Game namespace
func revoke_entitlements(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/entitlements/revoke"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves an entitlement by its identifier
## GET /platform/admin/namespaces/{namespace}/entitlements/{entitlementId}
##
## Get entitlement. Other detail info: Returns: entitlement
##
## Parameters:
## - entitlement_id: Entitlement identifier.
## - namespace_param: Game namespace
func get_entitlement(entitlement_id: String, namespace_param: String) -> Dictionary:
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


## Queries fulfillment histories in the namespace
## GET /platform/admin/namespaces/{namespace}/fulfillment/history
##
## Lists fulfillment histories for the namespace. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Fulfillment status to filter results by.
## - user_id: AccelByte user ID
func query_fulfillment_histories(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1, status: String = ""
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


## Queries IAP clawback history
## GET /platform/admin/namespaces/{namespace}/iap/clawback/histories
##
## Query clawback history. Other detail info: Returns: paginated clawback history
##
## Parameters:
## - namespace_param: Game namespace
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - event_type: IAP event type to filter clawback history by.
## - external_order_id: Third party order id
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - status: Clawback status to filter results by.
## - user_id: AccelByte user ID
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


## Simulates a PlayStation clawback event for testing
## POST /platform/admin/namespaces/{namespace}/iap/clawback/playstation/mock
##
## Mock Sync PlayStation Clawback event..
##
## Parameters:
## - namespace_param: Game namespace
func mock_play_station_stream_event(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/clawback/playstation/mock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Simulates an Xbox clawback event for testing
## POST /platform/admin/namespaces/{namespace}/iap/clawback/xbl/mock
##
## Mock Sync XBox Clawback event.
##
## Parameters:
## - namespace_param: Game namespace
func mock_xbl_clawback_event(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/clawback/xbl/mock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the Apple IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/apple
##
## Get apple iap config. Other detail info: Returns: apple iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_apple_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Apple IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/apple
##
## Update apple iap config. Other detail info: Returns: updated apple iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_apple_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Apple IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/apple
##
## Delete apple iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_apple_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Uploads an Apple Store p8 certificate file
## PUT /platform/admin/namespaces/{namespace}/iap/config/apple/cert
##
## Upload Apple Store p8 file. Other detail info: Returns: updated apple iap config
##
## Parameters:
## - namespace_param: Game namespace
## - file: The p8 certificate file to upload.
func update_apple_p8_file(namespace_param: String, file: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/apple/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves the Epic Games IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/epicgames
##
## Get epic games iap config. Other detail info: Returns: epic games iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_epic_games_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/epicgames"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Epic Games IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/epicgames
##
## Update epic games iap config. Other detail info: Returns: updated epic games iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_epic_games_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/epicgames"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Epic Games IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/epicgames
##
## Delete epic games iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_epic_games_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/epicgames"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the Google IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/google
##
## Get google iap config. Other detail info: Returns: google iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_google_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Google IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/google
##
## Update google iap config. Other detail info: Returns: updated google iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_google_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Google IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/google
##
## Delete google iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_google_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Uploads a Google Play p12 certificate file
## PUT /platform/admin/namespaces/{namespace}/iap/config/google/cert
##
## Upload google play p12 file. Other detail info: Returns: updated google iap config
##
## Parameters:
## - namespace_param: Game namespace
## - file: The p12 certificate file to upload.
func update_google_p12_file(namespace_param: String, file: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/google/cert"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves the IAP item configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/item
##
## Get iap item config.
##
## Parameters:
## - namespace_param: Game namespace
func get_iap_item_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the IAP item configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/item
##
## Update iap item config. Other detail info: Returns: updated iap item config
##
## Parameters:
## - namespace_param: Game namespace
func update_iap_item_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes an IAP item configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/item
##
## Delete a iap item config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_iap_item_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/item"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the Oculus IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/oculus
##
## Get oculus iap config. Other detail info: Returns: steam iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_oculus_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Oculus IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/oculus
##
## Update oculus iap config. Other detail info: Returns: updated steam iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_oculus_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Oculus IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/oculus
##
## Delete oculus iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_oculus_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists all Meta Quest subscription groups
## GET /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group
##
## List Meta Quest(Oculus) subscriptions group
##
## Parameters:
## - namespace_param: Game namespace
func list_oculus_subscription_groups(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a Meta Quest subscription group
## POST /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group
##
## Create subscriptions group
##
## Parameters:
## - namespace_param: Game namespace
func create_oculus_subscription_group(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes a Meta Quest subscription group
## DELETE /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group/{sku}
##
## Deletes a Meta Quest subscription group. The group must not be in use.
##
## Parameters:
## - namespace_param: Game namespace
## - sku: SKU identifier of the subscription group to delete.
func delete_oculus_subscription_group(namespace_param: String, sku: String) -> Dictionary:
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


## Lists all tiers for a Meta Quest subscription group
## GET /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/group/{sku}/tiers
##
## List All Tier of AGS Meta Quest(Oculus) subscriptions group
##
## Parameters:
## - namespace_param: Game namespace
## - sku: SKU identifier of the subscription group whose tiers to list.
func list_oculus_subscription_group_tier(namespace_param: String, sku: String) -> Dictionary:
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


## Creates a Meta Quest subscription tier
## POST /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/tier
##
## Create Meta Quest(Oculus) subscriptions tier
##
## Parameters:
## - namespace_param: Game namespace
func add_tier_into_meta_quest_subscription_group(
	namespace_param: String, body: Dictionary = {}
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


## Deletes a Meta Quest subscription tier
## DELETE /platform/admin/namespaces/{namespace}/iap/config/oculus/subscription/tier/{sku}
##
## Deletes a Meta Quest subscription tier by its SKU identifier.
##
## Parameters:
## - namespace_param: Game namespace
## - sku: SKU identifier of the subscription tier to delete.
func delete_oculus_subscription_tier(namespace_param: String, sku: String) -> Dictionary:
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


## Retrieves the PlayStation IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/playstation
##
## Get playstation iap config. Other detail info: Returns: playstation iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_play_station_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the PlayStation IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/playstation
##
## Update playstation iap config. Other detail info: Returns: updated playstation iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_playstation_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the PlayStation IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/playstation
##
## Delete playstation iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_playstation_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Validates the existing PlayStation IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/playstation/validate
##
## Validates the currently saved PlayStation IAP configuration and returns test results.
##
## Parameters:
## - namespace_param: Game namespace
func validate_existed_playstation_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Validates a PlayStation IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/playstation/validate
##
## Validates the provided PlayStation IAP configuration and returns test results.
##
## Parameters:
## - namespace_param: Game namespace
func validate_playstation_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/playstation/validate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves the Steam IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/steam
##
## Get steam iap config. Other detail info: Returns: steam iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_steam_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Steam IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/steam
##
## Update steam iap config. Other detail info: Returns: updated steam iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_steam_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Steam IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/steam
##
## Delete steam iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_steam_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/steam"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the Twitch IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/twitch
##
## Get twitch iap config. Other detail info: Returns: twitch iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_twitch_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/twitch"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Twitch IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/twitch
##
## Update twitch iap config. Other detail info: Returns: updated twitch iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_twitch_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/twitch"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Twitch IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/twitch
##
## Delete twitch iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_twitch_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/twitch"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the Xbox Live IAP configuration
## GET /platform/admin/namespaces/{namespace}/iap/config/xbl
##
## Get xbox iap config. Other detail info: Returns: xbox iap config
##
## Parameters:
## - namespace_param: Game namespace
func get_xbl_iap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Xbox Live IAP configuration
## PUT /platform/admin/namespaces/{namespace}/iap/config/xbl
##
## Update xbl iap config. Other detail info: Returns: updated xbl iap config
##
## Parameters:
## - namespace_param: Game namespace
func update_xbl_iap_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Xbox Live IAP configuration
## DELETE /platform/admin/namespaces/{namespace}/iap/config/xbl
##
## Delete xbl iap config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_xbl_ap_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/config/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Uploads an Xbox Live business partner certificate file
## PUT /platform/admin/namespaces/{namespace}/iap/config/xbl/cert
##
## Upload xbl business partner cert file. Other detail info: Returns: updated xbl iap config
##
## Parameters:
## - namespace_param: Game namespace
## - file: The business partner certificate file to upload.
## - password: Password for the certificate file.
func update_xbl_bp_cert_file(
	namespace_param: String, file: String = "", password: String = ""
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


## Queries third-party IAP notifications
## GET /platform/admin/namespaces/{namespace}/iap/notifications
##
## Lists third-party IAP platform notifications for the namespace. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - end_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z
## - external_id: External transaction identifier to filter notifications by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - source: Platform source to filter notifications by.
## - start_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z
## - status: Notification status to filter results by.
## - type_param: Notification type to filter results by.
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


## Queries Steam IAP transactions flagged as abnormal
## GET /platform/admin/namespaces/{namespace}/iap/steam/abnormal_transactions
##
## Lists Steam IAP transactions that Steam flagged as abnormal. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order_id: Steam order identifier to filter results by.
## - steam_id: Steam user identifier to filter results by.
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


## Retrieves Steam report job information
## GET /platform/admin/namespaces/{namespace}/iap/steam/job
##
## Query steam report info
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_steam_job_info(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/steam/job"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Resets the Steam report job to a specified time
## PUT /platform/admin/namespaces/{namespace}/iap/steam/job/reset
##
## Resets the Steam IAP report processing job to start from a specified timestamp.
##
## Parameters:
## - namespace_param: Game namespace
func admin_reset_steam_job_time(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/iap/steam/job/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Refunds a Steam IAP order
## PUT /platform/admin/namespaces/{namespace}/iap/steam/orders/{iapOrderNo}/refund
##
## Only support steam transaction mode
##
## Parameters:
## - iap_order_no: IAP order number to refund.
## - namespace_param: Game namespace
func admin_refund_iap_order(iap_order_no: String, namespace_param: String) -> Dictionary:
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


## Retrieves Steam IAP report processing histories
## GET /platform/admin/namespaces/{namespace}/iap/steam/report/histories
##
## Lists Steam IAP report processing histories, sorted by creation time. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order_id: Steam order identifier to filter results by.
## - process_status: Processing status to filter results by.
## - steam_id: Steam user identifier to filter results by.
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


## Queries IAP subscriptions
## GET /platform/admin/namespaces/{namespace}/iap/subscriptions
##
## Lists IAP subscriptions, sorted by last update time. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active subscriptions only when true.
## - group_id: If platform is Google, please pass google subscription product id. if platform is Apple, please pass apple subscription group id
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - platform: Platform to filter subscriptions by.
## - product_id: If platform is Google, please pass google subscription plan id. if platform is Apple, please pass apple subscription product id
## - user_id: AccelByte user ID
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


## Retrieves IAP order consumption details by order number
## GET /platform/admin/namespaces/{namespace}/iap/{iapOrderNo}/consumedetails
##
## Get IAP Order Consume Details by IAP Order Number.
##
## Parameters:
## - iap_order_no: IAP order number to retrieve consumption details for.
## - namespace_param: Game namespace
func get_iap_order_consume_details(iap_order_no: String, namespace_param: String) -> Dictionary:
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


## Downloads invoice details as a CSV file
## GET /platform/admin/namespaces/{namespace}/invoice/details.csv
##
## Download invoice details as a csv file. Other detail info: Returns: invoice details csv file
##
## Parameters:
## - namespace_param: Game namespace
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - feature: Feature to filter invoice details by.
## - item_id: Item identifier to filter invoice details by.
## - item_type: Item type to filter invoice details by.
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
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


## Generates an invoice summary
## GET /platform/admin/namespaces/{namespace}/invoice/summary
##
## Generate invoice summary. Other detail info: Returns: query orders
##
## Parameters:
## - namespace_param: Game namespace
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - feature: Feature to include in the summary.
## - item_id: Item identifier to filter the summary by.
## - item_type: Item type to filter the summary by.
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
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


## Syncs an in-game item
## PUT /platform/admin/namespaces/{namespace}/items
##
## [Not supported yet in AGS Shared Cloud] Syncs an in-game item from a game namespace to the publisher namespace. Supported item types: INGAMEITEM, CODE, COINS, and SEASON. The synced item carries a targetItemId field in addition to targetNamespace and should not be modified manually after syncing.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store to sync the item into. Defaults to the primary store if omitted.
func sync_in_game_item(
	namespace_param: String, store_id: String, body: Dictionary = {}
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


## Creates an item in the store
## POST /platform/admin/namespaces/{namespace}/items
##
## Creates an item in the specified store. APP items can only be created in the publisher namespace. Supported item types: APP, COINS, INGAMEITEM, CODE, BUNDLE, LOOT_BOX, OPTION_BOX, and EXTENSION. At least one region with pricing data is required. Key names in item extension, localization extension, and inventory config custom attributes cannot start with '$' or contain '.'.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store to create the item in. Defaults to the primary store if omitted.
func create_item(namespace_param: String, store_id: String, body: Dictionary = {}) -> Dictionary:
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


## Retrieves an item by its application identifier
## GET /platform/admin/namespaces/{namespace}/items/byAppId
##
## Retrieves the item associated with the specified application identifier.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - store_id: Store identifier to search in. Defaults to the published store.
## - app_id: Application identifier to look up.
func get_item_by_app_id(
	namespace_param: String, app_id: String, active_only: bool = false, store_id: String = ""
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


## Queries items by criteria within a store
## GET /platform/admin/namespaces/{namespace}/items/byCriteria
##
## Queries items by criteria within a store. Supports filtering by category, item type, features, tags, and region. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - app_type: Application type to filter items by.
## - available_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z , filter date include(purchaseAt, expireAt)
## - base_app_id: Base application identifier to filter items by.
## - category_path: Category path to filter items by.
## - features: Comma-separated list of features to filter items by.
## - include_sub_category_item: When true, includes items from sub-categories. Only available when filtering by category path. Defaults to false.
## - item_type: Item type to filter results by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - region: Exist in region
## - sort_by: Default is name:asc,displayOrder:asc, allow values: [name, name:asc, name:desc, createdAt, createdAt:asc, createdAt:desc, updatedAt, updatedAt:asc, updatedAt:desc, displayOrder, displayOrder:asc, displayOrder:desc],and support sort group, eg: sortBy=name:asc,createdAt:desc. Make sure to always use more than one sort if the first sort is not an unique valuefor example, if you wish to sort by displayOrder, make sure to include other sort such as name or createdAt after the first sort, eg: displayOrder:asc,name:asc
## - store_id: Store identifier to search in. Defaults to the published store.
## - tags: Comma-separated list of tags to filter items by.
## - target_namespace: Target namespace to cross-query items from.
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


## Lists basic items filtered by features
## GET /platform/admin/namespaces/{namespace}/items/byFeatures/basic
##
## [SERVICE COMMUNICATION ONLY] Lists basic items that match the specified features.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - features: Comma-separated list of features to filter items by.
func list_basic_items_by_features(
	namespace_param: String, active_only: bool = false, features: Array = []
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


## Retrieves items by their identifiers
## GET /platform/admin/namespaces/{namespace}/items/byIds
##
## Retrieves a list of items by their identifiers.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - store_id: Store identifier to search in. Defaults to the published store.
## - item_ids: Commas separated item ids
func get_items(
	namespace_param: String, item_ids: String, active_only: bool = false, store_id: String = ""
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


## Retrieves an item by its SKU
## GET /platform/admin/namespaces/{namespace}/items/bySku
##
## Retrieves the item with the specified SKU.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - store_id: Store identifier to search in. Defaults to the published store.
## - sku: Stock keeping unit to look up.
func get_item_by_sku(
	namespace_param: String, sku: String, active_only: bool = false, store_id: String = ""
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


## Retrieves an item by SKU with locale-specific content
## GET /platform/admin/namespaces/{namespace}/items/bySku/locale
##
## Retrieves an item by SKU with content localised to the specified language and region. Falls back to the default region if the item does not exist in the requested region.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - language: Language code for localised content, e.g. en, id.
## - populate_bundle: Whether populate bundled items if it's a bundle
## - region: Region code for locale-specific pricing, e.g. US, ID.
## - store_id: Store identifier to search in. Defaults to the published store.
## - sku: Stock keeping unit to look up.
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


## Retrieves estimated prices for flexible pricing bundle items
## GET /platform/admin/namespaces/{namespace}/items/estimatedPrice
##
## Retrieves estimated prices for items in a flexible pricing bundle, taking into account user-specific pricing and regional rates.
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Platform to apply platform-specific pricing for.
## - region: Region code to apply regional pricing for.
## - store_id: Use published store id by default
## - item_ids: Commas separated item ids
## - user_id: AccelByte user ID
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


## Retrieves an item identifier by SKU
## GET /platform/admin/namespaces/{namespace}/items/itemId/bySku
##
## [SERVICE COMMUNICATION ONLY] Retrieves the item ID for the item matching the specified SKU.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - store_id: Store identifier to search in. Defaults to the published store.
## - sku: Stock keeping unit to look up.
func get_item_id_by_sku(
	namespace_param: String, sku: String, active_only: bool = false, store_id: String = ""
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


## Retrieves item IDs for a list of SKUs within a store
## GET /platform/admin/namespaces/{namespace}/items/itemId/bySkus
##
## Retrieves a list of item identifiers for the provided SKUs.
##
## Parameters:
## - namespace_param: Game namespace
## - sku: Comma-separated list of SKUs to look up.
## - store_id: Store identifier to search in. Defaults to the published store.
func get_bulk_item_id_by_skus(
	namespace_param: String, sku: Array = [], store_id: String = ""
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


## Retrieves multiple items with localized content for a specific language and region
## GET /platform/admin/namespaces/{namespace}/items/locale/byIds
##
## Retrieves multiple items with content localized to the specified language and region. Falls back to the default region for items not offered in the requested region.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - language: Language code for localised content, e.g. en, id.
## - region: Region code for locale-specific pricing, e.g. US, ID.
## - store_id: Store identifier to search in. Defaults to the published store.
## - item_ids: Commas separated item ids
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


## Retrieves available predicate types for items
## GET /platform/admin/namespaces/{namespace}/items/predicate/types
##
## Get available predicate types. Other detail info: Returns: available predicate types
##
## Parameters:
## - namespace_param: Game namespace
func get_available_predicate_types(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/items/predicate/types"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Validates purchase conditions for a user
## POST /platform/admin/namespaces/{namespace}/items/purchase/conditions/validate
##
## Validates whether a user meets the purchase conditions for the specified items.
##
## Parameters:
## - namespace_param: Game namespace
## - platform: The platform to apply when evaluating purchase conditions.
## - user_id: AccelByte user ID
func validate_item_purchase_condition(
	namespace_param: String, user_id: String, platform: String = "", body: Dictionary = {}
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


## Updates region data for items in bulk
## PUT /platform/admin/namespaces/{namespace}/items/regiondata
##
## Updates region pricing and availability data for multiple items in a single request.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier where the items reside.
func bulk_update_region_data(
	namespace_param: String, store_id: String, body: Dictionary = {}
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


## Searches items by keyword
## GET /platform/admin/namespaces/{namespace}/items/search
##
## Searches items by keyword across title, description, and long description within a store. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - item_type: Item type to filter results by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Default is name:asc,createdAt:asc, allow values: [name, name:asc, name:desc, createdAt, createdAt:asc, createdAt:desc, updatedAt, updatedAt:asc, updatedAt:desc, displayOrder, displayOrder:asc, displayOrder:desc],and support sort group, eg: sortBy=name:asc,createdAt:desc. Make sure to always use more than one sort if the first sort is not an unique valuefor example, if you wish to sort by displayOrder, make sure to include other sort such as name or createdAt after the first sort, eg: displayOrder:asc,name:asc
## - store_id: Store identifier to search in. Defaults to the published store.
## - keyword: Keyword to search for in item titles, descriptions, and long descriptions.
## - language: Language code to search localised content in, e.g. en, id.
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


## Queries uncategorized items in a store
## GET /platform/admin/namespaces/{namespace}/items/uncategorized
##
## Lists items that have no category assignment within a store. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - active_only: Filters results to active items only when true.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Default is name:asc, allow values: [name, name:asc, name:desc, createdAt, createdAt:asc, createdAt:desc, updatedAt, updatedAt:asc, updatedAt:desc, displayOrder, displayOrder:asc, displayOrder:desc],and support sort group, eg: sortBy=name:asc,createdAt:desc Make sure to always use more than one sort if the first sort is not an unique valuefor example, if you wish to sort by displayOrder, make sure to include other sort such as name or createdAt after the first sort, eg: displayOrder:asc,name:asc
## - store_id: Store identifier to search in. Defaults to the published store.
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


## Retrieves an item by identifier
## GET /platform/admin/namespaces/{namespace}/items/{itemId}
##
## Retrieves a single item from the specified store.
##
## Parameters:
## - item_id: Item identifier to retrieve.
## - namespace_param: Game namespace
## - active_only: Filters results to return only active items when set to true.
## - store_id: Store identifier to query. Defaults to the published store.
func get_item(
	item_id: String, namespace_param: String, active_only: bool = false, store_id: String = ""
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


## Updates an item in the store
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}
##
## Updates item properties such as category, localizations, pricing, images, and availability. Submit only the fields to change.
##
## Parameters:
## - item_id: Item identifier to update.
## - namespace_param: Game namespace
## - store_id: Store identifier where the item resides. Defaults to the published store.
func update_item(
	item_id: String, namespace_param: String, store_id: String, body: Dictionary = {}
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


## Deletes an item permanently
## DELETE /platform/admin/namespaces/{namespace}/items/{itemId}
##
## Permanently deletes an item from the store. Set force to true to bypass safety checks.
##
## Parameters:
## - item_id: Item identifier to delete.
## - namespace_param: Game namespace
## - features_to_check: Default is empty list
## - force: Default is false
## - store_id: Store identifier where the item resides. Defaults to the published store.
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


## Acquires a published item and decrements its available sale count
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/acquire
##
## Acquires a published item that has a maxCount limit, decreasing the available sale count. For internal service use only.
##
## Parameters:
## - item_id: Store containing the item to acquire.
## - namespace_param: Game namespace
func acquire_item(item_id: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
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


## Retrieves app info for an item
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/app
##
## Retrieves the app information associated with the specified item.
##
## Parameters:
## - item_id: Item identifier to retrieve app info for.
## - namespace_param: Game namespace
## - active_only: Filters results to return only active items when set to true.
## - store_id: Store identifier to query. Defaults to the published store.
func get_app(
	item_id: String, namespace_param: String, active_only: bool = false, store_id: String = ""
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


## Updates app properties for an item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/app
##
## Updates app properties for the specified item, including developer info, platform availability, release date, and website URLs.
##
## Parameters:
## - item_id: Item identifier to update.
## - namespace_param: Game namespace
## - store_id: Store identifier where the item resides. Defaults to the published store.
func update_app(
	item_id: String, namespace_param: String, store_id: String, body: Dictionary = {}
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


## Disables an item in the store
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/disable
##
## Disable an item. Other detail info: Returns: updated item
##
## Parameters:
## - item_id: Item identifier to disable.
## - namespace_param: Game namespace
## - store_id: Store identifier where the item resides. Defaults to the published store.
func disable_item(
	item_id: String, namespace_param: String, store_id: String, body: Dictionary = {}
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


## Retrieves dynamic data for a published item
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/dynamic
##
## Get item dynamic data for published item. Other detail info: Returns: item dynamic data
##
## Parameters:
## - item_id: Item identifier to retrieve dynamic data for.
## - namespace_param: Game namespace
func get_item_dynamic_data(item_id: String, namespace_param: String) -> Dictionary:
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


## Enables an item in the store
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/enable
##
## Enable an item. Other detail info: Returns: updated item
##
## Parameters:
## - item_id: Item identifier to enable.
## - namespace_param: Game namespace
## - store_id: Store identifier where the item resides. Defaults to the published store.
func enable_item(item_id: String, namespace_param: String, store_id: String) -> Dictionary:
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


## Adds a feature tag to an item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/features/{feature}
##
## Add a feature to an item. Other detail info: Returns: updated item
##
## Parameters:
## - feature: Feature tag to add.
## - item_id: Item identifier to add the feature to.
## - namespace_param: Game namespace
## - store_id: Store identifier where the item resides. Defaults to the published store.
func feature_item(
	feature: String, item_id: String, namespace_param: String, store_id: String
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


## Removes a feature tag from an item
## DELETE /platform/admin/namespaces/{namespace}/items/{itemId}/features/{feature}
##
## Remove a feature from an item. Other detail info: Returns: updated item
##
## Parameters:
## - feature: Feature tag to remove.
## - item_id: Item identifier to remove the feature from.
## - namespace_param: Game namespace
## - store_id: Store identifier where the item resides. Defaults to the published store.
func defeature_item(
	feature: String, item_id: String, namespace_param: String, store_id: String
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


## Retrieves an item in the specified locale
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/locale
##
## Retrieves an item in the specified locale. Returns the default region item if the item does not exist in the requested region.
##
## Parameters:
## - item_id: Item identifier to retrieve.
## - namespace_param: Game namespace
## - active_only: Filters results to return only active items when set to true.
## - language: BCP 47 language code for localization (e.g., en, fr, de).
## - populate_bundle: Whether populate bundled items if it's a bundle
## - region: Region code for item localization (e.g., US, EU).
## - store_id: Store identifier to query. Defaults to the published store.
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


## Updates the purchase condition for an item
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/purchase/condition
##
## Updates the purchase eligibility condition for the specified item.
##
## Parameters:
## - item_id: Item identifier to update.
## - namespace_param: Game namespace
## - store_id: Store identifier where the item resides. Defaults to the published store.
func update_item_purchase_condition(
	item_id: String, namespace_param: String, store_id: String, body: Dictionary = {}
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


## Retrieves references for an item
## GET /platform/admin/namespaces/{namespace}/items/{itemId}/references
##
## Retrieves all references to the specified item across the store.
##
## Parameters:
## - item_id: Item identifier to retrieve references for.
## - namespace_param: Game namespace
## - features_to_check: Default is empty list
## - store_id: Use published store id by default
func query_item_references(
	item_id: String, namespace_param: String, features_to_check: Array = [], store_id: String = ""
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


## Returns a purchased item and increments its available sale count
## PUT /platform/admin/namespaces/{namespace}/items/{itemId}/return
##
## Returns a published item that has a maxCount limit, increasing the available sale count. For internal service use only.
##
## Parameters:
## - item_id: Item identifier to return.
## - namespace_param: Game namespace
func return_item(item_id: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
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


## Queries key groups by name or tag
## GET /platform/admin/namespaces/{namespace}/keygroups
##
## Queries key groups in the namespace. Filters by name (fuzzy match) or tag. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Name filter for fuzzy match search.
## - offset: Number of results to skip for pagination
## - tag: Tag filter for key group search.
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


## Creates a key group
## POST /platform/admin/namespaces/{namespace}/keygroups
##
## Create key group. Other detail info: Returns: created key group
##
## Parameters:
## - namespace_param: Game namespace
func create_key_group(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/keygroups"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a key group by identifier
## GET /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}
##
## Get key group. Other detail info: Returns: key group info
##
## Parameters:
## - key_group_id: Key group identifier to retrieve.
## - namespace_param: Game namespace
func get_key_group(key_group_id: String, namespace_param: String) -> Dictionary:
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


## Updates a key group
## PUT /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}
##
## Update key group. Other detail info: Returns: updated key group
##
## Parameters:
## - key_group_id: Key group identifier to update.
## - namespace_param: Game namespace
func update_key_group(
	key_group_id: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves dynamic data for a key group
## GET /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/dynamic
##
## Get key group dynamic. Other detail info: Returns: key group info
##
## Parameters:
## - key_group_id: Key group identifier to retrieve dynamic data for.
## - namespace_param: Game namespace
func get_key_group_dynamic(key_group_id: String, namespace_param: String) -> Dictionary:
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


## Lists keys in a key group
## GET /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/keys
##
## Lists keys in the key group. Returns paginated results using offset and limit.
##
## Parameters:
## - key_group_id: Key group identifier to list keys for.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Key status filter (e.g., ACTIVE, ACQUIRED).
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


## Uploads keys from a CSV file to a key group
## POST /platform/admin/namespaces/{namespace}/keygroups/{keyGroupId}/keys
##
## Uploads keys in CSV format to the specified key group.
##
## Parameters:
## - key_group_id: Key group identifier to upload keys to.
## - namespace_param: Game namespace
## - file: CSV file containing keys to upload.
func upload_keys(key_group_id: String, namespace_param: String, file: String = "") -> Dictionary:
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


## Queries orders in a namespace
## GET /platform/admin/namespaces/{namespace}/orders
##
## Queries orders in the namespace. Filters by status, order numbers, and time range. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order_nos: Comma-separated list of order numbers to filter by.
## - sort_by: Default is createdTime:desc, support sort group, e.g. sortBy=status:asc,createdTime:desc
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - status: Order status filter (e.g., INIT, CHARGED, FULFILLED, REFUNDED).
## - with_total: Return total in slice result when true
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


## Retrieves order statistics for a namespace
## GET /platform/admin/namespaces/{namespace}/orders/stats
##
## Get Order Statistics. Other detail info: Returns: order statistics
##
## Parameters:
## - namespace_param: Game namespace
func get_order_statistics(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/orders/stats"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves an order by order number
## GET /platform/admin/namespaces/{namespace}/orders/{orderNo}
##
## Get order by orderNo. Other detail info: Returns: order instance
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number to retrieve.
func get_order(namespace_param: String, order_no: String) -> Dictionary:
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


## Refunds an order
## PUT /platform/admin/namespaces/{namespace}/orders/{orderNo}/refund
##
## Refund order by orderNo.
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number to refund.
func refund_order(namespace_param: String, order_no: String, body: Dictionary = {}) -> Dictionary:
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


## Retrieves the payment domain whitelist config for a namespace
## GET /platform/admin/namespaces/{namespace}/payment/config/domains
##
## [Not supported yet in AGS Shared Cloud] Get payment domain whitelist config by namespace. Other detail info: Returns: payment domain whitelist config info
##
## Parameters:
## - namespace_param: Game namespace
func get_payment_merchant_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/payment/config/domains"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the payment domain whitelist config for a namespace
## PUT /platform/admin/namespaces/{namespace}/payment/config/domains
##
## [Not supported yet in AGS Shared Cloud] Updates the payment domain whitelist for a namespace. Domains must include the protocol (http/https), but validation checks only the host portion of the URL.
##
## Parameters:
## - namespace_param: Game namespace
func update_payment_domain_whitelist_config(
	namespace_param: String, body: Dictionary = {}
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


## Queries payment notifications
## GET /platform/admin/namespaces/{namespace}/payment/notifications
##
## Queries payment notifications in the namespace. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - end_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z
## - external_id: External order ID to filter by.
## - limit: Number of results to return
## - notification_source: Payment notification source filter.
## - notification_type: Payment notification type filter.
## - offset: Number of results to skip for pagination
## - payment_order_no: Payment order number to filter by.
## - start_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z
## - status: Notification status filter.
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


## Queries payment orders
## GET /platform/admin/namespaces/{namespace}/payment/orders
##
## Queries payment orders in the namespace. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - channel: Payment channel filter.
## - ext_tx_id: External transaction ID to filter by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Payment order status filter.
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


## Creates a payment order from a non-Justice service
## POST /platform/admin/namespaces/{namespace}/payment/orders
##
## Creates a payment order from a non-Justice service such as a dedicated server. Returns the payment station URL. Intended for internal service communication only.
##
## Parameters:
## - namespace_param: Game namespace
func create_payment_order_by_dedicated(
	namespace_param: String, body: Dictionary = {}
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


## Lists payment order numbers by external transaction ID
## GET /platform/admin/namespaces/{namespace}/payment/orders/byExtTxId
##
## [Not supported yet in AGS Shared Cloud] List external order No by external transaction id. Other detail info: Returns: payment orders
##
## Parameters:
## - namespace_param: Game namespace
## - ext_tx_id: External transaction ID to query payment orders by.
func list_ext_order_no_by_ext_tx_id(namespace_param: String, ext_tx_id: String) -> Dictionary:
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


## Retrieves a payment order by order number
## GET /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}
##
## [Not supported yet in AGS Shared Cloud] Get payment order by paymentOrderNo. Other detail info: Returns: payment order instance
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to retrieve.
func get_payment_order(namespace_param: String, payment_order_no: String) -> Dictionary:
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


## Charges a payment order directly without the payment flow
## PUT /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}
##
## Charges an unpaid payment order directly, bypassing the payment flow. For test use only; forbidden in live environments.
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to charge.
func charge_payment_order(
	namespace_param: String, payment_order_no: String, body: Dictionary = {}
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


## Refunds a payment order from a non-Justice service
## PUT /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/refund
##
## Refunds a payment order from a non-Justice service such as a dedicated server. REFUNDED status means the order is already refunded (wallet payments); REFUNDING status means a webhook notification fires once the refund completes (real currency). For internal service use only.
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to refund.
func refund_payment_order_by_dedicated(
	namespace_param: String, payment_order_no: String, body: Dictionary = {}
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


## Simulates a payment notification for a sandbox order
## PUT /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/simulate-notification
##
## Simulates a payment notification on a sandbox payment order for testing purposes. Forbidden in live environments.
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to simulate the notification for.
func simulate_payment_order_notification(
	namespace_param: String, payment_order_no: String, body: Dictionary = {}
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


## Retrieves the charge status of a payment order
## GET /platform/admin/namespaces/{namespace}/payment/orders/{paymentOrderNo}/status
##
## [Not supported yet in AGS Shared Cloud] Get payment order charge status. Other detail info: Returns: payment order charge status
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to check.
func get_payment_order_charge_status(
	namespace_param: String, payment_order_no: String
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


## Checks PSN entitlement ownership by entitlement label
## POST /platform/admin/namespaces/{namespace}/platforms/psn/entitlements/{entitlementLabel}/ownership
##
## Get user psn entitlement ownership by entitlement label.
##
## Parameters:
## - entitlement_label: PSN entitlement label to check ownership for.
## - namespace_param: Game namespace
func get_psn_entitlement_ownership(
	entitlement_label: String, namespace_param: String, body: Dictionary = {}
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


## Checks Xbox entitlement ownership by product SKU
## POST /platform/admin/namespaces/{namespace}/platforms/xbl/entitlements/{productSku}/ownership
##
## Get Xbox entitlement ownership by product sku.
##
## Parameters:
## - namespace_param: Game namespace
## - product_sku: Xbox product SKU to check ownership for.
func get_xbox_entitlement_ownership(
	namespace_param: String, product_sku: String, body: Dictionary = {}
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


## Retrieves the platform entitlement config list
## GET /platform/admin/namespaces/{namespace}/platforms/{platform}/entitlement/config
##
## Get platform entitlement config list. Other detail info: Returns: entitlement info
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Platform identifier (e.g., Steam, PlayStation, Xbox).
func get_platform_entitlement_config(namespace_param: String, platform: String) -> Dictionary:
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


## Updates the platform entitlement config
## PUT /platform/admin/namespaces/{namespace}/platforms/{platform}/entitlement/config
##
## Update platform entitlement config. Other detail info: Returns: platform entitlement config
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Platform identifier to update the config for.
func update_platform_entitlement_config(
	namespace_param: String, platform: String, body: Dictionary = {}
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


## Retrieves the platform wallet config list
## GET /platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config
##
## Get platform wallet config list. Other detail info: Returns: wallet info
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Platform identifier.
func get_platform_wallet_config(namespace_param: String, platform: String) -> Dictionary:
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


## Updates the platform wallet config
## PUT /platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config
##
## Update platform wallet config. Other detail info: Returns: platform wallet config
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Platform identifier to update the config for.
func update_platform_wallet_config(
	namespace_param: String, platform: String, body: Dictionary = {}
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


## Resets the platform wallet config to defaults
## PUT /platform/admin/namespaces/{namespace}/platforms/{platform}/wallet/config/reset
##
## Reset platform wallet config to default config. Other detail info: Returns: platform wallet config
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Platform identifier to reset the config for.
func reset_platform_wallet_config(namespace_param: String, platform: String) -> Dictionary:
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


## Retrieves the revocation configuration for a namespace
## GET /platform/admin/namespaces/{namespace}/revocation/config
##
## Get revocation configuration. Other detail info: Returns: Revocation config
##
## Parameters:
## - namespace_param: Game namespace
func get_revocation_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the revocation configuration for a namespace
## PUT /platform/admin/namespaces/{namespace}/revocation/config
##
## Update revocation configuration. Other detail info: Returns: Revocation config
##
## Parameters:
## - namespace_param: Game namespace
func update_revocation_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the revocation config for a namespace
## DELETE /platform/admin/namespaces/{namespace}/revocation/config
##
## Delete revocation config.
##
## Parameters:
## - namespace_param: Game namespace
func delete_revocation_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Queries revocation histories in a namespace
## GET /platform/admin/namespaces/{namespace}/revocation/history
##
## Queries revocation histories in the namespace. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZ
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - source: Revocation source filter.
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZ
## - status: Revocation status filter.
## - transaction_id: Transaction ID to filter by.
## - user_id: AccelByte user ID
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


## Retrieves the revocation plugin config
## GET /platform/admin/namespaces/{namespace}/revocation/plugins/revocation
##
## Get revocation plugin config.
##
## Parameters:
## - namespace_param: Game namespace
func get_revocation_plugin_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/plugins/revocation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the revocation plugin config
## PUT /platform/admin/namespaces/{namespace}/revocation/plugins/revocation
##
## Update revocation plugin config. Other detail info: Returns: updated service plugin config
##
## Parameters:
## - namespace_param: Game namespace
func update_revocation_plugin_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/revocation/plugins/revocation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the revocation plugin config
## DELETE /platform/admin/namespaces/{namespace}/revocation/plugins/revocation
##
## Deletes the revocation plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func delete_revocation_plugin_config(namespace_param: String) -> Dictionary:
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
##
## Upload revocation plugin custom config tls cert.Other detail info:
##
## * Returns : updated service plugin config
func upload_revocation_plugin_config_cert_v2(
	namespace_param: String, file: String = ""
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


## Creates a reward
## POST /platform/admin/namespaces/{namespace}/rewards
##
## Creates a reward with the specified code, conditions, and reward items. Acceptable values for rewardItem identityType are ITEM_ID and ITEM_SKU.
##
## Parameters:
## - namespace_param: Game namespace
func create_reward(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Queries rewards by criteria
## GET /platform/admin/namespaces/{namespace}/rewards/byCriteria
##
## Queries rewards in the namespace by event topic. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - event_topic: Event topic to filter rewards by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Default is namespace:asc,rewardCode:asc, allow values: [namespace, namespace:asc, namespace:desc, rewardCode, rewardCode:asc, rewardCode:desc, createdAt:asc, createdAt:desc],and support sort group, eg: sortBy=namespace:asc,rewardCode:asc
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


## Exports all reward configurations for a namespace
## GET /platform/admin/namespaces/{namespace}/rewards/export
##
## Exports reward configurations for the namespace into a JSON file.
##
## Parameters:
## - namespace_param: Game namespace
func export_rewards(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/rewards/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Imports reward configurations for a namespace
## POST /platform/admin/namespaces/{namespace}/rewards/import
##
## Imports reward configurations for the namespace from a JSON file. Set replaceExisting to true to overwrite rewards with matching codes.
##
## Parameters:
## - namespace_param: Game namespace
## - replace_existing: Whether to overwrite existing rewards with matching codes.
## - file: JSON file containing reward configurations to import.
func import_rewards(
	namespace_param: String, replace_existing: bool, file: String = ""
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


## Retrieves a reward by identifier
## GET /platform/admin/namespaces/{namespace}/rewards/{rewardId}
##
## Retrieves a reward by its identifier.
##
## Parameters:
## - namespace_param: Game namespace
## - reward_id: Reward identifier to retrieve.
func get_reward(namespace_param: String, reward_id: String) -> Dictionary:
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


## Updates a reward
## PUT /platform/admin/namespaces/{namespace}/rewards/{rewardId}
##
## Updates reward properties including conditions and reward items. Acceptable values for rewardItem identityType are ITEM_ID and ITEM_SKU.
##
## Parameters:
## - namespace_param: Game namespace
## - reward_id: Reward identifier to update.
func update_reward(namespace_param: String, reward_id: String, body: Dictionary = {}) -> Dictionary:
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


## Deletes a reward permanently
## DELETE /platform/admin/namespaces/{namespace}/rewards/{rewardId}
##
## Deletes the specified reward permanently.
##
## Parameters:
## - namespace_param: Game namespace
## - reward_id: Reward identifier to delete.
func delete_reward(namespace_param: String, reward_id: String) -> Dictionary:
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


## Checks if an event matches a reward condition
## PUT /platform/admin/namespaces/{namespace}/rewards/{rewardId}/match
##
## [TEST FACILITY ONLY] Forbidden in live environment. Other detail info: Returns: match result
##
## Parameters:
## - namespace_param: Game namespace
## - reward_id: Reward identifier to check the condition for.
func check_event_condition(
	namespace_param: String, reward_id: String, body: Dictionary = {}
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


## Deletes a reward condition record
## DELETE /platform/admin/namespaces/{namespace}/rewards/{rewardId}/record
##
## Deletes a reward condition record by reward ID and optional condition name. For test use only; forbidden in live environments.
##
## Parameters:
## - namespace_param: Game namespace
## - reward_id: Reward identifier.
func delete_reward_condition_record(
	namespace_param: String, reward_id: String, body: Dictionary = {}
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


## Lists sections in a namespace
## GET /platform/admin/namespaces/{namespace}/sections
##
## Lists sections in the namespace. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - end: Section active range time end, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - start: Section active range time start , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - store_id: Store identifier to query. Defaults to the published store.
## - view_id: View identifier to filter sections by.
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


## Creates a section
## POST /platform/admin/namespaces/{namespace}/sections
##
## Creates a section in the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store to create the section in. Defaults to the published store.
func create_section(namespace_param: String, store_id: String, body: Dictionary = {}) -> Dictionary:
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


## Purges expired sections from a store
## DELETE /platform/admin/namespaces/{namespace}/sections/purge/expired
##
## Purges all expired sections from the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to purge expired sections from.
func purge_expired_section(namespace_param: String, store_id: String) -> Dictionary:
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


## Retrieves a section by identifier
## GET /platform/admin/namespaces/{namespace}/sections/{sectionId}
##
## Retrieves a section from the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - section_id: Section identifier to retrieve.
## - store_id: Store identifier to query. Defaults to the published store.
func get_section(namespace_param: String, section_id: String, store_id: String = "") -> Dictionary:
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


## Updates a section
## PUT /platform/admin/namespaces/{namespace}/sections/{sectionId}
##
## Updates a section in the specified store. Extension and localization keys cannot use '.' in their name or '$' as a prefix.
##
## Parameters:
## - namespace_param: Game namespace
## - section_id: Section identifier to update.
## - store_id: Store identifier where the section resides.
func update_section(
	namespace_param: String, section_id: String, store_id: String, body: Dictionary = {}
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


## Deletes a section permanently
## DELETE /platform/admin/namespaces/{namespace}/sections/{sectionId}
##
## Deletes the specified section permanently.
##
## Parameters:
## - namespace_param: Game namespace
## - section_id: Section identifier to delete.
## - store_id: Store identifier where the section resides.
func delete_section(namespace_param: String, section_id: String, store_id: String) -> Dictionary:
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


## Lists stores in a namespace
## GET /platform/admin/namespaces/{namespace}/stores
##
## Lists all stores available in the specified namespace.
##
## Parameters:
## - namespace_param: Game namespace
func list_stores(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a store
## POST /platform/admin/namespaces/{namespace}/stores
##
## Creates a new unpublished store in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func create_store(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the catalog definition
## GET /platform/admin/namespaces/{namespace}/stores/catalogDefinition
##
## Retrieves the catalog definition used for importing and exporting store data by CSV.
##
## Parameters:
## - namespace_param: Game namespace
## - catalog_type: Catalog type to retrieve the definition for.
func get_catalog_definition(namespace_param: String, catalog_type: String) -> Dictionary:
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


## Downloads CSV templates for store import
## GET /platform/admin/namespaces/{namespace}/stores/downloadCSVTemplates
##
## Downloads CSV templates used for importing store data.
##
## Parameters:
## - namespace_param: Game namespace
func download_csv_templates(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/downloadCSVTemplates"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Exports a store to CSV format
## POST /platform/admin/namespaces/{namespace}/stores/exportByCSV
##
## Exports store catalog data to CSV format.
##
## Parameters:
## - namespace_param: Game namespace
func export_store_by_csv(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/exportByCSV"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the published store
## GET /platform/admin/namespaces/{namespace}/stores/published
##
## Retrieves basic information for the published store, excluding category and item details.
##
## Parameters:
## - namespace_param: Game namespace
func get_published_store(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes the published store
## DELETE /platform/admin/namespaces/{namespace}/stores/published
##
## Deletes the published store, including all categories and items. Do not call this operation after the store launches publicly.
##
## Parameters:
## - namespace_param: Game namespace
func delete_published_store(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the published store's backup
## GET /platform/admin/namespaces/{namespace}/stores/published/backup
##
## Retrieves the backup snapshot for the published store.
##
## Parameters:
## - namespace_param: Game namespace
func get_published_store_backup(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published/backup"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Rolls back the published store
## PUT /platform/admin/namespaces/{namespace}/stores/published/rollback
##
## Rolls back the published store to its previous backup state.
##
## Parameters:
## - namespace_param: Game namespace
func rollback_published_store(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/stores/published/rollback"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves a store
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}
##
## Retrieves data for the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to retrieve.
func get_store(namespace_param: String, store_id: String) -> Dictionary:
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


## Updates a store
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}
##
## Updates basic information for the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to update.
func update_store(namespace_param: String, store_id: String, body: Dictionary = {}) -> Dictionary:
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


## Deletes a store
## DELETE /platform/admin/namespaces/{namespace}/stores/{storeId}
##
## Deletes a store. Unpublish the store before deleting it.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to delete.
func delete_store(namespace_param: String, store_id: String) -> Dictionary:
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


## Queries catalog changes
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/byCriteria
##
## Queries catalog changes by criteria with pagination support.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to query.
## - action: Action type filter.
## - item_sku: Item SKU filter.
## - item_type: Item type filter.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - selected: When true, returns only selected changes.
## - sort_by: Default is updatedAt:desc, allow values: [createdAt, createdAt:asc, createdAt:desc, updatedAt, updatedAt:asc, updatedAt:desc],and support sort group, eg: sortBy=title:asc,createdAt:desc. Make sure to always use more than one sort if the first sort is not an unique valuefor example, if you wish to sort by title, make sure to include other sort such as sku or createdAt after the first sort, eg: title:asc,updatedAt:desc
## - status: Change status filter. Defaults to UNPUBLISHED.
## - type_param: Change type filter.
## - updated_at_end: Updated at end , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - updated_at_start: Updated at start , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - with_total: When true, includes the total count of catalog changes in the response.
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


## Publishes all unpublished changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/publishAll
##
## Publishes all unpublished catalog changes for the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier whose changes to publish.
func publish_all(namespace_param: String, store_id: String) -> Dictionary:
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


## Publishes selected unpublished changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/publishSelected
##
## Publishes only the selected unpublished catalog changes.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier whose selected changes to publish.
func publish_selected(namespace_param: String, store_id: String) -> Dictionary:
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


## Selects all catalog changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/selectAll
##
## Select all changes.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier whose changes to select.
func select_all_records(namespace_param: String, store_id: String) -> Dictionary:
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


## Selects all catalog changes matching criteria
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/selectAllByCriteria
##
## Select all changes by criteria
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier whose changes to select.
## - action: Action type filter.
## - item_sku: Item SKU filter.
## - item_type: Item type filter.
## - selected: When true, returns only selected changes.
## - type_param: Change type filter.
## - updated_at_end: Updated at end , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - updated_at_start: Updated at start , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
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


## Retrieves catalog changes statistics
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/statistics
##
## Retrieves statistics for catalog changes matching the specified criteria.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to query statistics for.
## - action: Action type filter.
## - item_sku: Item SKU filter.
## - item_type: Item type filter.
## - type_param: Change type filter.
## - updated_at_end: Updated at end , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - updated_at_start: Updated at start , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
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


## Unselects all catalog changes
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/unselectAll
##
## Unselect all change.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier whose changes to unselect.
func unselect_all_records(namespace_param: String, store_id: String) -> Dictionary:
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


## Selects a catalog change for partial publish
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/{changeId}/select
##
## Selects a catalog change to include it in the next partial publish.
##
## Parameters:
## - change_id: Change identifier to select.
## - namespace_param: Game namespace
## - store_id: Store identifier containing the change.
func select_record(change_id: String, namespace_param: String, store_id: String) -> Dictionary:
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


## Unselects a catalog change
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/catalogChanges/{changeId}/unselect
##
## Unselects a catalog change, excluding it from the next partial publish.
##
## Parameters:
## - change_id: Change identifier to unselect.
## - namespace_param: Game namespace
## - store_id: Store identifier containing the change.
func unselect_record(change_id: String, namespace_param: String, store_id: String) -> Dictionary:
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


## Clones a store
## PUT /platform/admin/namespaces/{namespace}/stores/{storeId}/clone
##
## Clones a store, typically to copy draft changes into the published store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to clone from.
## - target_store_id: Store identifier to clone into. Defaults to the published store.
func clone_store(
	namespace_param: String, store_id: String, target_store_id: String = ""
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


## Queries store import history
## GET /platform/admin/namespaces/{namespace}/stores/{storeId}/import/history
##
## Queries the import history for the specified store. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to query import history for.
## - end: End of the date range filter (ISO 8601 timestamp).
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Default createdAt:desc. Allowed values: [createdAt:asc, createdAt:desc]
## - start: Start of the date range filter (ISO 8601 timestamp).
## - success: When true, returns only successful imports.
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


## Imports a store from CSV format
## POST /platform/admin/namespaces/{namespace}/stores/{storeId}/importByCSV
##
## Imports store data from a CSV file. The import must include at least one of: item, section, display, or category.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store identifier to import into.
## - category: Include category data from the CSV file.
## - display: Include display data from the CSV file.
## - item: Include item data from the CSV file.
## - notes: Notes for this import operation.
## - section: Include section data from the CSV file.
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


## Queries subscriptions
## GET /platform/admin/namespaces/{namespace}/subscriptions
##
## Query subscriptions. Other detail info: Returns: paginated subscriptions
##
## Parameters:
## - namespace_param: Game namespace
## - charge_status: Subscription charge status filter.
## - item_id: Item identifier filter.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sku: Item SKU filter.
## - status: Subscription status filter.
## - subscribed_by: Filter by who initiated the subscription.
## - user_id: AccelByte user ID
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


## Triggers a recurring charge for a subscription
## PUT /platform/admin/namespaces/{namespace}/subscriptions/{subscriptionId}/recurring
##
## [TEST FACILITY ONLY] Forbidden in live environment. Recurring charge subscription, it will trigger recurring charge if the USER subscription status is ACTIVE, nextBillingDate is before now and no fail recurring charge within X(default 12) hours. Other detail info: Returns: recurring charge result
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription identifier to charge.
func recurring_charge_subscription(namespace_param: String, subscription_id: String) -> Dictionary:
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


## Retrieves ticket dynamic data
## GET /platform/admin/namespaces/{namespace}/tickets/{boothName}
##
## [SERVICE COMMUNICATION ONLY] Get ticket(code/key) dynamic based on booth name. Other detail info: Returns: ticket dynamic
##
## Parameters:
## - booth_name: Booth name to retrieve ticket dynamic data for.
## - namespace_param: Game namespace
func get_ticket_dynamic(booth_name: String, namespace_param: String) -> Dictionary:
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


## Decrements ticket sale count
## PUT /platform/admin/namespaces/{namespace}/tickets/{boothName}/decrement
##
## [SERVICE COMMUNICATION ONLY] Decrease ticket(code/key) sale if requested orderNo is already increased.
##
## Parameters:
## - booth_name: Booth name whose ticket sale to decrement.
## - namespace_param: Game namespace
func decrease_ticket_sale(
	booth_name: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves the ticket booth ID
## GET /platform/admin/namespaces/{namespace}/tickets/{boothName}/id
##
## Get ticket(code/key) booth ID. Other detail info: Returns: ticket booth id
##
## Parameters:
## - booth_name: Booth name to retrieve the identifier for.
## - namespace_param: Game namespace
func get_ticket_booth_id(booth_name: String, namespace_param: String) -> Dictionary:
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


## Increments ticket sale count
## PUT /platform/admin/namespaces/{namespace}/tickets/{boothName}/increment
##
## [SERVICE COMMUNICATION ONLY] increase ticket(code/key) sale. Other detail info: Returns: Ticket sale increment result
##
## Parameters:
## - booth_name: Booth name whose ticket sale to increment.
## - namespace_param: Game namespace
func increase_ticket_sale(
	booth_name: String, namespace_param: String, body: Dictionary = {}
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


## Commits a chain of trade operations
## POST /platform/admin/namespaces/{namespace}/trade/commit
##
## Commits a chain of trade operations atomically. Supports FULFILL_ITEM actions.
##
## Parameters:
## - namespace_param: Game namespace
func commit(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/trade/commit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves trade history by criteria
## GET /platform/admin/namespaces/{namespace}/trade/history/byCriteria
##
## Retrieves trade history based on the provided criteria. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Status of the trade (SUCCESS/FAIL)
## - type_param: Trade type filter.
## - user_id: AccelByte user ID
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


## Retrieves trade history by transaction ID
## GET /platform/admin/namespaces/{namespace}/trade/{transactionId}
##
## Retrieves the trade history entry for the specified transaction.
##
## Parameters:
## - namespace_param: Game namespace
## - transaction_id: Transaction ID to query the trade history
func get_trade_history_by_transaction_id(
	namespace_param: String, transaction_id: String
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


## Unlocks a Steam achievement for a user
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/achievement/steam
##
## Unlocks a Steam achievement for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func unlock_steam_user_achievement(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves Xbox Live achievements for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/achievement/xbl
##
## Retrieves Xbox Live achievements for the specified user. For test use only.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - xbox_user_id: Xbox Live user identifier.
func get_xbl_user_achievements(
	namespace_param: String, user_id: String, xbox_user_id: String
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


## Updates Xbox Live achievements for a user
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/achievement/xbl
##
## Updates Xbox Live achievements for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_xbl_user_achievement(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Anonymizes campaign data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/campaign
##
## Anonymize campaign. At current it will only anonymize redeem history.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_campaign(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes entitlement data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/entitlements
##
## Anonymize entitlement. At current it will only anonymize entitlement, entitlement history.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_entitlement(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes fulfillment data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/fulfillment
##
## Anonymize fulfillment. At current it will only anonymize fulfillment history.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_fulfillment(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes integration data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/integrations
##
## Anonymize integrations. At current it will only anonymize iap histories.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_integration(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes order data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/orders
##
## Anonymize order. At current it will only anonymize order, order history.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_order(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes payment data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/payment
##
## Anonymize payment. At current it will only anonymize payment order, payment order history.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_payment(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes revocation data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/revocation
##
## Anonymize revocation. At current it will only anonymize revocation history.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_revocation(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes subscription data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/subscriptions
##
## Anonymize subscription. At current it will anonymize subscription, billing history and subscription activity.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_subscription(namespace_param: String, user_id: String) -> Dictionary:
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


## Anonymizes wallet data for a user
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/anonymization/wallets
##
## Anonymize wallet. At current it will only anonymize wallet, wallet transaction.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func anonymize_wallet(namespace_param: String, user_id: String) -> Dictionary:
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


## Retrieves user DLC by platform
## GET /platform/admin/namespaces/{namespace}/users/{userId}/dlc
##
## Get user dlc by platform. Other detail info: Returns: user dlc
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - type_param: Platform type to filter DLC by.
func get_user_dlc_by_platform(
	namespace_param: String, user_id: String, type_param: String
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


## Retrieves user DLC records
## GET /platform/admin/namespaces/{namespace}/users/{userId}/dlc/records
##
## Retrieves DLC records for a user. When includeAllNamespaces is true, returns DLC records across all namespaces, which is useful when checking DLC ownership before unlinking a third-party account.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - include_all_namespaces: When true, returns DLC records from all namespaces.
## - status: DLC status filter.
## - type_param: Platform type filter.
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


## Queries user entitlements
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements
##
## Queries entitlements for a specific user. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: When true, returns only active entitlements.
## - app_type: Application type filter.
## - collection_id: Collection identifier filter.
## - entitlement_clazz: Entitlement class filter.
## - entitlement_name: Entitlement name filter.
## - features: Feature tag filter.
## - fuzzy_match_name: When true, uses fuzzy matching for the entitlement name.
## - ignore_active_date: This param will work only with activeOnly=true. When fetching entitlement with active status, this param will ignore the startDate and endDate of an entitlement.
## - item_id: Item identifier filter.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - origin: Entitlement origin filter.
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


## Grants entitlements to a user
## POST /platform/admin/namespaces/{namespace}/users/{userId}/entitlements
##
## Grants entitlements to a user for supported item types: APP, INGAMEITEM, CODE, SUBSCRIPTION, MEDIA, OPTIONBOX, and LOOTBOX. The operation skips unsupported item types. Use the fulfillment operation to grant other item types such as COINS.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func grant_user_entitlement(
	namespace_param: String, user_id: String, body: Array = []
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


## Retrieves user app entitlement by app ID
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byAppId
##
## Get user app entitlement by appId.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: When true, returns only active entitlements.
## - app_id: Application identifier filter.
func get_user_app_entitlement_by_app_id(
	namespace_param: String, user_id: String, app_id: String, active_only: bool = false
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


## Queries app entitlements by app type
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byAppType
##
## Query app entitlements by appType. Other detail info: Returns: app entitlement pagination
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: When true, returns only active entitlements.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - app_type: Application type filter.
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


## Retrieves user entitlements by IDs
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byIds
##
## Get user entitlements by ids. This will return all entitlements regardless of its status Other detail info: Returns: entitlement list
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - ids: Comma-separated list of entitlement identifiers.
func get_user_entitlements_by_ids(
	namespace_param: String, user_id: String, ids: Array = []
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


## Retrieves user entitlement by item ID
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byItemId
##
## Get user entitlement by itemId.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: When true, returns only active entitlements.
## - entitlement_clazz: Entitlement class filter.
## - platform: Platform filter.
## - item_id: Item identifier filter.
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


## Retrieves user entitlements by item IDs
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/byItemIds
##
## Get user entitlements by itemIds.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - ids: Comma-separated list of item identifiers.
## - platform: Platform filter.
func get_user_active_entitlements_by_item_ids(
	namespace_param: String, user_id: String, ids: Array = [], platform: String = ""
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


## Retrieves user entitlement by SKU
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/bySku
##
## Get user entitlement by sku.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: When true, returns only active entitlements.
## - entitlement_clazz: Entitlement class filter.
## - platform: Platform filter.
## - sku: Item SKU filter.
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
##
## Exists any user active entitlement of specified itemIds, skus and appIds
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - app_ids: Application identifier filter.
## - item_ids: Item identifier filter.
## - platform: Platform filter.
## - skus: Item SKU filter.
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
##
## Exists any user active entitlement of specified items.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - platform: Platform filter.
## - item_ids: Item identifier filter.
func exists_any_user_active_entitlement_by_item_ids(
	namespace_param: String, user_id: String, item_ids: Array, platform: String = ""
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


## Retrieves user app entitlement ownership by app ID
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byAppId
##
## Get user app entitlement ownership by appId.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - app_id: Application identifier.
func get_user_app_entitlement_ownership_by_app_id(
	namespace_param: String, user_id: String, app_id: String
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


## Retrieves user entitlement ownership by item ID
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemId
##
## Get user entitlement ownership by itemId.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - entitlement_clazz: Entitlement class filter.
## - platform: Platform filter.
## - item_id: Item identifier.
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


## Retrieves user entitlement ownership by item IDs
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemIds
##
## Get user entitlement ownership by itemIds.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - ids: Comma-separated list of item identifiers.
## - platform: Platform filter.
func get_user_entitlement_ownership_by_item_ids(
	namespace_param: String, user_id: String, ids: Array = [], platform: String = ""
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


## Retrieves user entitlement ownership by SKU
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/ownership/bySku
##
## Get user entitlement ownership by sku.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - entitlement_clazz: Entitlement class filter.
## - platform: Platform filter.
## - sku: Item SKU filter.
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


## Revokes all entitlements for a user
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/revoke
##
## Revoke all entitlements of a user (This API is for testing purpose only) Other detail info: Returns: revoked entitlements count
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func revoke_all_entitlements(namespace_param: String, user_id: String) -> Dictionary:
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


## Revokes user entitlements by IDs
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/revoke/byIds
##
## Revoke user's entitlements by ids. Other detail info: Returns: revoke entitlements count
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - entitlement_ids: Comma-separated list of entitlement identifiers to revoke.
func revoke_user_entitlements(
	namespace_param: String, user_id: String, entitlement_ids: String
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


## Retrieves a user entitlement
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}
##
## Get user entitlement. Other detail info: Returns: entitlement
##
## Parameters:
## - entitlement_id: Entitlement identifier to retrieve.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String
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


## Updates a user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}
##
## Updates a user entitlement. Setting the use count of a CONSUMABLE entitlement to 0 changes its status to CONSUMED.
##
## Parameters:
## - entitlement_id: Entitlement identifier to update.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func update_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Consumes a user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/decrement
##
## Consumes a user entitlement. If the use count reaches 0, the entitlement status changes to CONSUMED.
##
## Parameters:
## - entitlement_id: Entitlement identifier to consume.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func consume_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Disables a user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/disable
##
## Disable user entitlement if entitlement, only active entitlement can be disable, disabled entitlement can't consume. Like revoke, it will lose the entitlement ownership, except disabled entitlement can enable. Other detail info: Returns: disable entitlement
##
## Parameters:
## - entitlement_id: Entitlement identifier to disable.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func disable_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String
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


## Enables a user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/enable
##
## Enable user entitlement. Other detail info: Returns: enable entitlement
##
## Parameters:
## - entitlement_id: Entitlement identifier to enable.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func enable_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String
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


## Retrieves user entitlement history
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/history
##
## Get user entitlement histories. Other detail info: Returns: list of entitlement history
##
## Parameters:
## - entitlement_id: Entitlement identifier to retrieve history for.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_entitlement_histories(
	entitlement_id: String, namespace_param: String, user_id: String
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


## Revokes a user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke
##
## Revoke user entitlement. Other detail info: Returns: revoke entitlement
##
## Parameters:
## - entitlement_id: Entitlement identifier to revoke.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func revoke_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Revokes a specified use count of a user entitlement
## POST /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke/byUseCount
##
## Revoke specified count of user entitlement. Other detail info: Returns: The revoked entitlement
##
## Parameters:
## - entitlement_id: Entitlement identifier to revoke use count from.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func revoke_user_entitlement_by_use_count(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Checks if a user entitlement is eligible for use-count revocation
## GET /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/revoke/byUseCount/preCheck
##
## Checks whether a specified use count of a user entitlement is eligible for revocation without performing it.
##
## Parameters:
## - entitlement_id: Entitlement identifier to check revocability for.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - quantity: Number of use counts to check for revocability.
func pre_check_revoke_user_entitlement_by_use_count(
	entitlement_id: String, namespace_param: String, user_id: String, quantity: int
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


## Sells a user entitlement
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/sell
##
## Sells a user entitlement. For consumable entitlements with useCount 0, the status transitions to CONSUMED. For durable entitlements, the status transitions to SOLD.
##
## Parameters:
## - entitlement_id: Entitlement identifier to sell.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sell_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Redeems a campaign code for a user
## POST /platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/code
##
## Redeem campaign code. Other detail info: Returns: fulfillment result
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func redeem_code(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
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


## Checks fulfillment items before processing
## POST /platform/admin/namespaces/{namespace}/users/{userId}/fulfillment/preCheck
##
## Retrieve and check fulfillment items based on the provided request. Other detail info: Returns: list of fulfillment items
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func pre_check_fulfill_item(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Queries IAP orders for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap
##
## Query IAP orders. Other detail info: Returns: paginated iap orders
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - product_id: Filter by product identifier.
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - status: Filter by IAP order status.
## - type_param: Filter by IAP provider type.
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


## Queries all IAP orders for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/all
##
## Query all user IAP orders. Other detail info: Returns: list of iap orders
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func query_all_user_iap_orders(namespace_param: String, user_id: String) -> Dictionary:
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


## Queries IAP consumption history for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/consume/history
##
## Query IAP consume history. Other detail info: Returns: paginated iap consume history
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - status: Filter by consumption status.
## - type_param: Filter by IAP provider type.
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


## Mocks IAP item fulfillment without receipt validation
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/mock/receipt
##
## [TEST FACILITY ONLY] Mocks IAP item fulfillment without receipt validation. For test use only; forbidden in live environments.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func mock_fulfill_iap_item(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs Meta Quest subscription for a user
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/oculus/subscription/sync
##
## Returns existing subscription transaction information from Meta Quest.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_sync_oculus_subscriptions(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Queries line items for an IAP order
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/orders/{iapOrderNo}/line_items
##
## Query IAP order ine items. Other detail info: Returns: paginated iap orders
##
## Parameters:
## - iap_order_no: IAP order number to retrieve line items for.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_iap_order_line_items(
	iap_order_no: String, namespace_param: String, user_id: String
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


## Syncs abnormal Steam transactions by transaction ID
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/steam/syncAbnormalTransaction
##
## Syncs abnormal Steam orders by transaction ID. Only works when Steam sync mode is TRANSACTION.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_sync_steam_abnormal_transaction(namespace_param: String, user_id: String) -> Dictionary:
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


## Manually syncs a Steam transaction by ID
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/steam/syncByTransaction
##
## Manually syncs a Steam order by transaction ID. Only works when Steam sync mode is TRANSACTION.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_sync_steam_iap_by_transaction(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Queries user subscriptions
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions
##
## Queries user subscriptions, sorted by updatedAt by default. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: Filter to return only active subscriptions.
## - group_id: If platform is Google, please pass google subscription product id. if platform is Apple, please pass apple subscription group id
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - platform: Filter by third-party IAP platform.
## - product_id: If platform is Google, please pass google subscription plan id. if platform is Apple, please pass apple subscription product id
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


## Retrieves user subscription ownership by subscription group ID
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}/ownership/byGroupId
##
## Get user third party subscription by subscription group id.
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Third-party IAP platform identifier.
## - user_id: AccelByte user ID
## - group_id: If platform is Google, please pass google subscription product id. if platform is Apple, please pass apple subscription group id
func get_third_party_platform_subscription_ownership_by_group_id(
	namespace_param: String, platform: String, user_id: String, group_id: String
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


## Retrieves user subscription ownership by subscription product ID
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}/ownership/byProductId
##
## Get user third party subscription by subscription product id.
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Third-party IAP platform identifier.
## - user_id: AccelByte user ID
## - product_id: If platform is Google, please pass google subscription plan id. if platform is Apple, please pass apple subscription product id
func get_third_party_platform_subscription_ownership_by_product_id(
	namespace_param: String, platform: String, user_id: String, product_id: String
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


## Queries subscription transactions for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions
##
## Queries subscription transactions for a user, sorted by startAt by default. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - active_only: Filter to return only active subscriptions.
## - group_id: If platform is Google, please pass google subscription product id. if platform is Apple, please pass apple subscription group id
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - platform: Filter by third-party IAP platform.
## - product_id: If platform is Google, please pass google subscription plan id. if platform is Apple, please pass apple subscription product id
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


## Retrieves details of a user subscription transaction
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}
##
## Returns the details of a third-party subscription transaction for the specified user.
##
## Parameters:
## - id: Subscription transaction identifier.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_third_party_subscription_details(
	id: String, namespace_param: String, user_id: String
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


## Retrieves subscription transaction update history
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}/histories
##
## Retrieves the update history for a user subscription transaction. Returns paginated results using offset and limit.
##
## Parameters:
## - id: Subscription transaction identifier.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_subscription_history(
	id: String, namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Syncs a subscription transaction
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/transactions/{id}/sync
##
## Sync Subscription Status
##
## Parameters:
## - id: Subscription transaction identifier.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_subscription_transaction(
	id: String, namespace_param: String, user_id: String
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


## Retrieves user subscription details
## GET /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/{id}
##
## Retrieves details for a user subscription.
##
## Parameters:
## - id: Subscription identifier.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_third_party_user_subscription_details(
	id: String, namespace_param: String, user_id: String
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


## Syncs subscription status for a user
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/subscriptions/{id}/sync
##
## Sync Subscription Status
##
## Parameters:
## - id: Subscription identifier.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_subscription(id: String, namespace_param: String, user_id: String) -> Dictionary:
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


## Sync twitch drops entitlements with App Token.
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/iap/twitch/sync
##
## Sync twitch drops entitlements. rate limit: 800 req/minutes.
##
## *  Returns :
func admin_sync_twitch_drops_entitlement(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/users/{userId}/iap/twitch/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Queries orders for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders
##
## Queries orders for a user. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - discounted: Filter to return only discounted orders.
## - item_id: Filter by item identifier.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Filter by order status.
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


## Creates an order for a user
## POST /platform/admin/namespaces/{namespace}/users/{userId}/orders
##
## Creates an order for a user. Returns the checkout link and payment token. Users with the SANDBOX permission create sandbox orders that bypass real payment for xsolla and alipay, and skip price validation for wxpay.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_create_user_order(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves the count of purchased items for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/countOfItem
##
## Retrieves the number of times a user has purchased an item.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - item_id: Item identifier to count purchases for.
func count_of_purchased_item(
	namespace_param: String, user_id: String, item_id: String
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


## Retrieves an order
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}
##
## Get an order. Other detail info: Returns: get order
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number to retrieve.
## - user_id: AccelByte user ID
func get_user_order(namespace_param: String, order_no: String, user_id: String) -> Dictionary:
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


## Updates the status of an order
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}
##
## Update order status. Other detail info: Returns: updated order
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number to update.
## - user_id: AccelByte user ID
func update_user_order_status(
	namespace_param: String, order_no: String, user_id: String, body: Dictionary = {}
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


## Fulfills a charged but unfulfilled order
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/fulfill
##
## Fulfills a charged order awaiting fulfillment.
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number to fulfill.
## - user_id: AccelByte user ID
func fulfill_user_order(namespace_param: String, order_no: String, user_id: String) -> Dictionary:
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


## Retrieves order history for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/history
##
## Get user order history. Other detail info: Returns: get order history
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number to retrieve history for.
## - user_id: AccelByte user ID
func get_user_order_histories(
	namespace_param: String, order_no: String, user_id: String
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


## Processes a payment notification webhook
## POST /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/notifications
##
## [SERVICE COMMUNICATION ONLY] Receives payment notification webhooks from the justice payment service. Intended for internal service communication only.
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number associated with the notification.
## - user_id: AccelByte user ID
func process_user_order_notification(
	namespace_param: String, order_no: String, user_id: String, body: Dictionary = {}
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


## Downloads an order receipt as PDF
## GET /platform/admin/namespaces/{namespace}/users/{userId}/orders/{orderNo}/receipt.pdf
##
## Download user order receipt by orderNo. Other detail info: Returns: order receipt pdf
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number to download the receipt for.
## - user_id: AccelByte user ID
func download_user_order_receipt(
	namespace_param: String, order_no: String, user_id: String
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


## Creates a payment order for a user
## POST /platform/admin/namespaces/{namespace}/users/{userId}/payment/orders
##
## [Not supported yet in AGS Shared Cloud][SERVICE COMMUNICATION ONLY] Creates a payment order from the justice service. Returns the payment station URL. Intended for internal service communication only.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func create_user_payment_order(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Refunds a payment order
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/payment/orders/{paymentOrderNo}/refund
##
## [Not supported yet in AGS Shared Cloud][SERVICE COMMUNICATION ONLY] Refunds a payment order by paymentOrderNo from the justice service.
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to refund.
## - user_id: AccelByte user ID
func refund_user_payment_order(
	namespace_param: String, payment_order_no: String, user_id: String, body: Dictionary = {}
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


## Retrieves platform account closure history for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/platform/closure/history
##
## Get user platform account closure history.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_user_platform_account_closure_histories(
	namespace_param: String, user_id: String
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


## Redeems a campaign code for a user
## POST /platform/admin/namespaces/{namespace}/users/{userId}/redemption
##
## [SERVICE COMMUNICATION ONLY] Redeems a campaign code for a user. A code with ACTIVE status is not redeemable if the campaign itself is inactive.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func apply_user_redemption(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Performs a revocation for a user
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/revocation
##
## Performs a revocation for a user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func do_revocation(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
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


## Registers or updates an Xbox session for a user
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/session/xbl
##
## Registers or updates a session on Xbox.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func register_xbl_sessions(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Queries subscriptions for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions
##
## Query user subscriptions. Other detail info: Returns: paginated subscription
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - charge_status: Filter by subscription charge status.
## - item_id: Filter by item identifier.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sku: Filter by SKU.
## - status: Filter by subscription status.
## - subscribed_by: Filters results by the subscription initiation method.
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


## Retrieves subscription activity for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/activities
##
## Get user subscription activity. Other detail info: Returns: paginated subscription activity
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - exclude_system: Exclude system-generated activities from results.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - subscription_id: Filter by subscription identifier.
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


## Subscribes a user for free via a platform
## POST /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/platformSubscribe
##
## Free subscribe by platform, can used by other justice service to redeem/reward the subscription. Other detail info: Returns: result subscription
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func platform_subscribe_subscription(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Checks if a user can subscribe to an item
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/subscribable/byItemId
##
## Check user subscription subscribable by itemId, ACTIVE USER subscription can't do subscribe again. Other detail info: Returns: subscribable info
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - item_id: Item identifier to check subscribability for.
func check_user_subscription_subscribable_by_item_id(
	namespace_param: String, user_id: String, item_id: String
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


## Retrieves a user subscription
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}
##
## Get user subscription. Other detail info: Returns: subscription
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription identifier to retrieve.
## - user_id: AccelByte user ID
func get_user_subscription(
	namespace_param: String, subscription_id: String, user_id: String
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


## Deletes a user subscription
## DELETE /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}
##
## [TEST FACILITY ONLY] Forbidden in live environment. Delete user subscription.
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription identifier to delete.
## - user_id: AccelByte user ID
func delete_user_subscription(
	namespace_param: String, subscription_id: String, user_id: String
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


## Cancels a user subscription
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/cancel
##
## Cancels an active subscription. Cancel at least one day before the billing period ends to avoid charges. When immediate is true, the subscription ends immediately; otherwise it continues until the end of the billing cycle. When force is true, the service ignores recurring charging errors.
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription identifier to cancel.
## - user_id: AccelByte user ID
## - force: If true, ignores errors during recurring charging.
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


## Grants additional days to a subscription
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/grant
##
## Grant days to a subscription, if grantDays is positive, it will add free days and push the next billing date by the amount of day. if the grantDays is negative or zero, it only apply to active/cancelled subscription, remove days will decrease current period end, and move the next billing date closer. Other detail info: Returns: updated subscription
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription identifier to grant days to.
## - user_id: AccelByte user ID
func grant_days_to_subscription(
	namespace_param: String, subscription_id: String, user_id: String, body: Dictionary = {}
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


## Retrieves subscription billing history for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/history
##
## Get user subscription billing histories. Other detail info: Returns: paginated subscription billing history
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription identifier to retrieve billing history for.
## - user_id: AccelByte user ID
## - exclude_free: Exclude free billing records from results.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Processes a subscription payment notification webhook
## POST /platform/admin/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/notifications
##
## [SERVICE COMMUNICATION ONLY] Receives subscription payment notification webhooks from the justice payment service. Intended for internal service communication only.
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription identifier associated with the notification.
## - user_id: AccelByte user ID
func process_user_subscription_notification(
	namespace_param: String, subscription_id: String, user_id: String, body: Dictionary = {}
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


## Acquires a ticket from a booth for a user
## POST /platform/admin/namespaces/{namespace}/users/{userId}/tickets/{boothName}
##
## [SERVICE COMMUNICATION ONLY] Acquires a ticket (code or key) from the specified booth for a user.
##
## Parameters:
## - booth_name: Name of the ticket booth to acquire from.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func acquire_user_ticket(
	booth_name: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves currency wallet summary for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/summary
##
## Get user currency wallet summary. Other detail info: (READ) Returns: currency wallet summary
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func query_user_currency_wallets(namespace_param: String, user_id: String) -> Dictionary:
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


## Debits a user wallet by currency code
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/{currencyCode}/debit
##
## Debit a user wallet by currency code, default is debit system wallet.
##
## Parameters:
## - currency_code: Currency code of the wallet to debit.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func debit_user_wallet_by_currency_code(
	currency_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists currency transactions for a user
## GET /platform/admin/namespaces/{namespace}/users/{userId}/wallets/currencies/{currencyCode}/transactions
##
## Lists currency transactions for a user, ordered by creation time descending. Returns paginated results using offset and limit.
##
## Parameters:
## - currency_code: Currency code to filter transactions by.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Checks if a user has sufficient wallet balance
## POST /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/balanceCheck
##
## Checks if the user has enough balance based on the provided criteria. Other detail info: Returns: boolean value indicating if the user has enough balance
##
## Parameters:
## - currency_code: Currency code of the wallet to check.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func check_balance(
	currency_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Credits a user wallet by currency code and balance origin
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/credit
##
## Credit a user wallet by currency code and balance origin, if wallet not exists, it will create a new wallet. Other detail info: (UPDATE)
##
## Parameters:
## - currency_code: Currency code of the wallet to credit.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func credit_user_wallet(
	currency_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Debits a user wallet by currency code and client platform
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/debitByWalletPlatform
##
## Debits a user's wallet by currency code and client platform. Metadata key names cannot start with '$' or contain '.'.
##
## Parameters:
## - currency_code: Currency code of the wallet to debit.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func debit_by_wallet_platform(
	currency_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Pays with a user wallet by currency code and client platform
## PUT /platform/admin/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/payment
##
## Pay with user wallet by currency code and client platform.
##
## Parameters:
## - currency_code: Currency code of the wallet to charge.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func pay_with_user_wallet(
	currency_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists all views in a store
## GET /platform/admin/namespaces/{namespace}/views
##
## Lists all views in the specified store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store to query. Defaults to the published store.
func list_views(namespace_param: String, store_id: String = "") -> Dictionary:
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


## Creates a view
## POST /platform/admin/namespaces/{namespace}/views
##
## Creates a view in the specified store. Localization key restrictions: keys cannot contain '.' (e.g., 'data.2') or start with '$' (e.g., '$data').
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store to add the view to. Defaults to the draft store.
func create_view(namespace_param: String, store_id: String, body: Dictionary = {}) -> Dictionary:
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


## Retrieves a view
## GET /platform/admin/namespaces/{namespace}/views/{viewId}
##
## Retrieves a view by its identifier.
##
## Parameters:
## - namespace_param: Game namespace
## - view_id: View identifier.
## - store_id: Store to query. Defaults to the published store.
func get_view(namespace_param: String, view_id: String, store_id: String = "") -> Dictionary:
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


## Updates a view
## PUT /platform/admin/namespaces/{namespace}/views/{viewId}
##
## Updates a view. Localization key restrictions: keys cannot contain '.' (e.g., 'data.2') or start with '$' (e.g., '$data').
##
## Parameters:
## - namespace_param: Game namespace
## - view_id: View identifier.
## - store_id: Store containing the view. Defaults to the draft store.
func update_view(
	namespace_param: String, view_id: String, store_id: String, body: Dictionary = {}
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


## Deletes a view
## DELETE /platform/admin/namespaces/{namespace}/views/{viewId}
##
## Deletes a view and all its related sections.
##
## Parameters:
## - namespace_param: Game namespace
## - view_id: View identifier.
## - store_id: Store containing the view. Defaults to the draft store.
func delete_view(namespace_param: String, view_id: String, store_id: String) -> Dictionary:
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


## Retrieves the wallet configuration for a namespace
## GET /platform/admin/namespaces/{namespace}/wallet/config
##
## Get wallet config
##
## Parameters:
## - namespace_param: Game namespace
func get_wallet_config(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallet/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the wallet configuration for a namespace
## PUT /platform/admin/namespaces/{namespace}/wallet/config
##
## Update wallet config of a namespace
##
## Parameters:
## - namespace_param: Game namespace
func update_wallet_config(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallet/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Credits multiple users' wallets in bulk
## POST /platform/admin/namespaces/{namespace}/wallets/credit
##
## Credit different users' wallets. Other detail info: Returns: bulk credit result
##
## Parameters:
## - namespace_param: Game namespace
func bulk_credit(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallets/credit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Debits multiple users' wallets in bulk
## POST /platform/admin/namespaces/{namespace}/wallets/debit
##
## Debit different users' wallets. Other detail info: Returns: bulk credit result
##
## Parameters:
## - namespace_param: Game namespace
func bulk_debit(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/namespaces/{namespace}/wallets/debit"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Syncs orders within a time range
## GET /platform/admin/orders
##
## [Not supported yet in AGS Shared Cloud] Sync orders. If response contains nextEvaluatedKey, please use it as query param in the next call to fetch the next batch, a batch has 1000 elements or less. Other detail info: Returns: sync orders
##
## Parameters:
## - next_evaluated_key: Pagination cursor from the previous response for fetching the next page.
## - end: Exclude ISODateTimeFormat no millis like yyyy-MM-dd'T'HH:mm:ssZZ
## - start: Include ISODateTimeFormat no millis like yyyy-MM-dd'T'HH:mm:ssZZ
func sync_orders(end: String, start: String, next_evaluated_key: String = "") -> Dictionary:
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


## Tests the Adyen payment provider configuration
## POST /platform/admin/payment/config/merchant/adyenconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the Adyen configuration. Required fields: apiKey, merchantAccount. Optional fields: notificationHmacKey, notificationUsername, notificationPassword, liveEndpointUrlPrefix, allowedPaymentMethods, blockedPaymentMethods, settings.
##
## Parameters:
## - sandbox: When true, tests against the Adyen sandbox environment instead of production.
func test_adyen_config(sandbox: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Tests the Alipay payment provider configuration
## POST /platform/admin/payment/config/merchant/alipayconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test AliPay configuration.Reference: Alipay Document. Other detail info: Returns: test result
##
## Parameters:
## - sandbox: When true, tests against the Alipay sandbox environment instead of production.
func test_ali_pay_config(sandbox: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Tests the Checkout.com payment provider configuration
## POST /platform/admin/payment/config/merchant/checkoutconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the Checkout.com configuration. Required fields: publicKey, secretKey.
##
## Parameters:
## - sandbox: When true, tests against the Checkout.com sandbox environment instead of production.
func test_checkout_config(sandbox: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Retrieves the matched payment merchant configuration for a region
## GET /platform/admin/payment/config/merchant/matched
##
## [Not supported yet in AGS Shared Cloud] Debug matched payment merchant config. Other detail info: Returns: payment merchant config info
##
## Parameters:
## - namespace_param: Game namespace
## - region: Region code to match the payment merchant configuration against.
func debug_matched_payment_merchant_config(
	namespace_param: String = "", region: String = ""
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


## Tests the Neon Pay payment provider configuration
## POST /platform/admin/payment/config/merchant/neonpayconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the Neon Pay configuration. Required fields: apiKey, webhookSecretKey.
##
## Parameters:
## - sandbox: When true, tests against the Neon Pay sandbox environment instead of production.
func test_neon_pay_config(sandbox: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Tests the PayPal payment provider configuration
## POST /platform/admin/payment/config/merchant/paypalconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the PayPal configuration. Required fields: clientID, clientSecret. Optional fields: webHookId.
##
## Parameters:
## - sandbox: When true, tests against the PayPal sandbox environment instead of production.
func test_pay_pal_config(sandbox: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Tests the Stripe payment provider configuration
## POST /platform/admin/payment/config/merchant/stripeconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the Stripe configuration. Required fields: secretKey, allowedPaymentMethodTypes. Optional fields: publishableKey, webhookSecret.
##
## Parameters:
## - sandbox: When true, tests against the Stripe sandbox environment instead of production.
func test_stripe_config(sandbox: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Tests the WxPay payment provider configuration
## POST /platform/admin/payment/config/merchant/wxpayconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the WxPay payment provider configuration.
func test_wx_pay_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/wxpayconfig/test"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Tests the Xsolla payment provider configuration
## POST /platform/admin/payment/config/merchant/xsollaconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the Xsolla payment configuration. Required fields: merchantId, projectId, apiKey. Optional: projectSecretKey.
func test_xsolla_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/xsollaconfig/test"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a payment merchant configuration
## GET /platform/admin/payment/config/merchant/{id}
##
## [Not supported yet in AGS Shared Cloud] Get payment merchant config by id. Other detail info: Returns: payment merchant config info
##
## Parameters:
## - id: Payment merchant configuration identifier.
func get_payment_merchant_config_1(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Adyen configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/adyenconfig
##
## [Not supported yet in AGS Shared Cloud] Update adyen config. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, targets the Adyen sandbox environment instead of production.
## - validate: When true, validates the configuration before saving.
func update_adyen_config(
	id: String, sandbox: bool = false, validate: bool = false, body: Dictionary = {}
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


## Tests the Adyen configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/adyenconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test adyen configuration in payment merchant config. Other detail info: Returns: test adyen config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, tests against the Adyen sandbox environment instead of production.
func test_adyen_config_by_id(id: String, sandbox: bool = false) -> Dictionary:
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


## Updates the Alipay configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/alipayconfig
##
## [Not supported yet in AGS Shared Cloud] Update alipay configuration. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, targets the Alipay sandbox environment instead of production.
## - validate: When true, validates the configuration before saving.
func update_ali_pay_config(
	id: String, sandbox: bool = false, validate: bool = false, body: Dictionary = {}
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


## Tests the Alipay configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/alipayconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test AliPay configuration in payment merchant config. Reference: Alipay Document. Other detail info: Returns: test alipay config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, tests against the Alipay sandbox environment instead of production.
func test_ali_pay_config_by_id(id: String, sandbox: bool = false) -> Dictionary:
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


## Updates the Checkout.com configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/checkoutconfig
##
## [Not supported yet in AGS Shared Cloud] Update checkout.com config. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, targets the Checkout.com sandbox environment instead of production.
## - validate: When true, validates the configuration before saving.
func update_checkout_config(
	id: String, sandbox: bool = false, validate: bool = false, body: Dictionary = {}
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


## Tests the Checkout.com configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/checkoutconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test checkout.com configuration in payment merchant config. Other detail info: Returns: test result
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, tests against the Checkout.com sandbox environment instead of production.
func test_checkout_config_by_id(id: String, sandbox: bool = false) -> Dictionary:
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


## Updates the Neon Pay configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/neonpayconfig
##
## [Not supported yet in AGS Shared Cloud] Update Neon Pay config. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, targets the Neon Pay sandbox environment instead of production.
## - validate: When true, validates the configuration before saving.
func update_neon_pay_config(
	id: String, sandbox: bool = false, validate: bool = false, body: Dictionary = {}
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


## Tests the Neon Pay configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/neonpayconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test Neon Pay configuration in payment merchant config. Other detail info: Returns: test result
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, tests against the Neon Pay sandbox environment instead of production.
func test_neon_pay_config_by_id(id: String, sandbox: bool = false) -> Dictionary:
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


## Updates the PayPal configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/paypalconfig
##
## [Not supported yet in AGS Shared Cloud] Update PayPal config. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, targets the PayPal sandbox environment instead of production.
## - validate: When true, validates the configuration before saving.
func update_pay_pal_config(
	id: String, sandbox: bool = false, validate: bool = false, body: Dictionary = {}
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


## Tests the PayPal configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/paypalconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test PayPal configuration in payment merchant config. Other detail info: Returns: test result
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, tests against the PayPal sandbox environment instead of production.
func test_pay_pal_config_by_id(id: String, sandbox: bool = false) -> Dictionary:
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


## Updates the Stripe configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/stripeconfig
##
## [Not supported yet in AGS Shared Cloud] Update stripe config. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, targets the Stripe sandbox environment instead of production.
## - validate: When true, validates the configuration before saving.
func update_stripe_config(
	id: String, sandbox: bool = false, validate: bool = false, body: Dictionary = {}
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


## Tests the Stripe configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/stripeconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test stripe configuration in payment merchant config. Other detail info: Returns: test adyen config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - sandbox: When true, tests against the Stripe sandbox environment instead of production.
func test_stripe_config_by_id(id: String, sandbox: bool = false) -> Dictionary:
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


## Updates the WxPay configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/wxpayconfig
##
## [Not supported yet in AGS Shared Cloud] Update wxpay configuration. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - validate: When true, validates the configuration before saving.
func update_wx_pay_config(id: String, validate: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Uploads the WxPay certificate file for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/wxpayconfig/cert
##
## [Not supported yet in AGS Shared Cloud] Upload wxpay cert file. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - file: WxPay certificate file to upload.
func update_wx_pay_config_cert(id: String, file: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/wxpayconfig/cert"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Tests the WxPay configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/wxpayconfig/test
##
## [Not supported yet in AGS Shared Cloud] Tests the WxPay configuration for the specified payment merchant.
##
## Parameters:
## - id: Payment merchant configuration identifier.
func test_wx_pay_config_by_id(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/wxpayconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Xsolla configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/xsollaconfig
##
## [Not supported yet in AGS Shared Cloud] Update xsolla configuration. Reference: Xsolla Document. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
## - validate: When true, validates the configuration before saving.
func update_xsolla_config(id: String, validate: bool = false, body: Dictionary = {}) -> Dictionary:
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


## Tests the Xsolla configuration for a payment merchant
## GET /platform/admin/payment/config/merchant/{id}/xsollaconfig/test
##
## [Not supported yet in AGS Shared Cloud] Test xsolla configuration in payment merchant config. Reference: Xsolla Document. Other detail info: Returns: test xsolla config
##
## Parameters:
## - id: Payment merchant configuration identifier.
func test_xsolla_config_by_id(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/xsollaconfig/test"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the Xsolla UI configuration for a payment merchant
## PUT /platform/admin/payment/config/merchant/{id}/xsollauiconfig
##
## [Not supported yet in AGS Shared Cloud] Update xsolla UI configuration.Reference: Xsolla Document. Other detail info: Returns: updated payment merchant config
##
## Parameters:
## - id: Payment merchant configuration identifier.
func update_xsolla_ui_config(id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/merchant/{id}/xsollauiconfig"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Queries payment provider configurations
## GET /platform/admin/payment/config/provider
##
## [Not supported yet in AGS Shared Cloud] Queries payment provider configurations. Returns paginated results using offset and limit.
##
## Parameters:
## - limit: Number of results to return
## - namespace_param: Game namespace
## - offset: Number of results to skip for pagination
## - region: Region code to filter configurations by.
func query_payment_provider_config(
	limit: int = -1, namespace_param: String = "", offset: int = -1, region: String = ""
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


## Creates a payment provider configuration
## POST /platform/admin/payment/config/provider
##
## [Not supported yet in AGS Shared Cloud] Creates a payment provider configuration for a namespace and region. Provider priority order: exact namespace+region match, then namespace-only match, then region-only match, then wildcard match.
func create_payment_provider_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves available aggregate payment providers
## GET /platform/admin/payment/config/provider/aggregate
##
## [Not supported yet in AGS Shared Cloud] Retrieves available aggregate payment providers such as XSOLLA and ADYEN.
func get_aggregate_payment_providers() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/aggregate"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the matched payment provider configuration for a namespace and region
## GET /platform/admin/payment/config/provider/matched
##
## [Not supported yet in AGS Shared Cloud] Debug matched payment provider config. Other detail info: Returns: payment provider config
##
## Parameters:
## - namespace_param: Game namespace
## - region: Region code to match the payment provider configuration against.
func debug_matched_payment_provider_config(
	namespace_param: String = "", region: String = ""
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


## Retrieves available special payment providers
## GET /platform/admin/payment/config/provider/special
##
## [Not supported yet in AGS Shared Cloud] Get special payment providers, such as ALIPAY, WXPAY. Other detail info: Returns: payment provider list
func get_special_payment_providers() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/special"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a payment provider configuration
## PUT /platform/admin/payment/config/provider/{id}
##
## [Not supported yet in AGS Shared Cloud] Updates a payment provider configuration.
##
## Parameters:
## - id: Payment provider configuration identifier.
func update_payment_provider_config(id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes a payment provider configuration
## DELETE /platform/admin/payment/config/provider/{id}
##
## [Not supported yet in AGS Shared Cloud] Delete payment provider config. Other detail info: Returns: payment provider config
##
## Parameters:
## - id: Payment provider configuration identifier.
func delete_payment_provider_config(id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/provider/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the global payment tax configuration
## GET /platform/admin/payment/config/tax
##
## [Not supported yet in AGS Shared Cloud] Get payment global tax config. Other detail info: Returns: payment provider list
func get_payment_tax_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/tax"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the global payment tax configuration
## PUT /platform/admin/payment/config/tax
##
## [Not supported yet in AGS Shared Cloud] Updates the payment tax configuration for the namespace.
func update_payment_tax_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/admin/payment/config/tax"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Syncs payment orders within a time range
## GET /platform/admin/payment/orders
##
## [Not supported yet in AGS Shared Cloud] Sync payment orders. If response contains nextEvaluatedKey, please use it as query param in the next call to fetch the next batch, a batch has 1000 elements or less. Other detail info: Returns: sync payment orders
##
## Parameters:
## - next_evaluated_key: Pagination cursor from the previous response for fetching the next page.
## - end: Exclude ISODateTimeFormat no millis like yyyy-MM-dd'T'HH:mm:ssZZ
## - start: Include ISODateTimeFormat no millis like yyyy-MM-dd'T'HH:mm:ssZZ
func sync_payment_orders(end: String, start: String, next_evaluated_key: String = "") -> Dictionary:
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


## Retrieves root categories
## GET /platform/public/namespaces/{namespace}/categories
##
## Retrieves root categories from a store. Users with PREVIEW or SANDBOX permissions can view draft store categories.
##
## Parameters:
## - namespace_param: Game namespace
## - language: Language code for localizing category display names.
## - store_id: Store to query. Defaults to the published store.
func public_get_root_categories(
	namespace_param: String, language: String = "", store_id: String = ""
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


## Downloads the store's full category structure
## GET /platform/public/namespaces/{namespace}/categories/download
##
## Downloads the store's full category hierarchy. Users with PREVIEW or SANDBOX permissions can view draft store content.
##
## Parameters:
## - namespace_param: Game namespace
## - language: Language code for localizing category display names.
## - store_id: Store to query. Defaults to the published store.
func download_categories(
	namespace_param: String, language: String = "", store_id: String = ""
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


## Retrieves a category by path
## GET /platform/public/namespaces/{namespace}/categories/{categoryPath}
##
## Retrieves a category by its path. Users with PREVIEW or SANDBOX permissions can view draft store categories.
##
## Parameters:
## - category_path: URL-encoded category path (e.g., '/electronics/phones').
## - namespace_param: Game namespace
## - language: Language code for localizing category display names.
## - store_id: Store to query. Defaults to the published store.
func public_get_category(
	category_path: String, namespace_param: String, language: String = "", store_id: String = ""
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


## Retrieves child categories for a given category path
## GET /platform/public/namespaces/{namespace}/categories/{categoryPath}/children
##
## Retrieves the direct child categories of a given category path. Users with PREVIEW or SANDBOX permissions can view draft store categories.
##
## Parameters:
## - category_path: URL-encoded category path.
## - namespace_param: Game namespace
## - language: Language code for localizing category display names.
## - store_id: Store to query. Defaults to the published store.
func public_get_child_categories(
	category_path: String, namespace_param: String, language: String = "", store_id: String = ""
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


## Retrieves all descendant categories for a given category path
## GET /platform/public/namespaces/{namespace}/categories/{categoryPath}/descendants
##
## Retrieves all descendant categories (at any depth) of a given category path. Users with PREVIEW or SANDBOX permissions can view draft store categories.
##
## Parameters:
## - category_path: URL-encoded category path.
## - namespace_param: Game namespace
## - language: Language code for localizing category display names.
## - store_id: Store to query. Defaults to the published store.
func public_get_descendant_categories(
	category_path: String, namespace_param: String, language: String = "", store_id: String = ""
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


## Lists available currencies
## GET /platform/public/namespaces/{namespace}/currencies
##
## List currencies of a namespace. Other detail info: Returns: Currency List
##
## Parameters:
## - namespace_param: Game namespace
## - currency_type: Filters results by currency type (e.g., REAL or VIRTUAL).
func public_list_currencies(namespace_param: String, currency_type: String = "") -> Dictionary:
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


## Retrieves a DLC durable reward mapping
## GET /platform/public/namespaces/{namespace}/dlc/rewards/durable/map
##
## Get dlc reward simple map, only return the sku of durable item reward.
##
## Parameters:
## - namespace_param: Game namespace
## - dlc_type: DLC platform type to filter the reward map by.
func ge_dlc_durable_reward_short_map(namespace_param: String, dlc_type: String) -> Dictionary:
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


## Retrieves the Apple IAP configuration version
## GET /platform/public/namespaces/{namespace}/iap/apple/config/version
##
## Get apple config version.
##
## Parameters:
## - namespace_param: Game namespace
func get_apple_config_version(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/iap/apple/config/version"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the IAP item mapping for a platform
## GET /platform/public/namespaces/{namespace}/iap/item/mapping
##
## Get iap item mapping.
##
## Parameters:
## - namespace_param: Game namespace
## - platform: Third-party platform identifier to retrieve the IAP mapping for.
func get_iap_item_mapping(namespace_param: String, platform: String = "") -> Dictionary:
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


## Retrieves an item by its app ID
## GET /platform/public/namespaces/{namespace}/items/byAppId
##
## Retrieves an item by its application ID. Users with PREVIEW or SANDBOX permissions can view draft store items.
##
## Parameters:
## - namespace_param: Game namespace
## - language: Language code for localizing item text.
## - region: Region code for applying regional pricing.
## - store_id: Store to query. Defaults to the published store.
## - app_id: Application ID to look up.
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


## Queries store items by criteria
## GET /platform/public/namespaces/{namespace}/items/byCriteria
##
## Queries items within a store by criteria. Falls back to the default region item if the requested region has no match. Users with PREVIEW or SANDBOX permissions can view draft store items. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - app_type: Filters items by application type (e.g., GAME, DLC, SOFTWARE).
## - auto_calc_estimated_price: When true, includes estimated price calculation for items.
## - base_app_id: Filters items by base application ID.
## - category_path: Catalog category path to filter items by. Must match the full path exactly.
## - features: Item features to filter by, comma-separated.
## - include_sub_category_item: When true, returns all items under the specified category path and its subcategories. Defaults to false. Only applies when filtering by category path.
## - item_type: Filters items by item type (e.g., APP, COINS, INGAMEITEM, BUNDLE, CODE, SUBSCRIPTION).
## - language: Language code for localizing item text.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - region: Region code for applying regional pricing.
## - sort_by: Default is name:asc,displayOrder:asc, allow values: [name, name:asc, name:desc, createdAt, createdAt:asc, createdAt:desc, updatedAt, updatedAt:asc, updatedAt:desc, displayOrder, displayOrder:asc, displayOrder:desc],and support sort group, eg: sortBy=name:asc,createdAt:desc. Make sure to always use more than one sort if the first sort is not an unique value for example, if you wish to sort by displayOrder, make sure to include other sort such as name or createdAt after the first sort, eg: displayOrder:asc,name:asc
## - store_id: Store to query. Defaults to the published store.
## - tags: Tags to filter by, comma-separated.
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


## Retrieves an item by its SKU
## GET /platform/public/namespaces/{namespace}/items/bySku
##
## Retrieves an item by its SKU. Users with PREVIEW or SANDBOX permissions can view draft store items.
##
## Parameters:
## - namespace_param: Game namespace
## - auto_calc_estimated_price: When true, includes estimated price calculation for the item.
## - language: Language code for localizing item text.
## - region: Region code for applying regional pricing.
## - store_id: Store to query. Defaults to the published store.
## - sku: Item SKU to look up.
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


## Retrieves estimated prices for items
## GET /platform/public/namespaces/{namespace}/items/estimatedPrice
##
## Retrieves estimated prices for one or more items.
##
## Parameters:
## - namespace_param: Game namespace
## - region: Region code for applying regional pricing.
## - store_id: Use published store id by default
## - item_ids: Commas separated item ids
func public_get_estimated_price(
	namespace_param: String, item_ids: String, region: String = "", store_id: String = ""
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


## Retrieves locale-specific item details in bulk
## GET /platform/public/namespaces/{namespace}/items/locale/byIds
##
## Retrieves locale-specific details for multiple items. Falls back to the default region item if the requested region has no match. Users with PREVIEW or SANDBOX permissions can view draft store items.
##
## Parameters:
## - namespace_param: Game namespace
## - auto_calc_estimated_price: When true, includes estimated price calculation for items.
## - language: Language code for localizing item text.
## - region: Region code for applying regional pricing.
## - store_id: Store to query. Defaults to the published store.
## - item_ids: Commas separated item ids
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


## Validates whether a user meets the purchase conditions for items
## POST /platform/public/namespaces/{namespace}/items/purchase/conditions/validate
##
## Validates whether a user meets the purchase conditions for the specified items.
##
## Parameters:
## - namespace_param: Game namespace
func public_validate_item_purchase_condition(
	namespace_param: String, body: Dictionary = {}
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


## Searches store items by keyword
## GET /platform/public/namespaces/{namespace}/items/search
##
## Searches items by keyword across title, description, and long description. Results are language-constrained and fall back to the default region if the requested region has no match. Users with PREVIEW or SANDBOX permissions can view draft store items. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - auto_calc_estimated_price: When true, includes estimated price calculation for items.
## - item_type: Filters results by item type (e.g., APP, COINS, INGAMEITEM).
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - region: Region code for applying regional pricing and filtering.
## - store_id: Store to search. Defaults to the published store.
## - keyword: Keyword to search for across item title, description, and long description.
## - language: Language code for localizing item text and constraining keyword search.
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


## Retrieves an app item with locale-specific details
## GET /platform/public/namespaces/{namespace}/items/{itemId}/app/locale
##
## Retrieves an app item with locale-specific details. Falls back to the default region if the requested region has no match. Users with PREVIEW or SANDBOX permissions can view draft store apps.
##
## Parameters:
## - item_id: Item identifier.
## - namespace_param: Game namespace
## - language: Language code for localizing item text.
## - region: Region code for applying regional pricing.
## - store_id: Store to query. Defaults to the published store.
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


## Retrieves dynamic data for an item
## GET /platform/public/namespaces/{namespace}/items/{itemId}/dynamic
##
## Get item dynamic data for a published item. Other detail info: Returns: item dynamic data
##
## Parameters:
## - item_id: Item identifier.
## - namespace_param: Game namespace
func public_get_item_dynamic_data(item_id: String, namespace_param: String) -> Dictionary:
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


## Retrieves an item with locale-specific details
## GET /platform/public/namespaces/{namespace}/items/{itemId}/locale
##
## Retrieves an item with locale-specific details. Falls back to the default region if the requested region has no match. Users with PREVIEW or SANDBOX permissions can view draft store items.
##
## Parameters:
## - item_id: Item identifier.
## - namespace_param: Game namespace
## - auto_calc_estimated_price: When true, calculates and includes the estimated price in the response.
## - language: Language code for localizing item text.
## - populate_bundle: Whether populate bundled items if it's a bundle
## - region: Region code for applying regional pricing.
## - store_id: Store to query. Defaults to the published store.
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


## Retrieves a payment URL for a payment order
## POST /platform/public/namespaces/{namespace}/payment/link
##
## [Not supported yet in AGS Shared Cloud] Retrieves a payment URL for a payment order. For Neon Pay, the neonPayConfig field sets separate success and cancel URLs; if absent, returnUrl applies to both.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_payment_url(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/payment/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves available payment methods for a payment order
## GET /platform/public/namespaces/{namespace}/payment/methods
##
## [Not supported yet in AGS Shared Cloud] Get payment methods. Other detail info: Returns: Payment method list
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to retrieve methods for.
func public_get_payment_methods(namespace_param: String, payment_order_no: String) -> Dictionary:
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


## Retrieves payment order information
## GET /platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/info
##
## [Not supported yet in AGS Shared Cloud] Get payment order info. Other detail info: Returns: Payment order details
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number.
func public_get_unpaid_payment_order(
	namespace_param: String, payment_order_no: String
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


## Submits payment for a payment order
## POST /platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/pay
##
## [Not supported yet in AGS Shared Cloud] Do payment(For now, this only support checkout.com). Other detail info: Returns: Payment process result
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number to pay.
## - payment_provider: Payment provider to use for the transaction.
## - zip_code: Billing ZIP code, used for tax calculation.
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


## Checks the paid status of a payment order
## GET /platform/public/namespaces/{namespace}/payment/orders/{paymentOrderNo}/status
##
## [Not supported yet in AGS Shared Cloud] Check payment order paid status. Other detail info: Returns: Payment order paid result
##
## Parameters:
## - namespace_param: Game namespace
## - payment_order_no: Payment order number.
func public_check_payment_order_paid_status(
	namespace_param: String, payment_order_no: String
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


## Retrieves the public configuration for a payment provider
## GET /platform/public/namespaces/{namespace}/payment/publicconfig
##
## [Not supported yet in AGS Shared Cloud] Get payment provider public config, at current only Strip provide public config. Other detail info: Returns: Public config
##
## Parameters:
## - namespace_param: Game namespace
## - sandbox: When true, returns the sandbox environment configuration.
## - payment_provider: Payment provider to retrieve the public configuration for.
## - region: Region code for retrieving region-specific public configuration.
func get_payment_public_config(
	namespace_param: String, payment_provider: String, region: String, sandbox: bool = false
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


## Retrieves a QR code for a payment
## GET /platform/public/namespaces/{namespace}/payment/qrcode
##
## [Not supported yet in AGS Shared Cloud] Get qrcode. Other detail info: Returns: QRCode image stream
##
## Parameters:
## - namespace_param: Game namespace
## - code: QR code value from the payment provider.
func public_get_qr_code(namespace_param: String, code: String) -> Dictionary:
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


## Normalizes a payment provider return URL after payment
## GET /platform/public/namespaces/{namespace}/payment/returnurl
##
## [Not supported yet in AGS Shared Cloud] Normalizes the return URL after a payment provider redirect. Payment status values: DONE (payment completed), CANCELLED (cancelled before completion), PENDING (awaiting completion). Redirects to the configured return URL with payment result parameters appended.
##
## Parameters:
## - namespace_param: Game namespace
## - payer_id: PayPal payer id
## - foreinginvoice: Alipay foreign invoice reference.
## - invoice_id: Alipay invoice identifier.
## - payload: Adyen redirect session data for checkout sdk
## - redirect_result: Adyen redirect session data for drop in
## - result_code: Adyen redirect resultCode from checkout sdk
## - session_id: Adyen redirect session Id for drop in
## - status: Paypal and xsolla will return this
## - token: PayPal token
## - type_param: Payment result type from the payment provider.
## - user_id: User identifier from the payment provider.
## - order_no: Platform order no
## - payment_order_no: Platform payment order no
## - payment_provider: Platform payment provider
## - return_url: URL to redirect to after payment processing.
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


## Retrieves the tax calculation result for a payment order
## GET /platform/public/namespaces/{namespace}/payment/tax
##
## [Not supported yet in AGS Shared Cloud] Check and get a payment order's should pay tax. Other detail info: Returns: tax result
##
## Parameters:
## - namespace_param: Game namespace
## - zip_code: Billing ZIP code for tax calculation.
## - payment_order_no: Payment order number to calculate tax for.
## - payment_provider: Payment provider to use for tax calculation.
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


## Retrieves a reward by its code
## GET /platform/public/namespaces/{namespace}/rewards/byCode
##
## Retrieves a reward by its reward code.
##
## Parameters:
## - namespace_param: Game namespace
## - reward_code: Reward code to look up.
func get_reward_by_code(namespace_param: String, reward_code: String) -> Dictionary:
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


## Queries rewards by criteria
## GET /platform/public/namespaces/{namespace}/rewards/byCriteria
##
## Queries rewards by criteria. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - event_topic: Filters rewards by event topic.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for results (e.g., createdAt:asc, rewardCode:desc).
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


## Retrieves a reward by its identifier
## GET /platform/public/namespaces/{namespace}/rewards/{rewardId}
##
## Retrieves a reward by its identifier.
##
## Parameters:
## - namespace_param: Game namespace
## - reward_id: Reward identifier.
func get_reward_1(namespace_param: String, reward_id: String) -> Dictionary:
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


## Lists all stores in a namespace
## GET /platform/public/namespaces/{namespace}/stores
##
## Lists all stores in the namespace. Users with PREVIEW or SANDBOX permissions can view draft stores.
##
## Parameters:
## - namespace_param: Game namespace
func public_list_stores(namespace_param: String) -> Dictionary:
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
##
## Checks whether the current user has any active entitlement for the specified item IDs, SKUs, or app IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - app_ids: Comma-separated list of app IDs to check ownership for.
## - item_ids: Comma-separated list of item IDs to check ownership for.
## - skus: Comma-separated list of SKUs to check ownership for.
func public_exists_any_my_active_entitlement(
	namespace_param: String, app_ids: Array = [], item_ids: Array = [], skus: Array = []
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


## Checks ownership of a specific app entitlement
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownership/byAppId
##
## Checks the current user's entitlement ownership for a specific app. The namespace can be the publisher namespace to check ownership in a publisher context.
##
## Parameters:
## - namespace_param: Game namespace
## - app_id: Application ID to check ownership for.
func public_get_my_app_entitlement_ownership_by_app_id(
	namespace_param: String, app_id: String
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


## Checks ownership of a specific item entitlement
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownership/byItemId
##
## Checks the current user's entitlement ownership for a specific item. The namespace can be the publisher namespace to check ownership in a publisher context.
##
## Parameters:
## - namespace_param: Game namespace
## - entitlement_clazz: Entitlement class to filter by (e.g., APP, GAME, DLC, ENTITLEMENT).
## - item_id: Item ID to check ownership for.
func public_get_my_entitlement_ownership_by_item_id(
	namespace_param: String, item_id: String, entitlement_clazz: String = ""
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


## Checks ownership of a specific SKU entitlement
## GET /platform/public/namespaces/{namespace}/users/me/entitlements/ownership/bySku
##
## Checks the current user's entitlement ownership for a specific SKU. The namespace can be the publisher namespace to check ownership in a publisher context.
##
## Parameters:
## - namespace_param: Game namespace
## - entitlement_clazz: Entitlement class to filter by (e.g., APP, GAME, DLC, ENTITLEMENT).
## - sku: SKU to check ownership for.
func public_get_my_entitlement_ownership_by_sku(
	namespace_param: String, sku: String, entitlement_clazz: String = ""
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
##
## Generates a signed JWT ownership token for the specified item IDs, SKUs, and app IDs. Verify the token using the JWKS operation at /platform/jwks.
##
## Parameters:
## - namespace_param: Game namespace
## - app_ids: Comma-separated list of app IDs to include in the ownership token.
## - item_ids: Comma-separated list of item IDs to include in the ownership token.
## - skus: Comma-separated list of SKUs to include in the ownership token.
func public_get_entitlement_ownership_token(
	namespace_param: String, app_ids: Array = [], item_ids: Array = [], skus: Array = []
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


## Syncs Twitch drop entitlements for the current user
## PUT /platform/public/namespaces/{namespace}/users/me/iap/twitch/sync
##
## Sync my game twitch drops entitlements.
##
## Parameters:
## - namespace_param: Game namespace
func sync_twitch_drops_entitlement(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/public/namespaces/{namespace}/users/me/iap/twitch/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves the current user's wallet for a currency
## GET /platform/public/namespaces/{namespace}/users/me/wallets/{currencyCode}
##
## Retrieves the current user's wallet for the specified currency. The namespace can be the publisher namespace to retrieve the wallet in a publisher context.
##
## Parameters:
## - currency_code: Currency code of the wallet to retrieve.
## - namespace_param: Game namespace
func public_get_my_wallet(currency_code: String, namespace_param: String) -> Dictionary:
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


## Syncs Epic Games DLC entitlements for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/epicgames/sync
##
## Sync epic games dlc items
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_epic_game_dlc(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs Oculus DLC entitlements for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/oculus/sync
##
## Sync oculus dlc
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_oculus_dlc(namespace_param: String, user_id: String) -> Dictionary:
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


## Syncs PSN Store DLC entitlements for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/psn/sync
##
## Synchronize with dlc entitlements in PSN Store.Other detail info: Returns: result of synchronization
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_sync_psn_dlc_inventory(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs PSN Store DLC entitlements across multiple service labels
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/psn/sync/multiServiceLabels
##
## Syncs PSN Store DLC entitlements for a user across multiple service labels.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_sync_psn_dlc_inventory_with_multiple_service_labels(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs Steam DLC entitlements for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/steam/sync
##
## Sync steam dlc
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_steam_dlc(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
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


## Syncs Xbox DLC entitlements for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/dlc/xbl/sync
##
## Sync Xbox inventory's dlc items
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_xbox_dlc(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
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


## Queries entitlements for a user
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements
##
## Queries entitlements for a user, with optional filtering by app type, entitlement class, name, features, or item. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - app_type: Filters entitlements by application type.
## - entitlement_clazz: Filters entitlements by class (e.g., APP, GAME, DLC, ENTITLEMENT).
## - entitlement_name: Filters entitlements by name.
## - features: Filters entitlements by feature tags.
## - item_id: Filters entitlements by item ID.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Retrieves a user's app entitlement by app ID
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/byAppId
##
## Get user app entitlement by appId.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - app_id: Application ID to look up the entitlement for.
func public_get_user_app_entitlement_by_app_id(
	namespace_param: String, user_id: String, app_id: String
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


## Queries a user's app entitlements by application type
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/byAppType
##
## Query app entitlements by appType. Other detail info: Returns: app entitlement pagination
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - app_type: Application type to filter entitlements by (e.g., GAME, DLC, SOFTWARE).
func public_query_user_entitlements_by_app_type(
	namespace_param: String, user_id: String, app_type: String, limit: int = -1, offset: int = -1
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


## Retrieves user entitlements by their identifiers
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/byIds
##
## Get user entitlements by ids.. Other detail info: Returns: entitlement list
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - available_platform_only: When true, returns only entitlements available on the current platform.
## - ids: Comma-separated list of entitlement IDs to retrieve.
func public_get_user_entitlements_by_ids(
	namespace_param: String, user_id: String, available_platform_only: bool = false, ids: Array = []
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


## Retrieves entitlement history for a user
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/history
##
## Retrieves the entitlement history for a user. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - end_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z
## - entitlement_clazz: Filters history by entitlement class (e.g., APP, GAME, DLC, ENTITLEMENT).
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - start_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z
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
##
## Checks whether a user has any active entitlement for the specified item IDs, SKUs, or app IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - app_ids: Comma-separated list of app IDs to check ownership for.
## - item_ids: Comma-separated list of item IDs to check ownership for.
## - skus: Comma-separated list of SKUs to check ownership for.
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


## Checks a user's ownership of a specific app entitlement
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byAppId
##
## Get user app entitlement ownership by appId.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - app_id: Application ID to check ownership for.
func public_get_user_app_entitlement_ownership_by_app_id(
	namespace_param: String, user_id: String, app_id: String
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


## Checks a user's entitlement ownership for a specific item
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemId
##
## Get user entitlement ownership by itemId.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - entitlement_clazz: Entitlement class to filter by.
## - item_id: Item ID to check ownership for.
func public_get_user_entitlement_ownership_by_item_id(
	namespace_param: String, user_id: String, item_id: String, entitlement_clazz: String = ""
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


## Checks a user's entitlement ownership for multiple items
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/byItemIds
##
## Get user entitlement ownership by itemIds.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - ids: Comma-separated list of item IDs to check ownership for.
func public_get_user_entitlement_ownership_by_item_ids(
	namespace_param: String, user_id: String, ids: Array = []
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


## Checks a user's entitlement ownership for a specific SKU
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/ownership/bySku
##
## Get user entitlement ownership by sku.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - entitlement_clazz: Entitlement class to filter by.
## - sku: Item SKU to check ownership for.
func public_get_user_entitlement_ownership_by_sku(
	namespace_param: String, user_id: String, sku: String, entitlement_clazz: String = ""
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


## Retrieves a user entitlement by ID
## GET /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}
##
## Get user entitlement. Other detail info: Returns: entitlement
##
## Parameters:
## - entitlement_id: Entitlement ID.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String
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


## Consumes a user entitlement
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/decrement
##
## Decrements the use count of a user entitlement. If the use count reaches 0, the entitlement status changes to CONSUMED. For OPTIONBOX entitlements, include the item ID in the request options.
##
## Parameters:
## - entitlement_id: Entitlement ID.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_consume_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Sells a user entitlement
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/sell
##
## Marks a user entitlement as sold. For consumable entitlements with a use count of 0, the status changes to CONSUMED. For durable entitlements, the status changes to SOLD.
##
## Parameters:
## - entitlement_id: Entitlement ID.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_sell_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Splits a user entitlement into two
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/split
##
## Splits a specified use count from an entitlement and creates a new entitlement with the split use count. Returns the updated entitlement.
##
## Parameters:
## - entitlement_id: Entitlement ID.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_split_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Transfers use count from one entitlement to another
## PUT /platform/public/namespaces/{namespace}/users/{userId}/entitlements/{entitlementId}/transfer
##
## Transfers a specified use count from one entitlement to another. Returns the updated entitlement.
##
## Parameters:
## - entitlement_id: Source entitlement ID.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_transfer_user_entitlement(
	entitlement_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Redeems a campaign code for a user
## POST /platform/public/namespaces/{namespace}/users/{userId}/fulfillment/code
##
## Redeem campaign code, this api have rate limit, default: only allow request once per user in 2 seconds Other detail info: Returns: fulfillment result
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_redeem_code(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Verifies an Apple IAP receipt and fulfills the item
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/apple/receipt
##
## Verifies an Apple IAP receipt and fulfills the corresponding item. Subscription purchases are not supported.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_fulfill_apple_iap_item(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs Epic Games inventory items for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/epicgames/sync
##
## Syncs Epic Games inventory items and fulfills any unmapped entitlements.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_epic_games_inventory(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Verifies a Google IAP receipt and fulfills the item
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/google/receipt
##
## Verifies a Google Play IAP receipt and fulfills the corresponding item.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_fulfill_google_iap_item(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs a Meta Quest subscription transaction for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/oculus/subscription/sync
##
## Returns existing subscription transaction information for a Meta Quest subscription.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_oculus_subscriptions(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs Oculus entitlements for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/oculus/sync
##
## Syncs Oculus entitlements and fulfills any unmapped items.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_oculus_consumable_entitlements(namespace_param: String, user_id: String) -> Dictionary:
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


## Syncs a user's PSN Store entitlements
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/psn/sync
##
## Syncs entitlements from the PlayStation Store and fulfills any unmapped items.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_reconcile_play_station_store(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs PSN Store entitlements across multiple service labels
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/psn/sync/multiServiceLabels
##
## Syncs entitlements from the PlayStation Store across multiple service labels and fulfills any unmapped items.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_reconcile_play_station_store_with_multiple_service_labels(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs Steam inventory items for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/steam/sync
##
## Syncs Steam inventory items and fulfills any unmapped entitlements.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_steam_inventory(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs abnormal Steam transactions when sync mode is TRANSACTION
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/steam/syncAbnormalTransaction
##
## Syncs Steam orders that have abnormal transaction states. This operation only functions when the Steam IAP configuration uses TRANSACTION sync mode.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_steam_abnormal_transaction(namespace_param: String, user_id: String) -> Dictionary:
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


## Syncs a Steam in-app purchase by transaction ID
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/steam/syncByTransaction
##
## Syncs a Steam in-app purchase by transaction ID and fulfills the corresponding item.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_steam_iap_by_transaction(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a user's IAP subscriptions for a platform
## GET /platform/public/namespaces/{namespace}/users/{userId}/iap/subscriptions/platforms/{platform}
##
## Retrieves IAP subscriptions for a user on a specific platform, sorted by updatedAt by default. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - platform: IAP platform to query subscriptions for.
## - user_id: AccelByte user ID
## - active_only: Filters to only return active subscriptions.
## - group_id: If platform is Google, please pass google subscription product id. if platform is Apple, please pass apple subscription group id
## - limit: Number of results to return.
## - offset: Number of results to skip for pagination
## - product_id: If platform is Google, please pass google subscription plan id. if platform is Apple, please pass apple subscription product id
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


## Syncs Twitch Drops entitlements for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/twitch/sync
##
## Syncs Twitch Drops entitlements and fulfills any unmapped items.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_twitch_drops_entitlement_1(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Syncs Xbox inventory items for a user
## PUT /platform/public/namespaces/{namespace}/users/{userId}/iap/xbl/sync
##
## Syncs Xbox inventory items and fulfills any unmapped entitlements.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func sync_xbox_inventory(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists a user's orders
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders
##
## Lists a user's orders sorted by most recent. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - discounted: Filters to only return discounted orders.
## - item_id: Item ID to filter orders by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Order status to filter by.
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


## Creates an order for a user
## POST /platform/public/namespaces/{namespace}/users/{userId}/orders
##
## Creates an order and returns the checkout link and payment token. Users with the SANDBOX permission create sandbox orders, which skip real payment for xsolla and alipay, and skip price validation for wxpay.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_create_user_order(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Previews an order price after applying a discount code
## POST /platform/public/namespaces/{namespace}/users/{userId}/orders/discount/preview
##
## Calculates the order price after applying a discount code. Does not perform full order validation; only validates the discount code and computes the discounted price.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_preview_order_price(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Retrieves a user order by order number
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}
##
## Get user order. Other detail info: Returns: get order
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number.
## - user_id: AccelByte user ID
func public_get_user_order(
	namespace_param: String, order_no: String, user_id: String
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


## Cancels a user order
## PUT /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/cancel
##
## Cancel user order. Other detail info: Returns: cancelled order
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number.
## - user_id: AccelByte user ID
func public_cancel_user_order(
	namespace_param: String, order_no: String, user_id: String
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


## Retrieves the history of a user order
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/history
##
## Get user order histories. Other detail info: Returns: get order history
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number.
## - user_id: AccelByte user ID
func public_get_user_order_histories(
	namespace_param: String, order_no: String, user_id: String
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


## Downloads the receipt PDF for a user order
## GET /platform/public/namespaces/{namespace}/users/{userId}/orders/{orderNo}/receipt.pdf
##
## Download user order receipt by orderNo. Other detail info: Returns: order receipt pdf
##
## Parameters:
## - namespace_param: Game namespace
## - order_no: Order number.
## - user_id: AccelByte user ID
func public_download_user_order_receipt(
	namespace_param: String, order_no: String, user_id: String
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


## Retrieves a user's saved payment accounts
## GET /platform/public/namespaces/{namespace}/users/{userId}/payment/accounts
##
## [Not supported yet in AGS Shared Cloud] Get payment accounts. Other detail info: Returns: Payment account list
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_payment_accounts(namespace_param: String, user_id: String) -> Dictionary:
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


## Deletes a saved payment account
## DELETE /platform/public/namespaces/{namespace}/users/{userId}/payment/accounts/{type}/{id}
##
## [Not supported yet in AGS Shared Cloud] Deletes the specified saved payment account.
##
## Parameters:
## - id: Payment account id
## - namespace_param: Game namespace
## - type_param: Payment account type
## - user_id: AccelByte user ID
func public_delete_payment_account(
	id: String, namespace_param: String, type_param: String, user_id: String
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


## Lists active section contents
## GET /platform/public/namespaces/{namespace}/users/{userId}/sections
##
## Lists active section contents for a user. Users with PREVIEW permission can view draft sections.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - auto_calc_estimated_price: Whether to include estimated prices for items in the sections.
## - language: Language code for localized content.
## - region: Region code for regional pricing.
## - store_id: Store to retrieve sections from; defaults to the published store.
## - view_id: View ID to filter sections by.
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


## Lists a user's subscriptions
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions
##
## Query user subscriptions. Other detail info: Returns: paginated subscription
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - charge_status: Charge status to filter subscriptions by.
## - item_id: Item ID to filter subscriptions by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sku: Item SKU to filter subscriptions by.
## - status: Subscription status to filter by.
## - subscribed_by: Indicates who initiated the subscription (USER or PLATFORM).
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


## Creates a subscription for a user
## POST /platform/public/namespaces/{namespace}/users/{userId}/subscriptions
##
## Creates a subscription for a user. Supports both real and virtual payment. Use the checkout link returned in the response to complete the payment flow.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_subscribe_subscription(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Checks whether a user can subscribe to an item
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/subscribable/byItemId
##
## Check user subscription subscribable by itemId, ACTIVE USER subscription can't do subscribe again. Other detail info: Returns: subscribable info
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - item_id: Item ID to check subscription eligibility for.
func public_check_user_subscription_subscribable_by_item_id(
	namespace_param: String, user_id: String, item_id: String
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


## Retrieves a user subscription by ID
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}
##
## Get user subscription. Other detail info: Returns: subscription
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription ID.
## - user_id: AccelByte user ID
func public_get_user_subscription(
	namespace_param: String, subscription_id: String, user_id: String
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


## Requests a billing account change for a subscription
## PUT /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/billingAccount
##
## Initiates a billing account change for a subscription and returns a payment station URL. The change takes effect when the system receives the first successful payment notification. Only active subscriptions support this operation.
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription ID.
## - user_id: AccelByte user ID
func public_change_subscription_billing_account(
	namespace_param: String, subscription_id: String, user_id: String
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


## Cancels a subscription
## PUT /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/cancel
##
## Cancels a subscription. Only ACTIVE subscriptions support cancellation. For billing safety, cancel at least one day before the current period ends. Set immediateCancel to true to cancel immediately without waiting for the period to end.
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription ID.
## - user_id: AccelByte user ID
func public_cancel_subscription(
	namespace_param: String, subscription_id: String, user_id: String, body: Dictionary = {}
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


## Retrieves billing history for a subscription
## GET /platform/public/namespaces/{namespace}/users/{userId}/subscriptions/{subscriptionId}/history
##
## Get user subscription billing histories. Other detail info: Returns: paginated subscription history
##
## Parameters:
## - namespace_param: Game namespace
## - subscription_id: Subscription ID.
## - user_id: AccelByte user ID
## - exclude_free: Whether to exclude free billing records from the history.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Lists all views for a user
## GET /platform/public/namespaces/{namespace}/users/{userId}/views
##
## Lists all store views available to a user. Users with PREVIEW permission can view draft views.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - language: Language code for localized content.
## - store_id: Store to retrieve views from; defaults to the published store.
func public_list_views(
	namespace_param: String, user_id: String, language: String = "", store_id: String = ""
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


## Retrieves a wallet by currency code
## GET /platform/public/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}
##
## Get a wallet by currency code. Other detail info: Returns: wallet info
##
## Parameters:
## - currency_code: Currency code of the wallet.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_wallet(
	currency_code: String, namespace_param: String, user_id: String
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


## Lists wallet transactions for a currency code
## GET /platform/public/namespaces/{namespace}/users/{userId}/wallets/{currencyCode}/transactions
##
## Lists wallet transactions for a currency code, ordered by creation time descending. Returns paginated results using offset and limit.
##
## Parameters:
## - currency_code: Currency code of the wallet.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - balance_source: balanceSource
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func public_list_user_wallet_transactions(
	currency_code: String,
	namespace_param: String,
	user_id: String,
	balance_source: String = "",
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
	if not balance_source.is_empty():
		query_params["balanceSource"] = balance_source
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


## Retrieves DLC reward contents for the current user
## GET /platform/public/users/me/dlc/content
##
## Get user dlc reward contents. If includeAllNamespaces is false, will only return the dlc synced from the current namespace Other detail info: Returns: user dlc
##
## Parameters:
## - include_all_namespaces: Whether to include DLC synced from all namespaces.
## - type_param: DLC type to filter by.
func public_get_my_dlc_content(
	type_param: String, include_all_namespaces: bool = false
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


## Lists fulfillments in a namespace
## GET /platform/v2/admin/namespaces/{namespace}/fulfillments
##
## [Not supported yet in AGS Shared Cloud] Lists fulfillments in a namespace within a time range. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - end_time: End time is exclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - start_time: Start time is inclusive, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - state: Fulfillment state to filter by.
## - transaction_id: Transaction ID to filter by.
## - user_id: AccelByte user ID
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


## Queries items by criteria within a store
## GET /platform/v2/admin/namespaces/{namespace}/items/byCriteria
##
## Queries items by criteria within a store. For itemStatus: true returns only ACTIVE items, false returns only INACTIVE items, and omitting the parameter returns both. Returns paginated results using offset and limit.
##
## Parameters:
## - namespace_param: Game namespace
## - app_type: App type to filter items by.
## - available_date: Allowed format: d{4}-d{2}-d{2}Td{2}:d{2}:d{2}Z , filter date include(purchaseAt, expireAt)
## - base_app_id: Base app ID to filter items by.
## - category_path: Category path to filter items by.
## - features: Comma-separated list of feature flags to filter items by.
## - include_sub_category_item: Whether to include items from subcategories when filtering by category path; defaults to false.
## - item_name: ItemName, fuzzy matching
## - item_status: Item status to filter by (true = ACTIVE, false = INACTIVE).
## - item_type: Item type to filter by.
## - keyword: keyword matched against the field chosen by searchBy. For NAME, only the first 500 matches are paged
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - region: Exist in region
## - search_by: field the keyword searches, ignored when keyword is not set: NAME (contains, case-insensitive, ranked by relevance), SKU (prefix, case-sensitive) or ITEM_ID (exact)
## - section_exclusive: Whether to exclude items that belong exclusively to a section.
## - sort_by: Default is name:asc,displayOrder:asc, allow values: [name, name:asc, name:desc, createdAt, createdAt:asc, createdAt:desc, updatedAt, updatedAt:asc, updatedAt:desc, displayOrder, displayOrder:asc, displayOrder:desc],and support sort group, eg: sortBy=name:asc,createdAt:desc. Make sure to always use more than one sort if the first sort is not an unique valuefor example, if you wish to sort by displayOrder, make sure to include other sort such as name or createdAt after the first sort, eg: displayOrder:asc,name:asc
## - store_id: Store to query items from; defaults to the published store.
## - tags: Comma-separated list of tags to filter items by.
## - target_namespace: Namespace to search items in.
## - with_total: Whether to include the total item count in the response.
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
	keyword: String = "",
	limit: int = -1,
	offset: int = -1,
	region: String = "",
	search_by: String = "",
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
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not search_by.is_empty():
		query_params["searchBy"] = search_by
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


## Imports a store from a file
## PUT /platform/v2/admin/namespaces/{namespace}/stores/import
##
## Imports a store from a file.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Default we will use published store id,and will create published store if it dose not exist
## - strict_mode: Default strict mode is true, if strict mode is false, will not do any validation.
## - file: Store export file to import.
func import_store_1(
	namespace_param: String, store_id: String = "", strict_mode: bool = false, file: String = ""
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


## Exports a store's items
## POST /platform/v2/admin/namespaces/{namespace}/stores/{storeId}/export
##
## Exports all or a selected subset of items from a store.
##
## Parameters:
## - namespace_param: Game namespace
## - store_id: Store ID.
func export_store_1(namespace_param: String, store_id: String, body: Dictionary = {}) -> Dictionary:
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


## Verifies an Apple IAP transaction and fulfills the item
## PUT /platform/v2/public/namespaces/{namespace}/users/{userId}/iap/apple/receipt
##
## Verifies an Apple IAP transaction and fulfills the corresponding item, including subscription purchases.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func v2_public_fulfill_apple_iap_item(
	namespace_param: String, user_id: String, body: Dictionary = {}
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
##
## Fulfill multiple transactions.
## Other detail info:
##
## * Request body : list of fulfillment v3 requests. storeId, region, language, and entitlementCollectionId can be ignored.
## * SUBSCRIPTION, SEASON (Season Pass and Season Tier), and EXTENSION items support fulfillment only; revocation is not currently supported.
## *  Returns : list of fulfillment v2 results. Each result contains summaries only for grants executed by this invocation, not previous attempts.
func bulk_fulfill_items_v3(
	namespace_param: String, user_id: String, body: Array = []
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


## Fulfills items for a transaction
## PUT /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}
##
## [Not supported yet in AGS Shared Cloud] Fulfills items for a transaction ID. The storeId, region, language, and entitlementCollectionId fields in the input are not used.
##
## Parameters:
## - namespace_param: Game namespace
## - transaction_id: Transaction ID.
## - user_id: AccelByte user ID
func fulfill_items_v3(
	namespace_param: String, transaction_id: String, user_id: String, body: Dictionary = {}
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


## Get latest execution history of a fulfilled transaction
## GET /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/history/latest
##
## Returns the history referenced by the latest action of a currently FULFILLED transaction. Does not aggregate previous attempts or return revoked grants. Intended for caller recovery after a no-op retry.
func get_latest_fulfillment_history(
	namespace_param: String, transaction_id: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/history/latest"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "transactionId" + "}", transaction_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retries a fulfillment by transaction ID
## PUT /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/retry
##
## [Not supported yet in AGS Shared Cloud] Retries a fulfillment by transaction ID without resending the original request data.
##
## Parameters:
## - namespace_param: Game namespace
## - transaction_id: Transaction ID.
## - user_id: AccelByte user ID
func retry_fulfill_items_v3(
	namespace_param: String, transaction_id: String, user_id: String
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


## Revokes items for a transaction
## PUT /platform/v3/admin/namespaces/{namespace}/users/{userId}/fulfillments/{transactionId}/revoke
##
## [Not supported yet in AGS Shared Cloud] Revokes items associated with a transaction ID.
##
## Parameters:
## - namespace_param: Game namespace
## - transaction_id: Transaction ID.
## - user_id: AccelByte user ID
func revoke_items_v3(
	namespace_param: String, transaction_id: String, user_id: String
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
