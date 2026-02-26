## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## csm_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: custom-service-manager
## Version: 1.31.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(CsmService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name CsmService
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

## Gets the List of Apps for AB-Extend Customer
## POST /csm/v1/admin/namespaces/{namespace}/apps
## @deprecated
func get_app_list_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps"
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
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Gets the App By Name
## GET /csm/v1/admin/namespaces/{namespace}/apps/{app}
## @deprecated
func get_app_v1(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Creates new App for AB-Extend Customers
## PUT /csm/v1/admin/namespaces/{namespace}/apps/{app}
## @deprecated
func create_app_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete App by Åpp Name
## DELETE /csm/v1/admin/namespaces/{namespace}/apps/{app}
## @deprecated
func delete_app_v1(
	app: String,
	namespace_param: String,
	forced: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not forced.is_empty():
		query_params["forced"] = forced
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update App Partially
## PATCH /csm/v1/admin/namespaces/{namespace}/apps/{app}
## @deprecated
func update_app_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Creates Deployment
## POST /csm/v1/admin/namespaces/{namespace}/apps/{app}/deployments
## @deprecated
func create_deployment_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/deployments"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a list of container images
## GET /csm/v1/admin/namespaces/{namespace}/apps/{app}/images
## @deprecated
func get_app_image_list_v1(
	app: String,
	namespace_param: String,
	cached: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/images"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not cached.is_empty():
		query_params["cached"] = cached
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

## Deletes the images
## DELETE /csm/v1/admin/namespaces/{namespace}/apps/{app}/images
## @deprecated
func delete_app_images_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/images"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Gets the Latest Release Version info of this App
## GET /csm/v1/admin/namespaces/{namespace}/apps/{app}/release
func get_app_release_v1(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/release"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of environment secrets
## GET /csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets
## @deprecated
func get_list_of_secrets_v1(
	app: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
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

## Save an environment secret
## POST /csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets
## @deprecated
func save_secret_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update an environment secret
## PUT /csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}
## @deprecated
func update_secret_v1(
	app: String,
	config_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete an environment secret
## DELETE /csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}
## @deprecated
func delete_secret_v1(
	app: String,
	config_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Starts the Application
## PUT /csm/v1/admin/namespaces/{namespace}/apps/{app}/start
## @deprecated
func start_app_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/start"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Stops the Application
## PUT /csm/v1/admin/namespaces/{namespace}/apps/{app}/stop
## @deprecated
func stop_app_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/stop"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get list of environment variables
## GET /csm/v1/admin/namespaces/{namespace}/apps/{app}/variables
## @deprecated
func get_list_of_variables_v1(
	app: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/variables"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
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

## Save an environment variable
## POST /csm/v1/admin/namespaces/{namespace}/apps/{app}/variables
## @deprecated
func save_variable_v1(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/variables"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update an environment variable
## PUT /csm/v1/admin/namespaces/{namespace}/apps/{app}/variables/{configId}
## @deprecated
func update_variable_v1(
	app: String,
	config_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/variables/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete an environment variable
## DELETE /csm/v1/admin/namespaces/{namespace}/apps/{app}/variables/{configId}
## @deprecated
func delete_variable_v1(
	app: String,
	config_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/apps/{app}/variables/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Fetches the List of Deployments
## POST /csm/v1/admin/namespaces/{namespace}/deployments
## @deprecated
func get_list_of_deployment_v1(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/deployments"
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
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Deployment by Deployment ID
## GET /csm/v1/admin/namespaces/{namespace}/deployments/{deploymentId}
## @deprecated
func get_deployment_v1(
	deployment_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/deployments/{deploymentId}"
	url_path = url_path.replace("{" + "deploymentId" + "}", deployment_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Deployment by Deployment ID
## DELETE /csm/v1/admin/namespaces/{namespace}/deployments/{deploymentId}
## @deprecated
func delete_deployment_v1(
	deployment_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/deployments/{deploymentId}"
	url_path = url_path.replace("{" + "deploymentId" + "}", deployment_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## get service messages
## GET /csm/v1/messages
func public_get_messages() -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/messages"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of extend apps on a given game namespace
## POST /csm/v2/admin/namespaces/{namespace}/apps
func get_app_list_v2(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps"
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
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get extend app by name
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}
func get_app_v2(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create new extend app
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}
func create_app_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete extend app by name
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}
func delete_app_v2(
	app: String,
	namespace_param: String,
	forced: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not forced.is_empty():
		query_params["forced"] = forced
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update app info
## PATCH /csm/v2/admin/namespaces/{namespace}/apps/{app}
func update_app_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Subscribe To Topic
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/asyncmessaging/topics/subscriptions
func create_subscription_handler(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/asyncmessaging/topics/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Unsubscribe From Topic
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/asyncmessaging/topics/{topicName}/subscriptions
func unsubscribe_topic_handler(
	app: String,
	namespace_param: String,
	topic_name: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/asyncmessaging/topics/{topicName}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topicName" + "}", topic_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Creates Deployment
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/deployments
func create_deployment_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/deployments"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get a list of container images
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/images
func get_app_image_list_v2(
	app: String,
	namespace_param: String,
	cached: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/images"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not cached.is_empty():
		query_params["cached"] = cached
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete app images
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/images
func delete_app_images_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/images"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Creates a new database credential for the customer
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/crendentials
func create_no_sql_database_credential_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/crendentials"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get NoSQL Database for Extend App
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/databases
func get_no_sql_database_v2(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/databases"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Creates NoSQL Database for Extend App
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/databases
func create_no_sql_database_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/databases"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Deletes NoSQL Database for Extend App
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/databases
func delete_no_sql_database_v2(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/databases"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update app info
## PATCH /csm/v2/admin/namespaces/{namespace}/apps/{app}/resources
func update_app_resources_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/resources"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Request Resource Limit to be increased
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/resources/form
func update_app_resources_resource_limit_form_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/resources/form"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get list of environment secrets
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets
func get_list_of_secrets_v2(
	app: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
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

## Save an environment secret
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets
func save_secret_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update an environment secret
## PUT /csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}
func update_secret_v2(
	app: String,
	config_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete an environment secret
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}
func delete_secret_v2(
	app: String,
	config_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Starts the Application
## PUT /csm/v2/admin/namespaces/{namespace}/apps/{app}/start
func start_app_v2(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/start"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Stops the Application
## PUT /csm/v2/admin/namespaces/{namespace}/apps/{app}/stop
func stop_app_v2(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/stop"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get a list of the app notification subscriber
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions
func get_notification_subscriber_list_v2(
	app: String,
	namespace_param: String,
	notification_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not notification_type.is_empty():
		query_params["notificationType"] = notification_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk update of users subscribed to an app's notifications
## PUT /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions
func bulk_save_subscription_app_notification_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Subscribe the user(s) an app notification
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions
func subscribe_app_notification_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Subscription status of a user
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/me
func get_subscription_v2_handler(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/me"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Subscribe to app notification
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/me
func subscribe_v2_handler(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/me"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Unsubscribe to app notification
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/me
func unsubscribe_v2_handler(
	app: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/me"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Remove other person subscription by user ID
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/users/{userId}
func delete_subscription_app_notification_by_user_idv2(
	app: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/users/{userId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Remove other person subscription
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/{subscriptionId}
## @deprecated
func delete_subscription_app_notification_v2(
	app: String,
	namespace_param: String,
	subscription_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/subscriptions/{subscriptionId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "subscriptionId" + "}", subscription_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get list of environment variables
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/variables
func get_list_of_variables_v2(
	app: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/variables"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
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

## Save an environment variable
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/variables
func save_variable_v2(
	app: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/variables"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Update an environment variable
## PUT /csm/v2/admin/namespaces/{namespace}/apps/{app}/variables/{configId}
func update_variable_v2(
	app: String,
	config_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/variables/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete an environment variable
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/variables/{configId}
func delete_variable_v2(
	app: String,
	config_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/variables/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List Async Messaging Topics
## GET /csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics
func list_topics_handler(
	namespace_param: String,
	fuzzy_topic_name: String = "",
	is_subscribed_by_app_name: String = "",
	is_unsubscribed_by_app_name: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not fuzzy_topic_name.is_empty():
		query_params["fuzzyTopicName"] = fuzzy_topic_name
	if not is_subscribed_by_app_name.is_empty():
		query_params["isSubscribedByAppName"] = is_subscribed_by_app_name
	if not is_unsubscribed_by_app_name.is_empty():
		query_params["isUnsubscribedByAppName"] = is_unsubscribed_by_app_name
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

## Create Async Messaging Topic
## POST /csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics
func create_topic_handler(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Async Messaging Topic
## DELETE /csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics/{topicName}
func delete_topic_handler(
	namespace_param: String,
	topic_name: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics/{topicName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "topicName" + "}", topic_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Fetches the List of Deployments
## POST /csm/v2/admin/namespaces/{namespace}/deployments
func get_list_of_deployment_v2(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/deployments"
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
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Deployment by Deployment ID
## GET /csm/v2/admin/namespaces/{namespace}/deployments/{deploymentId}
func get_deployment_v2(
	deployment_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/deployments/{deploymentId}"
	url_path = url_path.replace("{" + "deploymentId" + "}", deployment_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Deployment by Deployment ID
## DELETE /csm/v2/admin/namespaces/{namespace}/deployments/{deploymentId}
func delete_deployment_v2(
	deployment_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/deployments/{deploymentId}"
	url_path = url_path.replace("{" + "deploymentId" + "}", deployment_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get NoSQL Cluster Information
## GET /csm/v2/admin/namespaces/{namespace}/nosql/clusters
func get_no_sql_cluster_v2(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update NoSQL Cluster Configurations
## PUT /csm/v2/admin/namespaces/{namespace}/nosql/clusters
func update_no_sql_cluster_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Creates NoSQL Cluster
## POST /csm/v2/admin/namespaces/{namespace}/nosql/clusters
func create_no_sql_cluster_v2(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete NoSQL Cluster
## DELETE /csm/v2/admin/namespaces/{namespace}/nosql/clusters
func delete_no_sql_cluster_v2(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Start NoSQL Cluster
## PUT /csm/v2/admin/namespaces/{namespace}/nosql/clusters/start
func start_no_sql_cluster_v2(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters/start"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Stop NoSQL Cluster
## PUT /csm/v2/admin/namespaces/{namespace}/nosql/clusters/stop
func stop_no_sql_cluster_v2(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters/stop"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get NoSQL Access Tunnel
## GET /csm/v2/admin/namespaces/{namespace}/nosql/tunnels
func get_no_sql_access_tunnel_v2(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/tunnels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Extend Apps Configurable Limits e.g. any kind of limits for...
## GET /csm/v2/admin/namespaces/{namespace}/resources/limits
func get_resources_limits(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/resources/limits"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get List of Extend App using NoSQL
## GET /csm/v2/admin/namespaces/{studioName}/nosql/{resourceId}/apps
func get_no_sql_app_list_v2(
	resource_id: String,
	studio_name: String,
	app_name: String = "",
	limit: int = -1,
	namespace_param: String = "",
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{studioName}/nosql/{resourceId}/apps"
	url_path = url_path.replace("{" + "resourceId" + "}", resource_id.uri_encode())
	url_path = url_path.replace("{" + "studioName" + "}", studio_name.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_name.is_empty():
		query_params["appName"] = app_name
	if limit >= 0:
		query_params["limit"] = limit
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if offset >= 0:
		query_params["offset"] = offset
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get a list of the app notification subscriber
## GET /csm/v3/admin/namespaces/{namespace}/apps/{app}/subscriptions
func get_notification_subscriber_list_v3(
	app: String,
	namespace_param: String,
	notification_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v3/admin/namespaces/{namespace}/apps/{app}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not notification_type.is_empty():
		query_params["notificationType"] = notification_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Remove other person subscription by user ID or email address
## DELETE /csm/v3/admin/namespaces/{namespace}/apps/{app}/subscriptions
func delete_subscription_app_notification_v3(
	app: String,
	namespace_param: String,
	email_address: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v3/admin/namespaces/{namespace}/apps/{app}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not email_address.is_empty():
		query_params["emailAddress"] = email_address
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)
