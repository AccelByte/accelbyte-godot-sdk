## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## sessionbrowser_service_web.gd
## Generated GDScript wrapper for AccelByte API (Web Platform Support)
## Service: justice-session-browser-service
## Version: 
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## This class provides web-compatible HTTP requests using Godot's HTTPRequest.
## On non-web platforms, it delegates to the C++ GDExtension SDK.
##
## Usage:
##   var service = SessionbrowserServiceWeb.new()
##   service.initialize(sdk)  # Pass your AccelByteSDK instance
##   var result = await service.method_name(params)
## =============================================================================

class_name SessionbrowserServiceWeb
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
	print("  [SessionbrowserServiceWeb] %s %s" % [_method_to_string(method), url])

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

	print("  [SessionbrowserServiceWeb] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
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

## Query to available game session
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession
## @deprecated
func admin_query_session(namespace_param: String,session_type: String,game_mode: String = "",game_version: String = "",joinable: String = "",limit: int = 0,match_exist: String = "",match_id: String = "",offset: int = 0,server_status: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not session_type.is_empty():
		query_params["session_type"] = session_type
	if not game_mode.is_empty():
		query_params["game_mode"] = game_mode
	if not game_version.is_empty():
		query_params["game_version"] = game_version
	if not joinable.is_empty():
		query_params["joinable"] = joinable
	if limit != 0:
		query_params["limit"] = limit
	if not match_exist.is_empty():
		query_params["match_exist"] = match_exist
	if not match_id.is_empty():
		query_params["match_id"] = match_id
	if offset != 0:
		query_params["offset"] = offset
	if not server_status.is_empty():
		query_params["server_status"] = server_status
	if not user_id.is_empty():
		query_params["user_id"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get all active session
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/active/count
## @deprecated
func get_total_active_session(namespace_param: String,session_type: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/active/count"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not session_type.is_empty():
		query_params["session_type"] = session_type

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get all active session for custom game, this return only dedicated...
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/active/custom-game
## @deprecated
func get_active_custom_game_sessions(namespace_param: String,limit: int = 0,offset: int = 0,server_region: String = "",session_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/active/custom-game"
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
	if not server_region.is_empty():
		query_params["server_region"] = server_region
	if not session_id.is_empty():
		query_params["session_id"] = session_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get all active session for matchmaking game, this return only...
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/active/matchmaking-game
## @deprecated
func get_active_matchmaking_game_sessions(namespace_param: String,limit: int = 0,match_id: String = "",offset: int = 0,server_region: String = "",session_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/active/matchmaking-game"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if limit != 0:
		query_params["limit"] = limit
	if not match_id.is_empty():
		query_params["match_id"] = match_id
	if offset != 0:
		query_params["offset"] = offset
	if not server_region.is_empty():
		query_params["server_region"] = server_region
	if not session_id.is_empty():
		query_params["session_id"] = session_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Admin delete specified session by session ID
## DELETE /sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func admin_delete_session(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Admin get specified session by session ID
## GET /sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func admin_get_session(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/gamesession/{sessionID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Search sessions
## GET /sessionbrowser/admin/namespaces/{namespace}/sessions/history/search
## @deprecated
func admin_search_sessions_v2(namespace_param: String,limit: int,offset: int,channel: String = "",deleted: bool = false,match_id: String = "",party_id: String = "",session_type: String = "",status: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/sessions/history/search"
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

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Get session history detailed
## GET /sessionbrowser/admin/namespaces/{namespace}/sessions/{matchID}/history/detailed
## @deprecated
func get_session_history_detailed(match_id: String,namespace_param: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/admin/namespaces/{namespace}/sessions/{matchID}/history/detailed"
	url_path = url_path.replace("{" + "matchID" + "}", _url_encode(match_id))
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Query to available game session
## GET /sessionbrowser/namespaces/{namespace}/gamesession
## @deprecated
func user_query_session(namespace_param: String,session_type: String,game_mode: String = "",game_version: String = "",joinable: String = "",limit: int = 0,match_exist: String = "",match_id: String = "",offset: int = 0,server_status: String = "",user_id: String = ""
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not session_type.is_empty():
		query_params["session_type"] = session_type
	if not game_mode.is_empty():
		query_params["game_mode"] = game_mode
	if not game_version.is_empty():
		query_params["game_version"] = game_version
	if not joinable.is_empty():
		query_params["joinable"] = joinable
	if limit != 0:
		query_params["limit"] = limit
	if not match_exist.is_empty():
		query_params["match_exist"] = match_exist
	if not match_id.is_empty():
		query_params["match_id"] = match_id
	if offset != 0:
		query_params["offset"] = offset
	if not server_status.is_empty():
		query_params["server_status"] = server_status
	if not user_id.is_empty():
		query_params["user_id"] = user_id

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Register a new game session
## POST /sessionbrowser/namespaces/{namespace}/gamesession
## @deprecated
func create_session(namespace_param: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Query game sessions by comma separated user ids
## GET /sessionbrowser/namespaces/{namespace}/gamesession/bulk
## @deprecated
func get_session_by_user_ids(namespace_param: String,user_ids: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/bulk"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	# Build query parameters
	var query_params: Dictionary = {}
	if not user_ids.is_empty():
		query_params["user_ids"] = user_ids

	if not query_params.is_empty():
		url_path += "?" + _build_query_string(query_params)

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Delete specified (p2p) session by session ID
## DELETE /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func delete_session(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Get specified session by session ID
## GET /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func get_session(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)

## Update session
## PUT /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}
## @deprecated
func update_session(namespace_param: String,session_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Join specified session by session ID
## POST /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/join
## @deprecated
func join_session(namespace_param: String,session_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/join"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## Only use for local DS entry, will error when calling non local DS entry
## DELETE /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/localds
## @deprecated
func delete_session_local_ds(namespace_param: String,session_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/localds"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Add player to game session
## POST /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player
## @deprecated
func add_player_to_session(namespace_param: String,session_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_POST, headers, request_body)

## remove player from game session
## DELETE /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player/{userID}
## @deprecated
func remove_player_from_session(namespace_param: String,session_id: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/player/{userID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	url_path = url_path.replace("{" + "userID" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_DELETE, headers, request_body)

## Update settings
## PUT /sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/settings
## @deprecated
func update_settings(namespace_param: String,session_id: String,
		body: Dictionary = {}
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/gamesession/{sessionID}/settings"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "sessionID" + "}", _url_encode(session_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_PUT, headers, request_body)

## Query recent players with given user id
## GET /sessionbrowser/namespaces/{namespace}/recentplayer/{userID}
## @deprecated
func get_recent_player(namespace_param: String,user_id: String
) -> Dictionary:
	# Update auth token from SDK
	update_auth_token()

	# Build URL path
	var url_path: String = "/sessionbrowser/namespaces/{namespace}/recentplayer/{userID}"
	url_path = url_path.replace("{" + "namespace" + "}", _url_encode(namespace_param))
	url_path = url_path.replace("{" + "userID" + "}", _url_encode(user_id))
	# Replace namespace
	if url_path.contains("{namespace}") and not _namespace.is_empty():
		url_path = url_path.replace("{namespace}", _url_encode(_namespace))

	var url: String = _base_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = _get_bearer_headers()
	return await _http_request(url, HTTPClient.METHOD_GET, headers, request_body)
