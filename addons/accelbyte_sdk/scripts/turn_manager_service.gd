## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## turn-manager_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: Justice TURN Manager Service
## Version: 2.13.3
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(TurnManagerService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name TurnManagerService
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

## Query auto scaling config
## GET /turnmanager/admin/configs/autoscale
func query_auto_scale_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Add new cluster for turn server
## POST /turnmanager/admin/configs/autoscale
func create_new_cluster(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get auto scaling config by region
## GET /turnmanager/admin/configs/autoscale/{region}
func get_auto_scale_config(
	region: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale/{region}"
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Modify auto scaling config
## PUT /turnmanager/admin/configs/autoscale/{region}
func save_auto_scale_config(
	region: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/configs/autoscale/{region}"
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)

## Estimate cost of the turn server
## POST /turnmanager/admin/namespace/{namespace}/prices/estimate
func price_estimate_namespace(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/namespace/{namespace}/prices/estimate"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get network usage
## GET /turnmanager/admin/networkusage
func get_network_usage_by_date_range(
	date_end: String = "",
	date_start: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/networkusage"
	# Build query parameters
	var query_params: Dictionary = {}
	if not date_end.is_empty():
		query_params["dateEnd"] = date_end
	if not date_start.is_empty():
		query_params["dateStart"] = date_start
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Update prices
## PATCH /turnmanager/admin/prices
func price_update(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/prices"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)

## Estimate cost of the turn server
## POST /turnmanager/admin/prices/estimate
func price_estimate(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/prices/estimate"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get price regions list
## GET /turnmanager/admin/prices/regions
func list_pricing_regions() -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/prices/regions"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get price list by region
## GET /turnmanager/admin/prices/regions/{region}
func list_price_by_region(
	region: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/prices/regions/{region}"
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Test the p2p connection for available turn server
## GET /turnmanager/admin/servers/testp2p
func p2p_connection_test() -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/servers/testp2p"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Mark the turn server as inactive
## DELETE /turnmanager/admin/servers/{region}/{ip}/{port}
func delete_server(
	ip: String,
	port: String,
	region: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/servers/{region}/{ip}/{port}"
	url_path = url_path.replace("{" + "ip" + "}", ip.uri_encode())
	url_path = url_path.replace("{" + "port" + "}", port.uri_encode())
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## [Deprecated] Modify a server service's region alias
## POST /turnmanager/admin/servers/{region}/{ip}/{port}/alias
## @deprecated
func set_server_alias(
	ip: String,
	port: String,
	region: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/servers/{region}/{ip}/{port}/alias"
	url_path = url_path.replace("{" + "ip" + "}", ip.uri_encode())
	url_path = url_path.replace("{" + "port" + "}", port.uri_encode())
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get configured public TURN servers
## GET /turnmanager/admin/turn/public
func get_public_turn_server() -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/turn/public"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Configure public TURN servers
## POST /turnmanager/admin/turn/public
func add_public_turn_server(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/admin/turn/public"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## For metric purpose only
## POST /turnmanager/metrics/namespaces/{namespace}/connected
func p2p_connected(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/metrics/namespaces/{namespace}/connected"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## For metric purpose only (disconnected)
## POST /turnmanager/metrics/namespaces/{namespace}/disconnected
func p2p_disconnected(
	namespace_param: String,
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/metrics/namespaces/{namespace}/disconnected"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get current time
## GET /turnmanager/public/time
func get_current_time() -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/public/time"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## [Deprecated] Get list of TURN services
## GET /turnmanager/public/turn
## @deprecated
func list_server_deprecated() -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/public/turn"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Send heartbeat
## POST /turnmanager/servers/heartbeat
func heartbeat(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/servers/heartbeat"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Get the public IP
## GET /turnmanager/servers/ip
func public_ip() -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/servers/ip"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Store Turn secret
## POST /turnmanager/servers/secret
func secret(
	body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/servers/secret"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)

## Delete secret for the turn server
## DELETE /turnmanager/servers/secret/{region}/{ip}/{port}
func delete_secret(
	ip: String,
	port: String,
	region: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/servers/secret/{region}/{ip}/{port}"
	url_path = url_path.replace("{" + "ip" + "}", ip.uri_encode())
	url_path = url_path.replace("{" + "port" + "}", port.uri_encode())
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)

## Get list of TURN services
## GET /turnmanager/turn
func list_server(
	all: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/turn"
	# Build query parameters
	var query_params: Dictionary = {}
	if not all.is_empty():
		query_params["all"] = all
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)

## Get generated username password
## GET /turnmanager/turn/secret/{region}/{ip}/{port}
func generate_username_password(
	ip: String,
	port: String,
	region: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/turnmanager/turn/secret/{region}/{ip}/{port}"
	url_path = url_path.replace("{" + "ip" + "}", ip.uri_encode())
	url_path = url_path.replace("{" + "port" + "}", port.uri_encode())
	url_path = url_path.replace("{" + "region" + "}", region.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)
