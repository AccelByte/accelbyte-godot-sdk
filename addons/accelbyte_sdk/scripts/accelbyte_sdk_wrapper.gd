## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.


## =============================================================================
## accelbyte_sdk_wrapper.gd
## Generated unified AccelByte SDK wrapper with platform routing
## Routes to C++ GDExtension on desktop, GDScript HTTP on web
## DO NOT EDIT - This file is auto-generated
## =============================================================================
##
## Usage:
##   var sdk = AccelByteSDKWrapper.new()
##   sdk.initialize(self)  # Pass a Node for scene tree access
##   sdk.set_server_url("https://demo.accelbyte.io")
##   sdk.set_client_credentials("your-client-id", "your-secret")
##   sdk.set_namespace("your-namespace")
##
##   # Login (tokens are stored automatically):
##   var iam = sdk.get_iam_service()
##   var result = await iam.token_grant_v3("password", "", "", "", "", "", "", false, password, "", "", "", username)
##
##   # Logout (tokens are cleared automatically):
##   await iam.logout()
## =============================================================================

class_name AccelByteSDKWrapper
extends RefCounted

## The C++ GDExtension SDK instance (used on all platforms for settings/state)
var _sdk: AccelByteSDK

## Scene root node (needed for HTTPRequest on web)
var _scene_root: Node

## Whether we are running on web platform
var _is_web_platform: bool = false

# Web service instances (only created on web platform)

var _achievement_web: AchievementServiceWeb

var _ams_qosm_web: AmsQosmServiceWeb

var _ams_web: AmsServiceWeb

var _analytics_config_web: AnalyticsConfigServiceWeb

var _analytics_connector_web: AnalyticsConnectorServiceWeb

var _analytics_web: AnalyticsServiceWeb

var _audit_web: AuditServiceWeb

var _basic_web: BasicServiceWeb

var _buildinfo_web: BuildinfoServiceWeb

var _challenge_web: ChallengeServiceWeb

var _chat_web: ChatServiceWeb

var _cloudsave_web: CloudsaveServiceWeb

var _config_web: ConfigServiceWeb

var _configpromoter_web: ConfigpromoterServiceWeb

var _csm_web: CsmServiceWeb

var _differ_web: DifferServiceWeb

var _dsartifact_web: DsartifactServiceWeb

var _dslogmanager_web: DslogmanagerServiceWeb

var _dsmc_web: DsmcServiceWeb

var _dsupload_web: DsuploadServiceWeb

var _ehs_web: EhsServiceWeb

var _eventlog_web: EventlogServiceWeb

var _gametelemetry_web: GametelemetryServiceWeb

var _gdpr_web: GdprServiceWeb

var _group_web: GroupServiceWeb

var _iam_web: IamServiceWeb

var _inventory_web: InventoryServiceWeb

var _leaderboard_web: LeaderboardServiceWeb

var _legal_web: LegalServiceWeb

var _lobby_web: LobbyServiceWeb

var _log_web: LogServiceWeb

var _login_queue_web: LoginQueueServiceWeb

var _loginqueue_web: LoginqueueServiceWeb

var _match2_web: Match2ServiceWeb

var _matchmaking_web: MatchmakingServiceWeb

var _observability_manager_web: ObservabilityManagerServiceWeb

var _odin_config_web: OdinConfigServiceWeb

var _platform_web: PlatformServiceWeb

var _qosm_web: QosmServiceWeb

var _reporting_web: ReportingServiceWeb

var _seasonpass_web: SeasonpassServiceWeb

var _session_web: SessionServiceWeb

var _sessionbrowser_web: SessionbrowserServiceWeb

var _sessionhistory_web: SessionhistoryServiceWeb

var _social_web: SocialServiceWeb

var _turn_manager_web: TurnManagerServiceWeb

var _ugc_web: UgcServiceWeb


# =============================================================================
# Initialization
# =============================================================================

