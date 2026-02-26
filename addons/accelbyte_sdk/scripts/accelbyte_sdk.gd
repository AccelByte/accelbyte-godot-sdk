## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_sdk.gd
## Generated AccelByte SDK facade (pure GDScript, all platforms)
## DO NOT EDIT - This file is auto-generated
## =============================================================================
##
## Usage:
##   var sdk = AccelByteSDKWrapper.new()
##   sdk.initialize(self)  # Pass a Node for scene tree access
##   sdk.set_base_url("https://demo.accelbyte.io")
##   sdk.set_client_credentials("your-client-id", "your-secret")
##   sdk.set_namespace("your-namespace")
##
##   # Login (tokens are stored automatically):
##   var result = await sdk.get_service(IamService).token_grant_v3("password", ...)
##
##   # Logout (tokens are cleared automatically):
##   await sdk.get_service(IamService).token_revocation_v3(sdk.get_access_token())
##
##   # Custom service (no facade change needed):
##   var result = await sdk.get_service(CustomIamService).my_endpoint(...)
##
##   # Adding a new service: just drop its .gd file in scripts/ and
##   # regenerate this facade with: make aggregate
## =============================================================================

class_name AccelByteSDK
extends RefCounted

## Shared HTTP client (used by all services)
var _http: AccelbyteHttp

## SDK configuration
var _settings: AccelByteSettings

## Token storage
var _tokens: AccelByteTokenStore

## Scene root node (for HTTPRequest attachment)
var _scene_root: Node

## WebSocket transport (for lobby/chat)
var _ws_transport: AccelByteWsTransport

## Lobby WebSocket service (typed methods + signals for all lobby message types)
var _lobby_ws_service: LobbyWsService

## Service registry — lazy-created on first get_service() call.
## Key: script resource path (stable unique identifier per class).
## Value: service instance (RefCounted).
var _service_registry: Dictionary = {}

## Emitted when the lobby WebSocket connection is established.
signal lobby_connected(data: Dictionary)

## Emitted when the lobby WebSocket connection is lost or closed.
signal lobby_disconnected(data: Dictionary)

## Emitted when the access token is successfully refreshed.
signal token_refreshed

## Emitted when token refresh fails permanently (max retries exceeded).
signal token_refresh_failed

## Emitted when the user session has expired and re-authentication is required.
## This is emitted after token_refresh_failed when tokens are cleared.
signal session_expired

# =============================================================================
# Token Refresh State
# =============================================================================

## Whether a token refresh is currently in-flight (prevents concurrent refreshes).
var _refresh_in_progress: bool = false

## Number of consecutive refresh failures (for exponential backoff).
var _refresh_retry_count: int = 0

## Delay before next refresh retry, in milliseconds.
## Starts at 1000ms, doubles each retry, capped at 3 600 000ms (1 hour).
## Matches the Unity SDK LoginSessionMaintainer backoff strategy.
var _refresh_retry_delay_ms: int = 0

## Uptime timestamp (ms) when the next retry may be attempted.
var _refresh_retry_at_ms: int = 0

## Maximum consecutive refresh failures before giving up and emitting token_refresh_failed.
## After this many failures the refresh poller stops — the game must re-authenticate.
const _REFRESH_MAX_RETRIES: int = 10

## Initial retry backoff (ms).
const _REFRESH_BACKOFF_INITIAL_MS: int = 1000

## Maximum retry backoff (ms) — 1 hour, matching Unity SDK cap.
const _REFRESH_BACKOFF_MAX_MS: int = 3600000

## Poll node that drives the token refresh background check.
var _refresh_poll_node: Node


# =============================================================================
# Initialization
# =============================================================================

