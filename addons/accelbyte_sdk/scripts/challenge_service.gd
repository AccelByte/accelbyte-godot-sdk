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


## Lists challenges in the namespace
## GET /challenge/v1/admin/namespaces/{namespace}/challenges
##
## Lists available challenges in the namespace, optionally filtered by code keyword, status, or tags. Supports cursor-based pagination via the `paging` field.
##
## Parameters:
## - namespace_param: Game namespace
## - keyword: Filter challenges by code with likes behavior
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort list by attributes. default value: updatedAt:desc.
## - status: Challenge status
## - tags: Filter challenges by tags, comma separated value
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


## Creates a new challenge
## POST /challenge/v1/admin/namespaces/{namespace}/challenges
##
## Creates a new challenge in the namespace. A challenge is a collection of goals that players can complete on a configurable schedule.
##
## The code must use only lowercase letters, numbers, and hyphens, starting and ending with a letter. Rotation (DAILY, WEEKLY, MONTHLY, NONE) controls how often the active goal set changes. Assignment rule (FIXED, RANDOMIZED, UNSCHEDULED, CUSTOM) controls how the challenge distributes goals to users. To configure a challenge that never ends, omit both `endDate` and `endAfter`.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_challenge(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves challenge references for an ecommerce item
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/item/references
##
## Retrieves challenges that reference a specific ecommerce item by its item ID.
##
## Parameters:
## - namespace_param: Game namespace
## - item_id: The id of the ecommerce item
func admin_get_item_references(namespace_param: String, item_id: String) -> Dictionary:
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


## Lists a user's active challenges
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/users/{userId}
##
## Lists the active challenges in which the specified user is currently participating. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_active_challenges(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
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


## Retrieves a challenge by code
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
##
## Retrieves the details of the specified challenge by its code.
##
## Parameters:
## - challenge_code: The code of the challenge data to get
## - namespace_param: Game namespace
func admin_get_challenge(challenge_code: String, namespace_param: String) -> Dictionary:
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


## Updates a challenge
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
##
## Updates the configuration of an existing challenge. Modifiable fields include name, description, schedule dates, rotation, assignment rule, goal visibility, reset configuration, and tags. The challenge code is immutable.
##
## Parameters:
## - challenge_code: The code of the challenge data to update
## - namespace_param: Game namespace
func admin_update_challenge(
	challenge_code: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a challenge
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}
##
## Deletes the specified challenge and all its associated goals and schedules.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge to delete.
## - namespace_param: Game namespace
func admin_delete_challenge(challenge_code: String, namespace_param: String) -> Dictionary:
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


## Lists goals of a challenge
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals
##
## Lists the goals defined within the specified challenge. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort list by attributes. default value: updatedAt:desc.
## - tags: Filter list by tags
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


