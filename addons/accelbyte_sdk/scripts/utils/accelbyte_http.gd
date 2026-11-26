## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_http.gd
## AccelByte HTTP Utility — shared HTTP client for all SDK services
## =============================================================================
##
## Usage:
##   var http = AccelbyteHttp.new()
##   http.initialize(scene_root)
##   var result = await http.request(url, method, headers, body)
##
## All generated services delegate HTTP calls to this class. It handles:
##   - HTTPRequest node lifecycle (create, await, cleanup)
##   - Response parsing (status code, JSON body, error extraction)
##   - Retry with exponential backoff for transient errors (5xx, 429, 449)
##   - Configurable timeout and logging
##   - Static helpers for auth headers, query strings, and form bodies
##
## CONCURRENCY BEHAVIOR:
##   Each request creates a new HTTPRequest node (up to 4 nodes per retrying call).
##   No rate limiting is applied. On web platforms, browsers enforce per-origin
##   connection limits (typically 6 connections), which may cause queuing for
##   heavy concurrent usage without feedback to the SDK.
## =============================================================================

class_name AccelbyteHttp
extends RefCounted

var _scene_root: Node = null
var _initialized: bool = false
## Global settings reference for secure credential retrieval (OAuth endpoints only)
var _global_settings: AccelByteSettings = null

## Maximum number of retry attempts for transient errors
var max_retries: int = 3

## Initial retry delay in milliseconds (doubles each attempt)
var retry_delay_ms: int = 200

## HTTP request timeout in seconds
var timeout_sec: float = 15.0

## Reuse connections between calls (desktop and servers). The web export always uses HTTPRequest.
var use_keep_alive: bool = true

## Idle connections kept per host:port.
var max_idle_connections_per_host: int = 8

## Time spent polling a connection inside one frame before waiting for the next frame.
var poll_budget_usec: int = 400

## Idle connections by "scheme://host:port".
var _idle: Dictionary = {}

## SDK version for the User-Agent header; AccelByteSDK sets it on startup.
static var sdk_version: String = "0.0.0"


## User-Agent value sent with every REST call and desktop WebSocket handshake.
static func get_user_agent() -> String:
	return "accelbyte-godot-sdk/" + sdk_version


## Add User-Agent unless the caller set one. Browsers refuse to set it, so the web export skips it.
static func _with_user_agent(headers: PackedStringArray) -> PackedStringArray:
	if is_web():
		return headers
	for h in headers:
		if h.to_lower().begins_with("user-agent:"):
			return headers
	var out := headers.duplicate()
	out.push_back("User-Agent: " + get_user_agent())
	return out


## Initialize with scene root (required for HTTPRequest node attachment)
func initialize(scene_root: Node) -> void:
	_scene_root = scene_root
	_initialized = true


## Set global settings reference for OAuth credential retrieval
func set_global_settings(settings: AccelByteSettings) -> void:
	_global_settings = settings


## Check if running on web platform
static func is_web() -> bool:
	return OS.has_feature("web")


## HTTP method constants
enum Method { GET = 0, POST = 1, PUT = 2, DELETE = 3, PATCH = 4 }


## Convert Method enum to HTTPClient method
static func to_http_method(method: Method) -> int:
	match method:
		Method.GET:
			return HTTPClient.METHOD_GET
		Method.POST:
			return HTTPClient.METHOD_POST
		Method.PUT:
			return HTTPClient.METHOD_PUT
		Method.DELETE:
			return HTTPClient.METHOD_DELETE
		Method.PATCH:
			return HTTPClient.METHOD_PATCH
		_:
			return HTTPClient.METHOD_GET


## HTTP method to string
static func method_to_string(method: Method) -> String:
	match method:
		Method.GET:
			return "GET"
		Method.POST:
			return "POST"
		Method.PUT:
			return "PUT"
		Method.DELETE:
			return "DELETE"
		Method.PATCH:
			return "PATCH"
		_:
			return "UNKNOWN"


## Make an HTTP request with automatic retry for transient errors.
## Returns Dictionary with: success, status_code, data, body, error
func request(
	url: String, method: Method, headers: PackedStringArray, body: String = ""
) -> Dictionary:
	if not _initialized or not _scene_root:
		return {"success": false, "error": "AccelbyteHttp not initialized", "status_code": 0}

	var result: Dictionary = {}
	for attempt in range(max_retries + 1):
		result = await _do_request(url, method, headers, body)

		if result.get("success", false) or not _should_retry(result.get("status_code", 0)):
			return result

		# Wait before retrying (exponential backoff)
		if attempt < max_retries:
			var delay_ms = retry_delay_ms * int(pow(2, attempt))
			if _global_settings and _global_settings.enable_http_logging:
				print(
					(
						"  [AccelbyteHttp] Retry %d/%d in %dms (status %d)"
						% [attempt + 1, max_retries, delay_ms, result.get("status_code", 0)]
					)
				)
			await _wait_ms(delay_ms)

	return result


