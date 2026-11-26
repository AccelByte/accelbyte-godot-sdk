## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_ws_codec_json_envelope.gd
## Codec for the "json-envelope" wire format (used by DSHub)
## =============================================================================
##
## Every message is a JSON object with a `topic` (the message type) and a `payload`:
##   {"topic":"serverClaimed","payload":{"session_id":"abc","namespace":"ns"}}
##
## There are no request ids, so responses cannot be matched to requests.
## Field names keep the exact case of the wire. There is no heartbeat at this level.
## =============================================================================

class_name AccelByteWsJsonEnvelopeCodec
extends AccelByteWsCodec


func encode(msg_type: String, fields: Dictionary, _msg_id: int = -1) -> String:
	return JSON.stringify({"topic": msg_type, "payload": fields})


func decode(raw: String) -> Dictionary:
	var parsed = JSON.parse_string(raw)
	if not (parsed is Dictionary):
		return {}
	var topic := str(parsed.get("topic", ""))
	if topic.is_empty():
		return {}
	var payload = parsed.get("payload", {})
	return {
		"type": topic,
		"id": -1,
		"code": 0,
		"fields": payload if payload is Dictionary else {"value": payload},
	}