## Initialize the SDK.
## Pass a Node (e.g. self) so the SDK can create HTTPRequest children.
func initialize(scene_root: Node = null) -> void:
	_scene_root = scene_root

	# Create shared utilities
	_http = AccelbyteHttp.new()
	if _scene_root:
		_http.initialize(_scene_root)

	_settings = AccelByteSettings.new()
	_tokens = AccelByteTokenStore.new()

	# Set global settings reference for secure OAuth credential retrieval
	_http.set_global_settings(_settings)

	# Create WebSocket transport and lobby service
	_ws_transport = AccelByteWsTransport.new()
	if _scene_root:
		_ws_transport.initialize(_scene_root)
	# Set token lifetime callback for security warnings
	_ws_transport.set_token_lifetime_callback(Callable(_tokens, "get_remaining_lifetime_seconds"))
	_lobby_ws_service = LobbyWsService.new(_ws_transport)

	# Forward lobby transport signals to SDK facade
	_ws_transport.connected.connect(func(data): lobby_connected.emit(data))
	_ws_transport.disconnected.connect(func(reason): lobby_disconnected.emit({"message": reason}))

	# Start the background token refresh poller
	_start_token_refresh_poller()


# =============================================================================
# Service Registry
#
# get_service() is the canonical way to access any service — built-in or custom.
# Services are lazy-created on first access and cached for the lifetime of the SDK.
#
# Usage:
#   var result = await sdk.get_service(IamService).token_grant_v3(...)
#   var result = await sdk.get_service(CustomIamService).my_endpoint(...)
# =============================================================================

## Get or create a service instance by its script class.
## The service is lazy-created on first call and cached thereafter.
func get_service(service_class) -> RefCounted:
	# Special case: LobbyWsService is pre-created and uses WebSocket transport
	if service_class.resource_path.get_file().begins_with("lobby_ws_service"):
		return _lobby_ws_service

	var key: String = service_class.resource_path
	# Fallback for runtime-created classes with empty resource_path
	if key.is_empty():
		key = "runtime:" + str(service_class)
	if not _service_registry.has(key):
		var svc: RefCounted = service_class.new()
		svc.initialize(_http)
		svc.set_base_url(_settings.base_url)
		# Auto-read Extend app service URL from project.godot if configured.
		# Convention: [accelbyte] section, key = {file_stem}_url
		# where file_stem is the service script name without the _service.gd suffix.
		# Example: guild_service.gd -> accelbyte/extend/guild_url
		# To override manually (higher priority), call set_service_url() after get_service():
		#   sdk.get_service(GuildService).set_service_url("https://my-studio.accelbyte.io/guild-app")
		var _stem: String = key.get_file().get_basename().trim_suffix("_service")
		var _extend_url: String = ProjectSettings.get_setting("accelbyte/extend/" + _stem + "_url", "")
		svc.set_service_url(_extend_url if not _extend_url.is_empty() else _settings.base_url)
		svc.set_namespace(_settings.game_namespace)
		svc.set_auth_token(_tokens.access_token)
		svc.set_client_id(_settings.client_id)
		svc.set_token_callback(Callable(self, "_on_token_grant"))
		svc.set_revoke_callback(Callable(self, "_on_token_revoke"))
		_service_registry[key] = svc
	return _service_registry[key]


# =============================================================================
# Configuration - Setters
# =============================================================================

func set_base_url(url: String) -> void:
	_settings.base_url = url
	if _settings.base_url.ends_with("/"):
		_settings.base_url = _settings.base_url.substr(0, _settings.base_url.length() - 1)
	# Auto-derive lobby/chat WebSocket URLs if not manually overridden.
	if _settings.lobby_url.is_empty():
		var ws_base = _settings.base_url.replace("https://", "wss://")
		_settings.lobby_url = ws_base + "/lobby/"
	if _settings.chat_url.is_empty():
		var ws_base = _settings.base_url.replace("https://", "wss://")
		_settings.chat_url = ws_base + "/chat/"
	_propagate_settings()


func set_lobby_url(url: String) -> void:
	_settings.lobby_url = url


func set_chat_url(url: String) -> void:
	_settings.chat_url = url


func set_client_id(id: String) -> void:
	_settings.client_id = id
	_propagate_settings()


func set_client_secret(secret: String) -> void:
	_settings.set_client_secret(secret)
	_propagate_settings()


func set_client_credentials(client_id: String, client_secret: String) -> void:
	_settings.client_id = client_id
	_settings.set_client_secret(client_secret)
	_propagate_settings()


