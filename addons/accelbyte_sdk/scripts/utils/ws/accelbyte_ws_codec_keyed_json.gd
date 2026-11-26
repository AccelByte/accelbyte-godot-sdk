## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_ws_codec_keyed_json.gd
## Codec for the "keyed-json" wire format (used by the AMS watchdog)
## =============================================================================
##
## Every message is a JSON object with one top-level key, the message type, whose value
## is the payload:
##   {"ready":{"dsid":"ds-1"}}
##   {"heartbeat":{}}
##   {"drain":{"currentState":"Ready"}}
##
## There are no request ids, so responses cannot be matched to requests.
## Field names keep the exact case of the wire.
##
## Heartbeat: when constructed with a heartbeat key, the codec offers that message every
## `interval` seconds, but only after `start_after_key` has been sent (the watchdog wants
## heartbeats only once the server has said `ready`).
## =============================================================================

class_name AccelByteWsKeyedJsonCodec
extends AccelByteWsCodec

var _heartbeat_key: String
var _heartbeat_interval: float
var _start_after_key: String
var _started: bool


func _init(
	heartbeat_key: String = "", heartbeat_interval: float = 0.0, start_after_key: String = ""
) -> void:
	_heartbeat_key = heartbeat_key
	_heartbeat_interval = heartbeat_interval
	_start_after_key = start_after_key
	_started = start_after_key.is_empty()


func encode(msg_type: String, fields: Dictionary, _msg_id: int = -1) -> String:
	if msg_type == _start_after_key:
		_started = true
	return JSON.stringify({msg_type: fields})


func decode(raw: String) -> Dictionary:
	var parsed = JSON.parse_string(raw)
	if not (parsed is Dictionary) or parsed.is_empty():
		return {}
	var key = parsed.keys()[0]
	var value = parsed[key]
	return {
		"type": str(key),
		"id": -1,
		"code": 0,
		"fields": value if value is Dictionary else {"value": value},
	}


func heartbeat_message() -> String:
	if _heartbeat_key.is_empty() or not _started:
		return ""
	return JSON.stringify({_heartbeat_key: {}})


func heartbeat_interval_sec() -> float:
	return _heartbeat_interval
