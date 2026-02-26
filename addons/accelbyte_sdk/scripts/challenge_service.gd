## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## challenge_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-challenge-service
## Version: 1.0.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(ChallengeService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name ChallengeService
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

## List Challenges
## GET /challenge/v1/admin/namespaces/{namespace}/challenges
func admin_get_challenges(
	namespace_param: String,
	keyword: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create New Challenge
## POST /challenge/v1/admin/namespaces/{namespace}/challenges
func admin_create_challenge(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get challenge ecommerce item references
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/item/references
func admin_get_item_references(
	namespace_param: String,
	item_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/item/references"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not item_id.is_empty():
		query_params["itemId"] = item_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List User's Active Challenges
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/users/{userId}
func admin_get_active_challenges(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/users/{userId}"
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

## Get a Challenge
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
func admin_get_challenge(
	challenge_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update a Challenge
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
func admin_update_challenge(
	challenge_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete a Challenge
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
func admin_delete_challenge(
	challenge_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## List Goals of a Challenge
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals
func admin_get_goals(
	challenge_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Create New Goal
## POST /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals
func admin_create_goal(
	challenge_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Goal
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
func admin_get_goal(
	challenge_code: String,
	code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update Goal
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
func admin_update_goals(
	challenge_code: String,
	code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete Goal
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
func admin_delete_goal(
	challenge_code: String,
	code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get goal's schedules
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules
func admin_list_schedules_by_goal(
	challenge_code: String,
	code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get Challenge's Periods
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/periods
func admin_get_periods(
	challenge_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/periods"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
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

## Randomize Goals of a Challenge
## POST /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/randomize
func admin_randomize_challenge(
	challenge_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/randomize"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get Challenge's schedules
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/schedules
func admin_list_schedules(
	challenge_code: String,
	namespace_param: String,
	date_time: String = "",
	limit: int = -1,
	offset: int = -1,
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Delete Tied Challenge
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied
func admin_delete_tied_challenge(
	challenge_code: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update Tied Challenge Schedule
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied/schedule
func admin_update_tied_challenge_schedule(
	challenge_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied/schedule"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Get assignment plugin
## GET /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_get_assignment_plugin(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update assignment plugin
## PUT /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_update_assignment_plugin(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Create assignment plugin
## POST /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_create_assignment_plugin(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete assignment plugin
## DELETE /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
func admin_delete_assignment_plugin(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Evaluate User's Progressions
## POST /challenge/v1/admin/namespaces/{namespace}/progress/evaluate
func admin_evaluate_progress(
	namespace_param: String,
	challenge_code: Array = [],
	include_one_time_event: String = "",
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/progress/evaluate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if challenge_code.size() > 0:
		query_params["challengeCode"] = challenge_code
	if not include_one_time_event.is_empty():
		query_params["includeOneTimeEvent"] = include_one_time_event
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Claim  rewards of multiple users
## POST /challenge/v1/admin/namespaces/{namespace}/users/rewards/claim
func admin_claim_users_rewards(
	namespace_param: String,
	body: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/rewards/claim"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Claim rewards of a single user by goal code
## POST /challenge/v1/admin/namespaces/{namespace}/users/{userId}/challenges/{challengeCode}/rewards/claim
func admin_claim_user_rewards_by_goal_code(
	challenge_code: String,
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/challenges/{challengeCode}/rewards/claim"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List User's Progressions
## GET /challenge/v1/admin/namespaces/{namespace}/users/{userId}/progress/{challengeCode}
func admin_get_user_progression(
	challenge_code: String,
	namespace_param: String,
	user_id: String,
	date_time: String = "",
	goal_code: String = "",
	limit: int = -1,
	offset: int = -1,
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/progress/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
	if not goal_code.is_empty():
		query_params["goalCode"] = goal_code
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List User's Rewards
## GET /challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards
func admin_get_user_rewards(
	namespace_param: String,
	user_id: String,
	challenge_code: String = "",
	goal_progression_id: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not challenge_code.is_empty():
		query_params["challengeCode"] = challenge_code
	if not goal_progression_id.is_empty():
		query_params["goalProgressionId"] = goal_progression_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Claim rewards of a single user
## POST /challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards/claim
func admin_claim_user_rewards(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards/claim"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List Challenges
## GET /challenge/v1/public/namespaces/{namespace}/challenges
func get_challenges(
	namespace_param: String,
	keyword: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not keyword.is_empty():
		query_params["keyword"] = keyword
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List Goals of a Challenge
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals
func public_get_scheduled_goals(
	challenge_code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get goal's schedules
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules
func public_list_schedules_by_goal(
	challenge_code: String,
	code: String,
	namespace_param: String,
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
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

## Get Challenge's schedules
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/schedules
func public_list_schedules(
	challenge_code: String,
	namespace_param: String,
	date_time: String = "",
	limit: int = -1,
	offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/schedules"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
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

## Claim User's Rewards by Goal Code
## POST /challenge/v1/public/namespaces/{namespace}/users/me/challenges/{challengeCode}/rewards/claim
func public_claim_user_rewards_by_goal_code(
	challenge_code: String,
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/challenges/{challengeCode}/rewards/claim"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Evaluate User's Challenge Progressions
## POST /challenge/v1/public/namespaces/{namespace}/users/me/progress/evaluate
func evaluate_my_progress(
	namespace_param: String,
	challenge_code: Array = [],
	include_one_time_event: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/progress/evaluate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if challenge_code.size() > 0:
		query_params["challengeCode"] = challenge_code
	if not include_one_time_event.is_empty():
		query_params["includeOneTimeEvent"] = include_one_time_event
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## List User's Progressions
## GET /challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}
func public_get_user_progression(
	challenge_code: String,
	namespace_param: String,
	date_time: String = "",
	goal_code: String = "",
	limit: int = -1,
	offset: int = -1,
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not date_time.is_empty():
		query_params["dateTime"] = date_time
	if not goal_code.is_empty():
		query_params["goalCode"] = goal_code
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List User's Progressions in the previous rotation.
## GET /challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}/index/{index}
func public_get_past_user_progression(
	challenge_code: String,
	index: int,
	namespace_param: String,
	goal_code: String = "",
	limit: int = -1,
	offset: int = -1,
	tags: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}/index/{index}"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	url_path = url_path.replace("{" + "index" + "}", str(index).uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not goal_code.is_empty():
		query_params["goalCode"] = goal_code
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if tags.size() > 0:
		query_params["tags"] = tags
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## List User's Rewards
## GET /challenge/v1/public/namespaces/{namespace}/users/me/rewards
func public_get_user_rewards(
	namespace_param: String,
	challenge_code: String = "",
	goal_progression_id: String = "",
	limit: int = -1,
	offset: int = -1,
	sort_by: String = "",
	status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not challenge_code.is_empty():
		query_params["challengeCode"] = challenge_code
	if not goal_progression_id.is_empty():
		query_params["goalProgressionId"] = goal_progression_id
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not sort_by.is_empty():
		query_params["sortBy"] = sort_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Claim User's Rewards
## POST /challenge/v1/public/namespaces/{namespace}/users/me/rewards/claim
func public_claim_user_rewards(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/rewards/claim"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
