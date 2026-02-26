## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## ams_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: fleet-commander
## Version: 1.43.0
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

## checks if fleet commander can auth with AMS
## GET /ams/auth
func auth_check() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/auth"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Health check
## GET /ams/healthz
func portal_health_check() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get the account associated with the namespace
## GET /ams/v1/admin/namespaces/{namespace}/account
func admin_account_get(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## create a new AMS account
## POST /ams/v1/admin/namespaces/{namespace}/account
func admin_account_create(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get a link to account token
## GET /ams/v1/admin/namespaces/{namespace}/account/link
func admin_account_link_token_get(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## link an account to a namespace
## POST /ams/v1/admin/namespaces/{namespace}/account/link
func admin_account_link(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/account/link"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## get all artifacts matching the provided criteria
## GET /ams/v1/admin/namespaces/{namespace}/artifacts
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

## delete artifacts that match criteria in bulk. all artifacts...
## DELETE /ams/v1/admin/namespaces/{namespace}/artifacts
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

## retrieve artifact storage usage for the namespace
## GET /ams/v1/admin/namespaces/{namespace}/artifacts/usage
func artifact_usage_get(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/artifacts/usage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## delete a specified artifact
## DELETE /ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}
func artifact_delete(
	artifact_id: String,
	namespace_param: String
) -> Dictionary:
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

## get a signed URL for a specific artifact
## GET /ams/v1/admin/namespaces/{namespace}/artifacts/{artifactID}/url
func artifact_get_url(
	artifact_id: String,
	namespace_param: String
) -> Dictionary:
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

## lists development server configurations with pagination
## GET /ams/v1/admin/namespaces/{namespace}/development/server-configurations
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

## create a new development server configuration
## POST /ams/v1/admin/namespaces/{namespace}/development/server-configurations
func development_server_configuration_create(
	namespace_param: String,
	body: Dictionary = {}
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

## get a development server configuration
## GET /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
func development_server_configuration_get(
	development_server_config_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace("{" + "developmentServerConfigID" + "}", development_server_config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## delete a development server configuration
## DELETE /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
func development_server_configuration_delete(
	development_server_config_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace("{" + "developmentServerConfigID" + "}", development_server_config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## patch a development server configuration
## PATCH /ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}
func development_server_configuration_patch(
	development_server_config_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/development/server-configurations/{developmentServerConfigID}"
	url_path = url_path.replace("{" + "developmentServerConfigID" + "}", development_server_config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## list all fleets in a namespace
## GET /ams/v1/admin/namespaces/{namespace}/fleets
func fleet_list(
	namespace_param: String,
	active: bool = false,
	count: int = -1,
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

## create a fleet
## POST /ams/v1/admin/namespaces/{namespace}/fleets
func fleet_create(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## delete one or more fleets. maximum of 1000 fleets allowed
## DELETE /ams/v1/admin/namespaces/{namespace}/fleets
func bulk_fleet_delete(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
func fleet_get(
	fleet_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}"
	url_path = url_path.replace("{" + "fleetID" + "}", fleet_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## update a fleet -– overrides current data
## PUT /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
func fleet_update(
	fleet_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
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

## delete a fleet
## DELETE /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}
func fleet_delete(
	fleet_id: String,
	namespace_param: String
) -> Dictionary:
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

## get the sampling rules for a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules
func fleet_artifact_sampling_rules_get(
	fleet_id: String,
	namespace_param: String
) -> Dictionary:
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

## set sampling rules for a fleet
## PUT /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/artifacts-sampling-rules
func fleet_artifact_sampling_rules_set(
	fleet_id: String,
	namespace_param: String,
	body: Dictionary = {}
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

## get server details & counts for a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers
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

## get history records of a dedicated server in a fleet
## GET /ams/v1/admin/namespaces/{namespace}/fleets/{fleetID}/servers/history
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

## get a list of existing images
## GET /ams/v1/admin/namespaces/{namespace}/images
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

## get current usage for images storage
## GET /ams/v1/admin/namespaces/{namespace}/images-storage
func images_storage(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/images-storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get image details.
## GET /ams/v1/admin/namespaces/{namespace}/images/{imageID}
func image_get(
	image_id: String,
	namespace_param: String
) -> Dictionary:
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

## mark the image for deletion
## DELETE /ams/v1/admin/namespaces/{namespace}/images/{imageID}
func image_mark_for_deletion(
	image_id: String,
	namespace_param: String
) -> Dictionary:
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

## edit the image
## PATCH /ams/v1/admin/namespaces/{namespace}/images/{imageID}
func image_patch(
	image_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
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

## unmarks the image for deletion
## POST /ams/v1/admin/namespaces/{namespace}/images/{imageID}/restore
func image_unmark_for_deletion(
	image_id: String,
	namespace_param: String
) -> Dictionary:
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

## get a list of available AMS QoS regions
## GET /ams/v1/admin/namespaces/{namespace}/qos
func qo_s_regions_get(
	namespace_param: String,
	status: String = ""
) -> Dictionary:
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

## update the status of a QoS region
## PATCH /ams/v1/admin/namespaces/{namespace}/qos/{region}
func qo_s_regions_update(
	namespace_param: String,
	region: String,
	body: Dictionary = {}
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

## get a list of the available AMS regions
## GET /ams/v1/admin/namespaces/{namespace}/regions
func info_regions(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/regions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get information about a dedicated server
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}
func fleet_server_info(
	namespace_param: String,
	server_id: String
) -> Dictionary:
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

## get connection info for a dedicated server
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}/connectioninfo
func fleet_server_connection_info(
	namespace_param: String,
	server_id: String
) -> Dictionary:
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

## get history records of a dedicated server
## GET /ams/v1/admin/namespaces/{namespace}/servers/{serverID}/history
func server_history(
	namespace_param: String,
	server_id: String
) -> Dictionary:
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

## get a list of available instance types for the current account
## GET /ams/v1/admin/namespaces/{namespace}/supported-instances
func info_supported_instances(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/admin/namespaces/{namespace}/supported-instances"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## get the account associated with the namespace
## GET /ams/v1/namespaces/{namespace}/account
func account_get(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/account"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## claim a dedicated server from a fleet
## PUT /ams/v1/namespaces/{namespace}/fleets/{fleetID}/claim
func fleet_claim_by_id(
	fleet_id: String,
	namespace_param: String,
	body: Dictionary = {}
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

## connect a local watchdog
## GET /ams/v1/namespaces/{namespace}/local/{watchdogID}/connect
func local_watchdog_connect(
	namespace_param: String,
	watchdog_id: String
) -> Dictionary:
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

## claim a dedicated server
## PUT /ams/v1/namespaces/{namespace}/servers/claim
func fleet_claim_by_keys(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/namespaces/{namespace}/servers/claim"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## connect a watchdog
## GET /ams/v1/namespaces/{namespace}/watchdogs/{watchdogID}/connect
func watchdog_connect(
	namespace_param: String,
	watchdog_id: String
) -> Dictionary:
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

## get an URL for uploading an image
## GET /ams/v1/upload-url
func upload_url_get() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/v1/upload-url"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Version info
## GET /ams/version
func func1() -> Dictionary:
	# Build URL path
	var url_path: String = "/ams/version"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Health check
## GET /healthz
func basic_health_check() -> Dictionary:
	# Build URL path
	var url_path: String = "/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
