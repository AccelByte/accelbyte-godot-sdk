## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## session_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-session-service
## Version: 3.29.3
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(SessionService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name SessionService
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

## GetHealthcheckInfo
## GET /healthz
func get_healthcheck_info() -> Dictionary:
	# Build URL path
	var url_path: String = "/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## GetHealthcheckInfoV1
## GET /session/healthz
func get_healthcheck_info_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Log Configuration
## GET /session/v1/admin/config/log
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Patch Update Log Configuration
## PATCH /session/v1/admin/config/log
func admin_patch_update_log_config(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get dsmc default configuration.
## GET /session/v1/admin/dsconfigs/default
## @deprecated
func admin_get_dsmc_configuration_default() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/dsconfigs/default"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List of environment variables.
## GET /session/v1/admin/environment-variables
func admin_list_environment_variables() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/environment-variables"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Record of global configuration data.
## GET /session/v1/admin/global-configurations
func admin_list_global_configuration() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Upsert global configuration data.
## PUT /session/v1/admin/global-configurations
func admin_update_global_configuration(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete of global configuration data.
## DELETE /session/v1/admin/global-configurations
func admin_delete_global_configuration() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get configuration alert.
## GET /session/v1/admin/namespaces/{namespace}/alerts-configuration
func admin_get_configuration_alert_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update configuration alert.
## PUT /session/v1/admin/namespaces/{namespace}/alerts-configuration
func admin_update_configuration_alert_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create configuration alert.
## POST /session/v1/admin/namespaces/{namespace}/alerts-configuration
func admin_create_configuration_alert_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete configuration alert.
## DELETE /session/v1/admin/namespaces/{namespace}/alerts-configuration
func admin_delete_configuration_alert_v1(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Upload certificates for XBox.
## PUT /session/v1/admin/namespaces/{namespace}/certificates/pfx/platforms/xbl
## @deprecated
func admin_upload_x_box_certificate(
	namespace_param: String,
	certname: String,
	file: String,
	password: String,
	description: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/certificates/pfx/platforms/xbl"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create configuration template.
## POST /session/v1/admin/namespaces/{namespace}/configuration
func admin_create_configuration_template_v1(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get configuration templates.
## GET /session/v1/admin/namespaces/{namespace}/configurations
func admin_get_all_configuration_templates_v1(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	order: String = "",
	order_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations"
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
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get configuration template.
## GET /session/v1/admin/namespaces/{namespace}/configurations/{name}
func admin_get_configuration_template_v1(
	name_param: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update configuration template.
## PUT /session/v1/admin/namespaces/{namespace}/configurations/{name}
func admin_update_configuration_template_v1(
	name_param: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete configuration template.
## DELETE /session/v1/admin/namespaces/{namespace}/configurations/{name}
func admin_delete_configuration_template_v1(
	name_param: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Member Active Session.
## GET /session/v1/admin/namespaces/{namespace}/configurations/{name}/memberactivesession/{userId}
func admin_get_member_active_session(
	name_param: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}/memberactivesession/{userId}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Reconcile Max Active Session.
## POST /session/v1/admin/namespaces/{namespace}/configurations/{name}/reconcile
func admin_reconcile_max_active_session(
	name_param: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}/reconcile"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get dsmc configuration .
## GET /session/v1/admin/namespaces/{namespace}/dsconfigs
## @deprecated
func admin_get_dsmc_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/dsconfigs"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## sync dsmc configuration.
## GET /session/v1/admin/namespaces/{namespace}/dsconfigs/sync
## @deprecated
func admin_sync_dsmc_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/dsconfigs/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all game sessions.
## GET /session/v1/admin/namespaces/{namespace}/gamesessions
func admin_query_game_sessions(
	namespace_param: String,
	configuration_name: String = "",
	ds_pod_name: String = "",
	from_time: String = "",
	game_mode: String = "",
	is_persistent: String = "",
	is_soft_deleted: String = "",
	joinability: String = "",
	limit: int = -1,
	match_pool: String = "",
	member_id: String = "",
	offset: int = -1,
	order: String = "",
	order_by: String = "",
	session_id: String = "",
	status: String = "",
	status_v2: String = "",
	to_time: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not configuration_name.is_empty():
		query_params["configurationName"] = configuration_name
	if not ds_pod_name.is_empty():
		query_params["dsPodName"] = ds_pod_name
	if not from_time.is_empty():
		query_params["fromTime"] = from_time
	if not game_mode.is_empty():
		query_params["gameMode"] = game_mode
	if not is_persistent.is_empty():
		query_params["isPersistent"] = is_persistent
	if not is_soft_deleted.is_empty():
		query_params["isSoftDeleted"] = is_soft_deleted
	if not joinability.is_empty():
		query_params["joinability"] = joinability
	if limit >= 0:
		query_params["limit"] = limit
	if not match_pool.is_empty():
		query_params["matchPool"] = match_pool
	if not member_id.is_empty():
		query_params["memberID"] = member_id
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not session_id.is_empty():
		query_params["sessionID"] = session_id
	if not status.is_empty():
		query_params["status"] = status
	if not status_v2.is_empty():
		query_params["statusV2"] = status_v2
	if not to_time.is_empty():
		query_params["toTime"] = to_time
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query game sessions by admin
## POST /session/v1/admin/namespaces/{namespace}/gamesessions
func admin_query_game_sessions_by_attributes(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete bulk game sessions.
## DELETE /session/v1/admin/namespaces/{namespace}/gamesessions/bulk
func admin_delete_bulk_game_sessions(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Admin set the DS ready to accept connection
## PUT /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/ds
func admin_set_ds_ready(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/ds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Update Game Session DS Information for Asynchronous Process.
## PUT /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/dsinformation
func admin_update_ds_information(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/dsinformation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Kick member from a game session.
## DELETE /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick
func admin_kick_game_session_member(
	member_id: String,
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick"
	url_path = url_path.replace("{" + "memberId" + "}", member_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update status of a game session member.
## PUT /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/status/{statusType}
func admin_update_game_session_member(
	member_id: String,
	namespace_param: String,
	session_id: String,
	status_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/status/{statusType}"
	url_path = url_path.replace("{" + "memberId" + "}", member_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "statusType" + "}", status_type.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## List of native sessions.
## GET /session/v1/admin/namespaces/{namespace}/native-sessions
func admin_get_list_native_session(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	order: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/native-sessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query parties.
## GET /session/v1/admin/namespaces/{namespace}/parties
func admin_query_parties(
	namespace_param: String,
	configuration_name: String = "",
	from_time: String = "",
	is_soft_deleted: String = "",
	joinability: String = "",
	key: String = "",
	leader_id: String = "",
	limit: int = -1,
	member_id: String = "",
	member_status: String = "",
	offset: int = -1,
	order: String = "",
	order_by: String = "",
	party_id: String = "",
	to_time: String = "",
	value: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/parties"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not configuration_name.is_empty():
		query_params["configurationName"] = configuration_name
	if not from_time.is_empty():
		query_params["fromTime"] = from_time
	if not is_soft_deleted.is_empty():
		query_params["isSoftDeleted"] = is_soft_deleted
	if not joinability.is_empty():
		query_params["joinability"] = joinability
	if not key.is_empty():
		query_params["key"] = key
	if not leader_id.is_empty():
		query_params["leaderID"] = leader_id
	if limit >= 0:
		query_params["limit"] = limit
	if not member_id.is_empty():
		query_params["memberID"] = member_id
	if not member_status.is_empty():
		query_params["memberStatus"] = member_status
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not to_time.is_empty():
		query_params["toTime"] = to_time
	if not value.is_empty():
		query_params["value"] = value
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete bulk parties.
## DELETE /session/v1/admin/namespaces/{namespace}/parties/bulk
func admin_delete_bulk_parties(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/parties/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Read Party Session Storage.
## GET /session/v1/admin/namespaces/{namespace}/parties/{partyId}/storage
func admin_read_party_session_storage(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/parties/{partyId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get platform credentials. These are used to sync PSN sessions.
## GET /session/v1/admin/namespaces/{namespace}/platform-credentials
func admin_get_platform_credentials(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update platform credentials. Currently only used to sync PSN sessions.
## PUT /session/v1/admin/namespaces/{namespace}/platform-credentials
func admin_update_platform_credentials(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete platform credentials.
## DELETE /session/v1/admin/namespaces/{namespace}/platform-credentials
func admin_delete_platform_credentials(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Delete platform credentials by platformId
## DELETE /session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}
func admin_delete_platform_credentials_by_platform_id(
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Sync Platform Credentials.
## PUT /session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/sync
func admin_sync_platform_credentials(
	namespace_param: String,
	platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Upload certificates for XBOX Platform
## PUT /session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/upload
func admin_upload_platform_credentials(
	namespace_param: String,
	platform_id: String,
	file: String,
	password: String,
	description: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/upload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query recent player with given user id.
## GET /session/v1/admin/namespaces/{namespace}/recent-player
func admin_get_recent_player(
	namespace_param: String,
	limit: int = -1,
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/recent-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query recent player who were on the same team with given user id.
## GET /session/v1/admin/namespaces/{namespace}/recent-team-player
func admin_get_recent_team_player(
	namespace_param: String,
	limit: int = -1,
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/recent-team-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Read Session Storage.
## GET /session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage
func admin_read_session_storage(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Session Storage.
## DELETE /session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage
func admin_delete_user_session_storage(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Read Session Storage User.
## GET /session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}
func admin_read_user_session_storage(
	namespace_param: String,
	session_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query player attributes.
## GET /session/v1/admin/namespaces/{namespace}/users/attributes
func admin_query_player_attributes(
	namespace_param: String,
	users: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/users/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not users.is_empty():
		query_params["users"] = users
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get player attributes.
## GET /session/v1/admin/namespaces/{namespace}/users/{userId}/attributes
func admin_get_player_attributes(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/users/{userId}/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Trigger user's active party session to native platform.
## POST /session/v1/admin/namespaces/{namespace}/users/{userId}/native-sync
func admin_sync_native_session(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/users/{userId}/native-sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Create a game session.
## POST /session/v1/public/namespaces/{namespace}/gamesession
func create_game_session(
	namespace_param: String,
	resolve_max_active_session: bool = false,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesession"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["resolveMaxActiveSession"] = resolve_max_active_session
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query game sessions
## POST /session/v1/public/namespaces/{namespace}/gamesessions
func public_query_game_sessions_by_attributes(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Join a session by code.
## POST /session/v1/public/namespaces/{namespace}/gamesessions/join/code
func public_session_join_code(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/join/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get game session detail.
## GET /session/v1/public/namespaces/{namespace}/gamesessions/servers/{podName}
func get_game_session_by_pod_name(
	namespace_param: String,
	pod_name: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/servers/{podName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "podName" + "}", pod_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get game session detail.
## GET /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
func get_game_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a game session.
## PUT /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
func update_game_session(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a game session.
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
func delete_game_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Patch update a game session.
## PATCH /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
func patch_update_game_session(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update game session backfill ticket id .
## PUT /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/backfill
func update_game_session_backfill_ticket_id(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/backfill"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Generate a game session code.
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code
func game_session_generate_code(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Revoke game session code.
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code
func public_revoke_game_session_code(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Invite a user to a game session.
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/invite
func public_game_session_invite(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/invite"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Join a game session.
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/join
func join_game_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/join"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Promote new game session leader.
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leader
func public_promote_game_session_leader(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Leave a game session.
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leave
func leave_game_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leave"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Kick member from a game session, only leader can kick member.
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick
func public_kick_game_session_member(
	member_id: String,
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick"
	url_path = url_path.replace("{" + "memberId" + "}", member_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Reject a game session invitation.
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/reject
func public_game_session_reject(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/reject"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Server Secret.
## GET /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/secret
func get_session_server_secret(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/secret"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Append new member or team to session. Please use...
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/teams
## @deprecated
func append_team_game_session(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/teams"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## cancel a game session invitation.
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/users/{userId}/cancel
func public_game_session_cancel(
	namespace_param: String,
	session_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/users/{userId}/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Join a party by code.
## POST /session/v1/public/namespaces/{namespace}/parties/users/me/join/code
func public_party_join_code(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/users/me/join/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get party details.
## GET /session/v1/public/namespaces/{namespace}/parties/{partyId}
func public_get_party(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a party.
## PUT /session/v1/public/namespaces/{namespace}/parties/{partyId}
func public_update_party(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Patch update a party.
## PATCH /session/v1/public/namespaces/{namespace}/parties/{partyId}
func public_patch_update_party(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Generate party code.
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/code
func public_generate_party_code(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Revoke party code.
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/code
func public_revoke_party_code(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Invite a user to a party.
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/invite
func public_party_invite(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/invite"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Promote new party leader.
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/leader
func public_promote_party_leader(
	namespace_param: String,
	party_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Read Party Session Storage.
## GET /session/v1/public/namespaces/{namespace}/parties/{partyId}/storage
func public_read_party_session_storage(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Insert Party Session Storage User.
## PATCH /session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}
func public_update_insert_party_session_storage(
	namespace_param: String,
	party_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update Insert Party Session Reserved Storage User.
## PATCH /session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}/reserved
func public_update_insert_party_session_storage_reserved(
	namespace_param: String,
	party_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}/reserved"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Join a party.
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/join
func public_party_join(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/join"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Leave a party.
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/leave
func public_party_leave(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/leave"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Reject a party invitation.
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/reject
func public_party_reject(
	namespace_param: String,
	party_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/reject"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Cancel a party invitation.
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/cancel
func public_party_cancel(
	namespace_param: String,
	party_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Kick a player from a party.
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/kick
func public_party_kick(
	namespace_param: String,
	party_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/kick"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Create a party.
## POST /session/v1/public/namespaces/{namespace}/party
func public_create_party(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/party"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query user's recent player
## GET /session/v1/public/namespaces/{namespace}/recent-player
func public_get_recent_player(
	namespace_param: String,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/recent-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query user's recent player who were on the same team.
## GET /session/v1/public/namespaces/{namespace}/recent-team-player
func public_get_recent_team_player(
	namespace_param: String,
	limit: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/recent-team-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Insert Session Storage Leader.
## PATCH /session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader
func public_update_insert_session_storage_leader(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update Insert Session Storage User.
## PATCH /session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}
func public_update_insert_session_storage(
	namespace_param: String,
	session_id: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Get player current platform in bulk.
## POST /session/v1/public/namespaces/{namespace}/users/bulk/platform
func public_get_bulk_player_current_platform(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/bulk/platform"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get player attributes.
## GET /session/v1/public/namespaces/{namespace}/users/me/attributes
func public_get_player_attributes(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Store player attributes.
## POST /session/v1/public/namespaces/{namespace}/users/me/attributes
func public_store_player_attributes(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Remove player attributes.
## DELETE /session/v1/public/namespaces/{namespace}/users/me/attributes
func public_delete_player_attributes(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Query user's game sessions
## GET /session/v1/public/namespaces/{namespace}/users/me/gamesessions
func public_query_my_game_sessions(
	namespace_param: String,
	order: String = "",
	order_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query my parties. Require valid JWT.
## GET /session/v1/public/namespaces/{namespace}/users/me/parties
func public_query_my_parties(
	namespace_param: String,
	order: String = "",
	order_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/parties"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