## Initialize the SDK wrapper.
## Pass a Node (e.g. self) so the SDK can create HTTPRequest children for web.
func initialize(scene_root: Node = null) -> void:
	_scene_root = scene_root
	_is_web_platform = OS.has_feature("web")

	# Create and initialize the C++ SDK (works on all platforms for settings)
	_sdk = AccelByteSDK.new()
	_sdk.initialize()

	if _scene_root:
		_sdk.initialize_async(_scene_root)

	# On web, create GDScript service instances
	if _is_web_platform:

		_achievement_web = AchievementServiceWeb.new()
		_achievement_web.initialize(_sdk, _scene_root)

		_ams_qosm_web = AmsQosmServiceWeb.new()
		_ams_qosm_web.initialize(_sdk, _scene_root)

		_ams_web = AmsServiceWeb.new()
		_ams_web.initialize(_sdk, _scene_root)

		_analytics_config_web = AnalyticsConfigServiceWeb.new()
		_analytics_config_web.initialize(_sdk, _scene_root)

		_analytics_connector_web = AnalyticsConnectorServiceWeb.new()
		_analytics_connector_web.initialize(_sdk, _scene_root)

		_analytics_web = AnalyticsServiceWeb.new()
		_analytics_web.initialize(_sdk, _scene_root)

		_audit_web = AuditServiceWeb.new()
		_audit_web.initialize(_sdk, _scene_root)

		_basic_web = BasicServiceWeb.new()
		_basic_web.initialize(_sdk, _scene_root)

		_buildinfo_web = BuildinfoServiceWeb.new()
		_buildinfo_web.initialize(_sdk, _scene_root)

		_challenge_web = ChallengeServiceWeb.new()
		_challenge_web.initialize(_sdk, _scene_root)

		_chat_web = ChatServiceWeb.new()
		_chat_web.initialize(_sdk, _scene_root)

		_cloudsave_web = CloudsaveServiceWeb.new()
		_cloudsave_web.initialize(_sdk, _scene_root)

		_config_web = ConfigServiceWeb.new()
		_config_web.initialize(_sdk, _scene_root)

		_configpromoter_web = ConfigpromoterServiceWeb.new()
		_configpromoter_web.initialize(_sdk, _scene_root)

		_csm_web = CsmServiceWeb.new()
		_csm_web.initialize(_sdk, _scene_root)

		_differ_web = DifferServiceWeb.new()
		_differ_web.initialize(_sdk, _scene_root)

		_dsartifact_web = DsartifactServiceWeb.new()
		_dsartifact_web.initialize(_sdk, _scene_root)

		_dslogmanager_web = DslogmanagerServiceWeb.new()
		_dslogmanager_web.initialize(_sdk, _scene_root)

		_dsmc_web = DsmcServiceWeb.new()
		_dsmc_web.initialize(_sdk, _scene_root)

		_dsupload_web = DsuploadServiceWeb.new()
		_dsupload_web.initialize(_sdk, _scene_root)

		_ehs_web = EhsServiceWeb.new()
		_ehs_web.initialize(_sdk, _scene_root)

		_eventlog_web = EventlogServiceWeb.new()
		_eventlog_web.initialize(_sdk, _scene_root)

		_gametelemetry_web = GametelemetryServiceWeb.new()
		_gametelemetry_web.initialize(_sdk, _scene_root)

		_gdpr_web = GdprServiceWeb.new()
		_gdpr_web.initialize(_sdk, _scene_root)

		_group_web = GroupServiceWeb.new()
		_group_web.initialize(_sdk, _scene_root)

		_iam_web = IamServiceWeb.new()
		_iam_web.initialize(_sdk, _scene_root)

		_inventory_web = InventoryServiceWeb.new()
		_inventory_web.initialize(_sdk, _scene_root)

		_leaderboard_web = LeaderboardServiceWeb.new()
		_leaderboard_web.initialize(_sdk, _scene_root)

		_legal_web = LegalServiceWeb.new()
		_legal_web.initialize(_sdk, _scene_root)

		_lobby_web = LobbyServiceWeb.new()
		_lobby_web.initialize(_sdk, _scene_root)

		_log_web = LogServiceWeb.new()
		_log_web.initialize(_sdk, _scene_root)

		_login_queue_web = LoginQueueServiceWeb.new()
		_login_queue_web.initialize(_sdk, _scene_root)

		_loginqueue_web = LoginqueueServiceWeb.new()
		_loginqueue_web.initialize(_sdk, _scene_root)

		_match2_web = Match2ServiceWeb.new()
		_match2_web.initialize(_sdk, _scene_root)

		_matchmaking_web = MatchmakingServiceWeb.new()
		_matchmaking_web.initialize(_sdk, _scene_root)

		_observability_manager_web = ObservabilityManagerServiceWeb.new()
		_observability_manager_web.initialize(_sdk, _scene_root)

		_odin_config_web = OdinConfigServiceWeb.new()
		_odin_config_web.initialize(_sdk, _scene_root)

		_platform_web = PlatformServiceWeb.new()
		_platform_web.initialize(_sdk, _scene_root)

		_qosm_web = QosmServiceWeb.new()
		_qosm_web.initialize(_sdk, _scene_root)

		_reporting_web = ReportingServiceWeb.new()
		_reporting_web.initialize(_sdk, _scene_root)

		_seasonpass_web = SeasonpassServiceWeb.new()
		_seasonpass_web.initialize(_sdk, _scene_root)

		_session_web = SessionServiceWeb.new()
		_session_web.initialize(_sdk, _scene_root)

		_sessionbrowser_web = SessionbrowserServiceWeb.new()
		_sessionbrowser_web.initialize(_sdk, _scene_root)

		_sessionhistory_web = SessionhistoryServiceWeb.new()
		_sessionhistory_web.initialize(_sdk, _scene_root)

		_social_web = SocialServiceWeb.new()
		_social_web.initialize(_sdk, _scene_root)

		_turn_manager_web = TurnManagerServiceWeb.new()
		_turn_manager_web.initialize(_sdk, _scene_root)

		_ugc_web = UgcServiceWeb.new()
		_ugc_web.initialize(_sdk, _scene_root)



