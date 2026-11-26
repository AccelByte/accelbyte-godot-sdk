## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## gdpr_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-gdpr-service
## Version: 1.2.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(GdprService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name GdprService
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


## pprofHandlerFunc
## GET /gdpr/admin/internal/debug/pprof/{pprof}
##
## Parameters:
## - pprof: pprof profile name
func pprof_handler_func(pprof: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/internal/debug/pprof/{pprof}"
	url_path = url_path.replace("{" + "pprof" + "}", pprof.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## func5
## GET /gdpr/admin/internal/metrics
func func5() -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/internal/metrics"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves all account deletion requests for a specified date
## GET /gdpr/admin/namespaces/{namespace}/deletions
##
## Lists account deletion requests across all users in the namespace for the specified date. Supports cursor-based pagination via the `after` and `before` query parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - after: Cursor for forward pagination
## - before: Cursor for backward pagination
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - request_date: The day in UTC of the deletion request. format : YYYY-MM-DD. Default : today time in UTC.
func admin_get_list_deletion_data_request(
	namespace_param: String,
	after: String = "",
	before: String = "",
	limit: int = -1,
	offset: int = -1,
	request_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/deletions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not after.is_empty():
		query_params["after"] = after
	if not before.is_empty():
		query_params["before"] = before
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not request_date.is_empty():
		query_params["requestDate"] = request_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves admin email address configurations for the namespace
## GET /gdpr/admin/namespaces/{namespace}/emails/configurations
##
## Get list of admin email address configuration.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func get_admin_email_configuration(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates admin email addresses in the personal data notification list
## PUT /gdpr/admin/namespaces/{namespace}/emails/configurations
##
## Update admin email address for receiving personal data request notification.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func update_admin_email_configuration(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Adds admin email addresses to the personal data notification list
## POST /gdpr/admin/namespaces/{namespace}/emails/configurations
##
## Add admin email address for receiving personal data request notification.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func save_admin_email_configuration(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes admin email addresses from the personal data notification list
## DELETE /gdpr/admin/namespaces/{namespace}/emails/configurations
##
## Delete a list of admin email addresses to stop receiving personal data request notification.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - emails: List of admin email to delete
func delete_admin_email_configuration(namespace_param: String, emails: Array) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if emails.size() > 0:
		query_params["emails"] = emails
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves platform account closure client configurations
## GET /gdpr/admin/namespaces/{namespace}/platforms/closure/clients
##
## Get platform account closure configs.
## ------
## Platform:
## - steamnetwork
## - xbox
## - psn
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_platform_account_closure_clients(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/closure/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Validates the Xbox Business Partner certificate file for account closure
## POST /gdpr/admin/namespaces/{namespace}/platforms/xbox/closure/cert/validation
##
## Checks whether the Xbox Business Partner certificate file has expired and returns its expiry date.
##
## Parameters:
## - namespace_param: Game namespace
func admin_validate_xbox_bp_cert_file(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/xbox/closure/cert/validation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the account closure client configuration for the specified platform
## GET /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
##
## Get platform account closure config.
## The namespace should be **publisher or studio namespace**
## ---
## Platform:
## - steamnetwork
## - xbox
## - psn
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - platform: 3rd party platform
func admin_get_platform_account_closure_client(
	namespace_param: String, platform: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the account closure client configuration for the specified platform
## POST /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
##
## Update platform account closure client.
## The namespace should be the **publisher or studio namespace**.
## ---
## Platform:
## - steamnetwork
## - xbox
## - psn
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - platform: 3rd party platform
func admin_update_platform_account_closure_client(
	namespace_param: String, platform: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes the account closure client configuration for the specified platform
## DELETE /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
##
## Delete platform account closure client.
## The namespace should be **publisher or studio namespace**
## ---
## Platform:
## - steamnetwork
## - xbox
## - psn
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - platform: 3rd party platform
func admin_delete_platform_account_closure_client(
	namespace_param: String, platform: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Creates a mock account closure event for the specified platform
## POST /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/mock
##
## Mock platform account closure data.
## -----
## **This is only for testing**
## Platform:
## - steamnetwork
## - xbox
## - psn
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - platform: 3rd party platform
func admin_mock_platform_account_closure_data(
	namespace_param: String, platform: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/mock"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platform" + "}", platform.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists personal data requests across the namespace
## GET /gdpr/admin/namespaces/{namespace}/requests
##
## Lists personal data requests across all users in the namespace for the specified date. Supports offset-based pagination using the `limit` and `offset` parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - request_date: Request date with format YYYY-MM-DD. Default value today UTC
func admin_get_list_personal_data_request(
	namespace_param: String, limit: int = -1, offset: int = -1, request_date: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/requests"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not request_date.is_empty():
		query_params["requestDate"] = request_date
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves registered service configurations for the namespace
## GET /gdpr/admin/namespaces/{namespace}/services/configurations
##
## Get Registered Services Configuration.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_services_configuration(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates registered service configurations for the namespace
## PUT /gdpr/admin/namespaces/{namespace}/services/configurations
##
## Update Registered Services Configuration.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_services_configuration(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Resets registered service configurations to defaults
## DELETE /gdpr/admin/namespaces/{namespace}/services/configurations/reset
##
## **[TEST FACILITY ONLY]**
## Reset Registered Services Configuration to use the default configuration.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func admin_reset_services_configuration(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves platform account closure service configurations for the namespace
## GET /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
##
## Get registered platform account closure services configuration.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_platform_account_closure_services_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/platforms/closure/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates platform account closure service configurations for the namespace
## PUT /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
##
## Update registered platform account closure services configuration.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_platform_account_closure_services_configuration(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/platforms/closure/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Resets platform account closure service configurations to defaults
## DELETE /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
##
## **[TEST FACILITY ONLY]**
## Reset registered platform account closure services configuration to use the default configuration.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
func admin_reset_platform_account_closure_services_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/platforms/closure/config"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves platform account closure histories across users in the namespace
## GET /gdpr/admin/namespaces/{namespace}/users/platforms/closure/histories
##
## Lists platform account closure histories across users in the namespace. Supported platforms: psn, steamnetwork, xbox. Supports offset-based pagination using the `limit` and `offset` parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - platform: 3rd party platform
## - user_id: AccelByte user ID
func admin_get_user_platform_account_closure_histories(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	platform: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/platforms/closure/histories"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not platform.is_empty():
		query_params["platform"] = platform
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the account deletion request for a specific user
## GET /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
##
## Retrieve specific user's account deletion request
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_user_account_deletion_request(
	namespace_param: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/deletions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Submits an account deletion request for a specific user
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
##
## Submit user's account deletion request.
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_submit_user_account_deletion_request(
	namespace_param: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/deletions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Cancels a user's pending account deletion request
## DELETE /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
##
## Cancel user's account deletion request
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_cancel_user_account_deletion_request(
	namespace_param: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/deletions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves personal data requests for a specific user
## GET /gdpr/admin/namespaces/{namespace}/users/{userId}/requests
##
## Lists personal data requests for the specified user. Supports offset-based pagination using the `limit` and `offset` parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_user_personal_data_requests(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests"
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


## Submits a personal data retrieval request for a user
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/requests
##
## Submits a personal data retrieval request for the specified user.
##
## ### Request Header:
## - **Content-Type: application/x-www-form-urlencoded**
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - password: IAM password of the user, required if admin requests their own data
func admin_request_data_retrieval(
	namespace_param: String, user_id: String, password: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Cancels a user's pending personal data request
## DELETE /gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}
##
## Cancel user's personal data requests
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - request_date: Request date in RFC3339 format
## - user_id: AccelByte user ID
func admin_cancel_user_personal_data_request(
	namespace_param: String, request_date: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestDate" + "}", str(request_date).uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Generates a personal data download URL for the specified request
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
##
## Generates a download URL for the requested personal data. When the requesting admin is the same user as the target, the admin must provide the password parameter.
##
## Parameters:
## - namespace_param: Game namespace
## - request_date: Request date in RFC3339 format
## - user_id: AccelByte user ID
## - password: Required when the requesting admin is the same user as the target.
func admin_generate_personal_data_url(
	namespace_param: String, request_date: String, user_id: String, password: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestDate" + "}", str(request_date).uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Upload Xbox BP Cert File
## POST /gdpr/internal/namespaces/{namespace}/platforms/xbox/closure/cert/upload
##
## Upload xbox bp cert file, no matter whether the file is expired or not.
## ----
## **NOTE: This is only for test**
##
## Parameters:
## - namespace_param: namespace
func admin_upload_xbox_bp_cert(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/internal/namespaces/{namespace}/platforms/xbox/closure/cert/upload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Submits an account deletion request for the specified user
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/deletions
##
## Submit user's account deletion request.
## Requires valid user access token and password
## Scope: account
##
## ### Request Header:
## - **Content-Type: application/x-www-form-urlencoded**
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - language_tag: IETF language tag for the notification email, such as `en` or `fr`.
## - password: IAM password of the user
func public_submit_user_account_deletion_request(
	namespace_param: String, user_id: String, password: String, language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/deletions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Cancels a user's pending account deletion request
## DELETE /gdpr/public/namespaces/{namespace}/users/{userId}/deletions
##
## Cancel user's account deletion request
## Requires valid user access token
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_cancel_user_account_deletion_request(
	namespace_param: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/deletions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the account deletion status for the specified user
## GET /gdpr/public/namespaces/{namespace}/users/{userId}/deletions/status
##
## Retrieve specific user's account deletion status
## Requires valid user access token
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_user_account_deletion_status(
	namespace_param: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/deletions/status"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves personal data requests for the specified user
## GET /gdpr/public/namespaces/{namespace}/users/{userId}/requests
##
## Lists personal data requests for the specified user. Supports offset-based pagination using the `limit` and `offset` parameters.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func public_get_user_personal_data_requests(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests"
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


## Submits a personal data retrieval request for the specified user
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests
##
## Submit personal data retrieval request.
## Scope: account
##
## ### Request Header:
## - **Content-Type: application/x-www-form-urlencoded**
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - language_tag: IETF language tag for the notification email, such as `en` or `fr`.
## - password: IAM password of the user
func public_request_data_retrieval(
	namespace_param: String, user_id: String, password: String, language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Cancels a user's pending personal data request
## DELETE /gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}
##
## Cancel user's personal data requests
## Requires valid user access token
## Scope: account
##
## Parameters:
## - namespace_param: Game namespace
## - request_date: Request date in RFC3339 format
## - user_id: AccelByte user ID
func public_cancel_user_personal_data_request(
	namespace_param: String, request_date: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestDate" + "}", request_date.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Generates a personal data download URL for the specified request
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
##
## Generates a download URL for the requested personal data. The caller must be authenticated with a valid user access token.
##
## ### Request Header:
## - **Content-Type: application/x-www-form-urlencoded**
##
## Parameters:
## - namespace_param: Game namespace
## - request_date: Request date in RFC3339 format
## - user_id: AccelByte user ID
## - password: IAM password of the user
func public_generate_personal_data_url(
	namespace_param: String, request_date: String, user_id: String, password: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestDate" + "}", request_date.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not password.is_empty():
		form_data["password"] = password
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Submits an account deletion request for the current user
## POST /gdpr/public/users/me/deletions
##
## Submits an account deletion request for the current user. Requires a valid platform ID and platform token; for accounts not linked to a third-party platform, use the namespace-scoped deletion operation instead.
##
## Parameters:
## - platform_id: Third-party platform identifier
## - platform_token: Platform token of current logged platform
func public_submit_my_account_deletion_request(
	platform_id: String, platform_token: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not platform_id.is_empty():
		form_data["platformId"] = platform_id
	if not platform_token.is_empty():
		form_data["platformToken"] = platform_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Cancels the current user's pending account deletion request
## DELETE /gdpr/public/users/me/deletions
##
## Cancel my account deletion request
## Requires valid user access token
func public_cancel_my_account_deletion_request() -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the current user's account deletion status
## GET /gdpr/public/users/me/deletions/status
##
## Retrieve my account deletion status
## Requires valid user access token
func public_get_my_account_deletion_status() -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions/status"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Submit my headless account deletion request
## POST /gdpr/public/users/me/headless/deletions
##
## Submit an Account Deletion Request for headless account scenario (without a password).
## **Typically used by web portal** to invoke headless player GDPR using 3rd platform web authentication.
## Requires a valid access token and a fresh **gdpr_token** cookie (max-age 10 seconds).
## The gdpr_token is issued by the IAM service during 3rd platform web authentication.
##
## If a full account is available, use `POST /gdpr/public/namespaces/{namespace}/users/{userId}/deletions` instead.
func public_submit_my_headless_deletion_request() -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/headless/deletions"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Submit my headless personal data request
## POST /gdpr/public/users/me/headless/requests
##
## Submit a Personal Data Request for headless account scenario (without a password).
## **Typically used by web portal** to invoke headless player GDPR using 3rd platform web authentication.
## Requires a valid access token and a fresh **gdpr_token** cookie (max-age 5 minutes).
## The gdpr_token is issued by the IAM service during 3rd platform web authentication.
##
## If a full account is available, use `POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests` instead.
##
## ### Request Header:
## - **Content-Type: application/x-www-form-urlencoded**
##
## Parameters:
## - email: Email address to receive notifications and download links when the generated data is ready.
## - language_tag: Language tag for the notification email
func public_submit_my_headless_personal_data_request(
	email: String = "", language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/headless/requests"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not email.is_empty():
		form_data["email"] = email
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Generate my headless personal data download url
## POST /gdpr/public/users/me/headless/requests/{requestDate}/generate
##
## Generate a download url for a completed Personal Data Request for headless account scenario (without a password).
## **Typically used by web portal** to invoke headless player GDPR using 3rd platform web authentication.
## Requires a valid access token and a fresh **gdpr_token** cookie (max-age 5 minutes).
## The gdpr_token is issued by the IAM service during 3rd platform web authentication.
##
## If a full account is available, use `POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate` instead.
##
## Parameters:
## - request_date: Request date in RFC3339 format
func public_generate_my_headless_personal_data_url(request_date: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/headless/requests/{requestDate}/generate"
	url_path = url_path.replace("{" + "requestDate" + "}", request_date.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Get my personal data requests
## GET /gdpr/public/users/me/requests
##
## List my personal data requests. Requires a valid access token.
func public_get_my_personal_data_requests() -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/requests"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Submit my personal data request
## POST /gdpr/public/users/me/requests
##
## Submit a Personal Data Request authenticated by a platform token.
## Requires a valid access token.
##
## This endpoint is intended for **in-game use** only and requires a valid platformId and platform token.
## If a full account is available, use `POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests` instead.
##
## ### Request Header:
## - **Content-Type: application/x-www-form-urlencoded**
##
## Parameters:
## - email: Email address to receive notifications and download links when the generated data is ready.
## - language_tag: Language tag for the notification email
## - platform_id: Platform ID
## - platform_token: Platform token
func public_submit_my_personal_data_request(
	platform_id: String, platform_token: String, email: String = "", language_tag: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/requests"
	var url: String = _service_url + url_path
	# Build form body
	var form_data: Dictionary = {}
	if not email.is_empty():
		form_data["email"] = email
	if not language_tag.is_empty():
		form_data["languageTag"] = language_tag
	if not platform_id.is_empty():
		form_data["platformId"] = platform_id
	if not platform_token.is_empty():
		form_data["platformToken"] = platform_token
	var request_body: String = AccelbyteHttp.build_form_body(form_data)

	# Build headers
	var headers: PackedStringArray = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Cancel my personal data request
## DELETE /gdpr/public/users/me/requests/{requestDate}
##
## Cancel a pending Personal Data Request by its request date. Requires a valid access token.
##
## Parameters:
## - request_date: Request date (RFC3339 format)
func public_cancel_my_personal_data_request(request_date: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/requests/{requestDate}"
	url_path = url_path.replace("{" + "requestDate" + "}", request_date.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Lists finished account deletion requests within a time range
## GET /gdpr/s2s/namespaces/{namespace}/deletions/finished
##
## Lists finished account deletion requests based on the specified time interval. The response excludes requests with status Request, Pending, or In-Progress.
##
## For deleted accounts, the system anonymizes the user ID in the response.
##
## Parameters:
## - namespace_param: Game namespace
## - end: Finished end time (RFC3339 format, example: 2024-01-01T01:30:59.12Z). Cannot exceed current time. End time is exclusive
## - start: Finished start time (RFC3339 format, example: 2024-01-01T01:30:59.12Z). Start time is inclusive
func s2s_get_list_finished_account_deletion_request(
	namespace_param: String, end: String, start: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/deletions/finished"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
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


## Lists finished personal data requests within a time range
## GET /gdpr/s2s/namespaces/{namespace}/requests/finished
##
## Lists finished personal data requests based on the specified time interval. The response excludes requests with status Pending, In-Progress, or Canceled.
##
## For deleted accounts, the system anonymizes the user ID in the response.
##
## Parameters:
## - namespace_param: Game namespace
## - end: Finished end time (RFC3339 format, example: 2024-01-01T01:30:59.12Z). Cannot exceed current time. End time is exclusive
## - start: Finished start time (RFC3339 format, example: 2024-01-01T01:30:59.12Z). Start time is inclusive
func s2s_get_list_finished_personal_data_request(
	namespace_param: String, end: String, start: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/requests/finished"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
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


## Retrieves a personal data request by its ID
## GET /gdpr/s2s/namespaces/{namespace}/requests/{requestId}
##
## Retrieves a personal data request by its ID. When the request is complete, returns a download URL for the data package.
##
## Parameters:
## - namespace_param: Game namespace
## - request_id: Unique identifier of the personal data request.
func s2s_get_data_request_by_request_id(namespace_param: String, request_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/requests/{requestId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestId" + "}", request_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Submits a user's account deletion request via server-to-server
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/deletions
##
## Submits an account deletion request for the specified user. The service accepts only publisher user IDs, not game user IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func s2s_submit_user_account_deletion_request(
	namespace_param: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/users/{userId}/deletions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Submits a personal data retrieval request via server-to-server
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/requests
##
## Submits a personal data retrieval request for the specified user. The service accepts only publisher user IDs, not game user IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func s2s_request_data_retrieval(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/users/{userId}/requests"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Generates a personal data download URL via server-to-server
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
##
## Generates a download URL for the requested personal data. The service accepts only publisher user IDs, not game user IDs.
##
## Parameters:
## - namespace_param: Game namespace
## - request_date: Request date in RFC3339 format
## - user_id: AccelByte user ID
func s2s_generate_personal_data_url(
	namespace_param: String, request_date: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestDate" + "}", str(request_date).uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
