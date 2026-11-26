## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.
## =============================================================================
## lobby_ws_service.gd
## Auto-generated from lobby.schema.yaml — DO NOT EDIT
## Service: justice-lobby-ws-service
## Version: 3.35.2
## =============================================================================
##
## Typed lobby WebSocket service with methods for each request type and signals
## for each notification/response type. Sits on top of a WebSocket transport.
##
## Usage:
##   var lobby_ws = LobbyWsService.new(ws_transport)
##   lobby_ws.party_invite_notif.connect(_on_party_invite)
##   lobby_ws.accept_friends_request("friend-user-id-here")##
## NOTE: The following models were not auto-classified (don't end with Notif/Response/Request):##   - exitAllChannel → Available via unclassified_message_received signal##   - heartbeat → Available via unclassified_message_received signal##   - systemComponentsStatus → Available via unclassified_message_received signal##   - userBannedNotification → Available via unclassified_message_received signal##   - userUnbannedNotification → Available via unclassified_message_received signal##   - sessionV2MemberData → Available via unclassified_message_received signal##   - sessionV2PartyInvited → Available via unclassified_message_received signal##   - sessionV2PartyJoined → Available via unclassified_message_received signal##   - sessionV2PartyMembersChanged → Available via unclassified_message_received signal##   - sessionV2PartyRejected → Available via unclassified_message_received signal##   - sessionV2PartyCancelled → Available via unclassified_message_received signal##   - sessionV2PartyKicked → Available via unclassified_message_received signal##   - sessionV2PartyUpdated → Available via unclassified_message_received signal##   - sessionV2GameInvited → Available via unclassified_message_received signal##   - sessionV2GameJoined → Available via unclassified_message_received signal##   - sessionV2GameKicked → Available via unclassified_message_received signal##   - sessionV2GameRejected → Available via unclassified_message_received signal##   - sessionV2GameMembersChanged → Available via unclassified_message_received signal##   - sessionV2GameUpdated → Available via unclassified_message_received signal##   - sessionV2GameEnded → Available via unclassified_message_received signal##
## To handle these messages, connect to the unclassified_message_received signal:
##   lobby_ws.unclassified_message_received.connect(_on_unclassified_message)## =============================================================================

class_name LobbyWsService
extends RefCounted

## Reference to the WebSocket transport layer.
var _ws: RefCounted

# =============================================================================
# Signals — Notifications (server-initiated)
# =============================================================================
signal accept_friends_notif(friend_id: String)
signal block_player_notif(blocked_user_id: String, user_id: String)
signal cancel_friends_notif(user_id: String)
signal channel_chat_notif(channel_slug: String, from: String, payload: String, sent_at: String)
signal connect_notif(
	lobby_session_id: String,
	login_type: String,
	reconnect_from_code: int,
	sequence_id: int,
	sequence_number: int
)
signal disconnect_notif(connection_id: String, namespace_param: String)
signal ds_notif(
	alternate_ips: Array,
	custom_attribute: String,
	deployment: String,
	server_version: String,
	image_version: String,
	ip: String,
	is_ok: bool,
	is_override_game_version: bool,
	last_update: String,
	match_id: String,
	message: String,
	namespace_param: String,
	pod_name: String,
	port: int,
	ports: Dictionary,
	protocol: String,
	provider: String,
	region: String,
	session_id: String,
	status: String
)
signal error_notif(message: String, request_type: String)
signal matchmaking_notif(
	counter_party_member: Array,
	match_id: String,
	message: String,
	party_member: Array,
	duration: int,
	status: String,
	ticket_id: String,
	game_mode: String,
	deployment: String,
	client_version: String,
	joinable: bool,
	matching_allies: Dictionary,
	region: String,
	error_code: int
)
signal message_notif(
	from: String,
	payload: String,
	sent_at: String,
	sequence_id: int,
	sequence_number: int,
	to: String,
	topic: String
)
signal message_session_notif(
	from: String,
	payload: String,
	sent_at: String,
	to: String,
	topic: String,
	sequence_id: int,
	sequence_number: int
)
signal party_chat_notif(from: String, payload: String, received_at: String, to: String)
signal party_connect_notif(user_id: String, party_id: String)
signal party_data_update_notif(
	custom_attribute: Dictionary,
	invitees: Array,
	leader: String,
	members: Array,
	namespace_param: String,
	party_id: String,
	updated_at: int
)
signal party_disconnect_notif(user_id: String, party_id: String)
signal party_get_invited_notif(from: String, invitation_token: String, party_id: String)
signal party_invite_notif(invitee_id: String, inviter_id: String, invitee_is_connected: bool)
signal party_join_notif(user_id: String)
signal party_kick_notif(leader_id: String, party_id: String, user_id: String, leader: String)
signal party_leave_notif(leader_id: String, user_id: String, leader: String, party_id: String)
signal party_notif(sender: String, topic: String, payload: String)
signal party_reject_notif(leader_id: String, party_id: String, user_id: String, leader: String)
signal personal_chat_notif(from: String, payload: String, received_at: String, to: String)
signal reject_friends_notif(user_id: String)
signal rematchmaking_notif(ban_duration: int)
signal request_friends_notif(friend_id: String)
signal set_ready_consent_notif(match_id: String, user_id: String)
signal set_reject_consent_notif(match_id: String, user_id: String)
signal shutdown_notif(message: String)
signal signaling_p2p_notif(destination_id: String, message: String)
signal unblock_player_notif(unblocked_user_id: String, user_id: String)
signal unfriend_notif(friend_id: String)
signal user_status_notif(
	activity: String, availability: String, last_seen_at: String, platform: String, user_id: String
)

