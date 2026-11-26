## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## seasonpass_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-seasonpass-service
## Version: 1.27.3
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(SeasonpassService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name SeasonpassService
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


## Exports season service data
## GET /seasonpass/admin/namespace/{namespace}/export
##
## Exports all season service data files in CSV format.
##
## Parameters:
## - namespace_param: Game namespace
func export_season(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespace/{namespace}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists seasons in the namespace
## GET /seasonpass/admin/namespaces/{namespace}/seasons
##
## Lists seasons in the namespace. Excludes publisher namespaces. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - status: Filters seasons by status. Valid values: DRAFT, PUBLISHED, RETIRED.
func query_seasons(
	namespace_param: String, limit: int = -1, offset: int = -1, status: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if status.size() > 0:
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a season in the namespace
## POST /seasonpass/admin/namespaces/{namespace}/seasons
##
## Creates a season. Requires a non-publisher namespace.
##
## Parameters:
## - namespace_param: Game namespace
func create_season(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the current published season summary
## GET /seasonpass/admin/namespaces/{namespace}/seasons/current
##
## Retrieves the current published season summary, including the previous season summary if one exists. Excludes publisher namespaces. Intended for internal service communication only.
##
## Parameters:
## - namespace_param: Game namespace
func get_current_season(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/current"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves current season progression for a batch of users
## POST /seasonpass/admin/namespaces/{namespace}/seasons/current/users/bulk/progression
##
## Retrieves the current season progression for a batch of users. Excludes publisher namespaces.
##
## Parameters:
## - namespace_param: Game namespace
func bulk_get_user_season_progression(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/current/users/bulk/progression"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves season pass item references from the ecommerce store
## GET /seasonpass/admin/namespaces/{namespace}/seasons/item/references
##
## Retrieves season pass item references from the ecommerce store.
##
## Parameters:
## - namespace_param: Game namespace
## - item_id: The id of the ecommerce item
func get_item_references(namespace_param: String, item_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/item/references"
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


## Retrieves a season by ID
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}
##
## Retrieves a season by ID. Excludes publisher namespaces.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to retrieve.
func get_season(namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a season permanently
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}
##
## Permanently deletes a season. Requires the season to be in DRAFT status.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to delete.
func delete_season(namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a season
## PATCH /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}
##
## Updates a season. Requires the season to be in DRAFT status.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to update.
func update_season(namespace_param: String, season_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Clones a season
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/clone
##
## Creates a copy of an existing season with a new time range.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to clone.
func clone_season(namespace_param: String, season_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/clone"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the full content of a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/full
##
## Retrieves the full content of a season including passes, rewards, and tiers. Excludes publisher namespaces.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to retrieve.
func get_full_season(namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/full"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists all passes for a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes
##
## Lists all passes for a season. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func query_passes(namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a pass for a season
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes
##
## Creates a pass for a draft season.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func create_pass(namespace_param: String, season_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a pass by code
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}
##
## Retrieves a pass for the specified season.
##
## Parameters:
## - code: Pass code identifying the pass to retrieve.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func get_pass(code: String, namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a pass permanently
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}
##
## Permanently deletes a pass. Requires the season to be in DRAFT status.
##
## Parameters:
## - code: Pass code identifying the pass to delete.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func delete_pass(code: String, namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a pass
## PATCH /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}
##
## Updates a pass. Requires the season to be in DRAFT status.
##
## Parameters:
## - code: Pass code identifying the pass to update.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func update_pass(
	code: String, namespace_param: String, season_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Publishes a season
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/publish
##
## Publishes a draft season. Each namespace may have at most one published season at a time.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to publish.
func publish_season(namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/publish"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retires a published season
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/retire
##
## Retires a published season. Fails if the season end date has not passed, unless force is true.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to retire.
## - force: When true, retires the season even if it has not ended. Defaults to false.
func retire_season(namespace_param: String, season_id: String, force: bool = false) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/retire"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["force"] = force
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists all rewards for a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards
##
## Lists all rewards for a season. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
## - q: Filters rewards by name. Performs a partial match on the reward name.
func query_rewards(namespace_param: String, season_id: String, q: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not q.is_empty():
		query_params["q"] = q
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates a reward for a season
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards
##
## Creates a reward for a draft season.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func create_reward(namespace_param: String, season_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a reward by code
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}
##
## Retrieves a reward for the specified season.
##
## Parameters:
## - code: Reward code identifying the reward to retrieve.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func get_reward(code: String, namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes a reward permanently
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}
##
## Permanently deletes a reward. Requires the season to be in DRAFT status.
##
## Parameters:
## - code: Reward code identifying the reward to delete.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func delete_reward(code: String, namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates a reward
## PATCH /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}
##
## Updates a reward. Requires the season to be in DRAFT status.
##
## Parameters:
## - code: Reward code identifying the reward to update.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func update_reward(
	code: String, namespace_param: String, season_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}"
	url_path = url_path.replace("{" + "code" + "}", code.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists all tiers for a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers
##
## Lists tiers for a season. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func query_tiers(
	namespace_param: String, season_id: String, limit: int = -1, offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
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


## Creates tiers for a season
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers
##
## Creates one or more tiers for a draft season.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func create_tier(namespace_param: String, season_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Updates a tier
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}
##
## Updates a tier. Requires the season to be in DRAFT status.
##
## Parameters:
## - id: Unique identifier of the tier to update.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func update_tier(
	id: String, namespace_param: String, season_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes a tier permanently
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}
##
## Permanently deletes a tier. Requires the season to be in DRAFT status.
##
## Parameters:
## - id: Unique identifier of the tier to delete.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func delete_tier(id: String, namespace_param: String, season_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Moves a tier to a new position
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}/reorder
##
## Reorders a tier within a draft season.
##
## Parameters:
## - id: Unique identifier of the tier to reorder.
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
func reorder_tier(
	id: String, namespace_param: String, season_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}/reorder"
	url_path = url_path.replace("{" + "id" + "}", id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Unpublishes a season
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/unpublish
##
## Unpublishes a published season. Fails if the season has already started, unless force is true.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season to unpublish.
## - force: When true, unpublishes the season even if it has already started. Defaults to false.
func unpublish_season(
	namespace_param: String, season_id: String, force: bool = false
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/unpublish"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["force"] = force
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves a user's participated season data
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons
##
## Retrieves season data for seasons the user has participated in. Excludes publisher namespaces. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
func get_user_participated_seasons(
	namespace_param: String, user_id: String, limit: int = -1, offset: int = -1
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons"
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


## Grants experience points to a user
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/exp
##
## Grants experience points to a user in the current season. Auto-enrolls the user if no active user season exists but a published season is active.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func grant_user_exp(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/exp"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Grants a pass to a user
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/passes
##
## Grants a pass to a user in the current season. Auto-enrolls the user if no active user season exists but a published season is active.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func grant_user_pass(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/passes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Checks ownership of any season pass
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/passes/ownership/any
##
## Checks whether the user owns any of the specified pass codes in the current season. Intended for internal service communication only.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - pass_codes: List of pass codes to check ownership for.
func exists_any_pass_by_pass_codes(
	namespace_param: String, user_id: String, pass_codes: Array = []
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/passes/ownership/any"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if pass_codes.size() > 0:
		query_params["passCodes"] = pass_codes
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the current user's season progression
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/progression
##
## Retrieves the current season progression for the specified user. Excludes publisher namespaces.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func get_current_user_season_progression(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/progression"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Checks if a pass or tier is purchasable
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/purchasable
##
## Checks whether the specified pass or tier is purchasable for the user in the current season.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func check_season_purchasable(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/purchasable"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Resets user data in the current season
## DELETE /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/reset
##
## Resets a user's data in the current season. Rewarded entitlements are not revoked. Available in test environments only; not permitted in live namespaces.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func reset_user_season(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/reset"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Grants a tier to a user
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/tiers
##
## Grants a tier to a user in the current season. Auto-enrolls the user if no active user season exists but a published season is active.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func grant_user_tier(namespace_param: String, user_id: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/tiers"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists a user's season experience acquisition history
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/exp/history
##
## Lists the user's experience acquisition history. Defaults to the current active season. Excludes publisher namespaces. Supports offset/limit pagination.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - from: Section active range time start , using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - season_id: If not provide, will query current season
## - source: Exp grant source
## - tags: Exp grant tags
## - to: Section active range time end, using ISO 8601 format e.g. yyyy-MM-dd'T'HH:mm:ssZZ
func query_user_exp_grant_history(
	namespace_param: String,
	user_id: String,
	from: String = "",
	limit: int = -1,
	offset: int = -1,
	season_id: String = "",
	source: String = "",
	tags: Array = [],
	to: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/exp/history"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not from.is_empty():
		query_params["from"] = from
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not season_id.is_empty():
		query_params["seasonId"] = season_id
	if not source.is_empty():
		query_params["source"] = source
	if tags.size() > 0:
		query_params["tags"] = tags
	if not to.is_empty():
		query_params["to"] = to
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Lists reason tags for a user's experience history
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/exp/history/tags
##
## Lists the reason tags used in the user's experience acquisition history. Defaults to the current active season.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
## - season_id: If not provide, will query current season
func query_user_exp_grant_history_tag(
	namespace_param: String, user_id: String, season_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/exp/history/tags"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not season_id.is_empty():
		query_params["seasonId"] = season_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a user's data for a specific season
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/{seasonId}/data
##
## Retrieves season data for the specified user and season. Excludes publisher namespaces.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
## - user_id: AccelByte user ID
func get_user_season(namespace_param: String, season_id: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/{seasonId}/data"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the current published season
## GET /seasonpass/public/namespaces/{namespace}/seasons/current
##
## Retrieves the current published season for the namespace, with fields localized to the requested language.
##
## Parameters:
## - namespace_param: Game namespace
## - language: BCP 47 language tag for localizing season content. Defaults to the season's default language.
func public_get_current_season(namespace_param: String, language: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/public/namespaces/{namespace}/seasons/current"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not language.is_empty():
		query_params["language"] = language
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the current user's season data
## GET /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/data
##
## Retrieves the current season data for the user. Auto-enrolls the user if no active user season exists but a published season is active.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_get_current_user_season(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/data"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Claims a tier reward
## POST /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/rewards
##
## Claims a reward for the specified tier in the current season.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_claim_user_reward(
	namespace_param: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/rewards"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Claims all remaining tier rewards
## POST /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/rewards/bulk
##
## Claims all unclaimed rewards across all tiers in the current season.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func public_bulk_claim_user_rewards(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/rewards/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a user's data for a specific season
## GET /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/{seasonId}/data
##
## Retrieves season data for the specified user and season.
##
## Parameters:
## - namespace_param: Game namespace
## - season_id: Unique identifier of the season.
## - user_id: AccelByte user ID
func public_get_user_season(
	namespace_param: String, season_id: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/{seasonId}/data"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "seasonId" + "}", season_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
