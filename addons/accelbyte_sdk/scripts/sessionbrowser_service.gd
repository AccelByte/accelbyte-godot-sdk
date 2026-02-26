## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## sessionbrowser_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-session-browser-service
## Version: 
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(SessionbrowserService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name SessionbrowserService
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

## Query to available game session
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession
## @deprecated
func admin_query_session(
	namespace_param: String,
	session_type: String,
	game_mode: String = "",
	game_version: String = "",
	joinable: String = "",
	limit: int = -1,
	match_exist: String = "",
	match_id: String = "",
	offset: int = -1,
	server_status: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not game_mode.is_empty():
		query_params["game_mode"] = game_mode
	if not game_version.is_empty():
		query_params["game_version"] = game_version
	if not joinable.is_empty():
		query_params["joinable"] = joinable
	if limit >= 0:
		query_params["limit"] = limit
	if not match_exist.is_empty():
		query_params["match_exist"] = match_exist
	if not match_id.is_empty():
		query_params["match_id"] = match_id
	if offset >= 0:
		query_params["offset"] = offset
	if not server_status.is_empty():
		query_params["server_status"] = server_status
	if not user_id.is_empty():
		query_params["user_id"] = user_id
	if not session_type.is_empty():
		query_params["session_type"] = session_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all active session
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/active/count
## @deprecated
func get_total_active_session(
	namespace_param: String,
	session_type: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/active/count"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not session_type.is_empty():
		query_params["session_type"] = session_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all active session for custom game, this return only dedicated...
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/active/custom-game
## @deprecated
func get_active_custom_game_sessions(
	namespace_param: String,
	limit: int = -1,
	offset: int = -1,
	server_region: String = "",
	session_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/active/custom-game"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not server_region.is_empty():
		query_params["server_region"] = server_region
	if not session_id.is_empty():
		query_params["session_id"] = session_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get all active session for matchmaking game, this return only...
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/active/matchmaking-game
## @deprecated
func get_active_matchmaking_game_sessions(
	namespace_param: String,
	limit: int = -1,
	match_id: String = "",
	offset: int = -1,
	server_region: String = "",
	session_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/active/matchmaking-game"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not match_id.is_empty():
		query_params["match_id"] = match_id
	if offset >= 0:
		query_params["offset"] = offset
	if not server_region.is_empty():
		query_params["server_region"] = server_region
	if not session_id.is_empty():
		query_params["session_id"] = session_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin get specified session by session ID
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func admin_get_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Admin delete specified session by session ID
## DELETE /sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func admin_delete_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Search sessions
## GET /sessionbrowser/admin/namespaces/{namespace}/sessions/history/search
## @deprecated
func admin_search_sessions_v2(
	namespace_param: String,
	limit: int,
	offset: int,
	channel: String = "",
	deleted: bool = false,
	match_id: String = "",
	party_id: String = "",
	session_type: String = "",
	status: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/sessions/history/search"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not channel.is_empty():
		query_params["channel"] = channel
	query_params["deleted"] = deleted
	if not match_id.is_empty():
		query_params["matchID"] = match_id
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not session_type.is_empty():
		query_params["sessionType"] = session_type
	if not status.is_empty():
		query_params["status"] = status
	if not user_id.is_empty():
		query_params["userID"] = user_id
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

## Get session history detailed
## GET /sessionbrowser/admin/namespaces/{namespace}/sessions/{matchID}/history/detailed
## @deprecated
func get_session_history_detailed(
	match_id: String,
	namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/sessions/{matchID}/history/detailed"
	url_path = url_path.replace("{" + "matchID" + "}", match_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Query to available game session
## GET /sessionbrowser/namespaces/{namespace}/gamesession
## @deprecated
func user_query_session(
	namespace_param: String,
	session_type: String,
	game_mode: String = "",
	game_version: String = "",
	joinable: String = "",
	limit: int = -1,
	match_exist: String = "",
	match_id: String = "",
	offset: int = -1,
	server_status: String = "",
	user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not game_mode.is_empty():
		query_params["game_mode"] = game_mode
	if not game_version.is_empty():
		query_params["game_version"] = game_version
	if not joinable.is_empty():
		query_params["joinable"] = joinable
	if limit >= 0:
		query_params["limit"] = limit
	if not match_exist.is_empty():
		query_params["match_exist"] = match_exist
	if not match_id.is_empty():
		query_params["match_id"] = match_id
	if offset >= 0:
		query_params["offset"] = offset
	if not server_status.is_empty():
		query_params["server_status"] = server_status
	if not user_id.is_empty():
		query_params["user_id"] = user_id
	if not session_type.is_empty():
		query_params["session_type"] = session_type
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Register a new game session
## POST /sessionbrowser/namespaces/{namespace}/gamesession
## @deprecated
func create_session(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Query game sessions by comma separated user ids
## GET /sessionbrowser/namespaces/{namespace}/gamesession/bulk
## @deprecated
func get_session_by_user_i_ds(
	namespace_param: String,
	user_ids: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not user_ids.is_empty():
		query_params["user_ids"] = user_ids
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get specified session by session ID
## GET /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func get_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update session
## PUT /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func update_session(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Delete specified (p2p) session by session ID
## DELETE /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func delete_session(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Join specified session by session ID
## POST /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/join
## @deprecated
func join_session(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/join"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Only use for local DS entry, will error when calling non local DS entry
## DELETE /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/localds
## @deprecated
func delete_session_local_ds(
	namespace_param: String,
	session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/localds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Add player to game session
## POST /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player
## @deprecated
func add_player_to_session(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## remove player from game session
## DELETE /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player/{userID}
## @deprecated
func remove_player_from_session(
	namespace_param: String,
	session_id: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player/{userID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userID" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Update settings
## PUT /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/settings
## @deprecated
func update_settings(
	namespace_param: String,
	session_id: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/settings"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionID" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Query recent players with given user id
## GET /sessionbrowser/namespaces/{namespace}/recentplayer/{userID}
## @deprecated
func get_recent_player(
	namespace_param: String,
	user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/recentplayer/{userID}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userID" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
