## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## legal_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-legal-service
## Version: 4.6.1
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = LegalServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name LegalServiceWeb
extends RefCounted

## Reference to the main SDK (for accessing tokens and settings)
var _sdk: AccelByteSDK
var _base_url: String = ""
var _auth_token: String = ""
var _namespace: String = ""
var _scene_root: Node = null

## Initialize with SDK reference
func initialize(sdk: AccelByteSDK, scene_root: Node = null) -> void:
	_sdk = sdk
	_scene_root = scene_root
	if _sdk:
		_base_url = _sdk.get_server_url()
		_namespace = _sdk.get_namespace()


## Update auth token (call after login)
func update_auth_token() -> void:
	if _sdk:
		_auth_token = _sdk.get_access_token()


func set_base_url(url: String) -> void:
	_base_url = url
	if _base_url.ends_with("/"):
		_base_url = _base_url.substr(0, _base_url.length() - 1)


func set_auth_token(token: String) -> void:
	_auth_token = token


func set_namespace(ns: String) -> void:
	_namespace = ns


## Check if running on web platform
func _is_web() -> bool:
	return OS.has_feature("web")


## Get parent node for HTTPRequest (needed on web)
func _get_parent_node() -> Node:
	if _scene_root:
		return _scene_root
	# Try to get scene tree root
	var tree = Engine.get_main_loop()
	if tree is SceneTree:
		return tree.root
	return null


## HTTP method enum to string
func _method_to_string(method: int) -> String:
	match method:
		HTTPClient.METHOD_GET: return "GET"
		HTTPClient.METHOD_POST: return "POST"
		HTTPClient.METHOD_PUT: return "PUT"
		HTTPClient.METHOD_DELETE: return "DELETE"
		HTTPClient.METHOD_PATCH: return "PATCH"
		_: return "UNKNOWN"


