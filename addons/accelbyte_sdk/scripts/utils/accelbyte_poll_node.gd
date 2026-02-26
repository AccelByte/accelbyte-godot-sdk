## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_poll_node.gd
## Internal auto-poll node for AccelByte WebSocket transport
## =============================================================================
##
## This node is added to the scene tree by AccelByteWsTransport to drive
## WebSocket polling, heartbeat, and reconnection automatically.
##
## No class_name — this is an internal utility, invisible in the editor.
## =============================================================================

extends Node

var _callback: Callable


func _process(_delta: float) -> void:
	if _callback.is_valid():
		_callback.call()