func set_publisher_credentials(publisher_id: String, publisher_secret: String) -> void:
	_settings.publisher_id = publisher_id
	_settings.set_publisher_secret(publisher_secret)


func set_publisher_id(publisher_id: String) -> void:
	_settings.publisher_id = publisher_id


func set_publisher_secret(publisher_secret: String) -> void:
	_settings.set_publisher_secret(publisher_secret)


func set_publisher_namespace(publisher_namespace: String) -> void:
	_settings.publisher_namespace = publisher_namespace


func set_namespace(ns: String) -> void:
	_settings.game_namespace = ns
	_propagate_settings()


# =============================================================================
# Configuration - Getters
# =============================================================================

func get_base_url() -> String:
	return _settings.base_url


func get_lobby_url() -> String:
	return _settings.lobby_url


func get_chat_url() -> String:
	return _settings.chat_url


func get_client_id() -> String:
	return _settings.client_id


## DEPRECATED: Removed for security reasons. Client secrets should not be exposed via public API.
## Use set_client_credentials() for write-only access.
func get_client_secret() -> String:
	push_error("[AccelByteSDK] SECURITY: get_client_secret() is deprecated and will be removed. Client secrets should not be readable at runtime.")
	return ""


func get_publisher_id() -> String:
	return _settings.publisher_id


## DEPRECATED: Removed for security reasons. Publisher secrets should not be exposed via public API.
## Use set_publisher_credentials() for write-only access.
func get_publisher_secret() -> String:
	push_error("[AccelByteSDK] SECURITY: get_publisher_secret() is deprecated and will be removed. Publisher secrets should not be readable at runtime.")
	return ""


func get_publisher_namespace() -> String:
	return _settings.publisher_namespace


func get_namespace() -> String:
	return _settings.game_namespace


func get_sdk_version() -> String:
	return "0.0.28"


# =============================================================================
# Authentication State
# =============================================================================

## Manually set auth tokens (rarely needed — tokens are auto-managed).
func set_auth_tokens(access_token: String, refresh_token: String, user_id: String, expires_in: int = 3600, endpoint_url: String = "") -> void:
	_tokens.set_tokens(access_token, refresh_token, user_id, expires_in, endpoint_url)
	_propagate_auth()
	# Update WebSocket transport for future reconnections
	if _ws_transport:
		_ws_transport.set_auth_token(access_token)


## Get current access token
func get_access_token() -> String:
	return _tokens.access_token



## Get current user ID
func get_user_id() -> String:
	return _tokens.user_id


## Check if user is logged in
func is_logged_in() -> bool:
	return _tokens.is_logged_in()


## Get the token store instance (for internal SDK use and security warnings).
## This is used by WebSocket transport to check token lifetime.
func get_token_store() -> AccelByteTokenStore:
	return _tokens


## Check if access token has expired
func is_token_expired() -> bool:
	return _tokens.is_expired()


## Get HTTP logging setting (for internal SDK components)
func is_http_logging_enabled() -> bool:
	return _settings.enable_http_logging if _settings else false


# =============================================================================
# Typed Service Accessors (deprecated — use get_service() instead)
#
# These exist for backwards compatibility and IDE autocomplete.
# Prefer: sdk.get_service(IamService)
# =============================================================================
## @deprecated Use sdk.get_service(AchievementService) instead.
func get_achievement_service() -> AchievementService:
	return get_service(AchievementService) as AchievementService

## @deprecated Use sdk.get_service(AmsService) instead.
func get_ams_service() -> AmsService:
	return get_service(AmsService) as AmsService

## @deprecated Use sdk.get_service(BasicService) instead.
func get_basic_service() -> BasicService:
	return get_service(BasicService) as BasicService

## @deprecated Use sdk.get_service(BuildinfoService) instead.
func get_buildinfo_service() -> BuildinfoService:
	return get_service(BuildinfoService) as BuildinfoService

## @deprecated Use sdk.get_service(ChallengeService) instead.
func get_challenge_service() -> ChallengeService:
	return get_service(ChallengeService) as ChallengeService

