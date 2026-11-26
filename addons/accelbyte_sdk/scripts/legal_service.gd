## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## legal_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-legal-service
## Version: 4.9.2
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


## Updates a user's preference consent settings
## PATCH /agreement/admin/agreements/localized-policy-versions/preferences/namespaces/{namespace}/userId/{userId}
##
## Will Update Preference Consent
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func change_preference_consent(
	namespace_param: String, user_id: String, body: Array = []
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


## Retrieves accepted legal agreements for a set of users
## POST /agreement/admin/namespaces/{namespace}/agreements
##
## Returns all accepted legal agreements for each user, including agreements of game users when the publisher user has a corresponding game account.
##
## Parameters:
## - namespace_param: Game namespace
func retrieve_accepted_agreements_for_multi_users(
	namespace_param: String, body: Dictionary = {}
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


## Retrieves accepted legal agreements for a user
## GET /agreement/admin/namespaces/{namespace}/agreements/policies/users/{userId}
##
## Will return all accepted Legal Agreements for specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - exclude_other_namespaces_policies: Whether to restrict the query to policies in this namespace only. Defaults to false.
func retrieve_accepted_agreements(
	namespace_param: String, user_id: String, exclude_other_namespaces_policies: bool = false
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


## Retrieves users who have accepted a specific policy version
## GET /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users
##
## Returns all users who have accepted a specific policy version. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - convert_game_user_id: In the publisher legal scenario, whether to return the publisher user ID instead of the game user ID in the response.
## - keyword: Display name or email or username
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - policy_version_id: ID of the policy version to filter accepted agreements by.
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


## Downloads an exported CSV of users' accepted agreements
## GET /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/download
##
## Checks the status of an export process. If the export is complete, returns a download URL for the CSV file.
##
## Parameters:
## - namespace_param: Game namespace
## - export_id: ID of the export job to retrieve.
func download_exported_agreements_in_csv(namespace_param: String, export_id: String) -> Dictionary:
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


## Starts an export of users' accepted agreements to CSV
## POST /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/initiate
##
## Starts an export of users who have accepted a specific policy version into a CSV file. To check export status once started, use the download operation.
##
## Parameters:
## - namespace_param: Game namespace
## - end: End time of signing date to retrieve, will use current time if not specified. Using ISO 8601 format yyyy-MM-dd'T'HH:mm:ss'Z', e.g. 2024-01-01T00:00:00Z
## - policy_version_id: ID of the policy version to export accepted agreements for.
## - start: Start time of signing date to retrieve. Using ISO 8601 format yyyy-MM-dd'T'HH:mm:ss'Z', e.g. 2024-01-01T00:00:00Z
func initiate_export_agreements_to_csv(
	namespace_param: String, policy_version_id: String, start: String, end: String = ""
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


## Retrieves base legal policies in a namespace
## GET /agreement/admin/namespaces/{namespace}/base-policies
##
## Retrieve base policies in the namespace. Set `limit = -1` to retrieve all records
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - visible_only: Whether to return only visible policies. Defaults to false.
func retrieve_all_legal_policies_by_namespace(
	namespace_param: String, limit: int = -1, offset: int = -1, visible_only: bool = false
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


## Creates a base legal policy
## POST /agreement/admin/namespaces/{namespace}/base-policies
##
## Creates a legal policy. Note: the `countryType` field only accepts COUNTRY or COUNTRY_GROUP. COUNTRY_GROUP `countryType` requires the caller to supply `countryGroupName` and `affectedCountries` fields. Policies with COUNTRY_GROUP type cover many countries and apply the same policy to each.
##
## Parameters:
## - namespace_param: Game namespace
func create_policy(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a base legal policy
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
##
## Retrieve a base policy.
##
## Parameters:
## - base_policy_id: BasePolicy Id
## - namespace_param: Game namespace
func retrieve_single_policy(base_policy_id: String, namespace_param: String) -> Dictionary:
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


## Deletes a base legal policy
## DELETE /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
##
## Deletes a base legal policy. Deletion succeeds only if the policy has no published versions and no user has accepted any version.
##
## Parameters:
## - base_policy_id: BasePolicy Id
## - namespace_param: Game namespace
func delete_base_policy(base_policy_id: String, namespace_param: String) -> Dictionary:
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


## Updates a base legal policy
## PATCH /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
##
## Updates an existing base policy. Note: the `countryType` field only accepts COUNTRY or COUNTRY_GROUP. COUNTRY_GROUP `countryType` requires the caller to supply `countryGroupName` and `affectedCountries` fields. Policies with COUNTRY_GROUP type cover many countries and apply the same policy to each.
##
## Parameters:
## - base_policy_id: BasePolicy Id
## - namespace_param: Game namespace
func partial_update_policy(
	base_policy_id: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves a base legal policy for a specific country
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/countries/{countryCode}
##
## Retrieve a Base Legal Policy based on a Particular Country.
##
## Parameters:
## - base_policy_id: BasePolicy Id
## - country_code: ISO 3166-1 alpha-2 country code.
## - namespace_param: Game namespace
func retrieve_policy_country(
	base_policy_id: String, country_code: String, namespace_param: String
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


## Retrieves all policies under a base legal policy
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies
##
## Retrieve all policies from Base Legal Policy.
##
## Parameters:
## - base_policy_id: BasePolicy Id
## - namespace_param: Game namespace
func retrieve_all_policies_from_base_policy(
	base_policy_id: String, namespace_param: String
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


## Creates a policy under a base legal policy
## POST /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies
##
## Creates a policy under a base legal policy. Note: the `countryType` field only accepts COUNTRY or COUNTRY_GROUP. COUNTRY_GROUP policy requires the caller to supply `countryGroupName` and `countries` fields. Policies with COUNTRY_GROUP type cover many countries and apply the same policy to each.
##
## Parameters:
## - base_policy_id: BasePolicy Id
## - namespace_param: Game namespace
func create_policy_under_base_policy(
	base_policy_id: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a localized policy version
## DELETE /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{localizedPolicyVersionId}
##
## Deletes a localized policy version. Deletion succeeds only if the parent policy version is not active and no user has accepted the localized version.
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to delete.
## - namespace_param: Game namespace
func delete_localized_policy(
	localized_policy_version_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{localizedPolicyVersionId}"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves localized versions of a country-specific policy
## GET /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}
##
## Retrieve versions of a particular country-specific policy.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_version_id: ID of the policy version to retrieve localized versions for.
func retrieve_localized_policy_versions(
	namespace_param: String, policy_version_id: String
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


## Creates a localized version of a country-specific policy
## POST /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}
##
## Create a version of a particular country-specific policy.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_version_id: ID of the policy version to create a localized version under.
func create_localized_policy_version(
	namespace_param: String, policy_version_id: String, body: Dictionary = {}
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


## Retrieves a localized version of a country-specific policy
## GET /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
##
## Retrieve a version of a particular country-specific policy.
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to retrieve.
## - namespace_param: Game namespace
func retrieve_single_localized_policy_version(
	localized_policy_version_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a localized version of a country-specific policy
## PUT /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
##
## Update a version of a particular country-specific policy.
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to update.
## - namespace_param: Game namespace
func update_localized_policy_version(
	localized_policy_version_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Requests a pre-signed URL for uploading a policy attachment
## POST /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/attachments
##
## Requests a pre-signed URL for uploading an attachment for a particular localized version of a base policy.
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to attach a document to.
## - namespace_param: Game namespace
func request_presigned_url(
	localized_policy_version_id: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/attachments"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Sets a localized policy version as the default
## PATCH /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/default
##
## Update a localized version policy to be the default.
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to set as default.
## - namespace_param: Game namespace
func set_default_localized_policy(
	localized_policy_version_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/default"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Deletes a version of a policy
## DELETE /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}
##
## Deletes a policy version. Deletion succeeds only if the version has no publication record and no user has accepted it.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_version_id: ID of the policy version to delete.
func delete_policy_version(namespace_param: String, policy_version_id: String) -> Dictionary:
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


## Updates a version of a policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}
##
## Update a particular policy version.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_version_id: ID of the policy version to update.
func update_policy_version(
	namespace_param: String, policy_version_id: String, body: Dictionary = {}
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


## Publishes a country-specific policy version
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/latest
##
## Manually publish a version of a particular country-specific policy.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_version_id: ID of the policy version to publish.
## - should_notify: Whether to notify users when this version goes live.
func publish_policy_version(
	namespace_param: String, policy_version_id: String, should_notify: bool = false
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


## Revokes the published status of a policy version
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/unpublish
##
## Removes the published status from a policy version. The revert succeeds only if no user has accepted it.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_version_id: ID of the policy version to revert to draft status.
func unpublish_policy_version(namespace_param: String, policy_version_id: String) -> Dictionary:
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


## Deletes a country-specific policy
## DELETE /agreement/admin/namespaces/{namespace}/policies/{policyId}
##
## Deletes a policy. Deletion succeeds only if the policy is not the default and no user has accepted any version under it.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_id: ID of the policy to delete.
func delete_policy(namespace_param: String, policy_id: String) -> Dictionary:
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


## Updates a country-specific policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/{policyId}
##
## Update country-specific and country-group policy.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_id: ID of the policy to update.
func update_policy(namespace_param: String, policy_id: String, body: Dictionary = {}) -> Dictionary:
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


## Sets a policy as the default
## PATCH /agreement/admin/namespaces/{namespace}/policies/{policyId}/default
##
## Update a policy to be the default.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_id: ID of the policy to set as default.
func set_default_policy(namespace_param: String, policy_id: String) -> Dictionary:
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


## Retrieves versions of a country-specific policy
## GET /agreement/admin/namespaces/{namespace}/policies/{policyId}/versions
##
## Retrieve a version of a particular country specific policy. If version is not provided, the Legal Service will assume caller requesting all versions from country-specific policy.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_id: ID of the policy to retrieve versions for.
## - version_id: ID of a specific version to retrieve. Omit to retrieve all versions.
func retrieve_single_policy_version(
	namespace_param: String, policy_id: String, version_id: String = ""
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


## Creates a version of a country-specific policy
## POST /agreement/admin/namespaces/{namespace}/policies/{policyId}/versions
##
## Create a version of a particular country-specific policy.
##
## Parameters:
## - namespace_param: Game namespace
## - policy_id: ID of the policy to create a version under.
func create_policy_version(
	namespace_param: String, policy_id: String, body: Dictionary = {}
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


## Retrieves all supported policy types
## GET /agreement/admin/namespaces/{namespace}/policy-types
##
## Retrieves all supported policy types. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - offset: Number of results to skip for pagination
## - limit: Number of results to return
func retrieve_all_policy_types(namespace_param: String, limit: int, offset: int = -1) -> Dictionary:
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


## Accepts a set of policy versions on behalf of a user
## POST /agreement/admin/namespaces/{namespace}/users/{userId}/agreements/policies
##
## Accepts many legal policy versions all at once. Supply with localized version policy id and user ID to accept an agreement.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - publisher_user_id: AccelByte user ID of the publisher account, used for publisher legal scenarios.
## - client_id: OAuth client ID
## - country_code: ISO 3166-1 alpha-2 country code to scope the policy acceptance.
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


## Checks a user's legal eligibility against active policies
## GET /agreement/admin/namespaces/{namespace}/users/{userId}/eligibilities
##
## Retrieves active policies and their conformance status for a user. The service supports cross-namespace checking between the game namespace and publisher namespace: if an active policy also exists in the publisher namespace, the service checks conformance there.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - publisher_user_id: AccelByte user ID of the publisher account, used for publisher legal scenarios.
## - client_id: OAuth client ID
## - country_code: ISO 3166-1 alpha-2 country code to scope the eligibility check.
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


## Anonymizes a user's agreement record
## DELETE /agreement/admin/users/{userId}/anonymization/agreements
##
## Will anonymize agreement record for specified user.
##
## Parameters:
## - user_id: AccelByte user ID
func anonymize_user_agreement(user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/admin/users/{userId}/anonymization/agreements"
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Accepts or revokes marketing preference consent
## PATCH /agreement/public/agreements/localized-policy-versions/preferences
##
## Change marketing preference consent.
func public_change_preference_consent(body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/localized-policy-versions/preferences"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Accepts a localized policy version
## POST /agreement/public/agreements/localized-policy-versions/{localizedPolicyVersionId}
##
## Accepts a legal policy version. Supply with localized version policy id to accept an agreement
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to accept.
func accept_versioned_policy(localized_policy_version_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the current user's accepted legal agreements
## GET /agreement/public/agreements/policies
##
## Retrieve accepted Legal Agreements.
func retrieve_agreements_public() -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Accepts policy versions in bulk
## POST /agreement/public/agreements/policies
##
## Accepts many legal policy versions all at once. Supply with localized version policy id to accept an agreement.
func bulk_accept_versioned_policy(body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Checks the current user's legal eligibility
## GET /agreement/public/eligibilities/namespaces/{namespace}
##
## Retrieves active policies and their compliance status for the current user. Supports cross-namespace checking: if the user has already accepted a policy in another namespace, that acceptance counts as eligible.
##
## Parameters:
## - namespace_param: Game namespace
func retrieve_eligibilities_public(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/eligibilities/namespaces/{namespace}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Checks legal eligibility for a specific user
## GET /agreement/public/eligibilities/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}
##
## Retrieves active policies and their compliance status for a specific user. Supports cross-namespace checking between the game namespace and publisher namespace: if the user has accepted a policy in the publisher namespace, it also counts as eligible in non-publisher namespaces.
##
## Parameters:
## - client_id: OAuth client ID
## - country_code: ISO 3166-1 alpha-2 country code.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func retrieve_eligibilities_public_indirect(
	client_id: String, country_code: String, namespace_param: String, user_id: String
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


## Retrieves a localized policy version
## GET /agreement/public/localized-policy-versions/{localizedPolicyVersionId}
##
## Retrieves a specific localized policy version, including the parent policy version and base policy version.
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to retrieve.
func old_public_retrieve_single_localized_policy_version(
	localized_policy_version_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a localized policy version for a namespace
## GET /agreement/public/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
##
## Retrieves a specific localized policy version within the namespace, including the parent policy version and base policy version.
##
## Parameters:
## - localized_policy_version_id: ID of the localized policy version to retrieve.
## - namespace_param: Game namespace
func public_retrieve_single_localized_policy_version(
	localized_policy_version_id: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace(
		"{" + "localizedPolicyVersionId" + "}", localized_policy_version_id.uri_encode()
	)
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves countries that have active legal policies
## GET /agreement/public/policies/countries/list
##
## Retrieve List of Countries that have Active and Visible Legal Policies.
func retrieve_country_list_with_policies() -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/policies/countries/list"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the latest active policies for a country
## GET /agreement/public/policies/countries/{countryCode}
##
## Retrieves the active latest policies for a country. Filter results by policy type or tags; set defaultOnEmpty to true to fall back to the default country-specific policy when the requested country has no active policies.
##
## Parameters:
## - country_code: ISO 3166-1 alpha-2 country code.
## - default_on_empty: If true, returns the default country-specific policy when no active policies exist for the requested country.
## - policy_type: Filters results by policy type. Omit to return all policy types.
## - tags: Comma-separated list of tags to filter policies by.
## - visible_only: If true, returns only policies visible to end users.
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


## Retrieves the latest active policies for a namespace and country
## GET /agreement/public/policies/namespaces/{namespace}
##
## Retrieves active latest policies for the namespace, using the country from the user token. Filter by policy type or tags; set defaultOnEmpty to true to fall back to the default country-specific policy. Set alwaysIncludeDefault to true to always include default policies alongside country-specific ones.
##
## Parameters:
## - namespace_param: Game namespace
## - always_include_default: If true, always includes default policies alongside country-specific ones in the response.
## - default_on_empty: If true, returns the default country-specific policy when no active policies exist for the user's country.
## - policy_type: Filters results by policy type. Omit to return all policy types.
## - tags: Comma-separated list of tags to filter policies by.
## - visible_only: If true, returns only policies visible to end users.
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


## Retrieves the latest active policies for a namespace and country
## GET /agreement/public/policies/namespaces/{namespace}/countries/{countryCode}
##
## Retrieves active latest policies for the specified namespace and country. Filter by policy type or tags; set defaultOnEmpty to true to fall back to the default country-specific policy. Set alwaysIncludeDefault to true to always include default policies alongside country-specific ones.
##
## Parameters:
## - country_code: ISO 3166-1 alpha-2 country code.
## - namespace_param: Game namespace
## - always_include_default: If true, always includes default policies alongside country-specific ones in the response.
## - default_on_empty: If true, returns the default country-specific policy when no active policies exist for the requested country.
## - policy_type: Filters results by policy type. Omit to return all policy types.
## - tags: Comma-separated list of tags to filter policies by.
## - visible_only: If true, returns only policies visible to end users.
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


## Checks whether legal data is ready
## GET /agreement/public/readiness
##
## Readiness status defined as at least one legal base policy is present and having an active base policy.
func check_readiness() -> Dictionary:
	# Build URL path
	var url_path: String = "/agreement/public/readiness"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the latest active policies for a namespace and country (v2)
## GET /agreement/v2/public/policies/namespaces/{namespace}/countries/{countryCode}
##
## Lists all active policies for the registration page, including both optional and mandatory documents, filtered by namespace, country, and client. The service resolves results per-client and includes country-specific and default policies based on the configuration.
##
## Parameters:
## - country_code: ISO 3166-1 alpha-2 country code.
## - namespace_param: Game namespace
## - client_id: OAuth client ID
func retrieve_latest_policies_by_namespace_and_country_public(
	country_code: String, namespace_param: String, client_id: String
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
