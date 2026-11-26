## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_ws_codec_jsonrpc.gd
## Codec for JSON-RPC 2.0 over WebSocket (used by Chat v2)
## =============================================================================
##
## Request (params is always present, even when empty):
##   {"jsonrpc":"2.0","id":"7","method":"sendChat","params":{"topicId":"t","message":"hi"}}
## Response (method echoes the request method):
##   {"jsonrpc":"2.0","id":"7","method":"sendChat","result":{"processed":"123"}}
##   {"jsonrpc":"2.0","id":"7","method":"sendChat","error":{"code":"-32603","message":"..."}}
## Server event (no id):
##   {"jsonrpc":"2.0","method":"eventNewChat","params":{...}}
##
## Request ids are strings on the wire; the transport allocates integers, which are
## written as strings and read back as integers (-1 when the id is missing or not numeric).
## protojson int64 values arrive as strings, so error codes are parsed from strings or numbers.
##
## Envelope markers: when the client sends X-Ab-RpcEnvelopeStart / End headers the server
## wraps every message as <start><json><end>. Pass the same two markers to the constructor
## and they are stripped before parsing. Outgoing messages are never wrapped.
##
## Decoded error responses carry the JSON-RPC error code in `code` and the error object
## under fields["error"].
## =============================================================================

class_name AccelByteWsJsonRpcCodec
extends AccelByteWsCodec

var _marker_start: String
var _marker_end: String


func _init(marker_start: String = "", marker_end: String = "") -> void:
	_marker_start = marker_start
	_marker_end = marker_end


func encode(msg_type: String, fields: Dictionary, msg_id: int = -1) -> String:
	var message := {"jsonrpc": "2.0", "method": msg_type, "params": fields}
	if msg_id >= 0:
		message["id"] = str(msg_id)
	return JSON.stringify(message)


func decode(raw: String) -> Dictionary:
	var text := raw
	if (
		not _marker_start.is_empty()
		and text.begins_with(_marker_start)
		and text.ends_with(_marker_end)
	):
		text = text.substr(
			_marker_start.length(), text.length() - _marker_start.length() - _marker_end.length()
		)

	var parsed = JSON.parse_string(text)
	if not (parsed is Dictionary):
		return {}

	var msg_id := -1
	var raw_id = parsed.get("id")
	if raw_id is String and raw_id.is_valid_int():
		msg_id = raw_id.to_int()
	elif raw_id is float or raw_id is int:
		msg_id = int(raw_id)

	var method := str(parsed.get("method", ""))
	var error = parsed.get("error")
	if error is Dictionary and not error.is_empty():
		# A parse error comes back with an empty id and no method.
		return {
			"type": method if not method.is_empty() else "rpcError",
			"id": msg_id,
			"code": _to_int(error.get("code"), -32603),
			"fields": {"error": error},
		}

	var body = parsed.get("result", parsed.get("params", {}))
	return {
		"type": method,
		"id": msg_id,
		"code": 0,
		"fields": body if body is Dictionary else {"value": body},
	}


func supports_correlation() -> bool:
	return true


static func _to_int(value, default: int) -> int:
	if value is int:
		return value
	if value is float:
		return int(value)
	if value is String and value.is_valid_int():
		return value.to_int()
	return default
