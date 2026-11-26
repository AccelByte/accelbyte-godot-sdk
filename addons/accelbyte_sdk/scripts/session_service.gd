## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## session_service.gd
## Generated AccelByte API service (pure GDScript, all platforms)
## Service: justice-session-service
## Version: 3.38.0
## DO NOT EDIT - This file is auto-generated from OpenAPI spec
## =============================================================================
##
## Usage:
##   var service = sdk.get_service(SessionService)
##   var result = await service.method_name(params)
##
## Optional Parameters:
##   Integer/float parameters use -1 as sentinel for "not provided"
##   To explicitly pass 0, use: method(offset: 0)  # Will be included
##   To omit parameter, use: method()             # offset=-1, not included
## =============================================================================

class_name SessionService
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


## Retrieves service health status
## GET /healthz
##
## Returns the current health status of the session service.
func get_healthcheck_info() -> Dictionary:
	# Build URL path
	var url_path: String = "/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves session service health status
## GET /session/healthz
##
## Returns the current health status of the session service.
func get_healthcheck_info_v1() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/healthz"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves the log configuration
## GET /session/v1/admin/config/log
##
## Returns the current log level and configuration for the session service.
func admin_get_log_config() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the log configuration
## PATCH /session/v1/admin/config/log
##
## Updates the log level and configuration for the session service.
func admin_patch_update_log_config(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/config/log"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Lists environment variables for the session service
## GET /session/v1/admin/environment-variables
##
## List of environment variables.
func admin_list_environment_variables() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/environment-variables"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves global configuration data
## GET /session/v1/admin/global-configurations
##
## Record of global configuration data.
func admin_list_global_configuration() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Creates or updates global configuration data
## PUT /session/v1/admin/global-configurations
##
## Creates a new global configuration or replaces the existing one if it already exists.
func admin_update_global_configuration(body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes global configuration data
## DELETE /session/v1/admin/global-configurations
##
## Delete of global configuration data.
func admin_delete_global_configuration() -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/global-configurations"
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the alerts configuration for the namespace
## GET /session/v1/admin/namespaces/{namespace}/alerts-configuration
##
## Returns the current alerts configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_configuration_alert_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the alerts configuration for the namespace
## PUT /session/v1/admin/namespaces/{namespace}/alerts-configuration
##
## Updates the alerts configuration for the namespace. Required fields: namespace and durationDays (must be greater than 0).
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_configuration_alert_v1(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Creates an alerts configuration for the namespace
## POST /session/v1/admin/namespaces/{namespace}/alerts-configuration
##
## Creates an alerts configuration for the namespace. Required fields: namespace and durationDays (must be greater than 0).
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_configuration_alert_v1(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes the alerts configuration for the namespace
## DELETE /session/v1/admin/namespaces/{namespace}/alerts-configuration
##
## Permanently removes the alerts configuration for the namespace.
##
## Parameters:
## - namespace_param: Game namespace
func admin_delete_configuration_alert_v1(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/alerts-configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Creates a configuration template for parties and game sessions
## POST /session/v1/admin/namespaces/{namespace}/configuration
##
## Create a configuration template for use across parties and game sessions.
## Session configuration mandatory :
## - name
## - joinability. supported values:
## - OPEN: user can join or rejoin the session without an invite
## - CLOSED: once the service creates a CLOSED session or updates joinability to CLOSED, member changes are not allowed and the service cancels remaining invites.
## - INVITE_ONLY: to join the session, the user must receive an invite or have a join code. When a user is kicked, leaves, or is rejected, they must receive a new invite to rejoin.
## - FRIENDS_OF_MEMBERS: only if a user is friend with at least one of the session members, they can join via code.
## - FRIENDS_OF_LEADER: only if a user is friend with the session leader, they can join via code.
## - FRIENDS_OF_FRIENDS: only friends of the leader OR friends of friends of the leader can join via code.
## - autoJoin: when enabled, players will automatically join the initial game session creation. Game session will not send any invite and players dont need to act upon it. default: false (disabled)
## - Type (example value : P2P, DS, NONE) if type empty, type defaults to NONE
## - MinPlayers (must greater or equal 0)
## - MaxPlayers (must greater than 0)
## - InviteTimeout (must greater or equal 0) if InviteTimeout equal 0 will be use default 60 seconds as the default
## - InactiveTimeout (must greater or equal 0) if InactiveTimeout equal 0 will be use default 60 seconds as the default
## - Persistent will only applies to session with type DS (example value true or false, default: false)
## - If Persistent True the session always active even DS removing or terminate and the session requests DS again until DS Ready or Busy.
## - To Stop Session Not request again to DS or want Delete Session can Delete Session using the Delete Game Session operation
## - If Persistent False the session will be inactive if all member left and DS terminate or removing
## - nativeSessionSetting:
## - XboxSessionTemplateName: the Xbox session template name used to define session join restrictions and max member count during native session sync.
## - XboxServiceConfigID: the XBox service configuration ID.
## - PSNServiceLabel: the PSN service label.
## - SessionTitle: the session title. In PSN, this will be used to define name of the session thats displayed on PlayStation system UI.
## - ShouldSync: to define whether the service needs to do session sync with native platform(s). Default: false (disabled).
## - PSNSupportedPlatforms: the PSN supported platforms. In PSN, if ShouldSync true and PSNSupportedPlatforms is empty, then PS5 will be set as default value.
## - PSNDisableSystemUIMenu: items whose operation from the PSN system software UI is to be disabled.
## - PSNBaseUrl this is for base URL PSN if not set will be default value https://s2s.sp-int.playstation.net. In a single namespace only 1 PSN Env that can be used. Multiple session template should refers to the same PSN Env as we have in IAM Service.
## - https://s2s.sp-int.playstation.net (DEV, need IP Whitelist)
## - https://s2s.prod-qa.playstation.net (QA Environment/PSN Certification)
## - https://s2s.np.playstation.net (Production)
## - localizedSessionName : for localized name and default language
## example value:
## "localizedSessionName":{
## "defaultLanguage" : "en-US"
## "localizedText" :{
## "en-US" : "title"
## }
## }
## - if the game client wants to enable push context to PSN, game client will need to store PSN_PUSH_CONTEXT_ID on the player attributes, otherwise Session service will try to populate from the session attributes or auto generate with random UUID if empty.
## - TieTeamsSessionLifetime (optional, default: false): If it is set to true, the lifetime of any partyId session inside teams attribute will be tied to the game session. Only applies when the teams partyId is game session.
## - DisableCodeGeneration (optional, default: false): If it is set to true, code will not be generated for party session automatically.
## - DSManualSetReady (optional, default: false): The DS need to call the specific operation to flag the DS for game session is ready to accept client connection.
## - EnableSecret (optional, default: false): if configuration template is created with TypeDS and EnableSecret is True, A secret will be created
## - LeaderElectionGracePeriod this is on second (optional, default:0) this is only use for party session, if value > 0 if leader disconnect will be wait until value reach and leader will be change after reach
## - ManualRejoin (optional, default: false): indicates if game client will handle manual rejoin upon websocket reconnection when enabled.
## - DisableResendInvite (optional, default: false): by default, the service will be sending invites until the user reacts to it. enabling this flag will prohibit the service to send reminder invites'.
## - appName (optional, default: empty string). Extend application name that uploaded to AccelByte extends deployment. The application is for custom/external DS management.
## - customURLGRPC (optional: default: empty string). Url for grpc server that server custom/external DS management. This value will be ignore when appName is filled. Value formatted as host:port. Example: yourdomain.com:9989
## - grpcSessionConfig (optional, default: empty object). Setting for grpc session extends. Session service will calls the grpc when any activity for the game sessions.
## - appName (required when customURL is empty) The extends app name that created and uploaded to AccelByte extends deployment.
## - customURL (required when appName is empty) The url for grpc server. Format is host:port. Example: mycustomdomain.com:9889. This will be ignore when appName is filled.
## - functionFlag (optional, default: -1) Flag to enable which function to calls when any event on the game sessions. The value is bitwise integer.
## - 0x1 is for created event. Event is sync, anything returned from the create event overrides the final game session.
## - 0x2 is for updated event. Event is async. Called when any update on the game session.
## - 0x4 is for deleted event. Event is async. Called when a game session is deleted.
## Example:
## - value 3: enable for created and updated
## - value 7: enable for created, updated, and deleted, etc
## - partyCodeGeneratorString (optional, default: 0123456789ABCDEFGHJKMNPQRSTVWXYZ)
## The code is generated by randomly selecting characters from the allowed set, with at least 6 characters long. Allowed characters:
## 0123456789ABCDEFGHJKMNPQRSTVWXYZ (All digits 0â9 and uppercase letters AâZ, excluding I, L, O, and U).
##
## Parameters:
## - namespace_param: Game namespace
func admin_create_configuration_template_v1(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configuration"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves configuration templates in the namespace
## GET /session/v1/admin/namespaces/{namespace}/configurations
##
## Returns all configuration templates in the specified namespace. Use offset and limit parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - name_param: Name of the configuration template to filter results by.
## - offset: Number of results to skip for pagination
## - order: Order of the result. Supported: desc (default), asc
## - order_by: Order result by specific attribute. Supported: createdAt (default), updatedAt
func admin_get_all_configuration_templates_v1(
	namespace_param: String,
	limit: int = -1,
	name_param: String = "",
	offset: int = -1,
	order: String = "",
	order_by: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not name_param.is_empty():
		query_params["name"] = name_param
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a configuration template by name
## GET /session/v1/admin/namespaces/{namespace}/configurations/{name}
##
## Returns the configuration template with the specified name.
##
## Parameters:
## - name_param: Name of the configuration template to retrieve.
## - namespace_param: Game namespace
func admin_get_configuration_template_v1(name_param: String, namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates the named configuration template
## PUT /session/v1/admin/namespaces/{namespace}/configurations/{name}
##
## Update the configuration template
## Session configuration mandatory :
## - name
## - joinability. supported values:
## - OPEN: user can join or rejoin the session without an invite
## - CLOSED: once the service creates a CLOSED session or updates joinability to CLOSED, member changes are not allowed and the service cancels remaining invites.
## - INVITE_ONLY: to join the session, the user must receive an invite or have a join code. When a user is kicked, leaves, or is rejected, they must receive a new invite to rejoin.
## - FRIENDS_OF_MEMBERS: only if a user is friend with at least one of the session members, they can join via code.
## - FRIENDS_OF_LEADER: only if a user is friend with the session leader, they can join via code.
## - FRIENDS_OF_FRIENDS: only friends of the leader OR friends of friends of the leader can join via code.
## - autoJoin: when enabled, players will automatically join the initial game session creation. Game session will not send any invite and players dont need to act upon it. default: false (disabled)
## - Type (example value : P2P, DS, NONE) if type empty, type defaults to NONE
## - MinPlayers (must greater or equal 0)
## - MaxPlayers (must greater than 0)
## - InviteTimeout (must greater or equal 0) if InviteTimeout equal 0 will be use default 60 seconds as the default
## - InactiveTimeout (must greater or equal 0) if InactiveTimeout equal 0 will be use default 60 seconds as the default
## - Persistent Flag only can use with type DS (example value true or false)
## - If Persistent True the session always active even DS removing or terminate and the session requests DS again until DS Ready or Busy.
## - To Stop Session Not request again to DS or want Delete Session can Delete Session using the Delete Game Session operation
## - If Persistent False the session will be inactive if all member left and DS terminate or removing
## - nativeSessionSetting:
## - XboxSessionTemplateName: the Xbox session template name used to define session join restrictions and max member count during native session sync.
## - XboxServiceConfigID: the XBox service configuration ID.
## - PSNServiceLabel: the PSN service label.
## - SessionTitle: the session title. In PSN, this will be used to define name of the session thats displayed on PlayStation system UI.
## - ShouldSync: to define whether the service needs to do session sync with native platform(s). Default: false (disabled).
## - PSNSupportedPlatforms: the PSN supported platforms. In PSN, if ShouldSync true and PSNSupportedPlatforms is empty, then PS5 will be set as default value.
## - PSNDisableSystemUIMenu: items whose operation from the PSN system software UI is to be disabled.
## - PSNBaseUrl this is for base URL PSN if not set will be default value https://s2s.sp-int.playstation.net. In a single namespace only 1 PSN Env that can be used. Multiple session template should refers to the same PSN Env as we have in IAM Service.
## - https://s2s.sp-int.playstation.net (DEV, need IP Whitelist)
## - https://s2s.prod-qa.playstation.net (QA Environment/PSN Certification)
## - https://s2s.np.playstation.net (Production)
## - localizedSessionName : for localized name and default language
## example value:
## "localizedSessionName":{
## "defaultLanguage" : "en-US"
## "localizedText" :{
## "en-US" : "title"
## }
## }
## - if the game client wants to enable push context to PSN, game client will need to store PSN_PUSH_CONTEXT_ID on the player attributes, otherwise Session service will try to populate from the session attributes or auto generate with random UUID if empty.
## - TieTeamsSessionLifetime: If it is set to true, the lifetime of any partyId session inside teams attribute will be tied to the game session. Only applies when the teams partyId is game session.
## - DisableCodeGeneration (optional, default: false): If it is set to true, code will not be generated for party session automatically.
## - DSManualSetReady (optional, default: false): The DS need to call the specific operation to flag the DS for game session is ready to accept client connection.
## - EnableSecret (optional, default: false): if configuration template is created with TypeDS and EnableSecret is True, A secret will be created.
## - ManualRejoin (optional, default: false): indicates if game client will handle manual rejoin upon websocket reconnection when enabled.
## - DisableResendInvite (optional, default: false): by default, the service will be sending invites until the user reacts to it. enabling this flag will prohibit the service to send reminder invites'.
## - appName (optional, default: empty string). Extend application name that uploaded to AccelByte extends deployment. The application is for custom/external DS management.
## - customURLGRPC (optional: default: empty string). Url for grpc server that server custom/external DS management. This value will be ignore when appName is filled. Value formatted as host:port. Example: yourdomain.com:9989
## - grpcSessionConfig (optional, default: empty object). Setting for grpc session extends. Session service will calls the grpc when any activity for the game sessions.
## - appName (required when customURL is empty) The extends app name that created and uploaded to AccelByte extends deployment.
## - customURL (required when appName is empty) The url for grpc server. Format is host:port. Example: mycustomdomain.com:9889. This will be ignore when appName is filled.
## - functionFlag (optional, default: -1) Flag to enable which function to calls when any event on the game sessions. The value is bitwise integer.
## - 0x1 is for created event. Event is sync, anything returned from the create event overrides the final game session.
## - 0x2 is for updated event. Event is async. Called when any update on the game session.
## - 0x4 is for deleted event. Event is async. Called when a game session is deleted.
## Example:
## - value 3: enable for created and updated
## - value 7: enable for created, updated, and deleted, etc
## - partyCodeGeneratorString (optional, default: 0123456789ABCDEFGHJKMNPQRSTVWXYZ)
## The code is generated by randomly selecting characters from the allowed set, with at least 6 characters long. Allowed characters:
## 0123456789ABCDEFGHJKMNPQRSTVWXYZ (All digits 0â9 and uppercase letters AâZ, excluding I, L, O, and U).
##
## Parameters:
## - name_param: Name of the configuration template to update.
## - namespace_param: Game namespace
func admin_update_configuration_template_v1(
	name_param: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes the named configuration template
## DELETE /session/v1/admin/namespaces/{namespace}/configurations/{name}
##
## Permanently removes the named configuration template from the namespace.
##
## Parameters:
## - name_param: Name of the configuration template to delete.
## - namespace_param: Game namespace
func admin_delete_configuration_template_v1(
	name_param: String, namespace_param: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the active session for a member in a configuration
## GET /session/v1/admin/namespaces/{namespace}/configurations/{name}/memberactivesession/{userId}
##
## Returns the active session for the specified user in the given configuration template.
##
## Parameters:
## - name_param: Name of the configuration template.
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_member_active_session(
	name_param: String, namespace_param: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}/memberactivesession/{userId}"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Reconciles the max active session count for a configuration template
## POST /session/v1/admin/namespaces/{namespace}/configurations/{name}/reconcile
##
## Reconciles the max active session count for the given configuration template.
##
## Parameters:
## - name_param: Name of the configuration template to reconcile.
## - namespace_param: Game namespace
func admin_reconcile_max_active_session(
	name_param: String, namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/configurations/{name}/reconcile"
	url_path = url_path.replace("{" + "name" + "}", name_param.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Lists all game sessions in the namespace
## GET /session/v1/admin/namespaces/{namespace}/gamesessions
##
## Returns all game sessions in the namespace. Supports filtering by configuration, status, joinability, and member. Use offset and limit parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - configuration_name: Configuration template name
## - ds_pod_name: Pod name of a dedicated server
## - from_time: Beginning of game session creation time range in RFC 3339 format e.g. 2022-10-21T07:20:50Z
## - game_mode: Game mode to filter results by.
## - is_persistent: Game session is Persistent. supported: TRUE, FALSE
## - is_soft_deleted: Game session is soft deleted. supported: TRUE, FALSE
## - joinability: Game session joinability to filter. joinability types: OPEN,CLOSED,INVITE_ONLY,FRIENDS_OF_MEMBERS,FRIENDS_OF_LEADER,FRIENDS_OF_FRIENDS
## - limit: Number of results to return
## - match_pool: Matchmaking pool
## - member_id: Member user ID
## - offset: Number of results to skip for pagination
## - order: Order of the result. Supported: desc (default), asc
## - order_by: Order result by specific attribute. Supported: createdAt (default), updatedAt
## - session_id: Game session ID
## - status: Game session status to filter. supported status: NEED_TO_REQUEST,REQUESTED,AVAILABLE,FAILED_TO_REQUEST,DS_ERROR,PREPARING
## - status_v2: Game session status to filter. supported status: NEED_TO_REQUEST,REQUESTED,AVAILABLE,FAILED_TO_REQUEST,UNKNOWN,ENDED,DS_ERROR,PREPARING,DS_CANCELLED
## - to_time: End of game session creation time range in RFC 3339 format e.g. 2022-10-21T07:20:50Z
func admin_query_game_sessions(
	namespace_param: String,
	configuration_name: String = "",
	ds_pod_name: String = "",
	from_time: String = "",
	game_mode: String = "",
	is_persistent: String = "",
	is_soft_deleted: String = "",
	joinability: String = "",
	limit: int = -1,
	match_pool: String = "",
	member_id: String = "",
	offset: int = -1,
	order: String = "",
	order_by: String = "",
	session_id: String = "",
	status: String = "",
	status_v2: String = "",
	to_time: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not configuration_name.is_empty():
		query_params["configurationName"] = configuration_name
	if not ds_pod_name.is_empty():
		query_params["dsPodName"] = ds_pod_name
	if not from_time.is_empty():
		query_params["fromTime"] = from_time
	if not game_mode.is_empty():
		query_params["gameMode"] = game_mode
	if not is_persistent.is_empty():
		query_params["isPersistent"] = is_persistent
	if not is_soft_deleted.is_empty():
		query_params["isSoftDeleted"] = is_soft_deleted
	if not joinability.is_empty():
		query_params["joinability"] = joinability
	if limit >= 0:
		query_params["limit"] = limit
	if not match_pool.is_empty():
		query_params["matchPool"] = match_pool
	if not member_id.is_empty():
		query_params["memberID"] = member_id
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not session_id.is_empty():
		query_params["sessionID"] = session_id
	if not status.is_empty():
		query_params["status"] = status
	if not status_v2.is_empty():
		query_params["statusV2"] = status_v2
	if not to_time.is_empty():
		query_params["toTime"] = to_time
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Queries game sessions using attribute filters
## POST /session/v1/admin/namespaces/{namespace}/gamesessions
##
## Query game sessions by admin.
##
## By default, the service returns a list of available game sessions (joinability: open).
## Session service tracks DS requests to DS providers using these DSInformation status values:
## - NEED_TO_REQUEST: number of active players hasn't reached session's minPlayers, so the service has not yet requested a DS.
## - REQUESTED: the service is requesting a DS from DSMC.
## - PREPARING: DS needs to call manual set ready for the game session
## - AVAILABLE: DS is ready to use. The DSMC status for this DS is either READY/BUSY.
## - FAILED_TO_REQUEST: DSMC fails to spin up a DS for session.
## - DS_ERROR: DS provider fails to spin up the DS or the DS itself becomes unreachable
## - DS_CANCELLED: when DSMC is preparing the DS, DSMC will give a temporary DS. In this phase, deleting the game session cancels the DS request.
## - ENDED: when a game session (match) has finished and DS has done its job, it shuts itself down.
## - UNKNOWN: if any unknown DS status is detected.
## DSInformation has 2 fields for DS status: "status" and "statusV2". The "status" is there for backward-compatibility, therefore we encourage to just rely on "statusV2" for the more updated statuses.
## DS Source can be DSMC, AMS or custom. In DSMC, a DS request is queued when no buffers are available, and DSMC notifies the service when the DS is ready. While AMS doesn't have a concept of queue. Therefore some "DSInformation.statusV2" values apply only to DSMC.
##
## Parameters:
## - namespace_param: Game namespace
func admin_query_game_sessions_by_attributes(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Deletes game sessions in bulk
## DELETE /session/v1/admin/namespaces/{namespace}/gamesessions/bulk
##
## Permanently removes multiple game sessions in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_delete_bulk_game_sessions(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Sets the DS as ready to accept connections
## PUT /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/ds
##
## When ds_manual_set_ready is true in the session template, the DS must call this operation to notify game clients that it accepts connections.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func admin_set_ds_ready(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/ds"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Updates DS information for a game session asynchronous process
## PUT /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/dsinformation
##
## Updates DS information for a game session. Used in the custom DS asynchronous flow and called after the service receives a response from the async RPC.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func admin_update_ds_information(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/dsinformation"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Kicks a member from a game session
## DELETE /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick
##
## Kick member from a game session.
##
## Parameters:
## - member_id: User ID of the member to kick.
## - namespace_param: Game namespace
## - session_id: Game session ID.
func admin_kick_game_session_member(
	member_id: String, namespace_param: String, session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick"
	url_path = url_path.replace("{" + "memberId" + "}", member_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Updates the status of a game session member
## PUT /session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/status/{statusType}
##
## Update a game session member status.
##
## Parameters:
## - member_id: User ID of the game session member.
## - namespace_param: Game namespace
## - session_id: Game session ID.
## - status_type: Member status to set. Valid values: INVITED, REJECTED, JOINED, LEFT. Lowercase values are automatically converted to uppercase.
func admin_update_game_session_member(
	member_id: String, namespace_param: String, session_id: String, status_type: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/status/{statusType}"
	url_path = url_path.replace("{" + "memberId" + "}", member_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "statusType" + "}", status_type.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Lists native sessions in the namespace
## GET /session/v1/admin/namespaces/{namespace}/native-sessions
##
## Returns native platform sessions in the namespace. Use offset and limit parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - offset: Number of results to skip for pagination
## - order: Order of the result by createdAt. Supported: desc (default), asc
func admin_get_list_native_session(
	namespace_param: String, limit: int = -1, offset: int = -1, order: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/native-sessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Queries parties in the namespace
## GET /session/v1/admin/namespaces/{namespace}/parties
##
## Returns parties in the namespace matching the specified criteria. Use offset and limit parameters to paginate results.
##
## Parameters:
## - namespace_param: Game namespace
## - configuration_name: Configuration template name
## - from_time: Beginning of party creation time range in RFC 3339 format e.g. 2022-10-21T07:20:50Z
## - is_soft_deleted: Game session is soft deleted. supported: TRUE, FALSE
## - joinability: Game session joinability to filter. joinability types: OPEN,CLOSED,INVITE_ONLY,FRIENDS_OF_MEMBERS,FRIENDS_OF_LEADER,FRIENDS_OF_FRIENDS
## - key: Attribute key
## - leader_id: User ID of the party leader to filter by.
## - limit: Number of results to return
## - member_id: User ID of the party member to filter by.
## - member_status: Member status to filter by.
## - offset: Number of results to skip for pagination
## - order: Order of the result. Supported: desc (default), asc
## - order_by: Order result by specific attribute. Supported: createdAt (default), updatedAt
## - party_id: Party ID to filter results by.
## - to_time: End of party creation time range in RFC 3339 format e.g. 2022-10-21T07:20:50Z
## - value: Attribute value
func admin_query_parties(
	namespace_param: String,
	configuration_name: String = "",
	from_time: String = "",
	is_soft_deleted: String = "",
	joinability: String = "",
	key: String = "",
	leader_id: String = "",
	limit: int = -1,
	member_id: String = "",
	member_status: String = "",
	offset: int = -1,
	order: String = "",
	order_by: String = "",
	party_id: String = "",
	to_time: String = "",
	value: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/parties"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not configuration_name.is_empty():
		query_params["configurationName"] = configuration_name
	if not from_time.is_empty():
		query_params["fromTime"] = from_time
	if not is_soft_deleted.is_empty():
		query_params["isSoftDeleted"] = is_soft_deleted
	if not joinability.is_empty():
		query_params["joinability"] = joinability
	if not key.is_empty():
		query_params["key"] = key
	if not leader_id.is_empty():
		query_params["leaderID"] = leader_id
	if limit >= 0:
		query_params["limit"] = limit
	if not member_id.is_empty():
		query_params["memberID"] = member_id
	if not member_status.is_empty():
		query_params["memberStatus"] = member_status
	if offset >= 0:
		query_params["offset"] = offset
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not party_id.is_empty():
		query_params["partyID"] = party_id
	if not to_time.is_empty():
		query_params["toTime"] = to_time
	if not value.is_empty():
		query_params["value"] = value
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes parties in bulk
## DELETE /session/v1/admin/namespaces/{namespace}/parties/bulk
##
## Permanently removes multiple parties in a single request.
##
## Parameters:
## - namespace_param: Game namespace
func admin_delete_bulk_parties(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/parties/bulk"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves party session storage
## GET /session/v1/admin/namespaces/{namespace}/parties/{partyId}/storage
##
## Read Party Session Storage by partyID
## Party Storage example:
## ```
## {
## "reserved": {
## "userID1": {"key": "value"},
## "userID2": {"key": "value"},
## ...
## }
## }
## ```
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Party ID of the party to retrieve storage for.
func admin_read_party_session_storage(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/parties/{partyId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves platform credentials for native session sync
## GET /session/v1/admin/namespaces/{namespace}/platform-credentials
##
## Platform credentials for native session synchronization.
## PSN:
## - clientID: Auth Server (Client Credential) ClientID
## - clientSecret: Auth Server (Client Credential) Secret. For security, only the first few characters are visible.
## - scope: should be psn:s2s.service (For Sync non PSN member to PSN Session)
##
## XBOX:
## - namespace: namespace of the configuration
## - businessPartnerCertFileName: name of pfx xbox configuration file
## - businessPartnerCertFileBytes: the pfx configuration file
## - updatedAt: date time of the last record update
## - createdAt: creation date and time of the record
## - createdBy: the actor who trigger the xbox configuration sync
##
## Parameters:
## - namespace_param: Game namespace
func admin_get_platform_credentials(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates platform credentials for native session sync
## PUT /session/v1/admin/namespaces/{namespace}/platform-credentials
##
## Update platform credentials for Native Session sync. Currently supports PSN platform.
## Send an empty body to clear data.
## PSN:
## - clientID: Auth Server (Client Credential) ClientID
## - clientSecret: Auth Server (Client Credential) Secret
## - scope: psn:s2s.service (For Sync non PSN member to PSN Session)
##
## Parameters:
## - namespace_param: Game namespace
func admin_update_platform_credentials(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes all platform credentials for the namespace
## DELETE /session/v1/admin/namespaces/{namespace}/platform-credentials
##
## Delete platform credentials used for Native Session sync.
##
## Parameters:
## - namespace_param: Game namespace
func admin_delete_platform_credentials(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Deletes platform credentials for the specified platform
## DELETE /session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}
##
## Delete platform credentials for specific platform used for Native Session sync. Supported platforms: XBOX, PSN
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func admin_delete_platform_credentials_by_platform_id(
	namespace_param: String, platform_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Syncs platform credentials from the platform service
## PUT /session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/sync
##
## Sync Platform Credentials.
##
## Supported Platforms:
## 1. XBOX
## With this method, the service syncs with the platform to retrieve the existing PFX certificate uploaded through the IAP service.
## If the API returns Not Found, either:
## a. upload PFX file to IAP. You can access it from Admin Portal Admin Portal.
## b. upload PFX file through Session API the Xbox certificate upload operation
## We recommend approach #a, since you need to only upload the file once, and the service will do the sync.
## If you set the PFX through Session service, when you call this operation, the service syncs and replaces the existing PFX file with the one from Platform (IAP).
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
func admin_sync_platform_credentials(namespace_param: String, platform_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Uploads certificates for the Xbox platform
## PUT /session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/upload
##
## Upload certificates for XBox. Certificate must be in the valid form of PFX format.
##
## Parameters:
## - namespace_param: Game namespace
## - platform_id: Third-party platform identifier
## - description: The description of the uploaded file
## - file: The file to upload
## - password: The uploaded file password
func admin_upload_platform_credentials(
	namespace_param: String,
	platform_id: String,
	file: String,
	password: String,
	description: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/platform-credentials/{platformId}/upload"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "platformId" + "}", platform_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Queries recent players for a given user
## GET /session/v1/admin/namespaces/{namespace}/recent-player
##
## Query recent player with given user id.
##
## If user id parameter is empty:
## 1. Using User Token : The service reads the user ID from the token
## 2. Using client token : the service returns an error
##
## Please set the environment variable RECENT_PLAYER_ENABLED to TRUE to use this feature.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - user_id: AccelByte user ID
func admin_get_recent_player(
	namespace_param: String, limit: int = -1, user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/recent-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Queries recent team players for a given user
## GET /session/v1/admin/namespaces/{namespace}/recent-team-player
##
## Query recent player who were on the same team with given user id.
##
## If user id parameter is empty:
## 1. Using User Token : The service reads the user ID from the token
## 2. Using client token : the service returns an error
##
## Please set the environment variable RECENT_TEAM_PLAYER_ENABLED to TRUE to use this feature.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
## - user_id: AccelByte user ID
func admin_get_recent_team_player(
	namespace_param: String, limit: int = -1, user_id: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/recent-team-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not user_id.is_empty():
		query_params["userId"] = user_id
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves session storage for a game session
## GET /session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage
##
## Read Session Storage by sessionID
## Session Storage feature only available for Gamesession
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func admin_read_session_storage(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Deletes session storage for a game session
## DELETE /session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage
##
## Delete Session Storage By sessionID
## Session Storage feature only available for Gamesession
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func admin_delete_user_session_storage(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves session storage for a user
## GET /session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}
##
## Read Session Storage by sessionID and userID
## Session Storage feature only available for Gamesession
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
## - user_id: AccelByte user ID
func admin_read_user_session_storage(
	namespace_param: String, session_id: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves player attributes for a list of users
## GET /session/v1/admin/namespaces/{namespace}/users/attributes
##
## Admin get attributes of players.
##
## Field descriptions:
## - userID : user who owns the attributes.
## - crossplayEnabled : set to true if the player wants to enable crossplay to their session (default: false).
## - platforms : list of the player's 3rd party platform account information.
## - name : platform name. supported platforms: STEAM, XBOX, PSN
## - userID : platform userID
## - data : other data that the player wants to store.
## - PSN_PUSH_CONTEXT_ID: if provided, session will refer to this when performing session sync with PSN, otherwise will populate from session attributes, otherwise will populate from session attributes
## - currentPlatform : latest user game platform.
## - roles : user role for matchmaking role base support.
##
## Parameters:
## - namespace_param: Game namespace
## - users: Comma-separated userIDs
func admin_query_player_attributes(namespace_param: String, users: String = "") -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/users/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not users.is_empty():
		query_params["users"] = users
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves player attributes for a user
## GET /session/v1/admin/namespaces/{namespace}/users/{userId}/attributes
##
## Admin get attributes of a player.
##
## Field descriptions:
## - userID : user who owns the attributes.
## - crossplayEnabled : set to true if the player wants to enable crossplay to their session (default: false).
## - platforms : list of the player's 3rd party platform account information.
## - name : platform name. supported platforms: STEAM, XBOX, PSN
## - userID : platform userID
## - data : other data that the player wants to store.
## - PSN_PUSH_CONTEXT_ID: if provided, session will refer to this when performing session sync with PSN, otherwise will populate from session attributes
## - currentPlatform : latest user game platform.
## - roles : user role for matchmaking role base support.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_get_player_attributes(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/users/{userId}/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Syncs the user's active party session to the native platform
## POST /session/v1/admin/namespaces/{namespace}/users/{userId}/native-sync
##
## Trigger user's active party session to native platform.
##
## Parameters:
## - namespace_param: Game namespace
## - user_id: AccelByte user ID
func admin_sync_native_session(namespace_param: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/admin/namespaces/{namespace}/users/{userId}/native-sync"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Creates a game session
## POST /session/v1/public/namespaces/{namespace}/gamesession
##
## Create a game session.
## Session configuration "name" is mandatory, the service takes the following values from the session template if not provided in the request:
## - type
## - joinability
## - autoJoin. If enabled (set to true), players provided in the request will automatically joined the initial game session creation. Game session will not send any invite and players dont need to act upon it.
## - minPlayers
## - maxPlayers
## - inviteTimeout
## - inactiveTimeout
## - attributes
## - dsSource
## - tieTeamsSessionLifetime
## - matchPool
## - clientVersion
## - deployment
## - serverName
## - textChat
## - autoJoin
## - requestedRegions
## - preferredClaimKeys
## - fallbackClaimKeys
## - customURLGRPC
##
## When the tieTeamsSessionLifetime is true, the lifetime of any partyId inside the teams attribute ties to the game session.
## Only applies when the teams partyId is a game session.
##
## Session has 2 fields for user status: "status" and "statusV2". The "status" is there for backward-compatibility, so we encourage relying on "statusV2" for the more current statuses.
## User statuses:
## 1. INVITED: by default, to join a session (except session with OPEN joinability or if session configuration has "autoJoin" sets to True) a user will receive an invite. The invitee will have the chance to respond within "inviteTimeout" which you can configure through session configuration.
## 2. TIMEOUT: when the service invites a user to a session, the user receives a notification. Unless "disableResendInvite" sets to True in the session configuration, the user will also receive invite reminder every 30s until they respond to the invite.
## 3. REJECTED: when a user rejects an invite. To rejoin an INVITE_ONLY session, they will need to be re-invited and accept the invite.
## 4. JOINED: there are few ways of a user to join a session, by invite, direct join (depends on session joinability) or join by code. upon invite, once a user accepts an invite, their status changes to JOINED.
## 5. LEFT: user can leave a session. in case of party, a user can only be in 1 party at a time. therefore when they decide to create or join another party, they will be automatically removed from their initial party and their status will be changed to LEFT.
## 6. KICKED: only party leader can kick a member.
## 7. DISCONNECTED: if user still have reserved seat in the session and they disconnect lobby websocket, their status in the session will be changed to DISCONNECTED and field the previousStatus field contains the member's status before they disconnected. the user will be given chance to reconnect within "inactiveTimeout" which you can configure through session configuration.
## 8. CONNECTED: when a user reconnect their lobby websocket, their status will change from DISCONNECTED to CONNECTED, only if they previously JOINED session. if they were on INVITED state before the disconnect happened, the user's status will return back to INVITED after they reconnect.
## 9. DROPPED: when "inactiveTimeout" is due and user never re-establish their websocket connection, we will drop them from the session.
## 10. TERMINATED: only applies to game session. If a game session (match) is ended, DS will end/delete the session and we will mark all remaining users' status to be TERMINATED.
## 11. CANCELLED: when a session joinability changes to CLOSED, any remaining invites will be canceled.
##
## User is considered as active if they're present in the session, which their status either CONNECTED or JOINED.
## User has a reserved seat in the session if their status either INVITED, JOINED, CONNECTED, DISCONNECTED. When user's' status change to other than these mentioned statuses, we will release the seat for other players to occupy.
##
## Managing the relation between session and lobby websocket connection:
## - Session relies on lobby to consider player's connection health to our backend. therefore a disruption to lobby websocket will be reflected in the user's status in all of their session(s).
## - If user still have a reserved seat in the session and they disconnect lobby websocket, their status in session(s) will be changed to DISCONNECTED and field the previousStatus field contains the member's status before they disconnected. This The previousStatus field tracks the member's status before disconnect; it clears once they reconnect.
## - If the disconnected user is the leader of the session they're disconnected from, we will wait until "leaderElectionGracePeriod" is due, to promote the next oldest member as the new leader of the session. You can configure "leaderElectionGracePeriod" through session configuration.
## - The user will be given chance to reconnect within "inactiveTimeout" which you can configure through session configuration. If until "inactiveTimeout" is due and the user doesn't reconnect their websocket, they will be removed from session and their status will change to DROPPED. If the dropped user was the leader of the session, we will promote the next oldest member as leader.
## - By default, we will update user's status to what it was before disconnect, when the user reconnects lobby websocket, unless "manualRejoin" sets to True in the session configuration. When "manualRejoin" is enabled, after lobby websocket reconnect, the game client will need to manually invoke join session again to rejoin the session.
## - If the user was on INVITED state before the disconnect happened, the user's status will return back to INVITED after they reconnect.
##
## When the session type is a DS, a DS creation request will be sent if number of active players reaches session's minPlayers.
## Session service has several DSInformation status to track DS request to DS providers:
## - NEED_TO_REQUEST: number of active players hasn't reached session's minPlayers therefore DS has not yet requested.
## - REQUESTED: DS is being requested to DSMC.
## - PREPARING: DS needs to call manual set ready for the game session
## - AVAILABLE: DS is ready to use. The DSMC status for this DS is either READY/BUSY.
## - FAILED_TO_REQUEST: DSMC fails to spin up a DS for session.
## - DS_ERROR: DS provider fails to spin up the DS or the DS itself becomes unreachable
## - DS_CANCELLED: when DSMC is preparing the DS, DSMC will give a temporary DS. In this phase, if you delete the game session, the DS request will be canceled.
## - ENDED: when a game session (match) has finished and DS has done its job, it will terminate itself.
## - UNKNOWN: if any unknown DS status is detected.
## DSInformation has 2 fields for DS status: "status" and "statusV2". The "status" is there for backward-compatibility, so we encourage relying on "statusV2" for the more current statuses.
## DS Source can be DSMC, AMS or custom. In DSMC, a DS request will be put in queue if they dont have available buffers, and DSMC will let the service knows when they finished spinning it up. While AMS doesn't have a concept of queue. Therefore some "DSInformation.statusV2" only applicable for DSMC.
##
## By default, DS requests are sent to DSMC, but if dsSource is set to "AMS":
## - A DS will be requested from AMS instead of DSMC.
## - The server will be chosen based on a set of claim keys, in order of preference, to match with fleets.
## - The claim key list is built build from the preferredClaimKeys, fallbackClaimKeys, and clientVersion as follows:
## [preferredClaimKeys.., clientVersion, fallbackClaimKeys...]
## - ttlHours is how long the session will active, only non persistent can use this, max value is 168 hours
## for session override, refer to the session customization documentation.
##
## Parameters:
## - namespace_param: Game namespace
## - resolve_max_active_session: If true, instead of returning an error when the initial members with status 'JOINED' (AutoJoin) have reached the active session limit, this operation returns success, and those members will become 'INVITED'
func create_game_session(
	namespace_param: String, resolve_max_active_session: bool = false, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesession"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	query_params["resolveMaxActiveSession"] = resolve_max_active_session
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Queries game sessions using attribute filters
## POST /session/v1/public/namespaces/{namespace}/gamesessions
##
## Query game sessions.
##
## By default, the service returns a list of available game sessions (joinability: open).
## Session service tracks DS requests to DS providers using these DSInformation status values:
## - NEED_TO_REQUEST: number of active players hasn't reached session's minPlayers, so the service has not yet requested a DS.
## - REQUESTED: the service is requesting a DS from DSMC.
## - PREPARING: DS needs to call manual set ready for the game session
## - AVAILABLE: DS is ready to use. The DSMC status for this DS is either READY/BUSY.
## - FAILED_TO_REQUEST: DSMC fails to spin up a DS for session.
## - DS_ERROR: DS provider fails to spin up the DS or the DS itself becomes unreachable
## - DS_CANCELLED: when DSMC is preparing the DS, DSMC will give a temporary DS. In this phase, deleting the game session cancels the DS request.
## - ENDED: when a game session (match) has finished and DS has done its job, it shuts itself down.
## - UNKNOWN: if any unknown DS status is detected.
## DSInformation has 2 fields for DS status: "status" and "statusV2". The "status" is there for backward-compatibility, therefore we encourage to just rely on "statusV2" for the more updated statuses.
## DS Source can be DSMC, AMS or custom. In DSMC, a DS request is queued when no buffers are available, and DSMC notifies the service when the DS is ready. While AMS doesn't have a concept of queue. Therefore some "DSInformation.statusV2" values apply only to DSMC.
##
## Parameters:
## - namespace_param: Game namespace
func public_query_game_sessions_by_attributes(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Joins a game session using an invite code
## POST /session/v1/public/namespaces/{namespace}/gamesessions/join/code
##
## Join a session by code. The user can join a session as long as the code is valid
##
## Parameters:
## - namespace_param: Game namespace
func public_session_join_code(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/join/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a game session by server pod name
## GET /session/v1/public/namespaces/{namespace}/gamesessions/servers/{podName}
##
## Retrieves game session details by pod name.
## Session service tracks DS requests to DS providers using these DSInformation status values:
## - NEED_TO_REQUEST: number of active players hasn't reached session's minPlayers, so the service has not yet requested a DS.
## - REQUESTED: the service is requesting a DS from DSMC.
## - PREPARING: DS needs to call manual set ready for the game session
## - AVAILABLE: DS is ready to use. The DSMC status for this DS is either READY/BUSY.
## - FAILED_TO_REQUEST: DSMC fails to spin up a DS for session.
## - DS_ERROR: DS provider fails to spin up the DS or the DS itself becomes unreachable
## - DS_CANCELLED: when DSMC is preparing the DS, DSMC will give a temporary DS. In this phase, deleting the game session cancels the DS request.
## - ENDED: when a game session (match) has finished and DS has done its job, it shuts itself down.
## - UNKNOWN: if any unknown DS status is detected.
## DSInformation has 2 fields for DS status: "status" and "statusV2". The "status" is there for backward-compatibility, therefore we encourage to just rely on "statusV2" for the more updated statuses.
## DS Source can be DSMC, AMS or custom. In DSMC, a DS request is queued when no buffers are available, and DSMC notifies the service when the DS is ready. While AMS doesn't have a concept of queue. Therefore some "DSInformation.statusV2" values apply only to DSMC.
##
## Parameters:
## - namespace_param: Game namespace
## - pod_name: Name of the dedicated server pod.
func get_game_session_by_pod_name(namespace_param: String, pod_name: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/servers/{podName}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "podName" + "}", pod_name.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a game session
## GET /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
##
## Get game session detail.
## Session will only be accessible from active players in the session, and client with the permission, except when joinability is OPEN.
## Session service tracks DS requests to DS providers using these DSInformation status values:
## - NEED_TO_REQUEST: number of active players hasn't reached session's minPlayers, so the service has not yet requested a DS.
## - REQUESTED: the service is requesting a DS from DSMC.
## - PREPARING: DS needs to call manual set ready for the game session
## - AVAILABLE: DS is ready to use. The DSMC status for this DS is either READY/BUSY.
## - FAILED_TO_REQUEST: DSMC fails to spin up a DS for session.
## - DS_ERROR: DS provider fails to spin up the DS or the DS itself becomes unreachable
## - DS_CANCELLED: when DSMC is preparing the DS, DSMC will give a temporary DS. In this phase, deleting the game session cancels the DS request.
## - ENDED: when a game session (match) has finished and DS has done its job, it shuts itself down.
## - UNKNOWN: if any unknown DS status is detected.
## DSInformation has 2 fields for DS status: "status" and "statusV2". The "status" is there for backward-compatibility, therefore we encourage to just rely on "statusV2" for the more updated statuses.
## DS Source can be DSMC, AMS or custom. In DSMC, a DS request is queued when no buffers are available, and DSMC notifies the service when the DS is ready. While AMS doesn't have a concept of queue. Therefore some "DSInformation.statusV2" values apply only to DSMC.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func get_game_session(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a game session
## PUT /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
##
## Updates a game session, this operation overwrites stored game session data.
## To update only specified fields, please use the Patch Game Session operation:
## method : PATCH
## - ttlHours is how long the session remains active, only non persistent can use this, max value is 168 hours
## To update DS attributes (clientVersion, deployment, requestedRegions) these take effect only before any DS request; otherwise the service ignores them.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func update_game_session(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Deletes a game session
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
##
## Permanently removes the specified game session.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func delete_game_session(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Applies partial field updates to the specified game session
## PATCH /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}
##
## Update specified fields from game session data.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func patch_update_game_session(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Updates the backfill ticket ID for a game session
## PUT /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/backfill
##
## Update game session backfill ticket id. Will override game session backfill ticket based on given request parameter
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func update_game_session_backfill_ticket_id(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/backfill"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Generates an invite code for a game session
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code
##
## Generate a new code for the game session. Only leader can generate a code.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func game_session_generate_code(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Revokes the game session invite code
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code
##
## Revoke code of the game session. Only leader can revoke a code.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func public_revoke_game_session_code(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Invites a user to a game session
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/invite
##
## Invite a user to a game session.
## platformID represents the native platform of the invitee. returns the corresponding native platform user ID.
## supported platforms:
## - STEAM
## - XBOX
## - PSN
## Metadata is optional parameter sent with the invitation notification but not permanently stored in the game session.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func public_game_session_invite(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/invite"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Joins a game session
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/join
##
## Adds the current user to the specified game session.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func join_game_session(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/join"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Promotes a member to game session leader
## POST /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leader
##
## Promote game session member to become the new game session leader.
##
## Supported callers:
## - User (game session member) who is the current leader of the game session
## - Game Client
## - Dedicated Server (DS)
##
## Promotes the leader candidate meeting the following criteria:
## - Leader candidate is a member of the game session
## - Leader candidate has a "CONNECTED" or "JOINED" status
## - If the leader candidate is the current leader, then no promotion occurs
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func public_promote_game_session_leader(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Leaves a game session
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leave
##
## Removes the current user from the specified game session.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func leave_game_session(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/leave"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Kicks a member from a game session (leader only)
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick
##
## Kick member from a game session, only leader can kick member.
##
## Parameters:
## - member_id: User ID of the member to kick.
## - namespace_param: Game namespace
## - session_id: Game session ID.
func public_kick_game_session_member(
	member_id: String, namespace_param: String, session_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/members/{memberId}/kick"
	url_path = url_path.replace("{" + "memberId" + "}", member_id.uri_encode())
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Get password of a password-protected game session.
## GET /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/password
##
## Get the plaintext password of a PASSWORD_PROTECTED game session. Only active members of the session may call this endpoint.
##
## Parameters:
## - namespace_param: Namespace
## - session_id: session ID
func public_get_game_session_password(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Update password of a password-protected game session.
## PUT /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/password
##
## Update the password of a PASSWORD_PROTECTED game session. Only the session leader may call this endpoint.
##
## Parameters:
## - namespace_param: Namespace
## - session_id: session ID
func public_update_game_session_password(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Rejects a game session invitation
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/reject
##
## Reject a game session invitation.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func public_game_session_reject(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/reject"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves the server secret for a game session
## GET /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/secret
##
## Returns the session secret for use by the game client
## constraints
## - EnableSecret = true
## - Type = "DS"
## - the service returns a secret only if enableSecret is true and type is DS
##
## if enableSecret = false
## - the service returns an empty secret as 200 OK
##
## Expected caller of this API
## - Game Client to get server secret
##
## In the Response you will get following:
## 200 OK returns the secret string.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
func get_session_server_secret(namespace_param: String, session_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/secret"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Cancels a game session invitation
## DELETE /session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/users/{userId}/cancel
##
## Cancel a game session invitation.
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Game session ID.
## - user_id: AccelByte user ID
func public_game_session_cancel(
	namespace_param: String, session_id: String, user_id: String
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/gamesessions/{sessionId}/users/{userId}/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Joins a party using an invite code
## POST /session/v1/public/namespaces/{namespace}/parties/users/me/join/code
##
## Join a party by code. The user can join a party as long as the code is valid
##
## Parameters:
## - namespace_param: Game namespace
func public_party_join_code(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/users/me/join/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves party details
## GET /session/v1/public/namespaces/{namespace}/parties/{partyId}
##
## Returns details for the specified party, including members and configuration.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Party ID to retrieve.
func public_get_party(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates a party
## PUT /session/v1/public/namespaces/{namespace}/parties/{partyId}
##
## Updates party data, this operation overwrites the stored party data.
##
## Only the party's leader can update the join type.
## To update only specified fields, please use the Patch Party operation:
## method: PATCH
##
## Reserved attributes key:
## 1. preference: used to store preference of the leader and this is non-replaceable to keep the initial behavior of
## the session regardless the leader changes.
## 2. NATIVESESSIONTITLE: used for session sync, to define name of session displayed on PlayStation system UI.
## - ttlHours is how long the session will active, max value is 168 hours
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Party ID to update.
func public_update_party(
	namespace_param: String, party_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Applies partial field updates to the specified party
## PATCH /session/v1/public/namespaces/{namespace}/parties/{partyId}
##
## Update specified fields from party data. Note: Only the party's leader can update the join type.
##
## Reserved attributes key:
## 1. preference: used to store preference of the leader and this is non-replaceable to keep the initial behavior of
## the session regardless the leader changes.
## 2. NATIVESESSIONTITLE: used for session sync, to define name of session displayed on PlayStation system UI.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Party ID to update.
func public_patch_update_party(
	namespace_param: String, party_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Generates an invite code for a party
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/code
##
## Generate a new code for the party. Only leader can generate a code.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Party ID to generate invite code for.
func public_generate_party_code(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Revokes the party invite code
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/code
##
## Revoke code of the party. Only leader can revoke a code.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Party ID to revoke invite code for.
func public_revoke_party_code(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/code"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Invites a user to a party
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/invite
##
## Invite a user to a party.
## platformID represents the native platform of the invitee. returns the corresponding native platform user ID.
## supported platforms:
## - STEAM
## - XBOX
## - PSN
## Metadata is optional parameter sent with the invitation notification but not permanently stored in the party.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Party ID to invite the user to.
func public_party_invite(
	namespace_param: String, party_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/invite"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Promotes a new party leader for the specified party
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/leader
##
## Promotes a party member to be a party leader. Only leader can promote a new leader.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
func public_promote_party_leader(
	namespace_param: String, party_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Get password of a password-protected party.
## GET /session/v1/public/namespaces/{namespace}/parties/{partyId}/password
##
## Get the plaintext password of a PASSWORD_PROTECTED party. Only active members of the party may call this endpoint.
##
## Parameters:
## - namespace_param: Namespace
## - party_id: Party ID
func public_get_party_password(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Update password of a password-protected party.
## PUT /session/v1/public/namespaces/{namespace}/parties/{partyId}/password
##
## Update the password of a PASSWORD_PROTECTED party. Only the party leader may call this endpoint.
##
## Parameters:
## - namespace_param: Namespace
## - party_id: Party ID
func public_update_party_password(
	namespace_param: String, party_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/password"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Retrieves the party session storage data
## GET /session/v1/public/namespaces/{namespace}/parties/{partyId}/storage
##
## Read Party Session Storage by partyID (with reserved and member).
## Contains "reserved" when Update Insert Party Session Reserved Storage User.
## Contains "member" when Update Insert Party Session Storage User.
## Party Storage example:
## ```
## {
## "reserved": {
## "userID1": {"key": "value"},
## "userID2": {"key": "value"},
## ...
## },
## "member": {
## "userID1": {"key": "value"},
## "userID2": {"key": "value"},
## ...
## }
## }
## ```
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
func public_read_party_session_storage(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/storage"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates or inserts party session storage data for the specified user
## PATCH /session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}
##
## Update Insert Party Session Storage User. User can only update or insert their own party storage (non-immutable).
## can store generic json
## example json can store :
## ```
## {
## "key": "value",
## "number": 123,
## }
## ```
## The service stores the data in the "member" storage field
## example stored data :
## ```
## {
## "member": {
## "userID1": {"key": "value"},
## "userID2": {"key": "value"},
## ...
## }
## }
## ```
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
## - user_id: AccelByte user ID
func public_update_insert_party_session_storage(
	namespace_param: String, party_id: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Updates or inserts reserved party session storage data for the specified user
## PATCH /session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}/reserved
##
## **For Internal Use Only**
## Update Insert Party Session Reserved Storage User. User can only update or insert their own reserve storage (non-immutable).
## can store generic json
## example json can store :
## ```
## {
## "key": "value",
## "number": 123,
## }
## ```
## The service stores the data in the "reserved" storage field
## example stored data :
## ```
## {
## "reserved": {
## "userID1": {"key": "value"},
## "userID2": {"key": "value"},
## ...
## }
## }
## ```
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
## - user_id: AccelByte user ID
func public_update_insert_party_session_storage_reserved(
	namespace_param: String, party_id: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/storage/users/{userId}/reserved"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Joins a party by invitation or open joinability
## POST /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/join
##
## Join a party. The user can join a party by accepting an invitation, or join any party with an "open" joinable setting.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
func public_party_join(
	namespace_param: String, party_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/join"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Leaves the specified party
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/leave
##
## Removes the current user from the specified party.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
func public_party_leave(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/leave"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Rejects an invitation to the specified party
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/reject
##
## Rejects a pending invitation to the specified party for the current user.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
func public_party_reject(namespace_param: String, party_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/me/reject"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Cancels a pending invitation for the specified user
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/cancel
##
## Cancels a pending party invitation for the specified user.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
## - user_id: AccelByte user ID
func public_party_cancel(namespace_param: String, party_id: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/cancel"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Kicks the specified player from the party
## DELETE /session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/kick
##
## Kick a player from a party. Requires invoker to be the party leader.
##
## Parameters:
## - namespace_param: Game namespace
## - party_id: Unique identifier of the party, in UUID format.
## - user_id: AccelByte user ID
func public_party_kick(namespace_param: String, party_id: String, user_id: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/parties/{partyId}/users/{userId}/kick"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "partyId" + "}", party_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Creates a new party and adds the requester as leader
## POST /session/v1/public/namespaces/{namespace}/party
##
## The service generates a join code automatically when the party is joinable.
##
## A user can be in 1 party at a time, so the service removes the requester from their previous party (if any) and adds them to this newly created party as leader.
##
## Session configuration name is optional.
## Default configuration name if empty:
## {
## "name": "default",
## "type": "NONE",
## "joinability": "OPEN",
## "minPlayers": 1,
## "maxPlayers": 8,
## "inviteTimeout": 60,
## "inactiveTimeout": 60,
## "textChat": false
## }
## When the caller provides a session configuration name, the service refers to the template for these empty fields:
## - textChat
## - minPlayers
## - maxPlayers
## - inviteTimeout
## - inactiveTimeout
## - type
## - joinability
## - configurationName
## - attributes
##
## Supported platforms:
## 1. STEAM
## 2. PSN
## 3. XBOX
##
## Reserved attributes key:
## 1. preference: used to store preference of the leader and this is non-replaceable and keeps the initial behavior of
## the session regardless the leader changes.
## 2. NATIVESESSIONTITLE: used for session sync, to define name of session displayed on PlayStation system UI.
##
## Session has 2 fields for user status: "status" and "statusV2". The "status" is there for backward-compatibility, therefore we encourage to just rely on "statusV2" for the more updated statuses.
##
## User statuses:
## 1. INVITED: by default, to join a session (except session with OPEN joinability or if session configuration has "autoJoin" sets to True) a user will receive an invite. The invitee will have the chance to respond within "inviteTimeout" which you can configure through session configuration.
## 2. TIMEOUT: when a user is invited to a session, they will receive an invite. Unless "disableResendInvite" sets to True in the session configuration, the user will also receive invite reminder every 30s until they respond to the invite.
## 3. REJECTED: when a user rejects an invite. To rejoin an INVITE_ONLY session, they will need to be re-invited and accept the invite.
## 4. JOINED: there are few ways of a user to join a session, by invite, direct join (depends on session joinability) or join by code. upon invite, once a user accepts an invite, their status will be changed to JOINED.
## 5. LEFT: user can leave a session. in case of party, a user can only be in 1 party at a time. therefore when they decide to create or join another party, they will be automatically removed from their initial party and their status will be changed to LEFT.
## 6. KICKED: only party leader can kick a member.
## 7. DISCONNECTED: if user still have reserved seat in the session and they disconnect lobby websocket, their status in the session will be changed to DISCONNECTED and field "members.previousStatus" of that user will contains the initial status before they disconnect lobby websocket. the user will be given chance to reconnect within "inactiveTimeout" which you can configure through session configuration.
## 8. CONNECTED: when a user reconnect their lobby websocket, their status will change from DISCONNECTED to CONNECTED, only if they previously JOINED session. if they were on INVITED state before the disconnect happened, the user's status will return back to INVITED after they reconnect.
## 9. DROPPED: when "inactiveTimeout" is due and user never re-establish their websocket connection, we will drop them from the session.
## 10. TERMINATED: only applies to game session. If a game session (match) is ended, DS will end/delete the session and we will mark all remaining users' status to be TERMINATED.
## 11. CANCELLED: when a session joinability changes to CLOSED, any remaining invites will be canceled.
##
## User is considered as active if they're present in the session, which their status either CONNECTED or JOINED.
## User has a reserved seat in the session if their status either INVITED, JOINED, CONNECTED, DISCONNECTED. When user's' status change to other than these mentioned statuses, we will release the seat for other players to occupy.
##
## Managing the relation between session and lobby websocket connection:
## - Session relies on lobby to consider player's connection health to our backend. therefore a disruption to lobby websocket will be reflected in the user's status in all of their session(s).
## - If user still have a reserved seat in the session and they disconnect lobby websocket, their status in session(s) will be changed to DISCONNECTED and field "members.previousStatus" of that user will contains the initial status before they disconnect lobby websocket. This "members.previousStatus" used to track user's previous status before they disconnect websocket, since we still reserve a seat for them, therefore this field will be empty again after they websocket.
## - If the disconnected user is the leader of the session they're disconnected from, we will wait until "leaderElectionGracePeriod" is due, to promote the next oldest member as the new leader of the session. You can configure "leaderElectionGracePeriod" through session configuration.
## - The user will be given chance to reconnect within "inactiveTimeout" which you can configure through session configuration. If until "inactiveTimeout" is due and the user doesn't reconnect their websocket, they will be removed from session and their status will change to DROPPED. If the dropped user was the leader of the session, we will promote the next oldest member as leader.
## - By default, we will update user's status to what it was before disconnect, when the user reconnects lobby websocket, unless "manualRejoin" sets to True in the session configuration. When "manualRejoin" is enabled, after lobby websocket reconnect, the game client will need to manually invoke join session again to rejoin the session.
## - If the user was on INVITED state before the disconnect happened, the user's status will return back to INVITED after they reconnect.
## - ttlHours is how long the session will active, max value is 168 hours
##
## Parameters:
## - namespace_param: Game namespace
func public_create_party(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/party"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves a list of the user's recent players
## GET /session/v1/public/namespaces/{namespace}/recent-player
##
## Query user's recent player.
##
## Please set the environment variable "RECENT_PLAYER_ENABLED" to "TRUE" to enable this feature.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
func public_get_recent_player(namespace_param: String, limit: int = -1) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/recent-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a list of the user's recent players from the same team
## GET /session/v1/public/namespaces/{namespace}/recent-team-player
##
## Query user's recent player who were on the same team.
##
## Please set the environment variable "RECENT_TEAM_PLAYER_ENABLED" to "TRUE" to enable this feature.
##
## Parameters:
## - namespace_param: Game namespace
## - limit: Number of results to return
func public_get_recent_team_player(namespace_param: String, limit: int = -1) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/recent-team-player"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if limit >= 0:
		query_params["limit"] = limit
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Updates or inserts session storage data for the session leader
## PATCH /session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader
##
## Update Insert Session Storage Leader. only Leader can update or insert user session storage data Leader.
## can store generic json
## example json can store :
## {
## "leader": {
## "leader": 1
## },
## "data": 123
## }
## game Admin can update or insert session storage
## Session Storage feature only available for Gamesession
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Unique identifier of the game session, in UUID format.
func public_update_insert_session_storage_leader(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Updates or inserts session storage data for the specified user
## PATCH /session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}
##
## Update Insert Session Storage User. user can only update or insert user session storage data itself.
## can store generic json
## example json can store :
## {
## "storage": {
## "storage": 1
## },
## "data": 123
## }
## game Admin can update or insert session storage
## Session Storage feature only available for Gamesession
##
## Parameters:
## - namespace_param: Game namespace
## - session_id: Unique identifier of the game session, in UUID format.
## - user_id: AccelByte user ID
func public_update_insert_session_storage(
	namespace_param: String, session_id: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Retrieves the current platform for a list of players
## POST /session/v1/public/namespaces/{namespace}/users/bulk/platform
##
## Get bulk players current platform.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_bulk_player_current_platform(
	namespace_param: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/bulk/platform"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Retrieves the current user's player attributes
## GET /session/v1/public/namespaces/{namespace}/users/me/attributes
##
## Get player attributes.
##
## Field descriptions:
## - userID : user who owns the attributes.
## - crossplayEnabled : set to true if the player wants to enable crossplay to their session (default: false).
## - platforms : list of the player's 3rd party platform account information.
## - name : platform name. supported platforms: STEAM, XBOX, PSN
## - userID : platform userID
## - data : other data that the player wants to store.
## - PSN_PUSH_CONTEXT_ID: if provided, session will refer to this when performing session sync with PSN, otherwise will populate from session attributes
## - currentPlatform : latest user game platform.
## - roles : user role for matchmaking role base support.
##
## Parameters:
## - namespace_param: Game namespace
func public_get_player_attributes(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Saves the current user's player attributes
## POST /session/v1/public/namespaces/{namespace}/users/me/attributes
##
## Behaves to upsert player's attributes.
##
## Field descriptions:
## - userID : user who owns the attributes.
## - crossplayEnabled : set to true if the player wants to enable crossplay to their session (default: false).
## - platforms : list of the player's 3rd party platform account information.
## - name : platform name. supported platforms: STEAM, XBOX, PSN
## - userID : platform userID
## - data : other data that the player wants to store.
## - PSN_PUSH_CONTEXT_ID: if provided, session will refer to this when performing session sync with PSN, otherwise will populate from session attributes
## - currentPlatform : latest user game platform.
## - roles : user role for matchmaking role base support.
##
## Parameters:
## - namespace_param: Game namespace
func public_store_player_attributes(namespace_param: String, body: Dictionary = {}) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.POST, headers, request_body)


## Removes the current user's player attributes
## DELETE /session/v1/public/namespaces/{namespace}/users/me/attributes
##
## Removes all player attributes for the current user, resetting them to defaults.
##
## Parameters:
## - namespace_param: Game namespace
func public_delete_player_attributes(namespace_param: String) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/attributes"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.DELETE, headers, request_body)


## Retrieves a list of the current user's game sessions
## GET /session/v1/public/namespaces/{namespace}/users/me/gamesessions
##
## Query user's game sessions.
## By default, the API returns a list of the user's active game sessions (INVITED,JOINED,CONNECTED).
##
## Session service tracks DS requests to DS providers using these DSInformation status values:
## - NEED_TO_REQUEST: number of active players hasn't reached session's minPlayers, so the service has not yet requested a DS.
## - REQUESTED: the service is requesting a DS from DSMC.
## - PREPARING: DS needs to call manual set ready for the game session
## - AVAILABLE: DS is ready to use. The DSMC status for this DS is either READY/BUSY.
## - FAILED_TO_REQUEST: DSMC fails to spin up a DS for session.
## - DS_ERROR: DS provider fails to spin up the DS or the DS itself becomes unreachable
## - DS_CANCELLED: when DSMC is preparing the DS, DSMC will give a temporary DS. In this phase, if you delete the game session, the service cancels the DS request.
## - ENDED: when a game session (match) has finished and DS has done its job, it will terminate itself.
## - UNKNOWN: if any unknown DS status is detected.
## DSInformation has 2 fields for DS status: "status" and "statusV2". The "status" is there for backward-compatibility, therefore we encourage to just rely on "statusV2" for the more updated statuses.
## DS Source can be DSMC, AMS or custom. In DSMC, a DS request will be put in queue if they dont have available buffers, and DSMC will let the service knows when they finished spinning it up. While AMS doesn't have a concept of queue. Therefore some "DSInformation.statusV2" only applicable for DSMC.
##
## Parameters:
## - namespace_param: Game namespace
## - order: Order of the result. Supported: desc (default), asc
## - order_by: Order result by specific attribute. Supported: createdAt (default), updatedAt
## - status: Game session status to filter. supported status: INVITED,JOINED,CONNECTED
func public_query_my_game_sessions(
	namespace_param: String, order: String = "", order_by: String = "", status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/gamesessions"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Retrieves a list of the current user's parties
## GET /session/v1/public/namespaces/{namespace}/users/me/parties
##
## Query user's parties. By default, API will return a list of user's active parties.
##
## Parameters:
## - namespace_param: Game namespace
## - order: Order of the result. Supported: desc (default), asc
## - order_by: Order result by specific attribute. Supported: createdAt (default), updatedAt
## - status: User status to filter. supported status: INVITED,JOINED,CONNECTED,DISCONNECT
func public_query_my_parties(
	namespace_param: String, order: String = "", order_by: String = "", status: String = ""
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v1/public/namespaces/{namespace}/users/me/parties"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	# Build query parameters
	var query_params: Dictionary = {}
	if not order.is_empty():
		query_params["order"] = order
	if not order_by.is_empty():
		query_params["orderBy"] = order_by
	if not status.is_empty():
		query_params["status"] = status
	if not query_params.is_empty():
		url_path += "?" + AccelbyteHttp.build_query_string(query_params)
	var url: String = _service_url + url_path
	var request_body: String = ""
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.GET, headers, request_body)


## Replace entire Session Storage Leader.
## PUT /session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader
##
## Replace entire Session Storage Leader with the request body. No merging is performed.
##
## Leader (regular token): Only the session leader can replace leader storage. Complete replacement.
## Game Admin (client token): Can replace leader storage. Complete replacement.
##
## PUT semantics: The request body completely replaces the existing storage, no partial updates.
## Leader storage is separate from per-user storage and identified by session context, not userID.
## Example request:
## {
## "gameState": {"round": "2"},
## "difficulty": "hard"
## }
##
## Session Storage feature only available for Gamesession.
##
## Parameters:
## - namespace_param: Namespace
## - session_id: sessionID
func public_replace_session_storage_leader_v2(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Update partial Session Storage Leader.
## PATCH /session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader
##
## Update partial Session Storage Leader. Performs selective merge with existing leader storage data.
##
## Leader (regular token): Only the session leader can update leader storage. Merges patch with existing data, nil values delete keys.
## Game Admin (client token): Can update leader storage. Merges patch with existing data, nil values delete keys.
##
## Deep merge: Nested objects are recursively merged, not replaced. Absent keys in patch are preserved in storage.
## Leader storage is separate from per-user storage and identified by session context, not userID.
## Example patch:
## {
## "gameState": {"round": "2"},
## "difficulty": null
## }
##
## Session Storage feature only available for Gamesession.
##
## Parameters:
## - namespace_param: Namespace
## - session_id: sessionID
func public_update_insert_session_storage_leader_v2(
	namespace_param: String, session_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/leader"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)


## Replace entire Session Storage User.
## PUT /session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}
##
## Replace entire Session Storage User with the request body. No merging is performed.
##
## User (regular token): Can only replace own user session storage. Complete replacement.
## Game Admin (client token): Can replace any user's session storage. Complete replacement.
##
## PUT semantics: The request body completely replaces the existing storage, no partial updates.
## Example request:
## {
## "weapon": "sword",
## "armor": "leather"
## }
##
## Session Storage feature only available for Gamesession.
##
## Parameters:
## - namespace_param: Namespace
## - session_id: sessionID
## - user_id: userID
func public_replace_session_storage_user_v2(
	namespace_param: String, session_id: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PUT, headers, request_body)


## Update partial Session Storage User.
## PATCH /session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}
##
## Update partial Session Storage User. Performs selective merge with existing storage data.
##
## User (regular token): Can only update own user session storage. Merges patch with existing data, nil values delete keys.
## Game Admin (client token): Can update any user's session storage. Merges patch with existing data, nil values delete keys.
##
## Deep merge: Nested objects are recursively merged, not replaced. Absent keys in patch are preserved in storage.
## Example patch:
## {
## "weapon": "sword",
## "level": null
## }
##
## Session Storage feature only available for Gamesession.
##
## Parameters:
## - namespace_param: Namespace
## - session_id: sessionID
## - user_id: userID
func public_update_insert_session_storage_user_v2(
	namespace_param: String, session_id: String, user_id: String, body: Dictionary = {}
) -> Dictionary:
	# Build URL path
	var url_path: String = "/session/v2/public/namespaces/{namespace}/sessions/{sessionId}/storage/users/{userId}"
	# Use namespace parameter with fallback to configured namespace
	var ns = namespace_param if not namespace_param.is_empty() else _namespace
	url_path = url_path.replace("{namespace}", ns.uri_encode())
	url_path = url_path.replace("{" + "sessionId" + "}", session_id.uri_encode())
	url_path = url_path.replace("{" + "userId" + "}", user_id.uri_encode())
	var url: String = _service_url + url_path
	var request_body: String = JSON.stringify(body)
	var headers: PackedStringArray = AccelbyteHttp.get_bearer_headers(_auth_token)
	return await _http.request(url, AccelbyteHttp.Method.PATCH, headers, request_body)