## Execute a single HTTP request (no retry).
## Desktop and servers use pooled keep-alive connections (HTTPClient); the web export, and any
## response that redirects, use an HTTPRequest node.
func _do_request(
	url: String, method: Method, headers: PackedStringArray, body: String = ""
) -> Dictionary:
	if _global_settings and _global_settings.enable_http_logging:
		# Strip query string from log to avoid exposing tokens or PII in query params.
		var log_url = url.split("?")[0]
		print("  [AccelbyteHttp] %s %s" % [method_to_string(method), log_url])

	headers = _with_user_agent(headers)
	if use_keep_alive and not is_web():
		var pooled: Dictionary = await _do_request_pooled(url, method, headers, body)
		if not pooled.get("fallback", false):
			return pooled
	return await _do_request_node(url, method, headers, body)


## Single request through an HTTPRequest node (web, redirects, or when keep-alive is off).
func _do_request_node(
	url: String, method: Method, headers: PackedStringArray, body: String
) -> Dictionary:
	var http_request = HTTPRequest.new()
	http_request.timeout = timeout_sec
	_scene_root.add_child(http_request)

	var http_method = to_http_method(method)
	var error = http_request.request(url, headers, http_method, body)
	if error != OK:
		http_request.queue_free()
		return {
			"success": false, "error": "Failed to start HTTP request: %d" % error, "status_code": 0
		}

	# Parse response: [result, response_code, headers, body]
	var response = await http_request.request_completed
	http_request.queue_free()
	return _make_result(response[0], response[1], response[3])


## Build the result dictionary from a finished response.
func _make_result(
	result_code: int, response_code: int, response_body: PackedByteArray
) -> Dictionary:
	var result: Dictionary = {"status_code": response_code}

	if result_code != HTTPRequest.RESULT_SUCCESS:
		result["success"] = false
		result["error"] = "HTTP request failed with result code: %d" % result_code
		return result

	# Parse body
	var body_string = response_body.get_string_from_utf8()
	result["body"] = body_string

	if not body_string.is_empty():
		var json = JSON.new()
		if json.parse(body_string) == OK:
			result["data"] = json.data
		else:
			result["data"] = body_string

	# Determine success
	result["success"] = (response_code >= 200 and response_code < 300)

	# Extract error message if present
	if not result["success"] and result.has("data") and result["data"] is Dictionary:
		var err_data = result["data"]
		if err_data.has("errorMessage"):
			result["error"] = err_data["errorMessage"]
		elif err_data.has("error_description"):
			result["error"] = err_data["error_description"]
		elif err_data.has("error"):
			result["error"] = err_data["error"]

	if _global_settings and _global_settings.enable_http_logging:
		print(
			(
				"  [AccelbyteHttp] Response: %d - %s"
				% [response_code, "success" if result["success"] else "failed"]
			)
		)
	return result


# =============================================================================
# Pooled keep-alive connections (HTTPClient)
# =============================================================================


## Split a URL into scheme, host, port and request path. Returns {} when it is not http(s).
static func _parse_url(url: String) -> Dictionary:
	var scheme_end := url.find("://")
	if scheme_end < 0:
		return {}
	var scheme := url.substr(0, scheme_end).to_lower()
	if scheme != "http" and scheme != "https":
		return {}
	var rest := url.substr(scheme_end + 3)
	var path_start := rest.find("/")
	var authority := rest if path_start < 0 else rest.substr(0, path_start)
	var path := "/" if path_start < 0 else rest.substr(path_start)
	var host := authority
	var port := 443 if scheme == "https" else 80
	if authority.begins_with("["):
		var close := authority.find("]")
		host = authority.substr(1, close - 1)
		if authority.length() > close + 2 and authority[close + 1] == ":":
			port = int(authority.substr(close + 2))
	elif ":" in authority:
		host = authority.get_slice(":", 0)
		port = int(authority.get_slice(":", 1))
	if host.is_empty():
		return {}
	return {
		"tls": scheme == "https",
		"host": host,
		"port": port,
		"path": path,
		"key": "%s://%s:%d" % [scheme, host, port]
	}


## Take an idle connection for this host, or null.
func _acquire_idle(key: String) -> HTTPClient:
	var list: Array = _idle.get(key, [])
	while not list.is_empty():
		var client: HTTPClient = list.pop_back()
		client.poll()
		if client.get_status() == HTTPClient.STATUS_CONNECTED:
			return client
		client.close()
	return null