## Get the underlying C++ SDK instance (for advanced usage)
func get_sdk() -> AccelByteSDK:
	return _sdk


## Check if running on web platform
func is_web() -> bool:
	return _is_web_platform


# =============================================================================
# Configuration - Setters
# =============================================================================

func set_server_url(url: String) -> void:
	_sdk.set_server_url(url)
	if _is_web_platform:

		if _achievement_web:
			_achievement_web.set_base_url(url)

		if _ams_qosm_web:
			_ams_qosm_web.set_base_url(url)

		if _ams_web:
			_ams_web.set_base_url(url)

		if _analytics_config_web:
			_analytics_config_web.set_base_url(url)

		if _analytics_connector_web:
			_analytics_connector_web.set_base_url(url)

		if _analytics_web:
			_analytics_web.set_base_url(url)

		if _audit_web:
			_audit_web.set_base_url(url)

		if _basic_web:
			_basic_web.set_base_url(url)

		if _buildinfo_web:
			_buildinfo_web.set_base_url(url)

		if _challenge_web:
			_challenge_web.set_base_url(url)

		if _chat_web:
			_chat_web.set_base_url(url)

		if _cloudsave_web:
			_cloudsave_web.set_base_url(url)

		if _config_web:
			_config_web.set_base_url(url)

		if _configpromoter_web:
			_configpromoter_web.set_base_url(url)

		if _csm_web:
			_csm_web.set_base_url(url)

		if _differ_web:
			_differ_web.set_base_url(url)

		if _dsartifact_web:
			_dsartifact_web.set_base_url(url)

		if _dslogmanager_web:
			_dslogmanager_web.set_base_url(url)

		if _dsmc_web:
			_dsmc_web.set_base_url(url)

		if _dsupload_web:
			_dsupload_web.set_base_url(url)

		if _ehs_web:
			_ehs_web.set_base_url(url)

		if _eventlog_web:
			_eventlog_web.set_base_url(url)

		if _gametelemetry_web:
			_gametelemetry_web.set_base_url(url)

		if _gdpr_web:
			_gdpr_web.set_base_url(url)

		if _group_web:
			_group_web.set_base_url(url)

		if _iam_web:
			_iam_web.set_base_url(url)

		if _inventory_web:
			_inventory_web.set_base_url(url)

		if _leaderboard_web:
			_leaderboard_web.set_base_url(url)

		if _legal_web:
			_legal_web.set_base_url(url)

		if _lobby_web:
			_lobby_web.set_base_url(url)

		if _log_web:
			_log_web.set_base_url(url)

		if _login_queue_web:
			_login_queue_web.set_base_url(url)

		if _loginqueue_web:
			_loginqueue_web.set_base_url(url)

		if _match2_web:
			_match2_web.set_base_url(url)

		if _matchmaking_web:
			_matchmaking_web.set_base_url(url)

		if _observability_manager_web:
			_observability_manager_web.set_base_url(url)

		if _odin_config_web:
			_odin_config_web.set_base_url(url)

		if _platform_web:
			_platform_web.set_base_url(url)

		if _qosm_web:
			_qosm_web.set_base_url(url)

		if _reporting_web:
			_reporting_web.set_base_url(url)

		if _seasonpass_web:
			_seasonpass_web.set_base_url(url)

		if _session_web:
			_session_web.set_base_url(url)

		if _sessionbrowser_web:
			_sessionbrowser_web.set_base_url(url)

		if _sessionhistory_web:
			_sessionhistory_web.set_base_url(url)

		if _social_web:
			_social_web.set_base_url(url)

		if _turn_manager_web:
			_turn_manager_web.set_base_url(url)

		if _ugc_web:
			_ugc_web.set_base_url(url)



