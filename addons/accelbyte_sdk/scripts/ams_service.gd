## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## ams_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: fleet-commander
## Version: 1.47.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(AmsService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name AmsService
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


## Checks if fleet commander can auth with AMS
## GET /ams/auth
##
## Checks whether Fleet Commander can communicate with AMS using the current IAM credentials.
func auth_check() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/auth"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Checks service health
## GET /ams/healthz
##
## Checks whether the AMS portal service is reachable and responding. Use this operation for basic service health verification.
func portal_health_check() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the account associated with the namespace
## GET /ams/v1/admin/namespaces/{namespace}/account
##
## Retrieves the AMS account associated with the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_account_get(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a new AMS account
## POST /ams/v1/admin/namespaces/{namespace}/account
##
## Creates an AMS account for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_account_create(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves an account link token
## GET /ams/v1/admin/namespaces/{namespace}/account/link
##
## Returns a link token that lets you connect another namespace to the account associated with the provided namespace. This operation fails if the specified namespace is not linked to an account.
##
## Parameters:
## - namespace_param: Game namespace
func admin_account_link_token_get(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Links an account to a namespace
## POST /ams/v1/admin/namespaces/{namespace}/account/link
##
## Links an existing AMS account to the namespace by using a valid account link token. The request fails if the namespace is already linked to an account.
##
## Parameters:
## - namespace_param: Game namespace
func admin_account_link(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves all artifacts that match the provided criteria
## GET /ams/v1/admin/namespaces/{namespace}/artifacts
##
## Returns artifacts that match the provided search criteria. When you omit a filter, the operation does not filter results by that field.
##
## Parameters:
## - namespace_param: Game namespace
## - artifact_type: Artifact type to include. Valid values: log, coredump.
## - count: Defines the largest number of records returned in one page.
## - end_date: Omit artifacts with collection dates newer than
## - fleet_id: Fleet ID filter for the artifact query.
## - image_id: Image ID filter for the artifact query.
## - max_size: Largest artifact size to include, in bytes.
## - min_size: Smallest artifact size to include, in bytes.
## - offset: Number of results to skip for pagination
## - region: Region filter for the artifact query.
## - server_id: Server ID filter for the artifact query.
## - sort_by: Field name to sort the artifact
## - sort_direction: Sort order for the returned artifacts.
## - start_date: Omit artifacts with collection dates older than
## - status: Artifact processing status. Valid values: success, skipped_sample, skipped_usage, failed.
func artifact_get(
	namespace_param: String,
	artifact_type: String = "",
	count: int = -1,
	end_date: String = "",
	fleet_id: String = "",
	image_id: String = "",
	max_size: int = -1,
	min_size: int = -1,
	offset: int = -1,
	region: String = "",
	server_id: String = "",
	sort_by: String = "",
	sort_direction: String = "",
	start_date: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not artifact_type.is_empty():
		query_params["artifactType"] = artifact_type
	if count >= 0:
		query_params["count"] = count
	if not end_date.is_empty():
		query_params["endDate"] = end_date
	if not fleet_id.is_empty():
		query_params["fleetID"] = fleet_id
	if not image_id.is_empty():
		query_params["imageID"] = image_id
	if max_size >= 0:
		query_params["maxSize"] = max_size
	if min_size >= 0:
		query_params["minSize"] = min_size
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not server_id.is_empty():
		query_params["serverId"] = server_id
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
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


## Deletes artifacts in bulk that match any of the provided criteria
## DELETE /ams/v1/admin/namespaces/{namespace}/artifacts
##
## Deletes artifacts in bulk that match the provided filters.
##
## Parameters:
## - namespace_param: Game namespace
## - artifact_type: Artifact type filter. Repeat this parameter to target more than one artifact type.
## - fleet_id: Fleet ID filter. Repeat this parameter to target artifacts from more than one fleet.
## - uploaded_before: Uploaded before date
func artifact_bulk_delete(
	namespace_param: String,
	artifact_type: String = "",
	fleet_id: String = "",
	uploaded_before: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not artifact_type.is_empty():
		query_params["artifactType"] = artifact_type
	if not fleet_id.is_empty():
		query_params["fleetId"] = fleet_id
	if not uploaded_before.is_empty():
		query_params["uploadedBefore"] = uploaded_before
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves artifact storage usage for the namespace
## GET /ams/v1/admin/namespaces/{namespace}/artifacts/usage
##
## Retrieves artifact storage usage for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func artifact_usage_get(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts/usage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a specified artifact
## DELETE /ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}
##
## Deletes the specified artifact.
##
## Parameters:
## - artifact_id: Unique identifier for the artifact to delete.
## - namespace_param: Game namespace
func artifact_delete(artifact_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}"
	url_path = url_path.replace("{" + "artifactID" + "}", artifact_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves a signed URL for a specific artifact
## GET /ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}/url
##
## Retrieves a signed URL for the specified artifact.
##
## Parameters:
## - artifact_id: Unique identifier for the artifact to download.
## - namespace_param: Game namespace
func artifact_get_url(artifact_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}/url"
	url_path = url_path.replace("{" + "artifactID" + "}", artifact_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists development server configurations with pagination
## GET /ams/v1/admin/namespaces/{namespace}/development/server-configurations
##
## Lists development server configurations for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - count: Defines the largest number of records returned in one page.
## - image_id: Filter by image ID
## - name_param: Filter by config name
## - offset: Number of results to skip for pagination
## - sort_by: Sort records by the given field
## - sort_direction: Sort direction (ascending or descending)
func development_server_configuration_list(
	namespace_param: String,
	count: int = -1,
	image_id: String = "",
	name_param: String = "",
	offset: int = -1,
	sort_by: String = "",
	sort_direction: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if count >= 0:
		query_params["count"] = count
	if not image_id.is_empty():
		query_params["imageId"] = image_id
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a new development server configuration
## POST /ams/v1/admin/namespaces/{namespace}/development/server-configurations
##
## Creates a development server configuration for the namespace. Configuration names can be up to 128 characters and must match `^[.a-zA-Z0-9_-]+$`.
##
## Parameters:
## - namespace_param: Game namespace
func development_server_configuration_create(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a development server configuration
## GET /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
##
## Retrieves the specified development server configuration.
##
## Parameters:
## - development_server_config_id: The name of the development server configuration
## - namespace_param: Game namespace
func development_server_configuration_get(
	development_server_config_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace(
		"{" + "developmentServerConfigID" + "}", development_server_config_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a development server configuration
## DELETE /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
##
## Deletes the specified development server configuration.
##
## Parameters:
## - development_server_config_id: The name of the development server configuration
## - namespace_param: Game namespace
func development_server_configuration_delete(
	development_server_config_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace(
		"{" + "developmentServerConfigID" + "}", development_server_config_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a development server configuration
## PATCH /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
##
## Updates the specified development server configuration.
##
## Parameters:
## - development_server_config_id: The name of the development server configuration
## - namespace_param: Game namespace
func development_server_configuration_patch(
	development_server_config_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace(
		"{" + "developmentServerConfigID" + "}", development_server_config_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists all fleets in a namespace
## GET /ams/v1/admin/namespaces/{namespace}/fleets
##
## Lists fleets in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
## - active: Filter fleets by active status
## - count: The number of fleets to return
## - include_inactive_regions: include inactive regions in the response
## - name_param: Filter fleets by name
## - offset: Number of results to skip for pagination
## - region: Filter fleets by region
## - sort_by: Sort fleets by column name
## - sort_direction: Sort direction (ascending or descending)
func fleet_list(
	namespace_param: String,
	active: bool = false,
	count: int = -1,
	include_inactive_regions: bool = false,
	name_param: String = "",
	offset: int = -1,
	region: String = "",
	sort_by: String = "",
	sort_direction: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["active"] = active
	if count >= 0:
		query_params["count"] = count
	query_params["includeInactiveRegions"] = include_inactive_regions
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a fleet
## POST /ams/v1/admin/namespaces/{namespace}/fleets
##
## Creates a fleet for the namespace using the provided fleet configuration. You can also include sampling rules for fleet artifacts.
##
## Parameters:
## - namespace_param: Game namespace
func fleet_create(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes one or more fleets
## DELETE /ams/v1/admin/namespaces/{namespace}/fleets
##
## Deletes up to 1000 fleets in a single request using the fleet IDs sent with the request.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_fleet_delete(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
##
## Retrieves the specified fleet.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet to retrieve.
## - namespace_param: Game namespace
## - include_inactive_regions: include inactive regions in the response
func fleet_get(
	fleet_id: String, namespace_param: String, include_inactive_regions: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["includeInactiveRegions"] = include_inactive_regions
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a fleet
## PUT /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
##
## Updates the fleet configuration and replaces the current fleet settings with the values in the request. You can also update the fleet artifact sampling rules.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet to update.
## - namespace_param: Game namespace
func fleet_update(fleet_id: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes a fleet
## DELETE /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
##
## Deletes the specified fleet.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet to delete.
## - namespace_param: Game namespace
func fleet_delete(fleet_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Returns the sampling rules for a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules
##
## Retrieves artifact sampling rules for the specified fleet.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet.
## - namespace_param: Game namespace
func fleet_artifact_sampling_rules_get(fleet_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Sets sampling rules for a fleet
## PUT /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules
##
## Sets artifact sampling rules for the specified fleet.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet whose artifact sampling rules to update.
## - namespace_param: Game namespace
func fleet_artifact_sampling_rules_set(
	fleet_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves server details and counts for a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers
##
## Retrieves server details and counts for the specified fleet.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet whose servers to retrieve.
## - namespace_param: Game namespace
## - count: The data limit
## - offset: Number of results to skip for pagination
## - region: The servers region
## - server_id: Unique identifier for the server to filter by.
## - sort_by: The field by which to order the data
## - sort_direction: The data ordering direction
## - status: The servers status
func fleet_servers(
	fleet_id: String,
	namespace_param: String,
	count: int = -1,
	offset: int = -1,
	region: String = "",
	server_id: String = "",
	sort_by: String = "",
	sort_direction: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if count >= 0:
		query_params["count"] = count
	if offset >= 0:
		query_params["offset"] = offset
	if not region.is_empty():
		query_params["region"] = region
	if not server_id.is_empty():
		query_params["serverId"] = server_id
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves history records for a dedicated server in a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers/history
##
## Retrieves server history records for the specified fleet.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet whose server history to retrieve.
## - namespace_param: Game namespace
## - count: Defines the largest number of records returned in one page. Defaults to 1000 when not provided.
## - offset: Number of results to skip for pagination
## - reason: Exit reason
## - region: Region to filter the dedicated server history by.
## - server_id: Dedicated server ID
## - sort_direction: Sort direction for the `createdAt` column. Defaults to `asc` when not provided.
## - status: Status of the dedicated server
func fleet_server_history(
	fleet_id: String,
	namespace_param: String,
	count: int = -1,
	offset: int = -1,
	reason: String = "",
	region: String = "",
	server_id: String = "",
	sort_direction: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers/history"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if count >= 0:
		query_params["count"] = count
	if offset >= 0:
		query_params["offset"] = offset
	if not reason.is_empty():
		query_params["reason"] = reason
	if not region.is_empty():
		query_params["region"] = region
	if not server_id.is_empty():
		query_params["serverId"] = server_id
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a list of existing images
## GET /ams/v1/admin/namespaces/{namespace}/images
##
## Returns images that currently exist in the linked account, including uploaded, uploading, and building images. This operation fails if the namespace is not linked to an account.
##
## Parameters:
## - namespace_param: Game namespace
## - count: The count of image list
## - in_use: Whether to return only images that are currently in use.
## - is_protected: The image protected
## - name_param: The image name
## - offset: Number of results to skip for pagination
## - sort_by: Field to sort the returned images by.
## - sort_direction: Sort direction for the returned images.
## - status: The image status
## - tag: The image tag
## - target_architecture: Target architecture to filter by. Supported values: `linux-x86_64`, `linux-arm_64`.
func image_list(
	namespace_param: String,
	count: int = -1,
	in_use: String = "",
	is_protected: bool = false,
	name_param: String = "",
	offset: int = -1,
	sort_by: String = "",
	sort_direction: String = "",
	status: String = "",
	tag: String = "",
	target_architecture: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if count >= 0:
		query_params["count"] = count
	if not in_use.is_empty():
		query_params["inUse"] = in_use
	query_params["isProtected"] = is_protected
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not sort_direction.is_empty():
		query_params["sortDirection"] = sort_direction
	if not status.is_empty():
		query_params["status"] = status
	if not tag.is_empty():
		query_params["tag"] = tag
	if not target_architecture.is_empty():
		query_params["targetArchitecture"] = target_architecture
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves current usage for image storage
## GET /ams/v1/admin/namespaces/{namespace}/images-storage
##
## Returns the account's image storage usage, including the free tier quota.
##
## Parameters:
## - namespace_param: Game namespace
func images_storage(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images-storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves image details
## GET /ams/v1/admin/namespaces/{namespace}/images/{imageID}
##
## Retrieves the specified image.
##
## Parameters:
## - image_id: Unique identifier for the image to retrieve.
## - namespace_param: Game namespace
func image_get(image_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}"
	url_path = url_path.replace("{" + "imageID" + "}", image_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Marks the image for deletion
## DELETE /ams/v1/admin/namespaces/{namespace}/images/{imageID}
##
## Marks an image for deletion. The image stops being available to fleets, and the cleanup process deletes it later.
##
## Parameters:
## - image_id: Unique identifier for the image to delete.
## - namespace_param: Game namespace
func image_mark_for_deletion(image_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}"
	url_path = url_path.replace("{" + "imageID" + "}", image_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates an image
## PATCH /ams/v1/admin/namespaces/{namespace}/images/{imageID}
##
## Updates the image name, protection setting, and tags for the specified image.
##
## Parameters:
## - image_id: Unique identifier for the image to update.
## - namespace_param: Game namespace
func image_patch(image_id: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}"
	url_path = url_path.replace("{" + "imageID" + "}", image_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Returns an image to active use
## POST /ams/v1/admin/namespaces/{namespace}/images/{imageID}/restore
##
## Restores an image marked for deletion so fleets can use it again.
##
## Parameters:
## - image_id: Unique identifier for the image to restore.
## - namespace_param: Game namespace
func image_unmark_for_deletion(image_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images/{imageID}/restore"
	url_path = url_path.replace("{" + "imageID" + "}", image_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves available AMS QoS regions
## GET /ams/v1/admin/namespaces/{namespace}/qos
##
## Lists the available AMS QoS services for each region. Game clients can ping the returned IP and port pairs to measure latency, help players choose a region, or send latency results to matchmaking.
##
## Parameters:
## - namespace_param: Game namespace
## - status: QoS status, available value: ACTIVE, INACTIVE
func qo_s_regions_get(namespace_param: String, status: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/qos"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a QoS region status
## PATCH /ams/v1/admin/namespaces/{namespace}/qos/{region}
##
## Updates the configurable status for the QoS service registered in the specified region.
##
## Parameters:
## - namespace_param: Game namespace
## - region: Region of the QoS
func qo_s_regions_update(
	namespace_param: String, region: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/qos/{region}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves available AMS regions
## GET /ams/v1/admin/namespaces/{namespace}/regions
##
## Retrieves the AMS regions available to the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func info_regions(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/regions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves dedicated server details
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}
##
## Retrieves details for the specified dedicated server.
##
## Parameters:
## - namespace_param: Game namespace
## - server_id: The id of the dedicated server
func fleet_server_info(namespace_param: String, server_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/servers/{serverID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "serverID" + "}", server_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves dedicated server connection info
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}/connectioninfo
##
## Retrieves connection information for the specified dedicated server.
##
## Parameters:
## - namespace_param: Game namespace
## - server_id: The ID of the dedicated server
func fleet_server_connection_info(namespace_param: String, server_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/servers/{serverID}/connectioninfo"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "serverID" + "}", server_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves dedicated server history
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}/history
##
## Retrieves history records for the specified dedicated server.
##
## Parameters:
## - namespace_param: Game namespace
## - server_id: The id of the dedicated server
func server_history(namespace_param: String, server_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/servers/{serverID}/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "serverID" + "}", server_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves available instance types for the current account
## GET /ams/v1/admin/namespaces/{namespace}/supported-instances
##
## Retrieves the supported instance types for the current account in the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func info_supported_instances(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/supported-instances"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the account associated with the namespace
## GET /ams/v1/namespaces/{namespace}/account
##
## Retrieves the AMS account associated with the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func account_get(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/account"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Claims a dedicated server from a fleet
## PUT /ams/v1/namespaces/{namespace}/fleets/{fleetID}/claim
##
## Claims a dedicated server from the specified fleet.
##
## Parameters:
## - fleet_id: Unique identifier for the fleet to claim a dedicated server from.
## - namespace_param: Game namespace
func fleet_claim_by_id(
	fleet_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/fleets/{fleetID}/claim"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Connects a local watchdog
## GET /ams/v1/namespaces/{namespace}/local/{watchdogID}/connect
##
## Supports local dedicated server development scenarios.
##
## Parameters:
## - namespace_param: Game namespace
## - watchdog_id: Identifier for the local watchdog to connect.
func local_watchdog_connect(namespace_param: String, watchdog_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/local/{watchdogID}/connect"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "watchdogID" + "}", watchdog_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Claims a dedicated server
## PUT /ams/v1/namespaces/{namespace}/servers/claim
##
## Claims a dedicated server from fleets with matching claim keys. Claims for regular fleets fail immediately when no server is available, while claims for development fleets can wait briefly for a new server to start before returning `404` if none is ready.
##
## Parameters:
## - namespace_param: Game namespace
func fleet_claim_by_keys(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/servers/claim"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Connects a watchdog
## GET /ams/v1/namespaces/{namespace}/watchdogs/{watchdogID}/connect
##
## Connects the specified watchdog.
##
## Parameters:
## - namespace_param: Game namespace
## - watchdog_id: Identifier for the watchdog to connect.
func watchdog_connect(namespace_param: String, watchdog_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/watchdogs/{watchdogID}/connect"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "watchdogID" + "}", watchdog_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves an upload URL for an image
## GET /ams/v1/upload-url
##
## Returns a temporary URL that clients can use to upload an image.
func upload_url_get() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/upload-url"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves version info
## GET /ams/version
##
## Returns version information for the AMS service.
func version_info() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/version"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Checks service health
## GET /healthz
##
## Returns the health status of the service.
func basic_health_check() -> Dictionary:
	# Build URL path
	var url_path: String = "/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