# =============================================================================
# Signals — Responses (emitted when server responds to a request)
# =============================================================================
signal accept_friends_response(code: int, friend_id: String)
signal block_player_response(blocked_user_id: String, code: int, namespace_param: String)
signal cancel_friends_response(code: int, friend_id: String)
signal cancel_matchmaking_response(code: int, ticket_id: String)
signal change_region_response(code: int)
signal clear_matchmaking_response(code: int)
signal create_ds_response(code: int)
signal friends_status_response(
	activity: Array,
	availability: Array,
	code: int,
	friends_id: Array,
	platform: Array,
	last_seen_at: Array
)
signal get_all_session_attribute_response(attributes: Dictionary, code: int)
signal get_blocked_player_response(code: int, blocked_user_ids: Array)
signal get_friendship_status_response(code: int, friendship_status: String, friend_id: String)
signal get_session_attribute_response(code: int, value: String)
signal join_default_channel_response(channel_slug: String, code: int)
signal list_incoming_friends_response(code: int, friends_id: Array)
signal list_incoming_friends_with_time_response(code: int, data: Array)
signal list_of_friends_response(code: int, friends_id: Array)
signal list_outgoing_friends_response(code: int, friends_id: Array)
signal list_outgoing_friends_with_time_response(code: int, data: Array)
signal offline_notification_response(code: int)
signal party_chat_response(code: int)
signal party_create_response(
	code: int,
	invitation_token: String,
	invitees: Array,
	leader: String,
	leader_id: String,
	members: Array,
	party_id: String,
	party_code: String
)
signal party_delete_code_response(code: int)
signal party_generate_code_response(code: int, party_code: String)
signal party_get_code_response(code: int, party_code: String)
signal party_info_response(
	code: int,
	custom_attributes: Dictionary,
	invitation_token: String,
	invitees: Array,
	leader: String,
	leader_id: String,
	members: Array,
	party_id: String,
	updated_at: int
)
signal party_invite_response(code: int, invitee_id: String, invitee_is_connected: bool)
signal party_join_response(
	code: int,
	invitation_token: String,
	invitees: Array,
	leader: String,
	leader_id: String,
	members: Array,
	party_id: String
)
signal party_join_via_code_response(
	code: int,
	invitation_token: String,
	invitees: Array,
	leader: String,
	leader_id: String,
	members: Array,
	party_id: String
)
signal party_kick_response(code: int, user_id: String)
signal party_leave_response(code: int)
signal party_promote_leader_response(
	code: int,
	invitation_token: String,
	invitees: Array,
	leader: String,
	leader_id: String,
	members: Array,
	party_id: String
)
signal party_reject_response(code: int, party_id: String)
signal party_send_notif_response(code: int)
signal personal_chat_history_response(chat: String, code: int, friend_id: String)
signal personal_chat_response(code: int)
signal refresh_token_response(code: int)
signal reject_friends_response(code: int, friend_id: String)
signal request_friends_by_public_id_response(code: int, friend_id: String)
signal request_friends_response(code: int, friend_id: String)
signal send_channel_chat_response(code: int)
signal set_ready_consent_response(code: int)
signal set_reject_consent_response(code: int)
signal set_session_attribute_response(code: int)
signal set_user_status_response(code: int)
signal start_matchmaking_response(code: int, ticket_id: String, message: String)
signal unblock_player_response(code: int, namespace_param: String, unblocked_user_id: String)
signal unfriend_response(code: int, friend_id: String)
signal user_metric_response(code: int, player_count: int)