## @deprecated Use sdk.get_service(ChatService) instead.
func get_chat_service() -> ChatService:
	return get_service(ChatService) as ChatService

## @deprecated Use sdk.get_service(CloudsaveService) instead.
func get_cloudsave_service() -> CloudsaveService:
	return get_service(CloudsaveService) as CloudsaveService

## @deprecated Use sdk.get_service(CsmService) instead.
func get_csm_service() -> CsmService:
	return get_service(CsmService) as CsmService

## @deprecated Use sdk.get_service(DifferService) instead.
func get_differ_service() -> DifferService:
	return get_service(DifferService) as DifferService

## @deprecated Use sdk.get_service(EventlogService) instead.
func get_eventlog_service() -> EventlogService:
	return get_service(EventlogService) as EventlogService

## @deprecated Use sdk.get_service(GametelemetryService) instead.
func get_gametelemetry_service() -> GametelemetryService:
	return get_service(GametelemetryService) as GametelemetryService

## @deprecated Use sdk.get_service(GdprService) instead.
func get_gdpr_service() -> GdprService:
	return get_service(GdprService) as GdprService

## @deprecated Use sdk.get_service(GroupService) instead.
func get_group_service() -> GroupService:
	return get_service(GroupService) as GroupService

## @deprecated Use sdk.get_service(IamService) instead.
func get_iam_service() -> IamService:
	return get_service(IamService) as IamService

## @deprecated Use sdk.get_service(InventoryService) instead.
func get_inventory_service() -> InventoryService:
	return get_service(InventoryService) as InventoryService

## @deprecated Use sdk.get_service(LeaderboardService) instead.
func get_leaderboard_service() -> LeaderboardService:
	return get_service(LeaderboardService) as LeaderboardService

## @deprecated Use sdk.get_service(LegalService) instead.
func get_legal_service() -> LegalService:
	return get_service(LegalService) as LegalService

## @deprecated Use sdk.get_service(LobbyService) instead.
func get_lobby_service() -> LobbyService:
	return get_service(LobbyService) as LobbyService

## @deprecated Use sdk.get_service(LoginqueueService) instead.
func get_loginqueue_service() -> LoginqueueService:
	return get_service(LoginqueueService) as LoginqueueService

## @deprecated Use sdk.get_service(Match2Service) instead.
func get_match2_service() -> Match2Service:
	return get_service(Match2Service) as Match2Service

## @deprecated Use sdk.get_service(MatchmakingService) instead.
func get_matchmaking_service() -> MatchmakingService:
	return get_service(MatchmakingService) as MatchmakingService

## @deprecated Use sdk.get_service(PlatformService) instead.
func get_platform_service() -> PlatformService:
	return get_service(PlatformService) as PlatformService

## @deprecated Use sdk.get_service(ReportingService) instead.
func get_reporting_service() -> ReportingService:
	return get_service(ReportingService) as ReportingService

## @deprecated Use sdk.get_service(SeasonpassService) instead.
func get_seasonpass_service() -> SeasonpassService:
	return get_service(SeasonpassService) as SeasonpassService

## @deprecated Use sdk.get_service(SessionService) instead.
func get_session_service() -> SessionService:
	return get_service(SessionService) as SessionService

## @deprecated Use sdk.get_service(SessionbrowserService) instead.
func get_sessionbrowser_service() -> SessionbrowserService:
	return get_service(SessionbrowserService) as SessionbrowserService

## @deprecated Use sdk.get_service(SessionhistoryService) instead.
func get_sessionhistory_service() -> SessionhistoryService:
	return get_service(SessionhistoryService) as SessionhistoryService

## @deprecated Use sdk.get_service(SocialService) instead.
func get_social_service() -> SocialService:
	return get_service(SocialService) as SocialService

## @deprecated Use sdk.get_service(TurnManagerService) instead.
func get_turn_manager_service() -> TurnManagerService:
	return get_service(TurnManagerService) as TurnManagerService

## @deprecated Use sdk.get_service(UgcService) instead.
func get_ugc_service() -> UgcService:
	return get_service(UgcService) as UgcService

