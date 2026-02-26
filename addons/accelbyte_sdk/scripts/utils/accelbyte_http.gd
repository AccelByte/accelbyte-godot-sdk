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
enum Method {
	GET = 0,
	POST = 1,
	PUT = 2,
	DELETE = 3,
	PATCH = 4
}


## Convert Method enum to HTTPClient method
static func to_http_method(method: Method) -> int:
	match method:
		Method.GET: return HTTPClient.METHOD_GET
		Method.POST: return HTTPClient.METHOD_POST
		Method.PUT: return HTTPClient.METHOD_PUT
		Method.DELETE: return HTTPClient.METHOD_DELETE
		Method.PATCH: return HTTPClient.METHOD_PATCH
		_: return HTTPClient.METHOD_GET


## HTTP method to string
static func method_to_string(method: Method) -> String:
	match method:
		Method.GET: return "GET"
		Method.POST: return "POST"
		Method.PUT: return "PUT"
		Method.DELETE: return "DELETE"
		Method.PATCH: return "PATCH"
		_: return "UNKNOWN"


## Make an HTTP request with automatic retry for transient errors.
## Returns Dictionary with: success, status_code, data, body, error
func request(url: String, method: Method, headers: PackedStringArray, body: String = "") -> Dictionary:
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
				print("  [AccelbyteHttp] Retry %d/%d in %dms (status %d)" % [attempt + 1, max_retries, delay_ms, result.get("status_code", 0)])
			await _wait_ms(delay_ms)

	return result


## Execute a single HTTP request (no retry).
func _do_request(url: String, method: Method, headers: PackedStringArray, body: String = "") -> Dictionary:
	if _global_settings and _global_settings.enable_http_logging:
		# Strip query string from log to avoid exposing tokens or PII in query params.
		var log_url = url.split("?")[0]
		print("  [AccelbyteHttp] %s %s" % [method_to_string(method), log_url])

	# Create HTTPRequest node
	var http_request = HTTPRequest.new()
	http_request.timeout = timeout_sec
	_scene_root.add_child(http_request)

	# Make the request
	var http_method = to_http_method(method)
	var error = http_request.request(url, headers, http_method, body)
	if error != OK:
		http_request.queue_free()
		return {"success": false, "error": "Failed to start HTTP request: %d" % error, "status_code": 0}

	# Wait for completion
	var response = await http_request.request_completed

	# Parse response: [result, response_code, headers, body]
	var result_code: int = response[0]
	var response_code: int = response[1]
	var response_body: PackedByteArray = response[3]

	# Clean up
	http_request.queue_free()

	# Build result dictionary
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
		print("  [AccelbyteHttp] Response: %d - %s" % [response_code, "success" if result["success"] else "failed"])
	return result


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
		return PackedStringArray(["Content-Type: application/x-www-form-urlencoded", "Accept: application/json"])

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
