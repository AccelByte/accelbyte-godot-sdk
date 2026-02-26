## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## gdpr_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-gdpr-service
## Version: 2.22.0
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

## Retrieve all user's account deletion requests in specified date
## GET /gdpr/admin/namespaces/{namespace}/deletions
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

## Get admin email addresses configuration
## GET /gdpr/admin/namespaces/{namespace}/emails/configurations
func get_admin_email_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update admin email address configuration
## PUT /gdpr/admin/namespaces/{namespace}/emails/configurations
func update_admin_email_configuration(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Add admin email address configuration
## POST /gdpr/admin/namespaces/{namespace}/emails/configurations
func save_admin_email_configuration(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/emails/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete admin emails configurations
## DELETE /gdpr/admin/namespaces/{namespace}/emails/configurations
func delete_admin_email_configuration(
	namespace_param: String,
	emails: Array
) -> Dictionary:
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

## Get Platform Account Closure Configs
## GET /gdpr/admin/namespaces/{namespace}/platforms/closure/clients
func admin_get_platform_account_closure_clients(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/closure/clients"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Validate Xbox BP cert file
## POST /gdpr/admin/namespaces/{namespace}/platforms/xbox/closure/cert/validation
func admin_validate_xbox_bp_cert_file(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/platforms/xbox/closure/cert/validation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Platform Account Closure Config
## GET /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
func admin_get_platform_account_closure_client(
	namespace_param: String,
	platform: String
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

## Update Platform Account Closure Client
## POST /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
func admin_update_platform_account_closure_client(
	namespace_param: String,
	platform: String,
	body: Dictionary = {}
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

## Delete Platform Account Closure Client
## DELETE /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/client
func admin_delete_platform_account_closure_client(
	namespace_param: String,
	platform: String
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

## Mock Platform Account Closure Data
## POST /gdpr/admin/namespaces/{namespace}/platforms/{platform}/closure/mock
func admin_mock_platform_account_closure_data(
	namespace_param: String,
	platform: String,
	body: Dictionary = {}
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

## Get list personal data requests
## GET /gdpr/admin/namespaces/{namespace}/requests
func admin_get_list_personal_data_request(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	request_date: String = ""
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

## Get Registered Services Configuration
## GET /gdpr/admin/namespaces/{namespace}/services/configurations
func admin_get_services_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Registered Services Configuration
## PUT /gdpr/admin/namespaces/{namespace}/services/configurations
func admin_update_services_configuration(
	namespace_param: String,
	body: Dictionary = {}
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

## Reset Registered Services Configuration
## DELETE /gdpr/admin/namespaces/{namespace}/services/configurations/reset
func admin_reset_services_configuration(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/services/configurations/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get Registered Platform Account Closure Services Configuration
## GET /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
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

## Update Registered Platform Account Closure Services Configuration
## PUT /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
func admin_update_platform_account_closure_services_configuration(
	namespace_param: String,
	body: Dictionary = {}
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

## Reset Registered Platform Account Closure Services Configuration
## DELETE /gdpr/admin/namespaces/{namespace}/services/platforms/closure/config
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

## Get User's Platform Account Closure Histories
## GET /gdpr/admin/namespaces/{namespace}/users/platforms/closure/histories
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

## Retrieve specific user's account deletion request
## GET /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
func admin_get_user_account_deletion_request(
	namespace_param: String,
	user_id: String
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

## Submit user's account deletion request
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
func admin_submit_user_account_deletion_request(
	namespace_param: String,
	user_id: String
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

## Cancel user's account deletion request
## DELETE /gdpr/admin/namespaces/{namespace}/users/{userId}/deletions
func admin_cancel_user_account_deletion_request(
	namespace_param: String,
	user_id: String
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

## Get user's personal data requests
## GET /gdpr/admin/namespaces/{namespace}/users/{userId}/requests
func admin_get_user_personal_data_requests(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
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

## Submit user personal data retrieval request
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/requests
func admin_request_data_retrieval(
	namespace_param: String,
	user_id: String,
	password: String = ""
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
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Cancel user's personal data requests
## DELETE /gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}
func admin_cancel_user_personal_data_request(
	namespace_param: String,
	request_date: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestDate" + "}", request_date.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Generate personal data download url
## POST /gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
func admin_generate_personal_data_url(
	namespace_param: String,
	request_date: String,
	user_id: String,
	password: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/admin/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
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
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Submit user's account deletion request
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/deletions
func public_submit_user_account_deletion_request(
	namespace_param: String,
	user_id: String,
	password: String,
	language_tag: String = ""
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
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Cancel user's account deletion request
## DELETE /gdpr/public/namespaces/{namespace}/users/{userId}/deletions
func public_cancel_user_account_deletion_request(
	namespace_param: String,
	user_id: String
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

## Retrieve specific user's account deletion status
## GET /gdpr/public/namespaces/{namespace}/users/{userId}/deletions/status
func public_get_user_account_deletion_status(
	namespace_param: String,
	user_id: String
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

## Get user's personal data requests
## GET /gdpr/public/namespaces/{namespace}/users/{userId}/requests
func public_get_user_personal_data_requests(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
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

## Submit personal data retrieval request
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests
func public_request_data_retrieval(
	namespace_param: String,
	user_id: String,
	password: String,
	language_tag: String = ""
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
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Cancel user's personal data requests
## DELETE /gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}
func public_cancel_user_personal_data_request(
	namespace_param: String,
	request_date: String,
	user_id: String
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

## Generate personal data download url
## POST /gdpr/public/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
func public_generate_personal_data_url(
	namespace_param: String,
	request_date: String,
	user_id: String,
	password: String
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
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Submit my account deletion requests.
## POST /gdpr/public/users/me/deletions
func public_submit_my_account_deletion_request(
	platform_id: String,
	platform_token: String
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
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Cancel my account deletion request
## DELETE /gdpr/public/users/me/deletions
func public_cancel_my_account_deletion_request() -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Retrieve my account deletion status
## GET /gdpr/public/users/me/deletions/status
func public_get_my_account_deletion_status() -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/public/users/me/deletions/status"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get list of finished account deletion requests
## GET /gdpr/s2s/namespaces/{namespace}/deletions/finished
func s2s_get_list_finished_account_deletion_request(
	namespace_param: String,
	end: String,
	start: String
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

## Get list of finished personal data requests
## GET /gdpr/s2s/namespaces/{namespace}/requests/finished
func s2s_get_list_finished_personal_data_request(
	namespace_param: String,
	end: String,
	start: String
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

## Get Personal Data Request by Request Id
## GET /gdpr/s2s/namespaces/{namespace}/requests/{requestId}
func s2s_get_data_request_by_request_id(
	namespace_param: String,
	request_id: String
) -> Dictionary:
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

## Submit user's account deletion request
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/deletions
func s2s_submit_user_account_deletion_request(
	namespace_param: String,
	user_id: String
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

## Submit user personal data retrieval request
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/requests
func s2s_request_data_retrieval(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Generate personal data download url
## POST /gdpr/s2s/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate
func s2s_generate_personal_data_url(
	namespace_param: String,
	request_date: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/gdpr/s2s/namespaces/{namespace}/users/{userId}/requests/{requestDate}/generate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "requestDate" + "}", request_date.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