## Emitted for lobby messages that don't match the standard naming convention.
## Allows handling of custom message types, future server updates, or debugging.
## Parameters match the raw WebSocket message format from AccelByte servers.
signal unclassified_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary)

# =============================================================================
# Initialization
# =============================================================================


func _init(ws: RefCounted = null) -> void:
	if ws:
		setup(ws)


## Connect this service to a WebSocket transport.
func setup(ws: RefCounted) -> void:
	_ws = ws
	_ws.message_received.connect(_on_message_received)


## Returns the underlying WebSocket transport.
## Used by AccelByteP2PManager to send raw signaling messages.
func get_ws_transport() -> RefCounted:
	return _ws


# =============================================================================
# Standard Service Interface (for compatibility with get_service() pattern)
# =============================================================================


## Standard service interface - not used by LobbyWsService (uses WebSocket transport).
func initialize(http: RefCounted) -> void:
	pass  # No-op - LobbyWsService uses WebSocket transport, not HTTP


## Standard service interface - not applicable to WebSocket services.
func set_base_url(url: String) -> void:
	pass  # No-op - LobbyWsService uses WebSocket URL via transport


## Standard service interface - not applicable to WebSocket services.
func set_service_url(url: String) -> void:
	pass  # No-op - LobbyWsService uses WebSocket URL via transport


## Standard service interface - not applicable to WebSocket services.
func set_namespace(ns: String) -> void:
	pass  # No-op - LobbyWsService doesn't need namespace


## Standard service interface - not applicable to WebSocket services.
func set_auth_token(token: String) -> void:
	pass  # No-op - auth handled by WebSocket transport


## Standard service interface - not applicable to WebSocket services.
func set_client_id(id: String) -> void:
	pass  # No-op - auth handled by WebSocket transport


## Standard service interface - not applicable to WebSocket services.
func set_client_secret(secret: String) -> void:
	pass  # No-op - auth handled by WebSocket transport


## Standard service interface - not applicable to WebSocket services.
func set_token_callback(cb: Callable) -> void:
	pass  # No-op - token management handled by SDK


## Standard service interface - not applicable to WebSocket services.
func set_revoke_callback(cb: Callable) -> void:
	pass  # No-op - token management handled by SDK


# =============================================================================
# Request Methods — one typed method per request definition
# =============================================================================
## acceptFriendsRequest
func accept_friends_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendId"] = friend_id
	_ws.send_request("acceptFriendsRequest", fields, callback)