func set_lobby_url(url: String) -> void:
	_sdk.set_lobby_url(url)


func set_chat_url(url: String) -> void:
	_sdk.set_chat_url(url)


func set_client_id(client_id: String) -> void:
	_sdk.set_client_id(client_id)


func set_client_secret(client_secret: String) -> void:
	_sdk.set_client_secret(client_secret)


func set_client_credentials(client_id: String, client_secret: String) -> void:
	_sdk.set_client_credentials(client_id, client_secret)


func set_publisher_id(publisher_id: String) -> void:
	_sdk.set_publisher_id(publisher_id)


func set_publisher_secret(publisher_secret: String) -> void:
	_sdk.set_publisher_secret(publisher_secret)


func set_namespace(ns: String) -> void:
	_sdk.set_namespace(ns)
	if _is_web_platform:

		if _achievement_web:
			_achievement_web.set_namespace(ns)

		if _ams_qosm_web:
			_ams_qosm_web.set_namespace(ns)

		if _ams_web:
			_ams_web.set_namespace(ns)

		if _analytics_config_web:
			_analytics_config_web.set_namespace(ns)

		if _analytics_connector_web:
			_analytics_connector_web.set_namespace(ns)

		if _analytics_web:
			_analytics_web.set_namespace(ns)

		if _audit_web:
			_audit_web.set_namespace(ns)

		if _basic_web:
			_basic_web.set_namespace(ns)

		if _buildinfo_web:
			_buildinfo_web.set_namespace(ns)

		if _challenge_web:
			_challenge_web.set_namespace(ns)

		if _chat_web:
			_chat_web.set_namespace(ns)

		if _cloudsave_web:
			_cloudsave_web.set_namespace(ns)

		if _config_web:
			_config_web.set_namespace(ns)

		if _configpromoter_web:
			_configpromoter_web.set_namespace(ns)

		if _csm_web:
			_csm_web.set_namespace(ns)

		if _differ_web:
			_differ_web.set_namespace(ns)

		if _dsartifact_web:
			_dsartifact_web.set_namespace(ns)

		if _dslogmanager_web:
			_dslogmanager_web.set_namespace(ns)

		if _dsmc_web:
			_dsmc_web.set_namespace(ns)

		if _dsupload_web:
			_dsupload_web.set_namespace(ns)

		if _ehs_web:
			_ehs_web.set_namespace(ns)

		if _eventlog_web:
			_eventlog_web.set_namespace(ns)

		if _gametelemetry_web:
			_gametelemetry_web.set_namespace(ns)

		if _gdpr_web:
			_gdpr_web.set_namespace(ns)

		if _group_web:
			_group_web.set_namespace(ns)

		if _iam_web:
			_iam_web.set_namespace(ns)

		if _inventory_web:
			_inventory_web.set_namespace(ns)

		if _leaderboard_web:
			_leaderboard_web.set_namespace(ns)

		if _legal_web:
			_legal_web.set_namespace(ns)

		if _lobby_web:
			_lobby_web.set_namespace(ns)

		if _log_web:
			_log_web.set_namespace(ns)

		if _login_queue_web:
			_login_queue_web.set_namespace(ns)

		if _loginqueue_web:
			_loginqueue_web.set_namespace(ns)

		if _match2_web:
			_match2_web.set_namespace(ns)

		if _matchmaking_web:
			_matchmaking_web.set_namespace(ns)

		if _observability_manager_web:
			_observability_manager_web.set_namespace(ns)

		if _odin_config_web:
			_odin_config_web.set_namespace(ns)

		if _platform_web:
			_platform_web.set_namespace(ns)

		if _qosm_web:
			_qosm_web.set_namespace(ns)

		if _reporting_web:
			_reporting_web.set_namespace(ns)

		if _seasonpass_web:
			_seasonpass_web.set_namespace(ns)

		if _session_web:
			_session_web.set_namespace(ns)

		if _sessionbrowser_web:
			_sessionbrowser_web.set_namespace(ns)

		if _sessionhistory_web:
			_sessionhistory_web.set_namespace(ns)

		if _social_web:
			_social_web.set_namespace(ns)

		if _turn_manager_web:
			_turn_manager_web.set_namespace(ns)

		if _ugc_web:
			_ugc_web.set_namespace(ns)



