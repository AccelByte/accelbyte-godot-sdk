## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_p2p_lobby_signaling.gd
## Carries AccelByteMultiplayerP2P signaling over the AccelByte Lobby
## =============================================================================
##
## Messages travel as the Lobby type "signalingP2PNotif". On receive, the Lobby server flips
## `destinationId`, so the value in the notification is the SENDER's user id.
##
## Usage:
##   var signaling := AccelByteP2PLobbySignaling.new(lobby_ws_service)
## =============================================================================

class_name AccelByteP2PLobbySignaling
extends RefCounted

## A signaling message arrived. `sender_user_id` is the AccelByte user id of the sender.
signal signaling_received(sender_user_id: String, base64_message: String)

var _lobby


func _init(lobby_ws) -> void:
	_lobby = lobby_ws
	_lobby.signaling_p2p_notif.connect(
		func(destination_id: String, message: String):
			signaling_received.emit(destination_id, message)
	)


func send_signaling(destination_user_id: String, base64_message: String) -> void:
	_lobby.get_ws_transport().send_request(
		"signalingP2PNotif", {"destinationId": destination_user_id, "message": base64_message}
	)