## Keep a healthy connection for the next call, up to max_idle_connections_per_host.
func _release_idle(key: String, client: HTTPClient) -> void:
	if client.get_status() != HTTPClient.STATUS_CONNECTED:
		client.close()
		return
	var list: Array = _idle.get(key, [])
	if list.size() >= max_idle_connections_per_host:
		client.close()
		return
	list.push_back(client)
	_idle[key] = list


## Close every idle connection (for example on shutdown or when the network changes).
func close_idle_connections() -> void:
	for key in _idle:
		for client in _idle[key]:
			client.close()
	_idle.clear()


func _request_failure(result_code: int) -> Dictionary:
	return _make_result(result_code, 0, PackedByteArray())


## One request over a pooled connection. Returns {"fallback": true} when the caller should use an
## HTTPRequest node instead (redirect responses).
func _do_request_pooled(
	url: String, method: Method, headers: PackedStringArray, body: String
) -> Dictionary:
	var parsed := _parse_url(url)
	if parsed.is_empty():
		return {"fallback": true}
	var deadline := Time.get_ticks_msec() + int(timeout_sec * 1000.0)
	var request_headers := headers.duplicate()
	if method != Method.GET:
		var has_length := false
		for h in request_headers:
			if h.to_lower().begins_with("content-length:"):
				has_length = true
		if not has_length:
			request_headers.push_back("Content-Length: %d" % body.to_utf8_buffer().size())

	# A reused connection may have been closed by the server while idle; if that shows up before any
	# response arrives, retry once on a fresh connection.
	var outcome: Dictionary = {}
	for attempt in 2:
		var client: HTTPClient = _acquire_idle(parsed["key"])
		var reused := client != null
		if not reused:
			client = HTTPClient.new()
			var connect_err := client.connect_to_host(
				parsed["host"], parsed["port"], TLSOptions.client() if parsed["tls"] else null
			)
			if connect_err != OK:
				return _request_failure(HTTPRequest.RESULT_CANT_CONNECT)
		outcome = await _exchange(client, parsed, method, request_headers, body, deadline)
		if outcome.get("stale", false) and reused:
			client.close()
			continue
		if outcome.get("keep", false):
			_release_idle(parsed["key"], client)
		else:
			client.close()
		break

	if outcome.get("redirect", false):
		return {"fallback": true}
	return _make_result(
		outcome.get("result", HTTPRequest.RESULT_REQUEST_FAILED),
		outcome.get("code", 0),
		outcome.get("body", PackedByteArray())
	)


## Drive one request/response on a client. Polls the client several times per frame (a frame is only
## awaited once a short time budget is used up) so a response that is already there does not cost a frame.
func _exchange(
	client: HTTPClient,
	parsed: Dictionary,
	method: Method,
	headers: PackedStringArray,
	body: String,
	deadline: int
) -> Dictionary:
	var tree := _scene_root.get_tree()
	var t0 := Time.get_ticks_usec()

	# Connect (already connected for a reused connection).
	while true:
		client.poll()
		var st := client.get_status()
		if st == HTTPClient.STATUS_CONNECTED:
			break
		if st != HTTPClient.STATUS_RESOLVING and st != HTTPClient.STATUS_CONNECTING:
			return {"result": _status_to_result(st), "stale": true}
		if Time.get_ticks_msec() > deadline:
			return {"result": HTTPRequest.RESULT_TIMEOUT}
		if Time.get_ticks_usec() - t0 > poll_budget_usec:
			await tree.process_frame
			t0 = Time.get_ticks_usec()

	if client.request(to_http_method(method), parsed["path"], headers, body) != OK:
		return {"result": HTTPRequest.RESULT_REQUEST_FAILED, "stale": true}

	# Send the request and wait for the response headers.
	while true:
		client.poll()
		var st := client.get_status()
		if st != HTTPClient.STATUS_REQUESTING:
			break
		if Time.get_ticks_msec() > deadline:
			return {"result": HTTPRequest.RESULT_TIMEOUT}
		if Time.get_ticks_usec() - t0 > poll_budget_usec:
			await tree.process_frame
			t0 = Time.get_ticks_usec()

	if not client.has_response():
		return {"result": _status_to_result(client.get_status()), "stale": true}

	var code := client.get_response_code()
	var keep := true
	for h in client.get_response_headers():
		if h.to_lower().replace(" ", "") == "connection:close":
			keep = false

	# Read the body.
	var chunks := PackedByteArray()
	while client.get_status() == HTTPClient.STATUS_BODY:
		client.poll()
		var chunk := client.read_response_body_chunk()
		if chunk.size() > 0:
			chunks.append_array(chunk)
			continue
		if Time.get_ticks_msec() > deadline:
			return {"result": HTTPRequest.RESULT_TIMEOUT}
		if Time.get_ticks_usec() - t0 > poll_budget_usec:
			await tree.process_frame
			t0 = Time.get_ticks_usec()

	if client.get_status() != HTTPClient.STATUS_CONNECTED:
		keep = false
	if code in [301, 302, 303, 307, 308]:
		return {"redirect": true}
	return {"result": HTTPRequest.RESULT_SUCCESS, "code": code, "body": chunks, "keep": keep}


