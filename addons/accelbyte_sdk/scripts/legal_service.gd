## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## legal_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-legal-service
## Version: 4.6.1
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(LegalService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name LegalService
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

## Change Preference Consent
## PATCH /agreement/admin/agreements/localized-policy-versions/preferences/namespaces/{namespace}/userId/{userId}
func change_preference_consent(
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/agreements/localized-policy-versions/preferences/namespaces/{namespace}/userId/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Retrieve Accepted Legal Agreements
## GET /agreement/admin/agreements/policies/users/{userId}
func old_retrieve_accepted_agreements(
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/agreements/policies/users/{userId}"
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Users Accepting Legal Agreements
## GET /agreement/admin/agreements/policy-versions/users
func old_retrieve_all_users_by_policy_version(
	policy_version_id: String,
	keyword: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/agreements/policy-versions/users"
	# Build query parameters
	var query_params: Dictionary = {}
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not policy_version_id.is_empty():
		query_params["policyVersionId"] = policy_version_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve All Base Legal Policy
## GET /agreement/admin/base-policies
func retrieve_all_legal_policies(
	visible_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/base-policies"
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["visibleOnly"] = visible_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a Base Legal Policy
## POST /agreement/admin/base-policies
func old_create_policy(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/base-policies"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve a Base Legal Policy
## GET /agreement/admin/base-policies/{basePolicyId}
func old_retrieve_single_policy(
	base_policy_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Base Legal Policy
## PATCH /agreement/admin/base-policies/{basePolicyId}
func old_partial_update_policy(
	base_policy_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Retrieve a Base Legal Policy based on a Particular Country
## GET /agreement/admin/base-policies/{basePolicyId}/countries/{countryCode}
func old_retrieve_policy_country(
	base_policy_id: String,
	country_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/base-policies/{basePolicyId}/countries/{countryCode}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Versions from Country-Specific Policy
## GET /agreement/admin/localized-policy-versions/versions/{policyVersionId}
func old_retrieve_localized_policy_versions(
	policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a Localized Version from Country-Specific Policy
## POST /agreement/admin/localized-policy-versions/versions/{policyVersionId}
func old_create_localized_policy_version(
	policy_version_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve a Localized Version from Country-Specific Policy
## GET /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}
func old_retrieve_single_localized_policy_version(
	localized_policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a Localized Version from Country-Specific Policy
## PUT /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}
func old_update_localized_policy_version(
	localized_policy_version_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Request Presigned URL for Upload Document
## POST /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/attachments
func old_request_presigned_url(
	localized_policy_version_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/attachments"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Set Default Localized Policy
## PATCH /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/default
func old_set_default_localized_policy(
	localized_policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/default"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Retrieve Accepted Legal Agreements For Multi Users
## POST /agreement/admin/namespaces/{namespace}/agreements
func retrieve_accepted_agreements_for_multi_users(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve Accepted Legal Agreements
## GET /agreement/admin/namespaces/{namespace}/agreements/policies/users/{userId}
func retrieve_accepted_agreements(
	namespace_param: String,
	user_id: String,
	exclude_other_namespaces_policies: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policies/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["excludeOtherNamespacesPolicies"] = exclude_other_namespaces_policies
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Users Accepting Legal Agreements
## GET /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users
func retrieve_all_users_by_policy_version(
	namespace_param: String,
	policy_version_id: String,
	convert_game_user_id: bool = false,
	keyword: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policy-versions/users"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["convertGameUserId"] = convert_game_user_id
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not policy_version_id.is_empty():
		query_params["policyVersionId"] = policy_version_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Download Exported Users Accepted Agreements in CSV
## GET /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/download
func download_exported_agreements_in_csv(
	namespace_param: String,
	export_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/download"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not export_id.is_empty():
		query_params["exportId"] = export_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Initiate Export Users Accepted Agreements to CSV
## POST /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/initiate
func initiate_export_agreements_to_csv(
	namespace_param: String,
	policy_version_id: String,
	start: String,
	end: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/initiate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not end.is_empty():
		query_params["end"] = end
	if not policy_version_id.is_empty():
		query_params["policyVersionId"] = policy_version_id
	if not start.is_empty():
		query_params["start"] = start
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve Base Legal Policy in the namespace
## GET /agreement/admin/namespaces/{namespace}/base-policies
func retrieve_all_legal_policies_by_namespace(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	visible_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	query_params["visibleOnly"] = visible_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a Base Legal Policy
## POST /agreement/admin/namespaces/{namespace}/base-policies
func create_policy(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve a Base Legal Policy
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
func retrieve_single_policy(
	base_policy_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Base Legal Policy
## DELETE /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
func delete_base_policy(
	base_policy_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Base Legal Policy
## PATCH /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
func partial_update_policy(
	base_policy_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Retrieve a Base Legal Policy based on a Particular Country
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/countries/{countryCode}
func retrieve_policy_country(
	base_policy_id: String,
	country_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/countries/{countryCode}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve all policies from Base Legal Policy
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies
func retrieve_all_policies_from_base_policy(
	base_policy_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create policy under base policy
## POST /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies
func create_policy_under_base_policy(
	base_policy_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies"
	url_path = url_path.replace("{" + "basePolicyId" + "}", base_policy_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete Localized Policy
## DELETE /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{localizedPolicyVersionId}
func delete_localized_policy(
	localized_policy_version_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Retrieve Versions from Country-Specific Policy
## GET /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}
func retrieve_localized_policy_versions(
	namespace_param: String,
	policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a Localized Version from Country-Specific Policy
## POST /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}
func create_localized_policy_version(
	namespace_param: String,
	policy_version_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve a Localized Version from Country-Specific Policy
## GET /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
func retrieve_single_localized_policy_version(
	localized_policy_version_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a Localized Version from Country-Specific Policy
## PUT /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
func update_localized_policy_version(
	localized_policy_version_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Request Presigned URL for Upload Document
## POST /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/attachments
func request_presigned_url(
	localized_policy_version_id: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/attachments"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Set Default Localized Policy
## PATCH /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/default
func set_default_localized_policy(
	localized_policy_version_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/default"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Delete a Version of Policy
## DELETE /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}
func delete_policy_version(
	namespace_param: String,
	policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update a Version of Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}
func update_policy_version(
	namespace_param: String,
	policy_version_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Manually Publish a Version from Country-Specific Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/latest
func publish_policy_version(
	namespace_param: String,
	policy_version_id: String,
	should_notify: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/latest"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["shouldNotify"] = should_notify
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Un-publish Version from Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/unpublish
func unpublish_policy_version(
	namespace_param: String,
	policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/unpublish"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Delete Policy
## DELETE /agreement/admin/namespaces/{namespace}/policies/{policyId}
func delete_policy(
	namespace_param: String,
	policy_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Country-Specific Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/{policyId}
func update_policy(
	namespace_param: String,
	policy_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Set Default Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/{policyId}/default
func set_default_policy(
	namespace_param: String,
	policy_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}/default"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Retrieve a Version from Country-Specific Policy
## GET /agreement/admin/namespaces/{namespace}/policies/{policyId}/versions
func retrieve_single_policy_version(
	namespace_param: String,
	policy_id: String,
	version_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}/versions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not version_id.is_empty():
		query_params["versionId"] = version_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a Version from Country-Specific Policy
## POST /agreement/admin/namespaces/{namespace}/policies/{policyId}/versions
func create_policy_version(
	namespace_param: String,
	policy_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}/versions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve All Policy Type
## GET /agreement/admin/namespaces/{namespace}/policy-types
func retrieve_all_policy_types(
	namespace_param: String,
	limit: int,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policy-types"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin bulk accept Policy Versions
## POST /agreement/admin/namespaces/{namespace}/users/{userId}/agreements/policies
func indirect_bulk_accept_versioned_policy(
	namespace_param: String,
	user_id: String,
	client_id: String,
	country_code: String,
	publisher_user_id: String = "",
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/users/{userId}/agreements/policies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not publisher_user_id.is_empty():
		query_params["publisherUserId"] = publisher_user_id
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not country_code.is_empty():
		query_params["countryCode"] = country_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check User Legal Eligibility
## GET /agreement/admin/namespaces/{namespace}/users/{userId}/eligibilities
func admin_retrieve_eligibilities(
	namespace_param: String,
	user_id: String,
	client_id: String,
	country_code: String,
	publisher_user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/users/{userId}/eligibilities"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not publisher_user_id.is_empty():
		query_params["publisherUserId"] = publisher_user_id
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not country_code.is_empty():
		query_params["countryCode"] = country_code
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Policies by Country
## GET /agreement/admin/policies/countries/{countryCode}
func retrieve_policies(
	country_code: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policies/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a Version of Policy
## PATCH /agreement/admin/policies/versions/{policyVersionId}
func old_update_policy_version(
	policy_version_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policies/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Manually Publish a Version from Country-Specific Policy
## PATCH /agreement/admin/policies/versions/{policyVersionId}/latest
func old_publish_policy_version(
	policy_version_id: String,
	should_notify: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policies/versions/{policyVersionId}/latest"
	url_path = url_path.replace("{" + "policyVersionId" + "}", policy_version_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["shouldNotify"] = should_notify
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Update Country-Specific Policy
## PATCH /agreement/admin/policies/{policyId}
func old_update_policy(
	policy_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}"
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Set Default Policy
## PATCH /agreement/admin/policies/{policyId}/default
func old_set_default_policy(
	policy_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}/default"
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Retrieve a Version from Country-Specific Policy
## GET /agreement/admin/policies/{policyId}/versions
func old_retrieve_single_policy_version(
	policy_id: String,
	version_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}/versions"
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not version_id.is_empty():
		query_params["versionId"] = version_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create a Version from Country-Specific Policy
## POST /agreement/admin/policies/{policyId}/versions
func old_create_policy_version(
	policy_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}/versions"
	url_path = url_path.replace("{" + "policyId" + "}", policy_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve All Policy Type
## GET /agreement/admin/policy-types
func old_retrieve_all_policy_types(
	limit: int,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/policy-types"
	# Build query parameters
	var query_params: Dictionary = {}
	if offset >= 0:
		query_params["offset"] = offset
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get user info cache status
## GET /agreement/admin/userInfo
func get_user_info_status(
	namespaces: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/userInfo"
	# Build query parameters
	var query_params: Dictionary = {}
	if not namespaces.is_empty():
		query_params["namespaces"] = namespaces
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Sync user info with iam service 
## PUT /agreement/admin/userInfo
## @deprecated
func sync_user_info(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/userInfo"
	# Build query parameters
	var query_params: Dictionary = {}
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Invalidate user info cache
## DELETE /agreement/admin/userInfo
## @deprecated
func invalidate_user_info_cache(
	namespace_param: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/userInfo"
	# Build query parameters
	var query_params: Dictionary = {}
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Anonymize user's agreement record
## DELETE /agreement/admin/users/{userId}/anonymization/agreements
func anonymize_user_agreement(
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/users/{userId}/anonymization/agreements"
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Accept/Revoke Marketing Preference Consent
## PATCH /agreement/public/agreements/localized-policy-versions/preferences
func public_change_preference_consent(
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/localized-policy-versions/preferences"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Accept a Policy Version
## POST /agreement/public/agreements/localized-policy-versions/{localizedPolicyVersionId}
func accept_versioned_policy(
	localized_policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Retrieve the accepted Legal Agreements
## GET /agreement/public/agreements/policies
func retrieve_agreements_public() -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk Accept Policy Versions
## POST /agreement/public/agreements/policies
func bulk_accept_versioned_policy(
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk Accept Policy Versions (Indirect)
## POST /agreement/public/agreements/policies/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}
## @deprecated
func indirect_bulk_accept_versioned_policy_v2(
	client_id: String,
	country_code: String,
	namespace_param: String,
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Bulk Accept Policy Versions (Indirect)
## POST /agreement/public/agreements/policies/users/{userId}
## @deprecated
func public_indirect_bulk_accept_versioned_policy(
	user_id: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies/users/{userId}"
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Check User Legal Eligibility
## GET /agreement/public/eligibilities/namespaces/{namespace}
func retrieve_eligibilities_public(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/eligibilities/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Check User Legal Eligibility
## GET /agreement/public/eligibilities/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}
func retrieve_eligibilities_public_indirect(
	client_id: String,
	country_code: String,
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/eligibilities/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}"
	url_path = url_path.replace("{" + "clientId" + "}", client_id.uri_encode())
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve a Localized Version
## GET /agreement/public/localized-policy-versions/{localizedPolicyVersionId}
func old_public_retrieve_single_localized_policy_version(
	localized_policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve a Localized Version
## GET /agreement/public/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
func public_retrieve_single_localized_policy_version(
	localized_policy_version_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve List of Countries that have Active Legal Policies
## GET /agreement/public/policies/countries/list
func retrieve_country_list_with_policies() -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/policies/countries/list"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Latest Policies by Country
## GET /agreement/public/policies/countries/{countryCode}
func retrieve_latest_policies(
	country_code: String,
	default_on_empty: bool = false,
	policy_type: String = "",
	tags: String = "",
	visible_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/policies/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["defaultOnEmpty"] = default_on_empty
	if not policy_type.is_empty():
		query_params["policyType"] = policy_type
	if not tags.is_empty():
		query_params["tags"] = tags
	query_params["visibleOnly"] = visible_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Latest Policies by Namespace and Country
## GET /agreement/public/policies/namespaces/{namespace}
func retrieve_latest_policies_public(
	namespace_param: String,
	always_include_default: bool = false,
	default_on_empty: bool = false,
	policy_type: String = "",
	tags: String = "",
	visible_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/policies/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["alwaysIncludeDefault"] = always_include_default
	query_params["defaultOnEmpty"] = default_on_empty
	if not policy_type.is_empty():
		query_params["policyType"] = policy_type
	if not tags.is_empty():
		query_params["tags"] = tags
	query_params["visibleOnly"] = visible_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Latest Policies by Namespace and Country
## GET /agreement/public/policies/namespaces/{namespace}/countries/{countryCode}
func old_retrieve_latest_policies_by_namespace_and_country_public(
	country_code: String,
	namespace_param: String,
	always_include_default: bool = false,
	default_on_empty: bool = false,
	policy_type: String = "",
	tags: String = "",
	visible_only: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/policies/namespaces/{namespace}/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["alwaysIncludeDefault"] = always_include_default
	query_params["defaultOnEmpty"] = default_on_empty
	if not policy_type.is_empty():
		query_params["policyType"] = policy_type
	if not tags.is_empty():
		query_params["tags"] = tags
	query_params["visibleOnly"] = visible_only
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Check Legal Data Readiness
## GET /agreement/public/readiness
func check_readiness() -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/readiness"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Retrieve Latest Policies by Namespace and Country
## GET /agreement/v2/public/policies/namespaces/{namespace}/countries/{countryCode}
func retrieve_latest_policies_by_namespace_and_country_public(
	country_code: String,
	namespace_param: String,
	client_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/v2/public/policies/namespaces/{namespace}/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", country_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
