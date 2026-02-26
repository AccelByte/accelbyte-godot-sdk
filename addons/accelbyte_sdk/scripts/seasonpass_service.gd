## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## seasonpass_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-seasonpass-service
## Version: 1.26.3
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

## export season service data
## GET /seasonpass/admin/namespace/{namespace}/export
func export_season(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespace/{namespace}/export"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query seasons
## GET /seasonpass/admin/namespaces/{namespace}/seasons
func query_seasons(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	status: Array = []
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

## Create a season
## POST /seasonpass/admin/namespaces/{namespace}/seasons
func create_season(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get current published season summary
## GET /seasonpass/admin/namespaces/{namespace}/seasons/current
func get_current_season(
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/current"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Bulk get user current season progression
## POST /seasonpass/admin/namespaces/{namespace}/seasons/current/users/bulk/progression
func bulk_get_user_season_progression(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/seasonpass/admin/namespaces/{namespace}/seasons/current/users/bulk/progression"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get season pass ecommerce item references
## GET /seasonpass/admin/namespaces/{namespace}/seasons/item/references
func get_item_references(
	namespace_param: String,
	item_id: String
) -> Dictionary:
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

## Get a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}
func get_season(
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Delete a season
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}
func delete_season(
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Update a season
## PATCH /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}
func update_season(
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Clone a season
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/clone
func clone_season(
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Get a season full content
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/full
func get_full_season(
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Query all passes for a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes
func query_passes(
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Create a pass
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes
func create_pass(
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Get a pass
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}
func get_pass(
	code: String,
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Delete a pass
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}
func delete_pass(
	code: String,
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Update a pass
## PATCH /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/passes/{code}
func update_pass(
	code: String,
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
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

## Publish a season
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/publish
func publish_season(
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Retire a season
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/retire
func retire_season(
	namespace_param: String,
	season_id: String,
	force: bool = false
) -> Dictionary:
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

## Query all rewards for a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards
func query_rewards(
	namespace_param: String,
	season_id: String,
	q: String = ""
) -> Dictionary:
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

## Create a reward
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards
func create_reward(
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Get a reward
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}
func get_reward(
	code: String,
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Delete a reward
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}
func delete_reward(
	code: String,
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Update a reward
## PATCH /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/rewards/{code}
func update_reward(
	code: String,
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
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

## Query paginated tiers for a season
## GET /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers
func query_tiers(
	namespace_param: String,
	season_id: String,
	limit: int = -1,
	offset: int = -1
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

## Create tier
## POST /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers
func create_tier(
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Update a tier
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}
func update_tier(
	id: String,
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
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

## Delete a tier
## DELETE /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}
func delete_tier(
	id: String,
	namespace_param: String,
	season_id: String
) -> Dictionary:
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

## Reorder a tier
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/tiers/{id}/reorder
func reorder_tier(
	id: String,
	namespace_param: String,
	season_id: String,
	body: Dictionary = {}
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

## Unpublish a season
## PUT /seasonpass/admin/namespaces/{namespace}/seasons/{seasonId}/unpublish
func unpublish_season(
	namespace_param: String,
	season_id: String,
	force: bool = false
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

## Get user participated season data
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons
func get_user_participated_seasons(
	namespace_param: String,
	user_id: String,
	limit: int = -1,
	offset: int = -1
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

## Grant exp to user
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/exp
func grant_user_exp(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Grant pass to user
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/passes
func grant_user_pass(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Get ownership for any pass codes
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/passes/ownership/any
func exists_any_pass_by_pass_codes(
	namespace_param: String,
	user_id: String,
	pass_codes: Array = []
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

## Get current user season progression
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/progression
func get_current_user_season_progression(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Check pass or tier purchasable
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/purchasable
func check_season_purchasable(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Reset user data in current season
## DELETE /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/reset
func reset_user_season(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Grant tier to user
## POST /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/current/tiers
func grant_user_tier(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
) -> Dictionary:
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

## Query user season exp acquisition history
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/exp/history
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

## Query user season exp acquisition history's reason tag list
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/exp/history/tags
func query_user_exp_grant_history_tag(
	namespace_param: String,
	user_id: String,
	season_id: String = ""
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

## Get user season data
## GET /seasonpass/admin/namespaces/{namespace}/users/{userId}/seasons/{seasonId}/data
func get_user_season(
	namespace_param: String,
	season_id: String,
	user_id: String
) -> Dictionary:
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

## Get current published season
## GET /seasonpass/public/namespaces/{namespace}/seasons/current
func public_get_current_season(
	namespace_param: String,
	language: String = ""
) -> Dictionary:
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

## Get current user season data
## GET /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/data
func public_get_current_user_season(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Claim tier reward
## POST /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/rewards
func public_claim_user_reward(
	namespace_param: String,
	user_id: String,
	body: Dictionary = {}
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

## Bulk claim all remained rewards
## POST /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/current/rewards/bulk
func public_bulk_claim_user_rewards(
	namespace_param: String,
	user_id: String
) -> Dictionary:
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

## Get user season data
## GET /seasonpass/public/namespaces/{namespace}/users/{userId}/seasons/{seasonId}/data
func public_get_user_season(
	namespace_param: String,
	season_id: String,
	user_id: String
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