# =============================================================================
# Configuration - Getters
# =============================================================================

func get_server_url() -> String:
	return _sdk.get_server_url()


func get_lobby_url() -> String:
	return _sdk.get_lobby_url()


func get_chat_url() -> String:
	return _sdk.get_chat_url()


func get_client_id() -> String:
	return _sdk.get_client_id()


func get_client_secret() -> String:
	return _sdk.get_client_secret()


func get_publisher_id() -> String:
	return _sdk.get_publisher_id()


func get_publisher_secret() -> String:
	return _sdk.get_publisher_secret()


func get_namespace() -> String:
	return _sdk.get_namespace()


func get_sdk_version() -> String:
	return _sdk.get_sdk_version()


# =============================================================================
# Authentication State
#
# Token management is automatic. When you call token_grant_v3(),
# platform_token_grant_v3(), or similar OAuth endpoints, the SDK
# automatically stores the returned tokens. When you call
# token_revocation_v3(), tokens are automatically cleared.
# =============================================================================

## Get current access token
func get_access_token() -> String:
	return _sdk.get_access_token()


## Get current user ID
func get_user_id() -> String:
	return _sdk.get_user_id()


## Check if user is logged in
func is_logged_in() -> bool:
	return _sdk.is_logged_in()


# =============================================================================
# Async Processing
# =============================================================================

## Call this every frame in _process() for async operations
func poll() -> void:
	_sdk.poll()


# =============================================================================
# Service Accessors (Platform-Aware)
#
# On desktop: returns the C++ service (synchronous, uses CNL HTTP)
# On web: returns the GDScript service (async, uses Godot HTTPRequest)
#
# Game code should always use `await` when calling service methods to be
# compatible with both platforms:
#   var result = await sdk.get_iam_service().some_method(...)
# =============================================================================


## Get the AchievementService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_achievement_service():
	if _is_web_platform:
		_achievement_web.update_auth_token()
		return _achievement_web
	else:
		return _sdk.get_achievement_service()


## Get the AmsQosmService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_ams_qosm_service():
	if _is_web_platform:
		_ams_qosm_web.update_auth_token()
		return _ams_qosm_web
	else:
		return _sdk.get_ams_qosm_service()


## Get the AmsService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_ams_service():
	if _is_web_platform:
		_ams_web.update_auth_token()
		return _ams_web
	else:
		return _sdk.get_ams_service()


## Get the AnalyticsConfigService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_analytics_config_service():
	if _is_web_platform:
		_analytics_config_web.update_auth_token()
		return _analytics_config_web
	else:
		return _sdk.get_analytics_config_service()