## blockPlayerRequest
func block_player_request(
	blocked_user_id: String, namespace_param: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not blocked_user_id.is_empty():
		fields["blockedUserId"] = blocked_user_id
	if not namespace_param.is_empty():
		fields["namespace"] = namespace_param
	_ws.send_request("blockPlayerRequest", fields, callback)


## cancelFriendsRequest
func cancel_friends_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendId"] = friend_id
	_ws.send_request("cancelFriendsRequest", fields, callback)


## cancelMatchmakingRequest
func cancel_matchmaking_request(
	game_mode: String, is_temp_party: bool, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not game_mode.is_empty():
		fields["gameMode"] = game_mode
	fields["isTempParty"] = is_temp_party
	_ws.send_request("cancelMatchmakingRequest", fields, callback)


## changeRegionRequest
func change_region_request(region: String = "", callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not region.is_empty():
		fields["region"] = region
	_ws.send_request("changeRegionRequest", fields, callback)


## clearPartyMatchmakingRequest
func clear_party_matchmaking_request(
	party_id: String = "", callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not party_id.is_empty():
		fields["partyID"] = party_id
	_ws.send_request("clearPartyMatchmakingRequest", fields, callback)


## createDSRequest
func create_ds_request(
	match_id: String = "",
	game_mode: String = "",
	server_name: String = "",
	client_version: String = "",
	region: String = "",
	deployment: String = "",
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not match_id.is_empty():
		fields["matchId"] = match_id
	if not game_mode.is_empty():
		fields["gameMode"] = game_mode
	if not server_name.is_empty():
		fields["serverName"] = server_name
	if not client_version.is_empty():
		fields["clientVersion"] = client_version
	if not region.is_empty():
		fields["region"] = region
	if not deployment.is_empty():
		fields["deployment"] = deployment
	_ws.send_request("createDSRequest", fields, callback)


## friendsStatusRequest
func friends_status_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("friendsStatusRequest", fields, callback)


## getAllSessionAttributeRequest
func get_all_session_attribute_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("getAllSessionAttributeRequest", fields, callback)


## getBlockedPlayerRequest
func get_blocked_player_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("getBlockedPlayerRequest", fields, callback)


## getFriendshipStatusRequest
func get_friendship_status_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendId"] = friend_id
	_ws.send_request("getFriendshipStatusRequest", fields, callback)


## getSessionAttributeRequest
func get_session_attribute_request(key: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not key.is_empty():
		fields["key"] = key
	_ws.send_request("getSessionAttributeRequest", fields, callback)


## joinDefaultChannelRequest
func join_default_channel_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("joinDefaultChannelRequest", fields, callback)


## listIncomingFriendsRequest
func list_incoming_friends_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("listIncomingFriendsRequest", fields, callback)


## listIncomingFriendsWithTimeRequest
func list_incoming_friends_with_time_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("listIncomingFriendsWithTimeRequest", fields, callback)


## listOfFriendsRequest
func list_of_friends_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("listOfFriendsRequest", fields, callback)


## listOutgoingFriendsRequest
func list_outgoing_friends_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("listOutgoingFriendsRequest", fields, callback)


## listOutgoingFriendsWithTimeRequest
func list_outgoing_friends_with_time_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("listOutgoingFriendsWithTimeRequest", fields, callback)


## offlineNotificationRequest
func offline_notification_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("offlineNotificationRequest", fields, callback)


## partyChatRequest
func party_chat_request(
	from: String, payload: String, received_at: String, to: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not from.is_empty():
		fields["from"] = from
	if not payload.is_empty():
		fields["payload"] = payload
	if not received_at.is_empty():
		fields["receivedAt"] = received_at
	if not to.is_empty():
		fields["to"] = to
	_ws.send_request("partyChatRequest", fields, callback)


## partyCreateRequest
func party_create_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("partyCreateRequest", fields, callback)


## partyDeleteCodeRequest
func party_delete_code_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("partyDeleteCodeRequest", fields, callback)


## partyGenerateCodeRequest
func party_generate_code_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("partyGenerateCodeRequest", fields, callback)


## partyGetCodeRequest
func party_get_code_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("partyGetCodeRequest", fields, callback)


## partyInfoRequest
func party_info_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("partyInfoRequest", fields, callback)


## partyInviteRequest
func party_invite_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendID"] = friend_id
	_ws.send_request("partyInviteRequest", fields, callback)


## partyJoinRequest
func party_join_request(
	invitation_token: String, party_id: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not invitation_token.is_empty():
		fields["invitationToken"] = invitation_token
	if not party_id.is_empty():
		fields["partyID"] = party_id
	_ws.send_request("partyJoinRequest", fields, callback)


## partyJoinViaCodeRequest
func party_join_via_code_request(party_code: String = "", callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not party_code.is_empty():
		fields["partyCode"] = party_code
	_ws.send_request("partyJoinViaCodeRequest", fields, callback)


## partyKickRequest
func party_kick_request(member_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not member_id.is_empty():
		fields["memberID"] = member_id
	_ws.send_request("partyKickRequest", fields, callback)


## partyLeaveRequest
func party_leave_request(ignore_user_registry: bool, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	fields["ignoreUserRegistry"] = ignore_user_registry
	_ws.send_request("partyLeaveRequest", fields, callback)


## partyPromoteLeaderRequest
func party_promote_leader_request(
	new_leader_user_id: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not new_leader_user_id.is_empty():
		fields["newLeaderUserId"] = new_leader_user_id
	_ws.send_request("partyPromoteLeaderRequest", fields, callback)


## partyPromoteRandomLeaderRequest
func party_promote_random_leader_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("partyPromoteRandomLeaderRequest", fields, callback)


## partyRejectRequest
func party_reject_request(
	invitation_token: String, party_id: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not invitation_token.is_empty():
		fields["invitationToken"] = invitation_token
	if not party_id.is_empty():
		fields["partyID"] = party_id
	_ws.send_request("partyRejectRequest", fields, callback)


## partySendNotifRequest
func party_send_notif_request(
	topic: String = "", payload: String = "", callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not topic.is_empty():
		fields["topic"] = topic
	if not payload.is_empty():
		fields["payload"] = payload
	_ws.send_request("partySendNotifRequest", fields, callback)


## personalChatHistoryRequest
func personal_chat_history_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendId"] = friend_id
	_ws.send_request("personalChatHistoryRequest", fields, callback)


## personalChatRequest
func personal_chat_request(
	from: String, payload: String, received_at: String, to: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not from.is_empty():
		fields["from"] = from
	if not payload.is_empty():
		fields["payload"] = payload
	if not received_at.is_empty():
		fields["receivedAt"] = received_at
	if not to.is_empty():
		fields["to"] = to
	_ws.send_request("personalChatRequest", fields, callback)


## refreshTokenRequest
func refresh_token_request(token: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not token.is_empty():
		fields["token"] = token
	_ws.send_request("refreshTokenRequest", fields, callback)


## rejectFriendsRequest
func reject_friends_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendId"] = friend_id
	_ws.send_request("rejectFriendsRequest", fields, callback)


## requestFriendsByPublicIDRequest
func request_friends_by_public_id_request(
	friend_public_id: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not friend_public_id.is_empty():
		fields["friendPublicId"] = friend_public_id
	_ws.send_request("requestFriendsByPublicIDRequest", fields, callback)


## requestFriendsRequest
func request_friends_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendId"] = friend_id
	_ws.send_request("requestFriendsRequest", fields, callback)


## sendChannelChatRequest
func send_channel_chat_request(
	channel_slug: String, payload: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not channel_slug.is_empty():
		fields["channelSlug"] = channel_slug
	if not payload.is_empty():
		fields["payload"] = payload
	_ws.send_request("sendChannelChatRequest", fields, callback)


## setReadyConsentRequest
func set_ready_consent_request(match_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not match_id.is_empty():
		fields["matchId"] = match_id
	_ws.send_request("setReadyConsentRequest", fields, callback)


## setRejectConsentRequest
func set_reject_consent_request(match_id: String = "", callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not match_id.is_empty():
		fields["matchId"] = match_id
	_ws.send_request("setRejectConsentRequest", fields, callback)


## setSessionAttributeRequest
func set_session_attribute_request(
	key: String, namespace_param: String, value: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not key.is_empty():
		fields["key"] = key
	if not namespace_param.is_empty():
		fields["namespace"] = namespace_param
	if not value.is_empty():
		fields["value"] = value
	_ws.send_request("setSessionAttributeRequest", fields, callback)


## setUserStatusRequest
func set_user_status_request(
	activity: String, availability: String, platform: String = "", callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not activity.is_empty():
		fields["activity"] = activity
	if not availability.is_empty():
		fields["availability"] = availability
	if not platform.is_empty():
		fields["platform"] = platform
	_ws.send_request("setUserStatusRequest", fields, callback)


## startMatchmakingRequest
func start_matchmaking_request(
	extra_attributes: String,
	game_mode: String,
	party_attributes: Dictionary,
	priority: int,
	temp_party: String,
	ticket_id: String = "",
	server_name: String = "",
	client_version: String = "",
	latencies: String = "",
	callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not extra_attributes.is_empty():
		fields["extraAttributes"] = extra_attributes
	if not game_mode.is_empty():
		fields["gameMode"] = game_mode
	if not party_attributes.is_empty():
		fields["partyAttributes"] = party_attributes
	fields["priority"] = priority
	if not temp_party.is_empty():
		fields["tempParty"] = temp_party
	if not ticket_id.is_empty():
		fields["ticketId"] = ticket_id
	if not server_name.is_empty():
		fields["serverName"] = server_name
	if not client_version.is_empty():
		fields["clientVersion"] = client_version
	if not latencies.is_empty():
		fields["latencies"] = latencies
	_ws.send_request("startMatchmakingRequest", fields, callback)


## unblockPlayerRequest
func unblock_player_request(
	namespace_param: String, unblocked_user_id: String, callback: Callable = Callable()
) -> void:
	var fields: Dictionary = {}
	if not namespace_param.is_empty():
		fields["namespace"] = namespace_param
	if not unblocked_user_id.is_empty():
		fields["unblockedUserId"] = unblocked_user_id
	_ws.send_request("unblockPlayerRequest", fields, callback)


## unfriendRequest
func unfriend_request(friend_id: String, callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}
	if not friend_id.is_empty():
		fields["friendId"] = friend_id
	_ws.send_request("unfriendRequest", fields, callback)


## userMetricRequest
func user_metric_request(callback: Callable = Callable()) -> void:
	var fields: Dictionary = {}

	_ws.send_request("userMetricRequest", fields, callback)


# =============================================================================
# Internal — Message Router
# =============================================================================


func _on_message_received(msg_type: String, msg_id: int, code: int, fields: Dictionary) -> void:
	match msg_type:
		"acceptFriendsNotif":
			accept_friends_notif.emit(fields.get("friendid", ""))
		"blockPlayerNotif":
			block_player_notif.emit(fields.get("blockeduserid", ""), fields.get("userid", ""))
		"cancelFriendsNotif":
			cancel_friends_notif.emit(fields.get("userid", ""))
		"channelChatNotif":
			channel_chat_notif.emit(
				fields.get("channelslug", ""),
				fields.get("from", ""),
				fields.get("payload", ""),
				fields.get("sentat", "")
			)
		"connectNotif":
			connect_notif.emit(
				fields.get("lobbysessionid", ""),
				fields.get("logintype", ""),
				_as_int(fields.get("reconnectfromcode"), -1),
				_as_int(fields.get("sequenceid"), -1),
				_as_int(fields.get("sequencenumber"), -1)
			)
		"disconnectNotif":
			disconnect_notif.emit(fields.get("connectionid", ""), fields.get("namespace", ""))
		"dsNotif":
			ds_notif.emit(
				fields.get("alternateips", []),
				fields.get("customattribute", ""),
				fields.get("deployment", ""),
				fields.get("serverversion", ""),
				fields.get("imageversion", ""),
				fields.get("ip", ""),
				_as_bool(fields.get("isok"), false),
				_as_bool(fields.get("isoverridegameversion"), false),
				fields.get("lastupdate", ""),
				fields.get("matchid", ""),
				fields.get("message", ""),
				fields.get("namespace", ""),
				fields.get("podname", ""),
				_as_int(fields.get("port"), -1),
				fields.get("ports", {}),
				fields.get("protocol", ""),
				fields.get("provider", ""),
				fields.get("region", ""),
				fields.get("sessionid", ""),
				fields.get("status", "")
			)
		"errorNotif":
			error_notif.emit(fields.get("message", ""), fields.get("requesttype", ""))
		"matchmakingNotif":
			matchmaking_notif.emit(
				fields.get("counterpartymember", []),
				fields.get("matchid", ""),
				fields.get("message", ""),
				fields.get("partymember", []),
				_as_int(fields.get("duration"), -1),
				fields.get("status", ""),
				fields.get("ticketid", ""),
				fields.get("gamemode", ""),
				fields.get("deployment", ""),
				fields.get("clientversion", ""),
				_as_bool(fields.get("joinable"), false),
				fields.get("matchingallies", {}),
				fields.get("region", ""),
				_as_int(fields.get("errorcode"), -1)
			)
		"messageNotif":
			message_notif.emit(
				fields.get("from", ""),
				fields.get("payload", ""),
				fields.get("sentat", ""),
				_as_int(fields.get("sequenceid"), -1),
				_as_int(fields.get("sequencenumber"), -1),
				fields.get("to", ""),
				fields.get("topic", "")
			)
		"messageSessionNotif":
			var _raw_payload: String = fields.get("payload", "")
			var _decoded_payload: String = _raw_payload
			if not _raw_payload.is_empty() and not _raw_payload.begins_with("{"):
				var _b64_regex := RegEx.new()
				_b64_regex.compile("^[A-Za-z0-9+/]+=*$")
				if _b64_regex.search(_raw_payload) != null:
					var _rem: int = _raw_payload.length() % 4
					var _padded: String = _raw_payload + "=".repeat(4 - _rem if _rem != 0 else 0)
					var _try_decode: String = Marshalls.base64_to_utf8(_padded)
					if not _try_decode.is_empty():
						_decoded_payload = _try_decode
			message_session_notif.emit(
				fields.get("from", ""),
				_decoded_payload,
				fields.get("sentat", ""),
				fields.get("to", ""),
				fields.get("topic", ""),
				_as_int(fields.get("sequenceid"), -1),
				_as_int(fields.get("sequencenumber"), -1)
			)
		"partyChatNotif":
			party_chat_notif.emit(
				fields.get("from", ""),
				fields.get("payload", ""),
				fields.get("receivedat", ""),
				fields.get("to", "")
			)
		"partyConnectNotif":
			party_connect_notif.emit(fields.get("userid", ""), fields.get("partyid", ""))
		"partyDataUpdateNotif":
			party_data_update_notif.emit(
				fields.get("custom_attribute", {}),
				fields.get("invitees", []),
				fields.get("leader", ""),
				fields.get("members", []),
				fields.get("namespace", ""),
				fields.get("partyid", ""),
				_as_int(fields.get("updatedat"), -1)
			)
		"partyDisconnectNotif":
			party_disconnect_notif.emit(fields.get("userid", ""), fields.get("partyid", ""))
		"partyGetInvitedNotif":
			party_get_invited_notif.emit(
				fields.get("from", ""), fields.get("invitationtoken", ""), fields.get("partyid", "")
			)
		"partyInviteNotif":
			party_invite_notif.emit(
				fields.get("inviteeid", ""),
				fields.get("inviterid", ""),
				_as_bool(fields.get("inviteeisconnected"), false)
			)
		"partyJoinNotif":
			party_join_notif.emit(fields.get("userid", ""))
		"partyKickNotif":
			party_kick_notif.emit(
				fields.get("leaderid", ""),
				fields.get("partyid", ""),
				fields.get("userid", ""),
				fields.get("leader", "")
			)
		"partyLeaveNotif":
			party_leave_notif.emit(
				fields.get("leaderid", ""),
				fields.get("userid", ""),
				fields.get("leader", ""),
				fields.get("partyid", "")
			)
		"partyNotif":
			party_notif.emit(
				fields.get("sender", ""), fields.get("topic", ""), fields.get("payload", "")
			)
		"partyRejectNotif":
			party_reject_notif.emit(
				fields.get("leaderid", ""),
				fields.get("partyid", ""),
				fields.get("userid", ""),
				fields.get("leader", "")
			)
		"personalChatNotif":
			personal_chat_notif.emit(
				fields.get("from", ""),
				fields.get("payload", ""),
				fields.get("receivedat", ""),
				fields.get("to", "")
			)
		"rejectFriendsNotif":
			reject_friends_notif.emit(fields.get("userid", ""))
		"rematchmakingNotif":
			rematchmaking_notif.emit(_as_int(fields.get("banduration"), -1))
		"requestFriendsNotif":
			request_friends_notif.emit(fields.get("friendid", ""))
		"setReadyConsentNotif":
			set_ready_consent_notif.emit(fields.get("matchid", ""), fields.get("userid", ""))
		"setRejectConsentNotif":
			set_reject_consent_notif.emit(fields.get("matchid", ""), fields.get("userid", ""))
		"shutdownNotif":
			shutdown_notif.emit(fields.get("message", ""))
		"signalingP2PNotif":
			signaling_p2p_notif.emit(fields.get("destinationid", ""), fields.get("message", ""))
		"unblockPlayerNotif":
			unblock_player_notif.emit(fields.get("unblockeduserid", ""), fields.get("userid", ""))
		"unfriendNotif":
			unfriend_notif.emit(fields.get("friendid", ""))
		"userStatusNotif":
			user_status_notif.emit(
				fields.get("activity", ""),
				fields.get("availability", ""),
				fields.get("lastseenat", ""),
				fields.get("platform", ""),
				fields.get("userid", "")
			)
		"acceptFriendsResponse":
			accept_friends_response.emit(code, fields.get("friendid", ""))
		"blockPlayerResponse":
			block_player_response.emit(
				fields.get("blockeduserid", ""), code, fields.get("namespace", "")
			)
		"cancelFriendsResponse":
			cancel_friends_response.emit(code, fields.get("friendid", ""))
		"cancelMatchmakingResponse":
			cancel_matchmaking_response.emit(code, fields.get("ticketid", ""))
		"changeRegionResponse":
			change_region_response.emit(code)
		"clearMatchmakingResponse":
			clear_matchmaking_response.emit(code)
		"createDSResponse":
			create_ds_response.emit(code)
		"friendsStatusResponse":
			friends_status_response.emit(
				fields.get("activity", []),
				fields.get("availability", []),
				code,
				fields.get("friendsid", []),
				fields.get("platform", []),
				fields.get("lastseenat", [])
			)
		"getAllSessionAttributeResponse":
			get_all_session_attribute_response.emit(fields.get("attributes", {}), code)
		"getBlockedPlayerResponse":
			get_blocked_player_response.emit(code, fields.get("blockeduserids", []))
		"getFriendshipStatusResponse":
			get_friendship_status_response.emit(
				code, fields.get("friendshipstatus", ""), fields.get("friendid", "")
			)
		"getSessionAttributeResponse":
			get_session_attribute_response.emit(code, fields.get("value", ""))
		"joinDefaultChannelResponse":
			join_default_channel_response.emit(fields.get("channelslug", ""), code)
		"listIncomingFriendsResponse":
			list_incoming_friends_response.emit(code, fields.get("friendsid", []))
		"listIncomingFriendsWithTimeResponse":
			list_incoming_friends_with_time_response.emit(code, fields.get("data", []))
		"listOfFriendsResponse":
			list_of_friends_response.emit(code, fields.get("friendsid", []))
		"listOutgoingFriendsResponse":
			list_outgoing_friends_response.emit(code, fields.get("friendsid", []))
		"listOutgoingFriendsWithTimeResponse":
			list_outgoing_friends_with_time_response.emit(code, fields.get("data", []))
		"offlineNotificationResponse":
			offline_notification_response.emit(code)
		"partyChatResponse":
			party_chat_response.emit(code)
		"partyCreateResponse":
			party_create_response.emit(
				code,
				fields.get("invitationtoken", ""),
				fields.get("invitees", []),
				fields.get("leader", ""),
				fields.get("leaderid", ""),
				fields.get("members", []),
				fields.get("partyid", ""),
				fields.get("partycode", "")
			)
		"partyDeleteCodeResponse":
			party_delete_code_response.emit(code)
		"partyGenerateCodeResponse":
			party_generate_code_response.emit(code, fields.get("partycode", ""))
		"partyGetCodeResponse":
			party_get_code_response.emit(code, fields.get("partycode", ""))
		"partyInfoResponse":
			party_info_response.emit(
				code,
				fields.get("custom_attributes", {}),
				fields.get("invitationtoken", ""),
				fields.get("invitees", []),
				fields.get("leader", ""),
				fields.get("leaderid", ""),
				fields.get("members", []),
				fields.get("partyid", ""),
				_as_int(fields.get("updatedat"), -1)
			)
		"partyInviteResponse":
			party_invite_response.emit(
				code, fields.get("inviteeid", ""), _as_bool(fields.get("inviteeisconnected"), false)
			)
		"partyJoinResponse":
			party_join_response.emit(
				code,
				fields.get("invitationtoken", ""),
				fields.get("invitees", []),
				fields.get("leader", ""),
				fields.get("leaderid", ""),
				fields.get("members", []),
				fields.get("partyid", "")
			)
		"partyJoinViaCodeResponse":
			party_join_via_code_response.emit(
				code,
				fields.get("invitationtoken", ""),
				fields.get("invitees", []),
				fields.get("leader", ""),
				fields.get("leaderid", ""),
				fields.get("members", []),
				fields.get("partyid", "")
			)
		"partyKickResponse":
			party_kick_response.emit(code, fields.get("userid", ""))
		"partyLeaveResponse":
			party_leave_response.emit(code)
		"partyPromoteLeaderResponse":
			party_promote_leader_response.emit(
				code,
				fields.get("invitationtoken", ""),
				fields.get("invitees", []),
				fields.get("leader", ""),
				fields.get("leaderid", ""),
				fields.get("members", []),
				fields.get("partyid", "")
			)
		"partyRejectResponse":
			party_reject_response.emit(code, fields.get("partyid", ""))
		"partySendNotifResponse":
			party_send_notif_response.emit(code)
		"personalChatHistoryResponse":
			personal_chat_history_response.emit(
				fields.get("chat", ""), code, fields.get("friendid", "")
			)
		"personalChatResponse":
			personal_chat_response.emit(code)
		"refreshTokenResponse":
			refresh_token_response.emit(code)
		"rejectFriendsResponse":
			reject_friends_response.emit(code, fields.get("friendid", ""))
		"requestFriendsByPublicIDResponse":
			request_friends_by_public_id_response.emit(code, fields.get("friendid", ""))
		"requestFriendsResponse":
			request_friends_response.emit(code, fields.get("friendid", ""))
		"sendChannelChatResponse":
			send_channel_chat_response.emit(code)
		"setReadyConsentResponse":
			set_ready_consent_response.emit(code)
		"setRejectConsentResponse":
			set_reject_consent_response.emit(code)
		"setSessionAttributeResponse":
			set_session_attribute_response.emit(code)
		"setUserStatusResponse":
			set_user_status_response.emit(code)
		"startMatchmakingResponse":
			start_matchmaking_response.emit(
				code, fields.get("ticketid", ""), fields.get("message", "")
			)
		"unblockPlayerResponse":
			unblock_player_response.emit(
				code, fields.get("namespace", ""), fields.get("unblockeduserid", "")
			)
		"unfriendResponse":
			unfriend_response.emit(code, fields.get("friendid", ""))
		"userMetricResponse":
			user_metric_response.emit(code, _as_int(fields.get("playercount"), -1))
		_:
			# Handle unclassified message types (following Unity SDK pattern)
			push_warning(
				(
					"[LobbyWsService] Unclassified message type '%s' received. Available via unclassified_message_received signal."
					% msg_type
				)
			)
			unclassified_message_received.emit(msg_type, msg_id, code, fields)


# Values of the text format arrive as strings; convert them to the declared signal parameter type.
static func _as_int(value, default: int = -1) -> int:
	if value is int:
		return value
	if value is float:
		return int(value)
	if value is String and value.is_valid_int():
		return value.to_int()
	return default


static func _as_float(value, default: float = -1.0) -> float:
	if value is float or value is int:
		return float(value)
	if value is String and value.is_valid_float():
		return value.to_float()
	return default


static func _as_bool(value, default: bool = false) -> bool:
	if value is bool:
		return value
	if value is String:
		return value.to_lower() == "true"
	return default
