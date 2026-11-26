## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_ws_codec.gd
## Base class of the AccelByte WebSocket codecs
## =============================================================================
##
## A codec turns a message into the text sent over a WebSocket and turns received
## text back into a message. Each AccelByte WebSocket service speaks its own wire
## format, so each format has one codec (Lobby text, keyed JSON, JSON envelope,
## JSON-RPC). The codec never touches the network; AccelByteWsTransport owns the
## socket, heartbeat, reconnect and request/response matching.
##
## Game code does not use codecs directly.
## =============================================================================

class_name AccelByteWsCodec
extends RefCounted


## Encode one outgoing message. `msg_id` is the id allocated by the transport,
## or -1 when the caller wants no id.
func encode(_msg_type: String, _fields: Dictionary, _msg_id: int = -1) -> String:
	push_error("[AccelByteWsCodec] encode() is not implemented by %s" % get_script().resource_path)
	return ""


## Decode one received text frame into
## {"type": String, "id": int, "code": int, "fields": Dictionary}.
## `id` is -1 and `code` is 0 when the format has none. Return an empty
## dictionary, or a dictionary with an empty "type", for frames that carry no message.
func decode(_raw: String) -> Dictionary:
	return {}


## Text of the periodic heartbeat, or an empty string when the service has none.
func heartbeat_message() -> String:
	return ""


## Default heartbeat interval in seconds (only used when heartbeat_message() is not empty).
func heartbeat_interval_sec() -> float:
	return 0.0


## True when the format carries request ids that come back in the response, so a
## callback can be matched to its response.
func supports_correlation() -> bool:
	return false


## Classify a decoded message for the transport. Returns "connected", "disconnected",
## "heartbeat" (a server heartbeat that must be answered) or "" for a normal message.
func control_kind(_decoded: Dictionary) -> String:
	return ""


## True when the transport should emit `connected` as soon as the socket opens.
## False when the server announces the connection with its own message
## (control_kind() returns "connected").
func connected_on_open() -> bool:
	return true