## Get the AnalyticsConnectorService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_analytics_connector_service():
	if _is_web_platform:
		_analytics_connector_web.update_auth_token()
		return _analytics_connector_web
	else:
		return _sdk.get_analytics_connector_service()


## Get the AnalyticsService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_analytics_service():
	if _is_web_platform:
		_analytics_web.update_auth_token()
		return _analytics_web
	else:
		return _sdk.get_analytics_service()


## Get the AuditService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_audit_service():
	if _is_web_platform:
		_audit_web.update_auth_token()
		return _audit_web
	else:
		return _sdk.get_audit_service()


## Get the BasicService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_basic_service():
	if _is_web_platform:
		_basic_web.update_auth_token()
		return _basic_web
	else:
		return _sdk.get_basic_service()


## Get the BuildinfoService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_buildinfo_service():
	if _is_web_platform:
		_buildinfo_web.update_auth_token()
		return _buildinfo_web
	else:
		return _sdk.get_buildinfo_service()


## Get the ChallengeService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_challenge_service():
	if _is_web_platform:
		_challenge_web.update_auth_token()
		return _challenge_web
	else:
		return _sdk.get_challenge_service()


## Get the ChatService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_chat_service():
	if _is_web_platform:
		_chat_web.update_auth_token()
		return _chat_web
	else:
		return _sdk.get_chat_service()


## Get the CloudsaveService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_cloudsave_service():
	if _is_web_platform:
		_cloudsave_web.update_auth_token()
		return _cloudsave_web
	else:
		return _sdk.get_cloudsave_service()


## Get the ConfigService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_config_service():
	if _is_web_platform:
		_config_web.update_auth_token()
		return _config_web
	else:
		return _sdk.get_config_service()


## Get the ConfigpromoterService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_configpromoter_service():
	if _is_web_platform:
		_configpromoter_web.update_auth_token()
		return _configpromoter_web
	else:
		return _sdk.get_configpromoter_service()


## Get the CsmService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_csm_service():
	if _is_web_platform:
		_csm_web.update_auth_token()
		return _csm_web
	else:
		return _sdk.get_csm_service()


## Get the DifferService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_differ_service():
	if _is_web_platform:
		_differ_web.update_auth_token()
		return _differ_web
	else:
		return _sdk.get_differ_service()


## Get the DsartifactService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_dsartifact_service():
	if _is_web_platform:
		_dsartifact_web.update_auth_token()
		return _dsartifact_web
	else:
		return _sdk.get_dsartifact_service()


## Get the DslogmanagerService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_dslogmanager_service():
	if _is_web_platform:
		_dslogmanager_web.update_auth_token()
		return _dslogmanager_web
	else:
		return _sdk.get_dslogmanager_service()


## Get the DsmcService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_dsmc_service():
	if _is_web_platform:
		_dsmc_web.update_auth_token()
		return _dsmc_web
	else:
		return _sdk.get_dsmc_service()


## Get the DsuploadService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_dsupload_service():
	if _is_web_platform:
		_dsupload_web.update_auth_token()
		return _dsupload_web
	else:
		return _sdk.get_dsupload_service()


## Get the EhsService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_ehs_service():
	if _is_web_platform:
		_ehs_web.update_auth_token()
		return _ehs_web
	else:
		return _sdk.get_ehs_service()


## Get the EventlogService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_eventlog_service():
	if _is_web_platform:
		_eventlog_web.update_auth_token()
		return _eventlog_web
	else:
		return _sdk.get_eventlog_service()


## Get the GametelemetryService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_gametelemetry_service():
	if _is_web_platform:
		_gametelemetry_web.update_auth_token()
		return _gametelemetry_web
	else:
		return _sdk.get_gametelemetry_service()


## Get the GdprService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_gdpr_service():
	if _is_web_platform:
		_gdpr_web.update_auth_token()
		return _gdpr_web
	else:
		return _sdk.get_gdpr_service()


## Get the GroupService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_group_service():
	if _is_web_platform:
		_group_web.update_auth_token()
		return _group_web
	else:
		return _sdk.get_group_service()


## Get the IamService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_iam_service():
	if _is_web_platform:
		_iam_web.update_auth_token()
		return _iam_web
	else:
		return _sdk.get_iam_service()


