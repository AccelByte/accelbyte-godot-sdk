## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## csm_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: custom-service-manager
## Version: 1.37.1
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


## Lists all App UI instances in a namespace
## GET /csm/v1/admin/namespaces/{namespace}/app-ui
##
## Retrieves a paginated list of App UI instances. Supports filtering by name and pagination using limit/offset.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Filter by app UI name
## - offset: Number of results to skip for pagination
func list_app_ui(
	namespace_param: String, limit: int = -1, name_param: String = "", offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/app-ui"
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
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates an App UI instance
## POST /csm/v1/admin/namespaces/{namespace}/app-ui
##
## Creates a new App UI configuration. The App UI can be hosted by AccelByte (the default) or externally.
##
## Parameters:
## - namespace_param: Game namespace
func create_app_ui(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/app-ui"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes an App UI instance
## DELETE /csm/v1/admin/namespaces/{namespace}/app-ui/{appUiName}
##
## Permanently deletes an App UI instance and schedules cleanup of associated S3 assets.
##
## Parameters:
## - app_ui_name: Name of the App UI instance to delete.
## - namespace_param: Game namespace
func delete_app_ui(app_ui_name: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/app-ui/{appUiName}"
	url_path = url_path.replace("{" + "appUiName" + "}", app_ui_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Uploads App UI assets as a ZIP archive
## POST /csm/v1/admin/namespaces/{namespace}/app-ui/{appUiName}/files/upload
##
## Uploads a ZIP archive of App UI static assets (HTML, CSS, JS, and similar). Files are stored in S3 and served with immutable caching.
##
## Parameters:
## - app_ui_name: Name of the App UI instance the assets belong to.
## - namespace_param: Game namespace
## - version: Version label for the uploaded assets. Defaults to `default` when omitted.
## - file: Zip file containing App UI assets
func upload_app_ui_file(
	app_ui_name: String, namespace_param: String, file: String, version: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/app-ui/{appUiName}/files/upload"
	url_path = url_path.replace("{" + "appUiName" + "}", app_ui_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not version.is_empty():
		query_params["version"] = version
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Gets the Latest Release Version info of this App
## GET /csm/v1/admin/namespaces/{namespace}/apps/{app}/release
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Gets the Latest Release Version info of this App
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_app_release_v1(app: String, namespace_param: String) -> Dictionary:
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


## Retrieves a hosted static file
## GET /csm/v1/admin/namespaces/{namespace}/files/{filePath}
##
## Serves static files used by Extend features, such as App UI files. Files are served with immutable caching headers.
##
## Parameters:
## - file_path: Path to file under namespace assets
## - namespace_param: Game namespace
func get_extend_file(file_path: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/files/{filePath}"
	url_path = url_path.replace("{" + "filePath" + "}", file_path.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists security assessment requests for Extend apps in a game namespace
## GET /csm/v1/admin/namespaces/{namespace}/pentestings
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:SECURITYASSESSMENT [READ]`
##
## Lists security assessment requests submitted for Extend Apps in this game namespace. This is a live
## proxy over ASA's engagement list -- status and findings always reflect ASA's current state.
##
## Parameters:
## - namespace_param: Game Namespace
func list_pentest_requests_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/pentestings"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a new security assessment request for an Extend app
## POST /csm/v1/admin/namespaces/{namespace}/pentestings
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:SECURITYASSESSMENT [CREATE]`
##
## Requests a security assessment engagement for an existing, running Extend App. CSM prepares
## dedicated IAM test credentials and submits the engagement to ASA (AGS Security Agent)
## synchronously; only one active engagement per app is allowed at a time.
##
## Rejected with `409 Conflict` when another security assessment session is already active
## for this app. Rejected with `400 Bad Request` when the app is not running, a
## submitted endpoint is not present in the app's OpenAPI spec, or a submitted/discovered
## endpoint permission is invalid.
##
## Parameters:
## - namespace_param: Game Namespace
func create_pentest_request_v1(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/pentestings"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Gets the testable endpoints and required permissions for a Service Extension app
## GET /csm/v1/admin/namespaces/{namespace}/pentestings/apps/{appName}/endpoints
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Returns the endpoint list of a Service Extension app's exposed API, with each endpoint's required
## permission auto-discovered from the app's OpenAPI spec (x-required-permission) or, as a fallback,
## gRPC server reflection. Used to populate the security assessment request form.
##
## Rejected with `404 Not Found` when the app doesn't exist in this namespace. When
## the app is not running, or has no reachable OpenAPI spec, discovery is skipped and this
## still returns `200 OK`, with isAppRunning/hasAPISpec reflecting that state rather
## than erroring.
##
## Parameters:
## - app_name: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game Namespace
func get_extend_app_endpoint_info_v1(app_name: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/pentestings/apps/{appName}/endpoints"
	url_path = url_path.replace("{" + "appName" + "}", app_name.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Downloads a completed security assessment report
## GET /csm/v1/admin/namespaces/{namespace}/pentestings/{engagementId}/report
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:SECURITYASSESSMENT [READ]`
##
## Returns a pre-signed URL (1 hour expiry) to download the completed security assessment report, as
## PDF or Markdown depending on the "format" query parameter ("pdf" by default, or "md").
##
## Rejected with `400 Bad Request` for an unsupported "format" value, and
## `404 Not Found` when the engagement doesn't exist or doesn't belong to the
## caller's namespace/studio. The report is only available once the engagement's status is
## COMPLETED.
##
## Parameters:
## - engagement_id: Numeric engagement ID, as returned by the create or list endpoints. Expected format: digits only, e.g. "12345"
## - namespace_param: Game Namespace
## - format: Report file format: 'pdf' (default) or 'md' for Markdown
func get_pentest_report_v1(
	engagement_id: String, namespace_param: String, format: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/admin/namespaces/{namespace}/pentestings/{engagementId}/report"
	url_path = url_path.replace("{" + "engagementId" + "}", engagement_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not format.is_empty():
		query_params["format"] = format
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves service messages
## GET /csm/v1/messages
##
## Get the list of messages.
func public_get_messages() -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v1/messages"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Subscribes the app to the specified async messaging topics
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/asyncmessaging/topics/subscriptions
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:ASYNCMESSAGING:SUBSCRIPTIONS [CREATE]`
##
## Subscribe App queue to given Topic name list inside a game namespace.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func create_subscription_handler(
	app: String, namespace_param: String, body: Dictionary = {}
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


## Unsubscribes the app from an async messaging topic
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/asyncmessaging/topics/{topicName}/subscriptions
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:ASYNCMESSAGING:SUBSCRIPTIONS [DELETE]`
##
## Unsubscribe App queue from a topic by Topic Name.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - topic_name: Name of the topic to unsubscribe from.
func unsubscribe_topic_handler(
	app: String, namespace_param: String, topic_name: String
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


## Generates a Key-Value credential for an integrated Extend app
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/credentials
##
## Generates a new credential for an Extend app that is already integrated with a Key-Value cluster.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func create_key_value_credential_v2(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/credentials"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves an Extend app's Key-Value integration
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/integrations
##
## Get integration of an extend app with a cluster.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_integration_app_key_value_cluster_v2(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/integrations"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Integrates an Extend app with a Key-Value cluster
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/integrations
##
## Integrate an Extend App with an existing KeyValue cluster. Injects REDIS_HOST, REDIS_PORT, REDIS_USERNAME, REDIS_PASSWORD to the app config.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func integrate_app_key_value_cluster_v2(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/integrations"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes an Extend app's Key-Value integration
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/integrations
##
## Remove integration of an extend app with a cluster. Removes key-value env/secret from app, deletes credential and AWS user.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func remove_integration_app_key_value_cluster_v2(
	app: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/keyvalue/integrations"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Creates a NoSQL database credential for an Extend app
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/credentials
##
## Creates a new database credential for the given Extend app, soft-deleting the previous credential.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func create_new_no_sql_database_credential_v2(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/credentials"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the NoSQL database for the extend app
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/nosql/databases
##
## Returns NoSQL database details for the given extend app and game namespace. The `resourceStatus` field indicates the current cluster state: `available` (accessible), `creating` (provisioning), `updating` (applying changes), `starting` (resuming), `stopping` (becoming inaccessible), `stopped` (inaccessible), `deleting` (removal in progress), `maintenance` (under maintenance), `failed` (error state), or `unknown`.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_no_sql_database_v2(app: String, namespace_param: String) -> Dictionary:
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
##
## Creates a NoSQL database and its credentials for the given extend app, provisioning it in the shared NoSQL cluster.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func create_no_sql_database_v2(
	app: String, namespace_param: String, body: Dictionary = {}
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
##
## Deletes the NoSQL database and its credentials for the given extend app, removing it from the provisioned NoSQL cluster.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func delete_no_sql_database_v2(app: String, namespace_param: String) -> Dictionary:
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


## Creates a SQL database credential for an Extend app
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/credentials
##
## Creates a new database credential for the customer. This will soft-delete the old credential and create a new one.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func create_sql_database_credential_v2(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/credentials"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the SQL database for an Extend app
## GET /csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/databases
##
## Returns information about the SQL database associated with the given Extend app.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_sql_database_v2(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/databases"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates SQL Database for Extend App
## POST /csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/databases
##
## Creates a SQL database and its credentials for the given Extend app.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func create_sql_database_v2(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/databases"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes SQL Database for Extend App
## DELETE /csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/databases
##
## Deletes the SQL database and its credentials for the given Extend app.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func delete_sql_database_v2(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/apps/{app}/sql/databases"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists async messaging topics
## GET /csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics
##
## Lists all async messaging topics in the game namespace. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - fuzzy_topic_name: Fuzzy search for topic name
## - is_subscribed_by_app_name: Filter to get only topics subscribed by given app name
## - is_unsubscribed_by_app_name: Filter to get only topics unsubscribed by given app name
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Creates an async messaging topic
## POST /csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:ASYNCMESSAGING:TOPICS [CREATE]`
##
## Create New Async Messaging Topic, the topic name is unique inside a game namespace.
##
## Parameters:
## - namespace_param: Game namespace
func create_topic_handler(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes an async messaging topic
## DELETE /csm/v2/admin/namespaces/{namespace}/asyncmessaging/topics/{topicName}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:ASYNCMESSAGING:TOPICS [DELETE]`
##
## Delete Async Messaging Topic inside a game namespace given its topic name.
##
## Parameters:
## - namespace_param: Game namespace
## - topic_name: Name of the topic to delete.
func delete_topic_handler(namespace_param: String, topic_name: String) -> Dictionary:
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


## Retrieves Key-Value cluster information
## GET /csm/v2/admin/namespaces/{namespace}/keyvalue/cluster/{resourceId}
##
## Get Key-Value cluster information returns the Key-Value cluster related information by given studio/publisher namespace.
##
## status field - indicates the Key-Value cluster status.
##
## Parameters:
## - namespace_param: Studio name
## - resource_id: Identifier of the Key-Value cluster to retrieve.
func get_key_value_cluster_v2(namespace_param: String, resource_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/keyvalue/cluster/{resourceId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resourceId" + "}", resource_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists Key-Value clusters
## GET /csm/v2/admin/namespaces/{namespace}/keyvalue/clusters
##
## List Key-Value clusters by studio/publisher namespace.
## If `refresh=true`, the service will sync cluster status from the provider (cached).
##
## Parameters:
## - namespace_param: Studio name
## - refresh: Refresh status from provider
func list_key_value_cluster_v2(namespace_param: String, refresh: bool = false) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/keyvalue/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["refresh"] = refresh
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates Key-Value Cluster
## POST /csm/v2/admin/namespaces/{namespace}/keyvalue/clusters
##
## Provisions a Key-Value cluster (AWS Valkey Serverless) for use by Extend apps in the game namespace.
##
## Parameters:
## - namespace_param: Studio name
func create_key_value_cluster_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/keyvalue/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves Key-Value cluster limit configuration
## GET /csm/v2/admin/namespaces/{namespace}/keyvalue/clusters/limitconfig
##
## Get Key-Value cluster limit config.
##
## Parameters:
## - namespace_param: Studio name
func get_key_value_cluster_limit_config_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/keyvalue/clusters/limitconfig"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates Key-Value cluster configuration
## PUT /csm/v2/admin/namespaces/{namespace}/keyvalue/clusters/{resourceId}
##
## Update Key-Value cluster configuration (maxDataStorageGB, maxECPUPerSecond, profileName).
## Only allowed when cluster status is AVAILABLE. Process is asynchronous; poll Get Cluster for updated status.
##
## Parameters:
## - namespace_param: Studio name
## - resource_id: Identifier of the Key-Value cluster to update.
func update_key_value_cluster_v2(
	namespace_param: String, resource_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/keyvalue/clusters/{resourceId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resourceId" + "}", resource_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the Key-Value cluster
## DELETE /csm/v2/admin/namespaces/{namespace}/keyvalue/clusters/{resourceId}
##
## Delete Key-Value cluster. Only allowed when cluster status is AVAILABLE or CREATE-FAILED.
## Force-deletes all active integrations. Returns resource with status DELETING.
##
## Parameters:
## - namespace_param: Studio name
## - resource_id: Identifier of the Key-Value cluster to delete.
func delete_key_value_cluster_v2(namespace_param: String, resource_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/keyvalue/clusters/{resourceId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resourceId" + "}", resource_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists Extend apps integrated with a Key-Value cluster
## GET /csm/v2/admin/namespaces/{namespace}/keyvalue/{resourceId}/integrations
##
## Lists the Extend apps integrated with a specific Key-Value cluster in the given namespace.
##
## Parameters:
## - namespace_param: Studio name
## - resource_id: Identifier of the Key-Value cluster whose integrated apps are listed.
func get_list_integrated_app_key_value_cluster_v2(
	namespace_param: String, resource_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/keyvalue/{resourceId}/integrations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resourceId" + "}", resource_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves NoSQL cluster information
## GET /csm/v2/admin/namespaces/{namespace}/nosql/clusters
##
## Returns NoSQL cluster details for the studio namespace. The `status` field indicates the current cluster state: `available`, `creating`, `updating`, `starting`, `stopping`, `stopped`, `deleting`, `maintenance`, `failed`, or `unknown`.
##
## Parameters:
## - namespace_param: Game namespace
func get_no_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the NoSQL cluster configuration
## PUT /csm/v2/admin/namespaces/{namespace}/nosql/clusters
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:NOSQL:CLUSTERS [UPDATE]`
##
## Update NoSQL cluster configurations such as min/max DCU (Database Capacity Units) for the NoSQL cluster in the given studio/publisher namespace.
## The cluster must be in an available state to allow configuration updates.
##
## Configuration update process may take some time to complete, you can check the updated status from the `status` field of the resource response.
##
## Parameters:
## - namespace_param: Game namespace
func update_no_sql_cluster_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
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
##
## Provisions a NoSQL database cluster for use by extend apps in the studio. Only one cluster can be created per studio namespace. The provisioning runs asynchronously; check the `status` field for current state.
##
## Parameters:
## - namespace_param: Game namespace
func create_no_sql_cluster_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes the NoSQL cluster
## DELETE /csm/v2/admin/namespaces/{namespace}/nosql/clusters
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:NOSQL:CLUSTERS [DELETE]`
##
## You can only delete the cluster when its status is "available".
##
## Deleting the cluster will:
## - Remove NoSQL integration.
## - Remove all the data from the NoSQL
## - Remove all the credentials, including the Extend Appâs credentials.
##
## Parameters:
## - namespace_param: Game namespace
func delete_no_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Starts the NoSQL cluster
## PUT /csm/v2/admin/namespaces/{namespace}/nosql/clusters/start
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:NOSQL:CLUSTERS [UPDATE]`
##
## Start NoSQL cluster.
## You can only start the cluster when its status is "stopped".
##
## Cluster starting process may take some time to complete.
##
## Parameters:
## - namespace_param: Game namespace
func start_no_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters/start"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Stops the NoSQL cluster
## PUT /csm/v2/admin/namespaces/{namespace}/nosql/clusters/stop
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:NOSQL:CLUSTERS [UPDATE]`
##
## Stop NoSQL cluster.
## You can only start the cluster when its status is "available".
##
## Cluster stopping process may take some time to complete.
##
## Parameters:
## - namespace_param: Game namespace
func stop_no_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/clusters/stop"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves the NoSQL access tunnel information
## GET /csm/v2/admin/namespaces/{namespace}/nosql/tunnels
##
## Returns the NoSQL access tunnel information for a specified game namespace
##
## Parameters:
## - namespace_param: Game namespace
func get_no_sql_access_tunnel_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/nosql/tunnels"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves SQL cluster information
## GET /csm/v2/admin/namespaces/{namespace}/sql/clusters
##
## Returns information about the SQL cluster for the studio or publisher namespace.
##
## Parameters:
## - namespace_param: Studio name
func get_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/sql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates SQL cluster configuration
## PUT /csm/v2/admin/namespaces/{namespace}/sql/clusters
##
## Update SQL cluster configurations such as min/max ACU (AuroraDB Capacity Units) for the SQL cluster in the given studio/publisher namespace.
## The cluster must be in an available state to allow configuration updates.
##
## Configuration update process may take some time to complete, you can check the updated status from the `status` field of the resource response.
##
## Parameters:
## - namespace_param: Studio name
func update_sql_cluster_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/sql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates SQL Cluster
## POST /csm/v2/admin/namespaces/{namespace}/sql/clusters
##
## Provisions a SQL database cluster and its instances for use by Extend apps in the game namespace.
##
## Parameters:
## - namespace_param: Studio name
func create_sql_cluster_v2(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/sql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes the SQL cluster
## DELETE /csm/v2/admin/namespaces/{namespace}/sql/clusters
##
## You can only delete the cluster when its status is "available".
##
## Deleting the cluster will:
## - Remove SQL integration.
## - Remove all the data from the SQL
## - Remove all the credentials, including the Extend Appâs credentials.
##
## Parameters:
## - namespace_param: Studio name
func delete_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/sql/clusters"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Starts the SQL cluster
## PUT /csm/v2/admin/namespaces/{namespace}/sql/clusters/start
##
## Start SQL cluster.
## You can only start the cluster when its status is "stopped".
##
## Cluster starting process may take some time to complete.
##
## Parameters:
## - namespace_param: Studio name
func start_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/sql/clusters/start"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Stops the SQL cluster
## PUT /csm/v2/admin/namespaces/{namespace}/sql/clusters/stop
##
## Stop SQL cluster.
## You can only start the cluster when its status is "available".
##
## Cluster stopping process may take some time to complete.
##
## Parameters:
## - namespace_param: Studio name
func stop_sql_cluster_v2(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/sql/clusters/stop"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists Extend apps using a SQL cluster
## GET /csm/v2/admin/namespaces/{namespace}/sql/{resourceId}/apps
##
## Lists the Extend apps using a SQL database in the given namespace and SQL cluster. Results are paginated with the limit and offset parameters.
##
## Parameters:
## - namespace_param: Studio name
## - resource_id: Identifier of the SQL cluster whose Extend apps are listed.
## - app_name: Filter by app name.
## - game_namespace: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_sql_app_list_v2(
	namespace_param: String,
	resource_id: String,
	app_name: String = "",
	game_namespace: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v2/admin/namespaces/{namespace}/sql/{resourceId}/apps"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "resourceId" + "}", resource_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not app_name.is_empty():
		query_params["appName"] = app_name
	if not game_namespace.is_empty():
		query_params["gameNamespace"] = game_namespace
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


## Lists extend apps using the NoSQL cluster
## GET /csm/v2/admin/namespaces/{studioName}/nosql/{resourceId}/apps
##
## Lists extend apps using the NoSQL cluster in the given studio namespace. Supports offset/limit pagination.
##
## Parameters:
## - resource_id: Unique identifier of the NoSQL cluster resource.
## - studio_name: Studio name
## - app_name: Filter by app name.
## - game_namespace: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_no_sql_app_list_v2(
	resource_id: String,
	studio_name: String,
	app_name: String = "",
	game_namespace: String = "",
	limit: int = -1,
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
	if not game_namespace.is_empty():
		query_params["gameNamespace"] = game_namespace
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


## Get debug info for an extend app
## GET /csm/v4/admin/namespaces/{namespace}/apps/{app}/debuginfo
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Returns the list of debug-ready pods and exposed services for the given extend app.
##
## A pod is included only when it is in `Running` phase and has an
## `extend-proxy-sidecar` container.
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game namespace
func get_app_debug_info_v4(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v4/admin/namespaces/{namespace}/apps/{app}/debuginfo"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Enable or disable remote debug mode for an extend app
## PUT /csm/v4/admin/namespaces/{namespace}/apps/{app}/debugmode
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [UPDATE]`
##
## Enable or disable the remote debug sidecar container for the specified extend app.
##
## When enabled and the app is in `deployment-running` status, a new deployment will be
## triggered automatically to apply the debug container configuration.
##
## This operation is rejected with `409 Conflict` if the app is currently in a
## transitional state (app-creating, app-removing, app-stopping).
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game namespace
func update_app_debug_mode_v4(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v4/admin/namespaces/{namespace}/apps/{app}/debugmode"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Stream live logs from an extend app
## GET /csm/v4/admin/namespaces/{namespace}/apps/{app}/logs
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Streams logs from the extend app pods over Server-Sent Events (SSE).
## By default only the `service` container is streamed.
##
## Individual log lines larger than 256KiB are not streamed; that pod source
## ends with a pod-done error for the oversized line.
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game namespace
## - follow: Stream continuously
## - pods: Number of newest running replicas to stream (default: 1; max from CSM_LOG_STREAM_MAX_PODS_PER_REQUEST; soft-capped to available Running pods)
## - previous: Previously terminated containers
## - since_seconds: Logs newer than N seconds
## - tail_lines: Lines per container before following
func stream_app_logs_v4(
	app: String,
	namespace_param: String,
	follow: bool = false,
	pods: int = -1,
	previous: bool = false,
	since_seconds: int = -1,
	tail_lines: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v4/admin/namespaces/{namespace}/apps/{app}/logs"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["follow"] = follow
	if pods >= 0:
		query_params["pods"] = pods
	query_params["previous"] = previous
	if since_seconds >= 0:
		query_params["sinceSeconds"] = since_seconds
	if tail_lines >= 0:
		query_params["tailLines"] = tail_lines
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Start an async historical log export
## POST /csm/v4/admin/namespaces/{namespace}/apps/{app}/logs/export
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [CREATE]`
##
## Starts an asynchronous export of the app's logs for the requested
## time range. The response is immediate (202 Accepted) with an
## `exportId` the caller polls via
## `GET /logs/export/{exportId}`.
##
## The time range must be RFC3339 UTC with a trailing `Z`,
## must satisfy `endTime > startTime`, cannot start in
## the future, and cannot exceed the configured max range (default
## 7 days). An `endTime` after now is clamped to now.
## Included lines are those whose `timeUnixNano` is in
## the half-open interval `[startTime, endTime)` from
## the app's `service` container only (same scope as
## live stream; sidecar and init containers are not exported).
## Glue `datehour` is only a partition prune. Quotas:
##
##
##
##
## * Per-user quota per UTC day (default: 10)
##
##
## * Concurrent preparing exports per namespace (default: 3)
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game namespace
func start_app_log_export_v4(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v4/admin/namespaces/{namespace}/apps/{app}/logs/export"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Get one historical log export
## GET /csm/v4/admin/namespaces/{namespace}/apps/{app}/logs/export/{exportId}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Returns the current status of an export job. On `ready`
## and within the retention window, the response includes a
## presigned `downloadUrl`. On `failed`, a
## short `message` is included. There is no
## `expired` status; compare `expiresAt` to
## the current time. Poll until `status` is
## `ready` or `failed`.
##
## `downloadUrl` is short-lived (default 15 minutes) and is
## issued once. The first successful call sets `downloadedAt`.
## Later calls omit `downloadUrl`. `expiresAt`
## is how long the export stays downloadable before that first call
## (default 24 hours from the POST), not the lifetime of the URL.
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - export_id: Export job id returned by the POST endpoint
## - namespace_param: Game namespace
func get_app_log_export_v4(app: String, export_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v4/admin/namespaces/{namespace}/apps/{app}/logs/export/{exportId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "exportId" + "}", export_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## List historical log exports for an app
## GET /csm/v4/admin/namespaces/{namespace}/apps/{app}/logs/exports
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Returns one page of export jobs for the app, newest first.
## Default page size is 5 (`?limit=5&offset=0`);
## the hard cap is 20. The `paging` object uses the
## same first/last/next/previous shape as other CSM lists.
## The response does not include a `downloadUrl`.
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game namespace
## - limit: Page size. Default 5, max 20.
## - offset: Number of rows to skip. Default 0.
func list_app_log_exports_v4(
	app: String, namespace_param: String, limit: int = -1, offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v4/admin/namespaces/{namespace}/apps/{app}/logs/exports"
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


## Get in-progress long-running operation steps for the extend app (stepper)
## GET /csm/v4/admin/namespaces/{namespace}/apps/{app}/status-progress
##
## Returns step rows for the current or last tracked operation.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_app_status_progress_v4(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v4/admin/namespaces/{namespace}/apps/{app}/status-progress"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Get list of extend apps on a given game namespace (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Available scenario:
## - scenario 1: `function-override`
## - scenario 2: `service-extension`
## - scenario 3: `event-handler`
##
##
## Available app status:
## - `app-creating`
## - `app-creation-failed`
## - `app-creation-timeout`
## - `app-undeployed`
## - `deployment-in-progress`
## - `deployment-failed`
## - `deployment-timeout`
## - `deployment-running`
## - `deployment-down`
## - `app-stopping`
## - `app-stop-failed`
## - `app-stop-timeout`
## - `app-stopped`
## - `app-removing`
## - `app-removed`
## - `app-remove-timeout`
##
##
## Put empty object {} for no filter
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Limit
## - offset: Offset
func list_apps_v5(
	namespace_param: String, limit: int = -1, offset: int = -1, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps"
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


## Get extend app by name (v5)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Get extend app by name
##
## Available scenario:
## - scenario 3: `event-handler`
## - scenario 1: `function-override`
## - scenario 2: `service-extension`
##
##
## Available app status:
## - `app-creating`
## - `app-creation-failed`
## - `app-creation-timeout`
## - `app-undeployed`
## - `deployment-in-progress`
## - `deployment-failed`
## - `deployment-timeout`
## - `deployment-running`
## - `deployment-down`
## - `app-stopping`
## - `app-stop-failed`
## - `app-stop-timeout`
## - `app-stopped`
## - `app-removing`
## - `app-removed`
## - `app-remove-timeout`
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_app_v5(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Create new extend app (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [CREATE]`
##
## Create new extend app with name provided by {app} path parameter and specified scenario type
##
## Available scenario:
## - scenario 1: `function-override`
## - scenario 2: `service-extension`
## - scenario 3: `event-handler`
##
##
## Available app status:
## - `app-creating`
## - `app-creation-failed`
## - `app-creation-timeout`
## - `app-undeployed`
## - `deployment-in-progress`
## - `deployment-failed`
## - `deployment-timeout`
## - `deployment-running`
## - `deployment-down`
## - `app-stopping`
## - `app-stop-failed`
## - `app-stop-timeout`
## - `app-stopped`
## - `app-removing`
## - `app-removed`
## - `app-remove-timeout`
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game namespace
func create_app_v5(app: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Delete an extend app and all of its resources (v5)
## DELETE /csm/v5/admin/namespaces/{namespace}/apps/{app}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [DELETE]`
##
## Removes the app's deployments, helm releases, stored manifests,
## secrets, ECR repository, configuration (DB + SSM), and â when the
## last app of a game namespace or studio is removed â the namespace
## and provisioner infrastructure. The cascade runs asynchronously;
## the app row transitions app-removing and is deleted on completion
## (app-remove-timeout after 1 hour).
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - forced: Force deletion (true|false) â bypasses the status guard only
func delete_app_v5(app: String, namespace_param: String, forced: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}"
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


## Update extend app (v5)
## PATCH /csm/v5/admin/namespaces/{namespace}/apps/{app}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [UPDATE]`
##
## Updates the app description. The enableDebugMode field is accepted
## for compatibility but ignored â use the debug-mode endpoint instead.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func update_app_v5(app: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Declaratively create or update an extend app from a spec (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}/apply
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP []`
##
## Idempotent endpoint that creates or updates an Extend app from a declarative spec.
## Uses three-way merge semantics (kubectl apply) for variables, secrets, and permissions.
##
## Note: preferred_k8s_namespace is only used on the initial create call; it is ignored on subsequent apply calls.
## On the first apply after creation the deletion phase is skipped (no prior apply state recorded).
##
## Parameters:
## - app: App Name. Expected format: (^[A-Za-z](?:[A-Za-z0-9-]*[A-Za-z0-9])?$)
## - namespace_param: Game namespace
func apply_app_config_v5(app: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/apply"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Create new deployment for an extend app (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}/deployments
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:DEPLOYMENT [CREATE]`
##
## Creates a new deployment for the given app + game namespace using the
## specified imageTag. The image tag MUST already exist in the app's ECR
## repository.
##
## Async behavior: the helm release install + status polling happen via
## the saga workflow "csmv5_createDeployment". v5 does NOT enqueue the v2-era Redis worker
## message â both endpoints coexist; pick one per client.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func create_deployment_v5(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/deployments"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Get a list of container images (v5)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}/images
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:IMAGE [READ]`
##
## Get a list of container images. Default 'cached' parameter is 'true'.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - cached: Get Cached Images
func get_app_image_list_v5(app: String, namespace_param: String, cached: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/images"
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


## Delete app images (v5)
## DELETE /csm/v5/admin/namespaces/{namespace}/apps/{app}/images
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:IMAGE [DELETE]`
##
## Deletes the provided image tags from the app image repository.
## Returns 409 if any requested tag is currently referenced by the
## app's latest deployment.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func delete_app_images_v5(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/images"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Update extend app resources (v5)
## PATCH /csm/v5/admin/namespaces/{namespace}/apps/{app}/resources
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [UPDATE]`
##
## Updates the app's requested cpu/memory/replica/autoscaling values
## and VM sharing configuration. When the app is currently running, a
## redeploy is triggered automatically to apply the new values.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func update_app_resources_v5(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/resources"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Request an extend app replica-limit increase (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}/resources/form
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [UPDATE]`
##
## Sends an email to the ops team with the app details and requested
## replica limit. Response is 204 No Content on success; the request
## is best-effort â no DB record is created.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func request_increase_limit_form_v5(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/resources/form"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Get a CPU/memory sizing recommendation for an extend app (v5)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}/resources/recommendation
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [READ]`
##
## Returns a deterministic, Prometheus/Mimir-backed CPU/memory sizing
## recommendation: current values, observed usage, the recommendation
## itself, confidence/reasoning/warnings, and a single-app cost
## impact estimate. Sparse or unmatched usage data never fails the
## request â it lowers Confidence to Low and adds a warning instead.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - target_hpa_cpu_pct: Override the app's deployed HPA target CPU utilization percent (10-500) for the CPU formula
func get_app_resource_recommendation_v5(
	app: String, namespace_param: String, target_hpa_cpu_pct: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/resources/recommendation"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not target_hpa_cpu_pct.is_empty():
		query_params["target_hpa_cpu_pct"] = target_hpa_cpu_pct
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Get list of environment secrets (v5)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:SECRET [READ]`
##
## Get list of environment secrets per app.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - limit: Limit
## - offset: Offset
func get_list_of_secrets_v5(
	app: String, namespace_param: String, limit: int = -1, offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets"
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


## Save an environment secret (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:SECRET [CREATE]`
##
## Save an environment secret. Secret will always be masked.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func save_secret_v5(app: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Update an environment secret (v5)
## PUT /csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:SECRET [UPDATE]`
##
## Update an environment secret. Secret will always be masked.
##
## Parameters:
## - app: App Name
## - config_id: Config ID
## - namespace_param: Game namespace
func update_secret_v5(
	app: String, config_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Delete an environment secret (v5)
## DELETE /csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:SECRET [DELETE]`
##
## Delete an environment secret by its config id.
##
## Parameters:
## - app: App Name
## - config_id: Config ID
## - namespace_param: Game namespace
func delete_secret_v5(app: String, config_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/secrets/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Start an extend app from its latest deployment (v5)
## PUT /csm/v5/admin/namespaces/{namespace}/apps/{app}/start
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [UPDATE]`
##
## Re-applies the helm release of the app's latest deployment (no
## re-render â configuration changes require a redeploy) and
## transitions to deployment-in-progress; the async workflow completes
## the start (deployment-running) or times out after 1 hour. Apps in
## creating/stopping/removing states cannot be started (400).
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func start_app_v5(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/start"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Get in-progress long-running operation steps for the extend app (stepper)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}/status-progress
##
## Returns step rows for the current or last tracked operation.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_app_status_progress_v5(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/status-progress"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Stop a running extend app (v5)
## PUT /csm/v5/admin/namespaces/{namespace}/apps/{app}/stop
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP [UPDATE]`
##
## Uninstalls the helm release of the app's latest deployment and
## transitions the app to app-stopping; the async workflow completes
## the stop (app-stopped) or times out after 1 hour (app-stop-timeout).
## Apps must be in deployment-running, deployment-down, or
## deployment-in-progress state (400 otherwise).
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func stop_app_v5(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/stop"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Get list of app notification subscribers (v5)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP:ALERT:SUBSCRIPTION [READ]`
##
## Query param 'notificationType' accepts: all, app-down, critical-vulnerability.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - notification_type: Notification Type (all, app-down, critical-vulnerability)
func get_notification_subscriber_list_v5(
	app: String, namespace_param: String, notification_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions"
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


## Bulk update of users subscribed to an app's notifications (v5)
## PUT /csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP:ALERT:SUBSCRIPTION [UPDATE]`
##
## Bulk update â each subscriber's notificationType map keys the change: true=subscribe, false=unsubscribe.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func bulk_save_subscription_app_notification_v5(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Subscribe user(s) to an app notification (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP:ALERT:SUBSCRIPTION [CREATE]`
##
## Subscribe user(s) to an app notification. Each subscriber must
## provide exactly one of userId or emailAddress. Supported
## notificationType values: all, app-down, critical-vulnerability.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func subscribe_app_notification_v5(
	app: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Remove a user from the notification subscription by user ID or email address (v5)
## DELETE /csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP:ALERT:SUBSCRIPTION [DELETE]`
##
## Remove a user from the notification subscription using either user ID
## or email address. Only one of them should be provided.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - email_address: Email Address
## - user_id: User ID
func delete_subscription_app_notification_v5(
	app: String, namespace_param: String, email_address: String = "", user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions"
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


## Get the caller's subscription status for the app (v5)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions/me
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func get_self_subscription_v5(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions/me"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Subscribe the caller to an app notification (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions/me
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP:ALERT:SELF:SUBSCRIPTION [CREATE]`
##
## Supported notificationType values: all, app-down, critical-vulnerability.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func self_subscribe_v5(app: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions/me"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Unsubscribe the caller from all notifications for the app (v5)
## DELETE /csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions/me
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:APP:ALERT:SELF:SUBSCRIPTION [DELETE]`
##
## Removes all notification-type rows for the caller on this app.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func self_unsubscribe_v5(app: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/subscriptions/me"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Get list of environment variables (v5)
## GET /csm/v5/admin/namespaces/{namespace}/apps/{app}/variables
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:VARIABLE [READ]`
##
## Get list of environment variables per app.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
## - limit: Limit
## - offset: Offset
func get_list_of_variables_v5(
	app: String, namespace_param: String, limit: int = -1, offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/variables"
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


## Save an environment variable (v5)
## POST /csm/v5/admin/namespaces/{namespace}/apps/{app}/variables
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:VARIABLE [CREATE]`
##
## Save an environment variable.
##
## Parameters:
## - app: App Name
## - namespace_param: Game namespace
func save_variable_v5(app: String, namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/variables"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Update an environment variable (v5)
## PUT /csm/v5/admin/namespaces/{namespace}/apps/{app}/variables/{configId}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:VARIABLE [UPDATE]`
##
## Update an environment variable.
##
## Parameters:
## - app: App Name
## - config_id: Config ID
## - namespace_param: Game namespace
func update_variable_v5(
	app: String, config_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/variables/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Delete an environment variable (v5)
## DELETE /csm/v5/admin/namespaces/{namespace}/apps/{app}/variables/{configId}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:VARIABLE [DELETE]`
##
## Delete an environment variable by its config id.
##
## Parameters:
## - app: App Name
## - config_id: Config ID
## - namespace_param: Game namespace
func delete_variable_v5(app: String, config_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/apps/{app}/variables/{configId}"
	url_path = url_path.replace("{" + "app" + "}", app.uri_encode())
	url_path = url_path.replace("{" + "configId" + "}", config_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Fetches the list of deployments (v5)
## POST /csm/v5/admin/namespaces/{namespace}/deployments
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:DEPLOYMENT [READ]`
##
## Filters the list of deployments for the given namespace.
## Request body: appIds, deploymentIds, statuses
## (deployment-in-progress, deployment-failed, deployment-timeout,
## deployment-running, deployment-down).
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Limit
## - offset: Offset
func list_deployments_v5(
	namespace_param: String, limit: int = -1, offset: int = -1, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/deployments"
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


## Get deployment by deployment ID (v5)
## GET /csm/v5/admin/namespaces/{namespace}/deployments/{deploymentId}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:DEPLOYMENT [READ]`
##
## Get deployment information by the given deploymentID.
##
## Parameters:
## - deployment_id: Deployment ID
## - namespace_param: Game namespace
func get_deployment_v5(deployment_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/deployments/{deploymentId}"
	url_path = url_path.replace("{" + "deploymentId" + "}", deployment_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Delete deployment by deployment ID (v5)
## DELETE /csm/v5/admin/namespaces/{namespace}/deployments/{deploymentId}
##
## Required permission : `ADMIN:NAMESPACE:{namespace}:EXTEND:DEPLOYMENT [DELETE]`
##
## Deletes the helm release for the deployment in the cluster,
## removes the stored release manifest, and deletes the deployment
## record. Deployments in deployment-in-progress state cannot be
## deleted (400).
##
## Parameters:
## - deployment_id: Deployment ID
## - namespace_param: Game namespace
func delete_deployment_v5(deployment_id: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/deployments/{deploymentId}"
	url_path = url_path.replace("{" + "deploymentId" + "}", deployment_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Get Extend App configurable limits (v5)
## GET /csm/v5/admin/namespaces/{namespace}/resources/limits
##
## Returns the Extend App configurable limits used by the AB Portal for
## pre-create validation (replica limit, cpu/memory limits, autoscaling
## bounds, max notification subscribers). No permission required â auth
## is valid token + valid audience + validated studio only.
##
## Parameters:
## - namespace_param: Game namespace
func get_resources_limits_v5(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/csm/v5/admin/namespaces/{namespace}/resources/limits"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