## Creates a new goal
## POST /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals
##
## Creates a new goal within the specified challenge. Goals define a set of completion criteria players must meet to earn rewards. Each group contains predicates that track player progression by statistic, achievement, account event, or entitlement; groups within a goal use OR logic. A challenge supports up to 100 goals. Adding a goal to a TIED challenge may affect existing user progress.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge to add the goal to.
## - namespace_param: Game namespace
func admin_create_goal(
	challenge_code: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves a goal
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
##
## Retrieves the details of a specific goal within a challenge.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - code: Goal code
## - namespace_param: Game namespace
func admin_get_goal(challenge_code: String, code: String, namespace_param: String) -> Dictionary:
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


## Updates a goal
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
##
## Updates the configuration of an existing goal within a challenge. Modifiable fields include name, description, schedule, criteria groups, rewards, tags, and active status.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - code: Goal code
## - namespace_param: Game namespace
func admin_update_goals(
	challenge_code: String, code: String, namespace_param: String, body: Dictionary = {}
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


## Deletes a goal
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}
##
## Deletes the specified goal from the challenge. Deleting a goal from a TIED challenge may affect or delete existing user progress data, which takes effect at the next evaluation cycle.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - code: Goal code
## - namespace_param: Game namespace
func admin_delete_goal(challenge_code: String, code: String, namespace_param: String) -> Dictionary:
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


## Lists schedules for a goal
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules
##
## Lists the schedules for a specific goal within a challenge, optionally filtered by user. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - code: Goal code
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - user_id: AccelByte user ID
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


## Move Goal to Another Slot
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/slots
##
## - Required permission: ADMIN:NAMESPACE:{namespace}:CHALLENGE [UPDATE]
## Moves a goal to a target slot in a FIXED or non-per-rotation RANDOMIZED challenge with repeatAfter set.
## slotIndex is 0-based and must be in [0, repeatAfter-1].
## Pass slotIndex = -1 to remove the goal from all slots; it will no longer appear in future rounds.
## TemplateSlots and all non-finished schedule documents are updated immediately.
## The currently active schedule document for the affected slot is skipped to avoid
## disrupting in-progress user progressions; the change takes effect from the next round.
## Finished (past) schedule documents are never modified.
##
## Parameters:
## - challenge_code: challenge code
## - code: goal code
## - namespace_param: Game namespace
func admin_move_goal_to_slot(
	challenge_code: String, code: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/slots"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists rotation periods of a challenge
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/periods
##
## Lists the rotation periods for the specified challenge. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func admin_get_periods(
	challenge_code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Triggers goal randomization for a challenge
## POST /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/randomize
##
## Executes a randomized goal schedule assignment for a challenge that uses the RANDOMIZED assignment rule with `randomizedPerRotation` set to true.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge to randomize.
## - namespace_param: Game namespace
func admin_randomize_challenge(challenge_code: String, namespace_param: String) -> Dictionary:
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


## Lists schedules for a challenge
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/schedules
##
## Lists the schedules for a challenge, optionally filtered by user and by a date cutoff. Use the `dateTime` parameter to retrieve schedules before a given time. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - date_time: Use RFC3339 format(2006-01-02T15:04:05Z).
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - user_id: AccelByte user ID
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


## Get Challenge Slots
## GET /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/slots
##
## - Required permission: ADMIN:NAMESPACE:{namespace}:CHALLENGE [READ]
## Returns the slot configuration for a FIXED or RANDOMIZED (non-per-rotation) assignment challenge.
## For repeating challenges (repeatAfter set), the response contains two separate fields:
## - templateSlots: the authoritative future configuration from TemplateSlots (goals only, no timing).
## - currentRound: the actual running state of the current (or nearest) round (goals + startTime/endTime from schedule documents).
## These two may differ when a slot move was deferred because the target slot was active.
## For non-repeating challenges, only currentRound is returned (templateSlots is absent).
##
## Parameters:
## - challenge_code: challenge code
## - namespace_param: Game namespace
func admin_get_challenge_slots(challenge_code: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/slots"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a tied challenge and all related data
## DELETE /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied
##
## Deletes a TIED challenge along with all related data, including goals, schedules, and player progressions.
##
## Parameters:
## - challenge_code: Unique code identifying the tied challenge to delete.
## - namespace_param: Game namespace
## - safe_delete: Since the early goal progress data does not include the namespace, it may lead to accidental deletion. If you want to safely delete this data, please set it to true, and it will check whether have conflict data.
func admin_delete_tied_challenge(
	challenge_code: String, namespace_param: String, safe_delete: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied"
	url_path = url_path.replace("{" + "challengeCode" + "}", challenge_code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not safe_delete.is_empty():
		query_params["safeDelete"] = safe_delete
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates the schedule of a tied challenge
## PUT /challenge/v1/admin/namespaces/{namespace}/challenges/{challengeCode}/tied/schedule
##
## Updates the schedule for a TIED challenge. Supported actions are STOP (retires the challenge) and `ACCELERATE` (advances the end time; not applicable to challenges with `endAfter` set).
##
## Parameters:
## - challenge_code: Unique code identifying the tied challenge to update.
## - namespace_param: Game namespace
func admin_update_tied_challenge_schedule(
	challenge_code: String, namespace_param: String, body: Dictionary = {}
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


## Retrieves the assignment plugin
## GET /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
##
## Retrieves the assignment plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_assignment_plugin(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the assignment plugin
## PUT /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
##
## Updates the assignment plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_assignment_plugin(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates an assignment plugin
## POST /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
##
## Creates an assignment plugin configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_assignment_plugin(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes the assignment plugin
## DELETE /challenge/v1/admin/namespaces/{namespace}/plugins/assignment
##
## Deletes the configured assignment plugin for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_delete_assignment_plugin(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/plugins/assignment"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Triggers progression evaluation for users
## POST /challenge/v1/admin/namespaces/{namespace}/progress/evaluate
##
## Evaluates progressions for up to 10 users in the specified challenges. Recalculates goal completion status based on current user statistics and activity.
##
## Parameters:
## - namespace_param: Game namespace
## - challenge_code: Challenge codes to assess, supplied as a comma-separated list.
## - include_one_time_event: Include one-time events (e.g. user achievement unlocks, platform linking). Normally this flag should be disabled and is only used to recover from failed one-time event processing.
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


## Claims rewards for a group of users
## POST /challenge/v1/admin/namespaces/{namespace}/users/rewards/claim
##
## Claims rewards for a group of users from their completed challenge goals.
##
## Parameters:
## - namespace_param: Game namespace
func admin_claim_users_rewards(namespace_param: String, body: Array = []) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/admin/namespaces/{namespace}/users/rewards/claim"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Claims rewards for a user by goal code
## POST /challenge/v1/admin/namespaces/{namespace}/users/{userId}/challenges/{challengeCode}/rewards/claim
##
## Claims rewards for a single user from completed goals within a specific challenge.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_claim_user_rewards_by_goal_code(
	challenge_code: String, namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists a user's goal progressions
## GET /challenge/v1/admin/namespaces/{namespace}/users/{userId}/progress/{challengeCode}
##
## Lists goal progressions for the specified user within a challenge. Supports filtering by goal code, date, and tags. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - date_time: Specific schedule date time. use RFC3339 format(2006-01-02T15:04:05Z).
## - goal_code: Unique code of the goal to filter progressions by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - tags: Filter goals by tags, comma separated value
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


## Lists a user's earned rewards
## GET /challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards
##
## Lists rewards earned by the specified user, optionally filtered by challenge, goal progression, or status. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - challenge_code: Reward's challenge code
## - goal_progression_id: Reward's goal progression id
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort list by attributes. default value: updatedAt:desc.
## - status: User reward status
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


## Claims rewards for a user
## POST /challenge/v1/admin/namespaces/{namespace}/users/{userId}/rewards/claim
##
## Claims pending rewards for the specified user from completed challenge goals.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_claim_user_rewards(
	namespace_param: String, user_id: String, body: Dictionary = {}
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


## Lists challenges in the namespace
## GET /challenge/v1/public/namespaces/{namespace}/challenges
##
## Lists challenges available in the namespace. Supports filtering by code keyword, status, and tags. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - keyword: Filter challenges by code with likes behavior
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort list by attributes. default value: updatedAt:desc.
## - status: Challenge status
## - tags: Filter challenges by tags, comma separated value
func public_get_challenges(
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


## Lists goals of a challenge
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals
##
## Lists the goals defined within the specified challenge. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort list by attributes. default value: updatedAt:desc.
## - tags: Filter list by tags
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


## Lists schedules for a goal
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/goals/{code}/schedules
##
## Lists the schedules for a specific goal within a challenge for the current user. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - code: Goal code
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func public_list_schedules_by_goal(
	challenge_code: String, code: String, namespace_param: String, limit: int = -1, offset: int = -1
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


## Lists schedules for a challenge
## GET /challenge/v1/public/namespaces/{namespace}/challenges/{challengeCode}/schedules
##
## Lists the schedules for a challenge for the current user. Use the `dateTime` parameter to retrieve schedules before a given time. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - date_time: Use RFC3339 format(2006-01-02T15:04:05Z).
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
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


## Claims the current user's rewards by goal code
## POST /challenge/v1/public/namespaces/{namespace}/users/me/challenges/{challengeCode}/rewards/claim
##
## Claims the current user's rewards from completed goals within a specific challenge.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
func public_claim_user_rewards_by_goal_code(
	challenge_code: String, namespace_param: String, body: Dictionary = {}
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


## Triggers progression evaluation for the current user
## POST /challenge/v1/public/namespaces/{namespace}/users/me/progress/evaluate
##
## Evaluates the current user's progressions for the specified challenges.
##
## Parameters:
## - namespace_param: Game namespace
## - challenge_code: Challenge codes to assess, supplied as a comma-separated list.
## - include_one_time_event: Include one-time events (e.g. user achievement unlocks, platform linking). Normally this flag should be disabled and is only used to recover from failed one-time event processing.
func public_evaluate_my_progress(
	namespace_param: String, challenge_code: Array = [], include_one_time_event: String = ""
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


## Lists the current user's goal progressions
## GET /challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}
##
## Lists the current user's goal progressions within a challenge. Supports filtering by goal code, date, and tags. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - namespace_param: Game namespace
## - date_time: Specific schedule date time. use RFC3339 format(2006-01-02T15:04:05Z).
## - goal_code: Unique code of the goal to filter progressions by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - tags: Filter goals by tags, comma separated value
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


## Lists the current user's progressions in a previous rotation
## GET /challenge/v1/public/namespaces/{namespace}/users/me/progress/{challengeCode}/index/{index}
##
## Lists the current user's goal progressions from a previous rotation of the challenge. Supports offset/limit pagination.
##
## Parameters:
## - challenge_code: Unique code identifying the challenge.
## - index: Rotation index. Treat rotation as an array sorted by the start time of a rotation in descending manner. positive integer. 0 indicates current or latest active rotation. increment the value to refer to specific past rotation.
## - namespace_param: Game namespace
## - goal_code: Unique code of the goal to filter progressions by.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - tags: Filter goals by tags, comma separated value
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


## Lists the current user's earned rewards
## GET /challenge/v1/public/namespaces/{namespace}/users/me/rewards
##
## Lists rewards earned by the current user, optionally filtered by challenge, goal progression, or status. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - challenge_code: Reward's challenge code
## - goal_progression_id: Reward's goal progression id
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - sort_by: Sort list by attributes. default value: updatedAt:desc.
## - status: User reward status
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


## Claims the current user's rewards
## POST /challenge/v1/public/namespaces/{namespace}/users/me/rewards/claim
##
## Claims pending rewards for the current user from completed challenge goals.
##
## Parameters:
## - namespace_param: Game namespace
func public_claim_user_rewards(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/challenge/v1/public/namespaces/{namespace}/users/me/rewards/claim"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)