## Get the InventoryService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_inventory_service():
	if _is_web_platform:
		_inventory_web.update_auth_token()
		return _inventory_web
	else:
		return _sdk.get_inventory_service()


## Get the LeaderboardService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_leaderboard_service():
	if _is_web_platform:
		_leaderboard_web.update_auth_token()
		return _leaderboard_web
	else:
		return _sdk.get_leaderboard_service()


## Get the LegalService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_legal_service():
	if _is_web_platform:
		_legal_web.update_auth_token()
		return _legal_web
	else:
		return _sdk.get_legal_service()


## Get the LobbyService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_lobby_service():
	if _is_web_platform:
		_lobby_web.update_auth_token()
		return _lobby_web
	else:
		return _sdk.get_lobby_service()


## Get the LogService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_log_service():
	if _is_web_platform:
		_log_web.update_auth_token()
		return _log_web
	else:
		return _sdk.get_log_service()


## Get the LoginQueueService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_login_queue_service():
	if _is_web_platform:
		_login_queue_web.update_auth_token()
		return _login_queue_web
	else:
		return _sdk.get_login_queue_service()


## Get the LoginqueueService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_loginqueue_service():
	if _is_web_platform:
		_loginqueue_web.update_auth_token()
		return _loginqueue_web
	else:
		return _sdk.get_loginqueue_service()


## Get the Match2Service (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_match2_service():
	if _is_web_platform:
		_match2_web.update_auth_token()
		return _match2_web
	else:
		return _sdk.get_match2_service()


## Get the MatchmakingService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_matchmaking_service():
	if _is_web_platform:
		_matchmaking_web.update_auth_token()
		return _matchmaking_web
	else:
		return _sdk.get_matchmaking_service()


## Get the ObservabilityManagerService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_observability_manager_service():
	if _is_web_platform:
		_observability_manager_web.update_auth_token()
		return _observability_manager_web
	else:
		return _sdk.get_observability_manager_service()


## Get the OdinConfigService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_odin_config_service():
	if _is_web_platform:
		_odin_config_web.update_auth_token()
		return _odin_config_web
	else:
		return _sdk.get_odin_config_service()


## Get the PlatformService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_platform_service():
	if _is_web_platform:
		_platform_web.update_auth_token()
		return _platform_web
	else:
		return _sdk.get_platform_service()


## Get the QosmService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_qosm_service():
	if _is_web_platform:
		_qosm_web.update_auth_token()
		return _qosm_web
	else:
		return _sdk.get_qosm_service()


## Get the ReportingService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_reporting_service():
	if _is_web_platform:
		_reporting_web.update_auth_token()
		return _reporting_web
	else:
		return _sdk.get_reporting_service()


## Get the SeasonpassService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_seasonpass_service():
	if _is_web_platform:
		_seasonpass_web.update_auth_token()
		return _seasonpass_web
	else:
		return _sdk.get_seasonpass_service()


## Get the SessionService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_session_service():
	if _is_web_platform:
		_session_web.update_auth_token()
		return _session_web
	else:
		return _sdk.get_session_service()


## Get the SessionbrowserService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_sessionbrowser_service():
	if _is_web_platform:
		_sessionbrowser_web.update_auth_token()
		return _sessionbrowser_web
	else:
		return _sdk.get_sessionbrowser_service()


## Get the SessionhistoryService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_sessionhistory_service():
	if _is_web_platform:
		_sessionhistory_web.update_auth_token()
		return _sessionhistory_web
	else:
		return _sdk.get_sessionhistory_service()


## Get the SocialService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_social_service():
	if _is_web_platform:
		_social_web.update_auth_token()
		return _social_web
	else:
		return _sdk.get_social_service()


## Get the TurnManagerService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_turn_manager_service():
	if _is_web_platform:
		_turn_manager_web.update_auth_token()
		return _turn_manager_web
	else:
		return _sdk.get_turn_manager_service()


## Get the UgcService (platform-aware).
## Desktop: C++ GDExtension service | Web: GDScript HTTP service
func get_ugc_service():
	if _is_web_platform:
		_ugc_web.update_auth_token()
		return _ugc_web
	else:
		return _sdk.get_ugc_service()

