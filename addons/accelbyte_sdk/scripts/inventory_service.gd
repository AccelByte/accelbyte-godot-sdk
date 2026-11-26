## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## inventory_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-inventory-service (Early Access)
## Version: 0.3.0
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


## Lists integration configurations
## GET /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations
##
## Lists integration configurations in the namespace. Results use standard offset-based pagination. You can filter them with `limit`, `offset`, and `sortBy`.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for the results. Valid values are `createdAt`, `createdAt:asc`, and `createdAt:desc`. Defaults to `createdAt`.
func admin_list_integration_configurations(
	namespace_param: String, limit: int = -1, offset: int = -1, sort_by: String = ""
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


## Creates an integration configuration
## POST /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations
##
## Creates an integration configuration in the namespace. Each namespace can have only one configuration for a given `serviceName`.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_integration_configuration(
	namespace_param: String, body: Dictionary = {}
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


## Updates an integration configuration
## PUT /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}
##
## Updates an integration configuration in the namespace. Each namespace can have only one configuration for a given `serviceName`.
##
## Parameters:
## - integration_configuration_id: Unique identifier for the integration configuration to update.
## - namespace_param: Game namespace
func admin_update_integration_configuration(
	integration_configuration_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}"
	url_path = url_path.replace(
		"{" + "integrationConfigurationId" + "}", integration_configuration_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates integration configuration status
## PUT /inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}/status
##
## Updates the status of an integration configuration in the namespace. Each namespace can have only one configuration for a given `serviceName`.
##
## Parameters:
## - integration_configuration_id: Unique identifier for the integration configuration to update.
## - namespace_param: Game namespace
func admin_update_status_integration_configuration(
	integration_configuration_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/integrationConfigurations/{integrationConfigurationId}/status"
	url_path = url_path.replace(
		"{" + "integrationConfigurationId" + "}", integration_configuration_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists inventories
## GET /inventory/v1/admin/namespaces/{namespace}/inventories
##
## Lists inventories in the namespace. Results use standard offset-based pagination. You can filter them by inventory configuration, user, and sort order.
##
## Parameters:
## - namespace_param: Game namespace
## - inventory_configuration_code: Inventory configuration code used to filter the returned inventories.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for the results. Valid values are `createdAt`, `createdAt:asc`, `createdAt:desc`, `inventoryConfigurationCode`, `inventoryConfigurationCode:asc`, `inventoryConfigurationCode:desc`, `updatedAt`, `updatedAt:asc`, and `updatedAt:desc`. Defaults to `createdAt`.
## - user_id: AccelByte user ID
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


## Creates an inventory
## POST /inventory/v1/admin/namespaces/{namespace}/inventories
##
## Creates an inventory for a user in the namespace. The referenced inventory configuration must already exist and sets the initial slot and upgrade-slot limits for the new inventory. You can update those limits later with the inventory update operation.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_inventory(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves an inventory
## GET /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}
##
## Retrieves inventory details for the specified inventory in the namespace.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory to retrieve.
## - namespace_param: Game namespace
func admin_get_inventory(inventory_id: String, namespace_param: String) -> Dictionary:
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


## Updates an inventory
## PUT /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}
##
## Updates the slot capacity for an inventory. Positive `incMaxSlots` values increase the current slot limit, and negative values reduce it. You cannot switch between limited and unlimited slots through this operation.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory to update.
## - namespace_param: Game namespace
func admin_update_inventory(
	inventory_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes an inventory
## DELETE /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}
##
## Deletes an inventory from the namespace. Remove all items from the inventory before calling this operation.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory to delete.
## - namespace_param: Game namespace
func delete_inventory(
	inventory_id: String, namespace_param: String, body: Dictionary = {}
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


## Lists inventory items
## GET /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}/items
##
## Lists items in the specified inventory. Results use standard offset-based pagination. You can filter them by source item and tags.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory whose items to list.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for the results. Valid values are `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, and `updatedAt:desc`. Defaults to `createdAt`.
## - source_item_id: Source item identifier used to filter the returned inventory items.
## - tags: Tag filter applied when listing inventory items.
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


## Retrieves an inventory item
## GET /inventory/v1/admin/namespaces/{namespace}/inventories/{inventoryId}/slots/{slotId}/sourceItems/{sourceItemId}
##
## Retrieves the inventory item that matches the specified inventory, slot, and source item identifiers.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the item.
## - namespace_param: Game namespace
## - slot_id: Unique identifier for the slot that contains the item.
## - source_item_id: Unique identifier for the source item associated with the inventory item.
func admin_get_inventory_item(
	inventory_id: String, namespace_param: String, slot_id: String, source_item_id: String
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


## Lists inventory configurations
## GET /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations
##
## Lists inventory configurations in the namespace. Results use standard offset-based pagination. You can filter them by configuration code.
##
## Parameters:
## - namespace_param: Game namespace
## - code: Configuration code filter. Matches inventory configurations whose code contains the provided value.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for the results. Valid values are `code`, `code:asc`, `code:desc`, `createdAt`, `createdAt:asc`, `createdAt:desc`, `updatedAt`, `updatedAt:asc`, and `updatedAt:desc`. Defaults to `createdAt`.
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


## Creates an inventory configuration
## POST /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations
##
## Creates an inventory configuration in the namespace. Each namespace can have only one configuration with a given code.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_inventory_configuration(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves an inventory configuration
## GET /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}
##
## Retrieves the specified inventory configuration in the namespace.
##
## Parameters:
## - inventory_configuration_id: Unique identifier for the inventory configuration to retrieve.
## - namespace_param: Game namespace
func admin_get_inventory_configuration(
	inventory_configuration_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}"
	url_path = url_path.replace(
		"{" + "inventoryConfigurationId" + "}", inventory_configuration_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates an inventory configuration
## PUT /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}
##
## Updates an inventory configuration in the namespace. Each namespace can have only one configuration with a given code.
##
## Parameters:
## - inventory_configuration_id: Unique identifier for the inventory configuration to update.
## - namespace_param: Game namespace
func admin_update_inventory_configuration(
	inventory_configuration_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}"
	url_path = url_path.replace(
		"{" + "inventoryConfigurationId" + "}", inventory_configuration_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes an inventory configuration
## DELETE /inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}
##
## Deletes an inventory configuration from the namespace. You cannot delete a configuration while any inventory still references it, such as when its status is `TIED`.
##
## Parameters:
## - inventory_configuration_id: Unique identifier for the inventory configuration to delete.
## - namespace_param: Game namespace
func admin_delete_inventory_configuration(
	inventory_configuration_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/inventoryConfigurations/{inventoryConfigurationId}"
	url_path = url_path.replace(
		"{" + "inventoryConfigurationId" + "}", inventory_configuration_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists item types
## GET /inventory/v1/admin/namespaces/{namespace}/itemtypes
##
## Lists item types in the namespace. Results use standard offset-based pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort order for the results. Valid values are `createdAt`, `createdAt:asc`, `createdAt:desc`, `name`, `name:asc`, and `name:desc`. Defaults to `createdAt`.
func admin_list_item_types(
	namespace_param: String, limit: int = -1, offset: int = -1, sort_by: String = ""
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


## Creates an item type
## POST /inventory/v1/admin/namespaces/{namespace}/itemtypes
##
## Creates a new item type in the namespace. The item type name must be unique within the namespace, and you can call this operation safely even if the item type already exists.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_item_type(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/itemtypes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes an item type
## DELETE /inventory/v1/admin/namespaces/{namespace}/itemtypes/{itemTypeName}
##
## Deletes the specified item type from the namespace. If the item type does not exist in the namespace, the operation returns `404 Not Found`.
##
## Parameters:
## - item_type_name: Name of the item type to delete.
## - namespace_param: Game namespace
func admin_delete_item_type(item_type_name: String, namespace_param: String) -> Dictionary:
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


## Lists tags
## GET /inventory/v1/admin/namespaces/{namespace}/tags
##
## Lists tags in the namespace. Results use standard offset-based pagination. You can filter them by owner.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - owner: Owner filter for the returned tags. Valid values are `SERVER` and `CLIENT`.
## - sort_by: Sort order for the results. Valid values are `createdAt`, `createdAt:asc`, `createdAt:desc`, `name`, `name:asc`, and `name:desc`. Defaults to `createdAt`.
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


## Creates a tag
## POST /inventory/v1/admin/namespaces/{namespace}/tags
##
## Creates a new tag in the namespace. The tag name must be unique within the namespace, and you can call this operation safely even if the tag already exists.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_tag(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes a tag
## DELETE /inventory/v1/admin/namespaces/{namespace}/tags/{tagName}
##
## Deletes the specified tag from the namespace. If the tag does not exist in the namespace, the operation returns `404 Not Found`.
##
## Parameters:
## - namespace_param: Game namespace
## - tag_name: Name of the tag to delete.
func admin_delete_tag(namespace_param: String, tag_name: String) -> Dictionary:
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


## Consumes an item from a user's inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/consume
##
## Consumes an item from the user's inventory. If the item type is `OPTIONBOX`, include the selected item ID in `options`.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the item to consume.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - date_range_validation: Whether to check the item's date-range restrictions. Defaults to `false`.
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


## Updates inventory items
## PUT /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items
##
## Updates items in the user's inventory in a single request. The operation creates referenced tags automatically when needed.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the items to update.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_update_my_items(
	inventory_id: String, namespace_param: String, user_id: String, body: Array = []
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


## Saves items to a specific inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items
##
## Saves items to a specific inventory for the user. For `ECOMMERCE` items, store-configured values can override fields such as `slotUsed`, `serverCustomAttributes`, `customAttributes`, and `type`, and the item's configured `useCount` multiplies the stored quantity. For `OTHER` items, you can define the item type directly in the request.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that will receive the saved items.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_save_item_to_inventory(
	inventory_id: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Removes inventory items
## DELETE /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items
##
## Removes items from the user's inventory in a single request.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the items to remove.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_remove_items(
	inventory_id: String, namespace_param: String, user_id: String, body: Array = []
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


## Saves items to a specific inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items/bulk
##
## Saves items to a specific inventory for the user in one bulk request. For `ECOMMERCE` items, store-configured values can override fields such as `slotUsed`, `serverCustomAttributes`, `customAttributes`, and `type`, and the item's configured `useCount` multiplies the stored quantity. For `OTHER` items, you can define the item type directly in each request item. A single bulk request can save up to 10 items.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that will receive the saved items.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_save_item_to_inventory(
	inventory_id: String, namespace_param: String, user_id: String, body: Array = []
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


## Consumes items from a user's inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items/consume
##
## Consumes one or more items from the user's inventory in a single request. If an item's type is `OPTIONBOX`, include the selected item ID in that item's `options`. This operation is not atomic: each item is consumed independently, so partial success is expected, and items already consumed are not rolled back if another item in the same request fails. Do not retry the entire batch after a timeout or network error without first confirming item state, since already-consumed items would be consumed again. Request parsing and validation failures return HTTP 400 with a single error body before any item is processed; item-level failures (not found, forbidden, insufficient quantity, etc.) are instead reported per item inside the HTTP 200 response body's `errorDetails` field, so the documented HTTP 404 and 500 responses are not expected in practice for this operation. Each successful entry also includes `item`, the inventory item after consumption, with the same fields the single consume endpoint returns; its `qty` is the quantity left, which is 0 when the item was fully consumed and removed from the inventory. `item` is omitted for failed entries, and also when a retry with the same `transactionId` finds that the item was already fully consumed.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the items to consume.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_consume_items(
	inventory_id: String, namespace_param: String, user_id: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventories/{inventoryId}/items/consume"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates user inventories by inventory configuration code
## PUT /inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventoryConfigurations/{inventoryConfigurationCode}/inventories
##
## Updates the user's inventories that use the specified inventory configuration code. Positive values increase `maxSlots`, negative values decrease it, and you cannot switch between limited and unlimited slot modes with this update.
##
## Parameters:
## - inventory_configuration_code: Inventory configuration code shared by the user's inventories to update.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_update_user_inventories_by_inventory_code(
	inventory_configuration_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/admin/namespaces/{namespace}/users/{userId}/inventoryConfigurations/{inventoryConfigurationCode}/inventories"
	url_path = url_path.replace(
		"{" + "inventoryConfigurationCode" + "}", inventory_configuration_code.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Saves an item to the user's inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/items
##
## Saves an item to the user's inventory using the provided `inventoryConfigurationCode`. If the user does not already have an inventory for that configuration, the service creates one. If the item already exists, the quantity increases. When an inventory is full, the service checks the user's other inventories in creation order for an available slot. For `ECOMMERCE` items, store-configured values can override fields such as `slotUsed`, `serverCustomAttributes`, `customAttributes`, and `type`, and the item's configured `useCount` multiplies the stored quantity.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_save_item(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
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


## Saves items to the user's inventory
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/items/bulk
##
## Saves items to the user's inventory in a bulk request using the provided `inventoryConfigurationCode` values. If the user does not already have an inventory for a configuration, the service creates one. If an item already exists, the quantity increases. When an inventory is full, the service checks the user's other inventories in creation order for an available slot. For `ECOMMERCE` items, store-configured values can override fields such as `slotUsed`, `serverCustomAttributes`, `customAttributes`, and `type`, and the item's configured `useCount` multiplies the stored quantity. A single bulk request can save up to 10 items.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_bulk_save_item(namespace_param: String, user_id: String, body: Array = []) -> Dictionary:
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


## Updates inventory from user entitlements
## PUT /inventory/v1/admin/namespaces/{namespace}/users/{userId}/items/entitlements/sync
##
## Synchronizes entitlements from the e-commerce service into the user's inventory for items that do not already exist there. The operation skips existing inventory items.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_sync_user_entitlements(namespace_param: String, user_id: String) -> Dictionary:
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


## Checks user inventory capacity for an e-commerce order
## POST /inventory/v1/admin/namespaces/{namespace}/users/{userId}/purchaseable
##
## Checks whether the user's inventory has enough capacity for the requested e-commerce item order.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_purchasable(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists inventory configurations
## GET /inventory/v1/public/namespaces/{namespace}/inventoryConfigurations
##
## Lists inventory configurations in the namespace. The response uses the standard paginated format.
##
## Parameters:
## - namespace_param: Game namespace
## - code: Will partially match inventoryConfigurationCode
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Field and direction used to sort the returned inventory configurations. Defaults to `createdAt`.
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


## Lists item types
## GET /inventory/v1/public/namespaces/{namespace}/itemtypes
##
## Lists item types in the namespace. The response uses the standard paginated format.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Field and direction used to sort the returned item types. Defaults to `createdAt`.
func public_list_item_types(
	namespace_param: String, limit: int = -1, offset: int = -1, sort_by: String = ""
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


## Lists tags
## GET /inventory/v1/public/namespaces/{namespace}/tags
##
## Lists tags in the namespace. The response uses the standard paginated format.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Field and direction used to sort the returned tags. Defaults to `createdAt`.
func public_list_tags(
	namespace_param: String, limit: int = -1, offset: int = -1, sort_by: String = ""
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


## Lists the current user's inventories
## GET /inventory/v1/public/namespaces/{namespace}/users/me/inventories
##
## Lists the current user's inventories in the namespace. The response uses the standard paginated format.
##
## Parameters:
## - namespace_param: Game namespace
## - inventory_configuration_code: Inventory configuration code filter for the returned inventories.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Field and direction used to sort the returned inventories. Defaults to `createdAt`.
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


## Updates the current user's inventory by consuming an item
## POST /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/consume
##
## Consumes an item from the current user's inventory. If the item type is `OPTIONBOX`, include the selected item ID in `options`.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the item to consume.
## - namespace_param: Game namespace
func public_consume_my_item(
	inventory_id: String, namespace_param: String, body: Dictionary = {}
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


## Lists items in the current user's inventory
## GET /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items
##
## Lists items owned by the current user in the specified inventory. The response uses the standard paginated format.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory whose items to list.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Field and direction used to sort the returned inventory items. Defaults to `createdAt`.
## - source_item_id: Source item identifier filter for the returned inventory items.
## - tags: Comma-separated tag filter for the returned inventory items.
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


## Updates items in the current user's inventory
## PUT /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items
##
## Updates one or more items in the current user's inventory in a single request.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the items to update.
## - namespace_param: Game namespace
func public_bulk_update_my_items(
	inventory_id: String, namespace_param: String, body: Array = []
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


## Removes items from the current user's inventory
## DELETE /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items
##
## Removes one or more items from the current user's inventory in a single request.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the items to remove.
## - namespace_param: Game namespace
func public_bulk_remove_my_items(
	inventory_id: String, namespace_param: String, body: Array = []
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


## Consumes items from the current user's inventory
## POST /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items/consume
##
## Consumes one or more items from the current user's inventory in a single request. If an item's type is `OPTIONBOX`, include the selected item ID in that item's `options`. This operation is not atomic: each item is consumed independently, so partial success is expected, and items already consumed are not rolled back if another item in the same request fails. Do not retry the entire batch after a timeout or network error without first confirming item state, since already-consumed items would be consumed again. Request parsing and validation failures return HTTP 400 with a single error body before any item is processed; item-level failures (not found, forbidden, insufficient quantity, etc.) are instead reported per item inside the HTTP 200 response body's `errorDetails` field, so the documented HTTP 404 and 500 responses are not expected in practice for this operation. Each successful entry also includes `item`, the inventory item after consumption, with the same fields the single consume endpoint returns; its `qty` is the quantity left, which is 0 when the item was fully consumed and removed from the inventory. `item` is omitted for failed entries, and also when a retry with the same `transactionId` finds that the item was already fully consumed.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the items to consume.
## - namespace_param: Game namespace
func public_bulk_consume_my_items(
	inventory_id: String, namespace_param: String, body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items/consume"
	url_path = url_path.replace("{" + "inventoryId" + "}", inventory_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Moves items between the current user's inventories
## POST /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/items/movement
##
## Moves items between inventories owned by the same user. For `ECOMMERCE` items, `qty` represents the entitlement `useCount`. For example, moving a quantity of 2 moves 2 units of the entitlement use count.
##
## Parameters:
## - inventory_id: Unique identifier for the source inventory that contains the items to move.
## - namespace_param: Game namespace
func public_move_my_items(
	inventory_id: String, namespace_param: String, body: Dictionary = {}
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


## Gets an item from the current user's inventory
## GET /inventory/v1/public/namespaces/{namespace}/users/me/inventories/{inventoryId}/slots/{slotId}/sourceItems/{sourceItemId}
##
## Retrieves details of a specific item in the current user's inventory.
##
## Parameters:
## - inventory_id: Unique identifier for the inventory that contains the item.
## - namespace_param: Game namespace
## - slot_id: Unique identifier for the slot that contains the item.
## - source_item_id: Unique identifier for the source item associated with the inventory item.
func public_get_item(
	inventory_id: String, namespace_param: String, slot_id: String, source_item_id: String
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