static func _status_to_result(status: int) -> int:
	match status:
		HTTPClient.STATUS_CANT_RESOLVE:
			return HTTPRequest.RESULT_CANT_RESOLVE
		HTTPClient.STATUS_CANT_CONNECT:
			return HTTPRequest.RESULT_CANT_CONNECT
		HTTPClient.STATUS_TLS_HANDSHAKE_ERROR:
			return HTTPRequest.RESULT_TLS_HANDSHAKE_ERROR
		HTTPClient.STATUS_CONNECTION_ERROR:
			return HTTPRequest.RESULT_CONNECTION_ERROR
		_:
			return HTTPRequest.RESULT_NO_RESPONSE


## Check if a status code indicates a transient error worth retrying
static func _should_retry(status_code: int) -> bool:
	return status_code >= 500 or status_code == 429 or status_code == 449


## Wait for a given number of milliseconds using a SceneTree timer
func _wait_ms(ms: int) -> void:
	if _scene_root and _scene_root.get_tree():
		await _scene_root.get_tree().create_timer(ms / 1000.0).timeout


# =============================================================================
# Convenience Methods
# =============================================================================


## Convenience method for GET request
func get_request(url: String, headers: PackedStringArray) -> Dictionary:
	return await request(url, Method.GET, headers, "")


## Convenience method for POST request with JSON body
func post_json(url: String, headers: PackedStringArray, data: Dictionary) -> Dictionary:
	var json_body = JSON.stringify(data)
	return await request(url, Method.POST, headers, json_body)


## Convenience method for POST request with form body
func post_form(url: String, headers: PackedStringArray, form_data: Dictionary) -> Dictionary:
	var form_body = build_form_body(form_data)
	return await request(url, Method.POST, headers, form_body)


# =============================================================================
# Static Helpers (used by generated services directly)
# =============================================================================


## Build form-urlencoded body from dictionary
static func build_form_body(params: Dictionary) -> String:
	var parts: Array[String] = []
	for key in params.keys():
		var value = params[key]
		var value_str: String
		if value is bool:
			value_str = "true" if value else "false"
		else:
			value_str = str(value)
		parts.append("%s=%s" % [str(key).uri_encode(), value_str.uri_encode()])
	return "&".join(parts)


## Build bearer auth headers
static func get_bearer_headers(token: String) -> PackedStringArray:
	var headers = PackedStringArray()
	headers.push_back("Content-Type: application/json")
	headers.push_back("Accept: application/json")
	if not token.is_empty():
		headers.push_back("Authorization: Bearer " + token)
	return headers


## Build basic auth headers (for OAuth endpoints)
static func get_basic_auth_headers(client_id: String, client_secret: String) -> PackedStringArray:
	var headers = PackedStringArray()
	headers.push_back("Content-Type: application/x-www-form-urlencoded")
	headers.push_back("Accept: application/json")
	if not client_id.is_empty():
		var auth_string = client_id + ":" + client_secret
		var base64_auth = Marshalls.raw_to_base64(auth_string.to_utf8_buffer())
		headers.push_back("Authorization: Basic " + base64_auth)
	return headers


## Get basic auth headers for OAuth endpoints, retrieving credentials from global settings.
## This prevents client secrets from being stored in individual service instances.
func get_basic_auth_headers_for_oauth(client_id: String) -> PackedStringArray:
	if not _global_settings:
		push_error("[AccelbyteHttp] No global settings available for OAuth basic auth")
		return PackedStringArray(
			["Content-Type: application/x-www-form-urlencoded", "Accept: application/json"]
		)

	var effective_client_id = client_id if not client_id.is_empty() else _global_settings.client_id
	return get_basic_auth_headers(effective_client_id, _global_settings._get_client_secret())


## Build query string from dictionary (handles arrays, booleans)
static func build_query_string(params: Dictionary) -> String:
	var parts: Array[String] = []
	for key in params.keys():
		var value = params[key]
		if value is Array:
			for item in value:
				parts.append("%s=%s" % [str(key).uri_encode(), str(item).uri_encode()])
		elif value is bool:
			parts.append("%s=%s" % [str(key).uri_encode(), "true" if value else "false"])
		else:
			parts.append("%s=%s" % [str(key).uri_encode(), str(value).uri_encode()])
	return "&".join(parts)