## Get the lobby WebSocket service (typed methods for friends, party, matchmaking, etc.)
func get_lobby_ws_service() -> LobbyWsService:
	return _lobby_ws_service


# =============================================================================
# Lobby WebSocket
# =============================================================================

## Connect to the lobby WebSocket server.
## Returns "" on success, or an error message.
func lobby_connect() -> String:
	if not is_logged_in():
		return "Error: not logged in"
	if _tokens.is_expired():
		return "Error: access token expired"
	if _ws_transport.is_ws_connected():
		return ""
	var err = _ws_transport.connect_to_lobby(_settings.lobby_url, _tokens.access_token)
	if err != OK:
		return "Error: connection failed (code %d)" % err
	return ""


## Disconnect from the lobby WebSocket server.
func lobby_disconnect() -> void:
	_ws_transport.disconnect_from_lobby()


## Check if the lobby WebSocket is currently connected.
func is_lobby_connected() -> bool:
	return _ws_transport.is_ws_connected()


# =============================================================================
# Internal
# =============================================================================

func _propagate_settings() -> void:
	for key in _service_registry:
		var svc = _service_registry[key]
		svc.set_base_url(_settings.base_url)
		svc.set_namespace(_settings.game_namespace)
		svc.set_client_id(_settings.client_id)
		# NOTE: client_secret no longer propagated to individual services for security

		# Check for Extend service URL override first
		var stem: String = key.get_file().get_basename().trim_suffix("_service")
		var extend_url: String = ProjectSettings.get_setting("accelbyte/extend/" + stem + "_url", "")
		if not extend_url.is_empty():
			# Use Extend-specific service URL
			svc.set_service_url(extend_url)
		else:
			# Fall back to base_url for standard AccelByte services
			svc.set_service_url(_settings.base_url)


func _propagate_auth() -> void:
	for svc in _service_registry.values():
		svc.set_auth_token(_tokens.access_token)
	if _ws_transport:
		_ws_transport.set_auth_token(_tokens.access_token)


## Reset all token refresh state variables to their initial values.
## Used by token grant, token revoke, and refresh failure handling.
func _reset_refresh_state() -> void:
	_refresh_retry_count = 0
	_refresh_retry_delay_ms = 0
	_refresh_retry_at_ms = 0


## Called automatically when a token-granting endpoint succeeds.
func _on_token_grant(result: Dictionary) -> void:
	var data = result.get("data", {})
	if data is Dictionary and data.has("access_token"):
		var endpoint_url = result.get("_endpoint_url", "")
		var user_id = data.get("user_id", "")
		set_auth_tokens(
			data.get("access_token", ""),
			data.get("refresh_token", ""),
			user_id,
			data.get("expires_in", 3600),
			endpoint_url
		)
		if user_id.is_empty():
			push_warning("[AccelByteSDK] Token granted but user_id is empty — check IAM response format")
		# Reset refresh backoff — new tokens, fresh start.
		# NOTE: Don't reset _refresh_in_progress here - only _do_token_refresh() should manage that flag
		# to avoid race conditions between user login and background refresh
		_reset_refresh_state()


## Called automatically when a token-revoking endpoint succeeds.
func _on_token_revoke() -> void:
	_tokens.clear()
	_propagate_auth()
	# Stop refresh attempts — user has logged out.
	# NOTE: It's safe to reset _refresh_in_progress here since logout should cancel any pending refresh
	_reset_refresh_state()
	_refresh_in_progress = false


# =============================================================================
# Token Auto-Refresh (background poller)
#
# Proactively refreshes the access token at 80% of its lifetime (Unity SDK
# convention). Uses exponential backoff on failure (1s → 2s → 4s → … → 1h),
# giving up after _REFRESH_MAX_RETRIES consecutive failures and emitting
# token_refresh_failed. The game must then re-authenticate.
# =============================================================================

const _PollNodeScript = preload("res://addons/accelbyte_sdk/scripts/utils/accelbyte_poll_node.gd")