## Generic HTTP request (web platform)
func _http_request(url: String, method: int, headers: PackedStringArray, body: String = "") -> Dictionary:
	print("  [LegalServiceWeb] %s %s" % [_method_to_string(method), url])

	var parent = _get_parent_node()
	if not parent:
		return {"success": false, "error": "No parent node for HTTPRequest", "status_code": 0}

	var http_request = HTTPRequest.new()
	parent.add_child(http_request)

	var error = http_request.request(url, headers, method, body)
	if error != OK:
		http_request.queue_free()
		return {"success": false, "error": "Failed to start HTTP request: %d" % error, "status_code": 0}

	var response = await http_request.request_completed
	var result_code: int = response[0]
	var response_code: int = response[1]
	var http_response_body: PackedByteArray = response[3]

	http_request.queue_free()

	var result: Dictionary = {"status_code": response_code}

	if result_code != HTTPRequest.RESULT_SUCCESS:
		result["success"] = false
		result["error"] = "HTTP request failed with result: %d" % result_code
		return result

	var body_string = http_response_body.get_string_from_utf8()
	result["body"] = body_string

	if not body_string.is_empty():
		var json = JSON.new()
		if json.parse(body_string) == OK:
			result["data"] = json.data
		else:
			result["data"] = body_string

	result["success"] = (response_code >= 200 and response_code < 300)

	if not result["success"] and result.has("data") and result["data"] is Dictionary:
		var err_data = result["data"]
		if err_data.has("errorMessage"):
			result["error"] = err_data["errorMessage"]
		elif err_data.has("error_description"):
			result["error"] = err_data["error_description"]

	print("  [LegalServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
	return result


## Get bearer auth headers
func _get_bearer_headers() -> PackedStringArray:
	var headers = PackedStringArray()
	headers.push_back("Content-Type: application/json")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return headers


## Get form-urlencoded headers
func _get_form_headers() -> PackedStringArray:
	var headers = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not _auth_token.is_empty():
		headers.push_back("Authorization: Bearer " + _auth_token)
	return headers


## URL encode a string
func _url_encode(value: String) -> String:
	return value.uri_encode()


## Build query string from dictionary
func _build_query_string(params: Dictionary) -> String:
	var parts: Array[String] = []
	for key in params.keys():
		var value = params[key]
		if value is Array:
			for item in value:
				parts.append("%s=%s" % [_url_encode(str(key)), _url_encode(str(item))])
		else:
			parts.append("%s=%s" % [_url_encode(str(key)), _url_encode(str(value))])
	return "&".join(parts)


## Build form body from dictionary
func _build_form_body(params: Dictionary) -> String:
	return _build_query_string(params)


# =============================================================================
# API Methods
# =============================================================================

## Change Preference Consent
## PATCH /agreement/admin/agreements/localized-policy-versions/preferences/namespaces/{namespace}/userId/{userId}
func change_preference_consent(namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/agreements/localized-policy-versions/preferences/namespaces/{namespace}/userId/{userId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Retrieve Accepted Legal Agreements
## GET /agreement/admin/agreements/policies/users/{userId}
func old_retrieve_accepted_agreements(user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/agreements/policies/users/{userId}"
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Users Accepting Legal Agreements
## GET /agreement/admin/agreements/policy-versions/users
func old_retrieve_all_users_by_policy_version(policy_version_id: String,keyword: String = "",limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/agreements/policy-versions/users"

	# Build query parameters
	var query_params: Dictionary = {}
	if not policy_version_id.is_empty():
		query_params["policyVersionId"] = policy_version_id
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve All Base Legal Policy
## GET /agreement/admin/base-policies
func retrieve_all_legal_policies(visible_only: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/base-policies"

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["visibleOnly"] = visible_only

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create a Base Legal Policy
## POST /agreement/admin/base-policies
func old_create_policy(
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/base-policies"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve a Base Legal Policy
## GET /agreement/admin/base-policies/{basePolicyId}
func old_retrieve_single_policy(base_policy_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update Base Legal Policy
## PATCH /agreement/admin/base-policies/{basePolicyId}
func old_partial_update_policy(base_policy_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Retrieve a Base Legal Policy based on a Particular Country
## GET /agreement/admin/base-policies/{basePolicyId}/countries/{countryCode}
func old_retrieve_policy_country(base_policy_id: String,country_code: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/base-policies/{basePolicyId}/countries/{countryCode}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Versions from Country-Specific Policy
## GET /agreement/admin/localized-policy-versions/versions/{policyVersionId}
func old_retrieve_localized_policy_versions(policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create a Localized Version from Country-Specific Policy
## POST /agreement/admin/localized-policy-versions/versions/{policyVersionId}
func old_create_localized_policy_version(policy_version_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve a Localized Version from Country-Specific Policy
## GET /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}
func old_retrieve_single_localized_policy_version(localized_policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update a Localized Version from Country-Specific Policy
## PUT /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}
func old_update_localized_policy_version(localized_policy_version_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Request Presigned URL for Upload Document
## POST /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/attachments
func old_request_presigned_url(localized_policy_version_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/attachments"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Set Default Localized Policy
## PATCH /agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/default
func old_set_default_localized_policy(localized_policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/localized-policy-versions/{localizedPolicyVersionId}/default"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Retrieve Accepted Legal Agreements For Multi Users
## POST /agreement/admin/namespaces/{namespace}/agreements
func retrieve_accepted_agreements_for_multi_users(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve Accepted Legal Agreements
## GET /agreement/admin/namespaces/{namespace}/agreements/policies/users/{userId}
func retrieve_accepted_agreements(namespace_param: String,user_id: String,exclude_other_namespaces_policies: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policies/users/{userId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["excludeOtherNamespacesPolicies"] = exclude_other_namespaces_policies

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Users Accepting Legal Agreements
## GET /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users
func retrieve_all_users_by_policy_version(namespace_param: String,policy_version_id: String,convert_game_user_id: bool = false,keyword: String = "",limit: int = 0,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policy-versions/users"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not policy_version_id.is_empty():
		query_params["policyVersionId"] = policy_version_id
	query_params["convertGameUserId"] = convert_game_user_id
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Download Exported Users Accepted Agreements in CSV
## GET /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/download
func download_exported_agreements_in_csv(namespace_param: String,export_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/download"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not export_id.is_empty():
		query_params["exportId"] = export_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Initiate Export Users Accepted Agreements to CSV
## POST /agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/initiate
func initiate_export_agreements_to_csv(namespace_param: String,policy_version_id: String,start: String,end: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/agreements/policy-versions/users/export-csv/initiate"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not policy_version_id.is_empty():
		query_params["policyVersionId"] = policy_version_id
	if not start.is_empty():
		query_params["start"] = start
	if not end.is_empty():
		query_params["end"] = end

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve Base Legal Policy in the namespace
## GET /agreement/admin/namespaces/{namespace}/base-policies
func retrieve_all_legal_policies_by_namespace(namespace_param: String,limit: int = 0,offset: int = 0,visible_only: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset
	query_params["visibleOnly"] = visible_only

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create a Base Legal Policy
## POST /agreement/admin/namespaces/{namespace}/base-policies
func create_policy(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete Base Legal Policy
## DELETE /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
func delete_base_policy(base_policy_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Retrieve a Base Legal Policy
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
func retrieve_single_policy(base_policy_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update Base Legal Policy
## PATCH /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}
func partial_update_policy(base_policy_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Retrieve a Base Legal Policy based on a Particular Country
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/countries/{countryCode}
func retrieve_policy_country(base_policy_id: String,country_code: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/countries/{countryCode}"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve all policies from Base Legal Policy
## GET /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies
func retrieve_all_policies_from_base_policy(base_policy_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create policy under base policy
## POST /agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies
func create_policy_under_base_policy(base_policy_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/base-policies/{basePolicyId}/policies"
	url_path = url_path.replace("{" + "basePolicyId" + "}", _url_encode(base_policy_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Delete Localized Policy
## DELETE /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{localizedPolicyVersionId}
func delete_localized_policy(localized_policy_version_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Retrieve Versions from Country-Specific Policy
## GET /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}
func retrieve_localized_policy_versions(namespace_param: String,policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create a Localized Version from Country-Specific Policy
## POST /agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}
func create_localized_policy_version(namespace_param: String,policy_version_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve a Localized Version from Country-Specific Policy
## GET /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
func retrieve_single_localized_policy_version(localized_policy_version_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update a Localized Version from Country-Specific Policy
## PUT /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
func update_localized_policy_version(localized_policy_version_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Request Presigned URL for Upload Document
## POST /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/attachments
func request_presigned_url(localized_policy_version_id: String,namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/attachments"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Set Default Localized Policy
## PATCH /agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/default
func set_default_localized_policy(localized_policy_version_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}/default"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Delete a Version of Policy
## DELETE /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}
func delete_policy_version(namespace_param: String,policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Update a Version of Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}
func update_policy_version(namespace_param: String,policy_version_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Manually Publish a Version from Country-Specific Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/latest
func publish_policy_version(namespace_param: String,policy_version_id: String,should_notify: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/latest"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["shouldNotify"] = should_notify

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Un-publish Version from Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/unpublish
func unpublish_policy_version(namespace_param: String,policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/versions/{policyVersionId}/unpublish"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Delete Policy
## DELETE /agreement/admin/namespaces/{namespace}/policies/{policyId}
func delete_policy(namespace_param: String,policy_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Update Country-Specific Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/{policyId}
func update_policy(namespace_param: String,policy_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Set Default Policy
## PATCH /agreement/admin/namespaces/{namespace}/policies/{policyId}/default
func set_default_policy(namespace_param: String,policy_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}/default"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Retrieve a Version from Country-Specific Policy
## GET /agreement/admin/namespaces/{namespace}/policies/{policyId}/versions
func retrieve_single_policy_version(namespace_param: String,policy_id: String,version_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}/versions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not version_id.is_empty():
		query_params["versionId"] = version_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create a Version from Country-Specific Policy
## POST /agreement/admin/namespaces/{namespace}/policies/{policyId}/versions
func create_policy_version(namespace_param: String,policy_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policies/{policyId}/versions"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve All Policy Type
## GET /agreement/admin/namespaces/{namespace}/policy-types
func retrieve_all_policy_types(namespace_param: String,limit: int,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/policy-types"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Admin bulk accept Policy Versions
## POST /agreement/admin/namespaces/{namespace}/users/{userId}/agreements/policies
func indirect_bulk_accept_versioned_policy(namespace_param: String,user_id: String,client_id: String,country_code: String,publisher_user_id: String = "",
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/users/{userId}/agreements/policies"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not country_code.is_empty():
		query_params["countryCode"] = country_code
	if not publisher_user_id.is_empty():
		query_params["publisherUserId"] = publisher_user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Check User Legal Eligibility
## GET /agreement/admin/namespaces/{namespace}/users/{userId}/eligibilities
func admin_retrieve_eligibilities(namespace_param: String,user_id: String,client_id: String,country_code: String,publisher_user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/namespaces/{namespace}/users/{userId}/eligibilities"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id
	if not country_code.is_empty():
		query_params["countryCode"] = country_code
	if not publisher_user_id.is_empty():
		query_params["publisherUserId"] = publisher_user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Policies by Country
## GET /agreement/admin/policies/countries/{countryCode}
func retrieve_policies(country_code: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policies/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update a Version of Policy
## PATCH /agreement/admin/policies/versions/{policyVersionId}
func old_update_policy_version(policy_version_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policies/versions/{policyVersionId}"
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Manually Publish a Version from Country-Specific Policy
## PATCH /agreement/admin/policies/versions/{policyVersionId}/latest
func old_publish_policy_version(policy_version_id: String,should_notify: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policies/versions/{policyVersionId}/latest"
	url_path = url_path.replace("{" + "policyVersionId" + "}", _url_encode(policy_version_id))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["shouldNotify"] = should_notify

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Update Country-Specific Policy
## PATCH /agreement/admin/policies/{policyId}
func old_update_policy(policy_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}"
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Set Default Policy
## PATCH /agreement/admin/policies/{policyId}/default
func old_set_default_policy(policy_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}/default"
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Retrieve a Version from Country-Specific Policy
## GET /agreement/admin/policies/{policyId}/versions
func old_retrieve_single_policy_version(policy_id: String,version_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}/versions"
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))

	# Build query parameters
	var query_params: Dictionary = {}
	if not version_id.is_empty():
		query_params["versionId"] = version_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Create a Version from Country-Specific Policy
## POST /agreement/admin/policies/{policyId}/versions
func old_create_policy_version(policy_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policies/{policyId}/versions"
	url_path = url_path.replace("{" + "policyId" + "}", _url_encode(policy_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve All Policy Type
## GET /agreement/admin/policy-types
func old_retrieve_all_policy_types(limit: int,offset: int = 0
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/policy-types"

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if offset != 0:
		query_params["offset"] = offset

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Invalidate user info cache
## DELETE /agreement/admin/userInfo
## @deprecated
func invalidate_user_info_cache(namespace_param: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/userInfo"

	# Build query parameters
	var query_params: Dictionary = {}
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get user info cache status
## GET /agreement/admin/userInfo
func get_user_info_status(namespaces: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/userInfo"

	# Build query parameters
	var query_params: Dictionary = {}
	if not namespaces.is_empty():
		query_params["namespaces"] = namespaces

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Sync user info with iam service 
## PUT /agreement/admin/userInfo
## @deprecated
func sync_user_info(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/userInfo"

	# Build query parameters
	var query_params: Dictionary = {}
	if not namespace_param.is_empty():
		query_params["namespace"] = namespace_param

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Anonymize user's agreement record
## DELETE /agreement/admin/users/{userId}/anonymization/agreements
func anonymize_user_agreement(user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/admin/users/{userId}/anonymization/agreements"
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Accept/Revoke Marketing Preference Consent
## PATCH /agreement/public/agreements/localized-policy-versions/preferences
func public_change_preference_consent(
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/agreements/localized-policy-versions/preferences"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PATCH, headers, request_body)

## Accept a Policy Version
## POST /agreement/public/agreements/localized-policy-versions/{localizedPolicyVersionId}
func accept_versioned_policy(localized_policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/agreements/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Retrieve the accepted Legal Agreements
## GET /agreement/public/agreements/policies
func retrieve_agreements_public() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Bulk Accept Policy Versions
## POST /agreement/public/agreements/policies
func bulk_accept_versioned_policy(
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies"

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk Accept Policy Versions (Indirect)
## POST /agreement/public/agreements/policies/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}
## @deprecated
func indirect_bulk_accept_versioned_policy_v2(client_id: String,country_code: String,namespace_param: String,user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}"
	url_path = url_path.replace("{" + "clientId" + "}", _url_encode(client_id))
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Bulk Accept Policy Versions (Indirect)
## POST /agreement/public/agreements/policies/users/{userId}
## @deprecated
func public_indirect_bulk_accept_versioned_policy(user_id: String,
		body: Array = []
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/agreements/policies/users/{userId}"
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Check User Legal Eligibility
## GET /agreement/public/eligibilities/namespaces/{namespace}
func retrieve_eligibilities_public(namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/eligibilities/namespaces/{namespace}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Check User Legal Eligibility
## GET /agreement/public/eligibilities/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}
func retrieve_eligibilities_public_indirect(client_id: String,country_code: String,namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/eligibilities/namespaces/{namespace}/countries/{countryCode}/clients/{clientId}/users/{userId}"
	url_path = url_path.replace("{" + "clientId" + "}", _url_encode(client_id))
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userId" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve a Localized Version
## GET /agreement/public/localized-policy-versions/{localizedPolicyVersionId}
func old_public_retrieve_single_localized_policy_version(localized_policy_version_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve a Localized Version
## GET /agreement/public/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}
func public_retrieve_single_localized_policy_version(localized_policy_version_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/namespaces/{namespace}/localized-policy-versions/{localizedPolicyVersionId}"
	url_path = url_path.replace("{" + "localizedPolicyVersionId" + "}", _url_encode(localized_policy_version_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve List of Countries that have Active Legal Policies
## GET /agreement/public/policies/countries/list
func retrieve_country_list_with_policies() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/policies/countries/list"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Latest Policies by Country
## GET /agreement/public/policies/countries/{countryCode}
func retrieve_latest_policies(country_code: String,default_on_empty: bool = false,policy_type: String = "",tags: String = "",visible_only: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/policies/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))

	# Build query parameters
	var query_params: Dictionary = {}
	query_params["defaultOnEmpty"] = default_on_empty
	if not policy_type.is_empty():
		query_params["policyType"] = policy_type
	if not tags.is_empty():
		query_params["tags"] = tags
	query_params["visibleOnly"] = visible_only

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Latest Policies by Namespace and Country
## GET /agreement/public/policies/namespaces/{namespace}
func retrieve_latest_policies_public(namespace_param: String,always_include_default: bool = false,default_on_empty: bool = false,policy_type: String = "",tags: String = "",visible_only: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/policies/namespaces/{namespace}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

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
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Latest Policies by Namespace and Country
## GET /agreement/public/policies/namespaces/{namespace}/countries/{countryCode}
func old_retrieve_latest_policies_by_namespace_and_country_public(country_code: String,namespace_param: String,always_include_default: bool = false,default_on_empty: bool = false,policy_type: String = "",tags: String = "",visible_only: bool = false
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/policies/namespaces/{namespace}/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

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
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Check Legal Data Readiness
## GET /agreement/public/readiness
func check_readiness() -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/public/readiness"

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Retrieve Latest Policies by Namespace and Country
## GET /agreement/v2/public/policies/namespaces/{namespace}/countries/{countryCode}
func retrieve_latest_policies_by_namespace_and_country_public(country_code: String,namespace_param: String,client_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/agreement/v2/public/policies/namespaces/{namespace}/countries/{countryCode}"
	url_path = url_path.replace("{" + "countryCode" + "}", _url_encode(country_code))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not client_id.is_empty():
		query_params["clientId"] = client_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
