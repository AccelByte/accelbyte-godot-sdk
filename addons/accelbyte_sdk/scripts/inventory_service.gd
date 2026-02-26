## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## inventory_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-inventory-service (Early Access)
## Version: 0.2.22
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(InventoryService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name InventoryService
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

## To Create Chaining Operation
## POST /inventory/v1/admin/namespaces/{namespace}/chainingOperations
func admin_create_chaining_operations(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/chainingOperations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To list integration configurations
## GET /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations
func admin_list_integration_configurations(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/integrationConfigurations"
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

## To create integration configuration
## POST /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations
func admin_create_integration_configuration(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/integrationConfigurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To update integration configuration
## PUT /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}
func admin_update_integration_configuration(
	integration_configuration_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}"
	url_path = url_path.replace("{" + "integrationConfigurationId" + "}", integration_configuration_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To update status integration configuration to be active / not active 
## PUT /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}/status
func admin_update_status_integration_configuration(
	integration_configuration_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}/status"
	url_path = url_path.replace("{" + "integrationConfigurationId" + "}", integration_configuration_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To list all inventories
## GET /inventory/v1/admin/namespaces/{namespace}/inventories
func admin_list_inventories(
	namespace_param: String,
	inventory_configuration_code: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not inventory_configuration_code.is_empty():
		query_params["inventoryConfigurationCode"] = inventory_configuration_code
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

## To create inventory
## POST /inventory/v1/admin/namespaces/{namespace}/inventories
func admin_create_inventory(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To get an inventory
## GET /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}
func admin_get_inventory(
	inventory_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To update inventory
## PUT /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}
func admin_update_inventory(
	inventory_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To delete inventory
## DELETE /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}
func delete_inventory(
	inventory_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## To list all items
## GET /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}/items
func admin_list_items(
	inventory_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	source_item_id: String = "",
	tags: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}/items"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
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
	if not source_item_id.is_empty():
		query_params["sourceItemId"] = source_item_id
	if not tags.is_empty():
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To get an item
## GET /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}/slots/{slotId}/sourceItems/{sourceItemId}
func admin_get_inventory_item(
	inventory_id: String,
	namespace_param: String,
	slot_id: String,
	source_item_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}/slots/{slotId}/sourceItems/{sourceItemId}"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "slotId" + "}", slot_id.uri_encode())
	url_path = url_path.replace("{" + "sourceItemId" + "}", source_item_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To list inventory configurations
## GET /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations
func admin_list_inventory_configurations(
	namespace_param: String,
	code: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To create inventory configuration
## POST /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations
func admin_create_inventory_configuration(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To get inventory configuration
## GET /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}
func admin_get_inventory_configuration(
	inventory_configuration_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}"
	url_path = url_path.replace("{" + "inventoryConfigurationId" + "}", inventory_configuration_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To update inventory configuration
## PUT /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}
func admin_update_inventory_configuration(
	inventory_configuration_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}"
	url_path = url_path.replace("{" + "inventoryConfigurationId" + "}", inventory_configuration_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To delete inventory configuration
## DELETE /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}
func admin_delete_inventory_configuration(
	inventory_configuration_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}"
	url_path = url_path.replace("{" + "inventoryConfigurationId" + "}", inventory_configuration_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## To list itemtypes
## GET /inventory/v1/admin/namespaces/{namespace}/itemtypes
func admin_list_item_types(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/itemtypes"
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

## To create an itemtype
## POST /inventory/v1/admin/namespaces/{namespace}/itemtypes
func admin_create_item_type(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/itemtypes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To delete an item type
## DELETE /inventory/v1/admin/namespaces/{namespace}/itemtypes/{itemTypeName}
func admin_delete_item_type(
	item_type_name: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/itemtypes/{itemTypeName}"
	url_path = url_path.replace("{" + "itemTypeName" + "}", item_type_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## To list tags
## GET /inventory/v1/admin/namespaces/{namespace}/tags
func admin_list_tags(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	owner: String = "",
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not owner.is_empty():
		query_params["owner"] = owner
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To create a tag
## POST /inventory/v1/admin/namespaces/{namespace}/tags
func admin_create_tag(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To delete a tag
## DELETE /inventory/v1/admin/namespaces/{namespace}/tags/{tagName}
func admin_delete_tag(
	namespace_param: String,
	tag_name: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/tags/{tagName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "tagName" + "}", tag_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## To consume item
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/consume
func admin_consume_user_item(
	inventory_id: String,
	namespace_param: String,
	user_id: String,
	date_range_validation: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/consume"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not date_range_validation.is_empty():
		query_params["dateRangeValidation"] = date_range_validation
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To bulk update items
## PUT /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items
func admin_bulk_update_my_items(
	inventory_id: String,
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To save item to specific inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items
func admin_save_item_to_inventory(
	inventory_id: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To bulk remove items
## DELETE /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items
func admin_bulk_remove_items(
	inventory_id: String,
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Bulk save items to specific inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items/bulk
func admin_bulk_save_item_to_inventory(
	inventory_id: String,
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items/bulk"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To update user inventories by inventory code
## PUT /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventoryConfigurations/{inventoryConfigurationCode}/inventories
func admin_update_user_inventories_by_inventory_code(
	inventory_configuration_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventoryConfigurations/{inventoryConfigurationCode}/inventories"
	url_path = url_path.replace("{" + "inventoryConfigurationCode" + "}", inventory_configuration_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To save item
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/items
func admin_save_item(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/items"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk save items to inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/items/bulk
func admin_bulk_save_item(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/items/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To sync user's entitlements to e-commerce
## PUT /inventory/v1/admin/namespaces/{namespace}/users/{userId}/items/entitlements/sync
func admin_sync_user_entitlements(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/items/entitlements/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To validate user inventory capacity when purchase ecommerce item
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/purchaseable
func admin_purchasable(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/purchaseable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To list inventory configurations
## GET /inventory/v1/public/namespaces/{namespace}/inventoryConfigurations
func public_list_inventory_configurations(
	namespace_param: String,
	code: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/inventoryConfigurations"
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
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To list item types
## GET /inventory/v1/public/namespaces/{namespace}/itemtypes
func public_list_item_types(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/itemtypes"
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

## To list tags
## GET /inventory/v1/public/namespaces/{namespace}/tags
func public_list_tags(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/tags"
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

## To list all my inventories
## GET /inventory/v1/public/namespaces/{namespace}/users/me/inventories
func public_list_inventories(
	namespace_param: String,
	inventory_configuration_code: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not inventory_configuration_code.is_empty():
		query_params["inventoryConfigurationCode"] = inventory_configuration_code
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

## To consume item
## POST /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/consume
func public_consume_my_item(
	inventory_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/consume"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To list all items
## GET /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items
func public_list_items(
	inventory_id: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	source_item_id: String = "",
	tags: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
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
	if not source_item_id.is_empty():
		query_params["sourceItemId"] = source_item_id
	if not tags.is_empty():
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## To bulk update items
## PUT /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items
func public_bulk_update_my_items(
	inventory_id: String,
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## To bulk remove items
## DELETE /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items
func public_bulk_remove_my_items(
	inventory_id: String,
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## To move items between my inventories
## POST /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items/movement
func public_move_my_items(
	inventory_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items/movement"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## To get an item
## GET /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/slots/{slotId}/sourceItems/{sourceItemId}
func public_get_item(
	inventory_id: String,
	namespace_param: String,
	slot_id: String,
	source_item_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/slots/{slotId}/sourceItems/{sourceItemId}"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "slotId" + "}", slot_id.uri_encode())
	url_path = url_path.replace("{" + "sourceItemId" + "}", source_item_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