func _start_token_refresh_poller() -> void:
	if _refresh_poll_node or not _scene_root:
		return
	_refresh_poll_node = _PollNodeScript.new()
	_refresh_poll_node.name = "_ABTokenRefreshPoll"
	_refresh_poll_node._callback = Callable(self, "_poll_token_refresh")
	_scene_root.add_child(_refresh_poll_node)


func _stop_token_refresh_poller() -> void:
	if _refresh_poll_node:
		_refresh_poll_node._callback = Callable()
		if _refresh_poll_node.is_inside_tree():
			_refresh_poll_node.queue_free()
		_refresh_poll_node = null

	# Reset refresh state to prevent permanent lockout after SDK teardown
	_refresh_in_progress = false


func _poll_token_refresh() -> void:
	# Nothing to refresh if not logged in or no refresh token.
	if not _tokens.is_logged_in() or _tokens.refresh_token.is_empty():
		return

	# Don't overlap refreshes.
	if _refresh_in_progress:
		return

	# If in backoff, wait until the delay has elapsed.
	if _refresh_retry_at_ms > 0 and Time.get_ticks_msec() < _refresh_retry_at_ms:
		return

	# Check if it's time for a proactive refresh (80% of token lifetime elapsed).
	if not _tokens.should_refresh():
		return

	_refresh_in_progress = true
	_do_token_refresh()


func _do_token_refresh() -> void:
	# Call the token refresh endpoint directly via _http to avoid service-layer
	# indirection. The IAM service's token callback would work too, but going
	# direct keeps the async control flow simple and avoids any registry side effects.
	# Use the same endpoint that issued the original tokens for consistency.
	var url: String = _tokens.get_refresh_endpoint_url(_settings.base_url)
	var headers: PackedStringArray = AccelbyteHttp.get_basic_auth_headers(
		_settings.client_id, _settings._get_client_secret()
	)
	var body: String = AccelbyteHttp.build_form_body({
		"grant_type": "refresh_token",
		"refresh_token": _tokens.refresh_token,
	})

	var result: Dictionary = await _http.request(url, AccelbyteHttp.Method.POST, headers, body)

	if result.get("success", false):
		var data = result.get("data", {})
		if data is Dictionary and data.has("access_token"):
			set_auth_tokens(
				data.get("access_token", ""),
				data.get("refresh_token", ""),
				data.get("user_id", ""),
				data.get("expires_in", 3600),
				url  # Track the refresh endpoint for future refreshes
			)
			# Reset refresh state — backoff and in-progress flag.
			_reset_refresh_state()
			_refresh_in_progress = false
			token_refreshed.emit()
			return
		else:
			# HTTP success but malformed response - trigger backoff like any other failure
			push_error("[AccelByteSDK] Token refresh response missing access_token — unexpected server response")
			_on_token_refresh_failed()
			return
	_on_token_refresh_failed()


func _on_token_refresh_failed() -> void:
	_refresh_retry_count += 1
	_refresh_in_progress = false

	if _refresh_retry_count > _REFRESH_MAX_RETRIES:
		push_error("[AccelByteSDK] Token refresh failed after %d retries — session expired. Re-authentication required." % _REFRESH_MAX_RETRIES)
		token_refresh_failed.emit()
		# Clear tokens so the game knows the session is gone.
		_tokens.clear()
		_propagate_auth()
		# Notify that the session has expired and re-authentication is required
		session_expired.emit()
		_reset_refresh_state()
		return

	# Exponential backoff: 1s, 2s, 4s, …, capped at 1 hour.
	if _refresh_retry_delay_ms <= 0:
		_refresh_retry_delay_ms = _REFRESH_BACKOFF_INITIAL_MS
	else:
		_refresh_retry_delay_ms = mini(_refresh_retry_delay_ms * 2, _REFRESH_BACKOFF_MAX_MS)

	_refresh_retry_at_ms = Time.get_ticks_msec() + _refresh_retry_delay_ms
	push_warning("[AccelByteSDK] Token refresh attempt %d/%d failed — retrying in %dms" % [
		_refresh_retry_count, _REFRESH_MAX_RETRIES, _refresh_retry_delay_ms
	])
