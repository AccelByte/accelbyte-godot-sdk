## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_ws_codec_lobby_text.gd
## Codec for the AccelByte Lobby text protocol (`key: value` lines)
## =============================================================================
##
## Wire example:
##   type: acceptFriendsRequest
##   id: 7
##   friendId: abc
##
## Decoded keys are lowercased on purpose: the generated LobbyWsService reads fields
## by lowercased key (for example "friendid"). List values arrive as `[a,b,]` or
## `[a, b]` text and are split on commas; empty entries (trailing comma) are dropped.
## =============================================================================

class_name AccelByteWsLobbyTextCodec
extends AccelByteWsCodec


func encode(msg_type: String, fields: Dictionary, msg_id: int = -1) -> String:
	var lines: PackedStringArray = PackedStringArray()
	lines.push_back("type: " + msg_type)
	if msg_id >= 0:
		lines.push_back("id: " + str(msg_id))
	for key in fields:
		var value = fields[key]
		if value is Array:
			var items: PackedStringArray = PackedStringArray()
			for item in value:
				items.push_back(str(item))
			lines.push_back(key + ": [" + ",".join(items) + "]")
		elif value is bool:
			lines.push_back(key + ": " + ("true" if value else "false"))
		else:
			lines.push_back(key + ": " + str(value))
	return "\n".join(lines)


func decode(raw: String) -> Dictionary:
	var flat: Dictionary = {}
	flat["id"] = -1
	flat["code"] = 0
	var text_id := ""

	for line in raw.split("\n"):
		if line.is_empty():
			continue
		var sep = line.find(": ")
		if sep == -1:
			continue
		# Keys are lowercased for case-insensitive lookup (see the header comment).
		var key = line.substr(0, sep).to_lower()
		var value = line.substr(sep + 2)

		if key == "id":
			# Responses carry the numeric id of the request; some notifications carry a text id (a 32-character hex id).
			# A text id is not a message id: it stays a string in the fields, and the message id is -1.
			if _is_small_int(value):
				flat["id"] = value.to_int()
			else:
				flat["id"] = -1
				text_id = value
		elif key == "code":
			flat["code"] = value.to_int() if _is_small_int(value) else 0
		elif value.begins_with("[") and value.ends_with("]"):
			# Array: [item1,item2,item3] — the server may send a trailing comma
			var inner = value.substr(1, value.length() - 2)
			if inner.is_empty():
				flat[key] = []
			else:
				var cleaned: Array = []
				for item in inner.split(","):
					if not item.is_empty():
						cleaned.append(item)
				flat[key] = cleaned
		else:
			flat[key] = value

	var fields: Dictionary = {}
	for key in flat.keys():
		if key not in ["type", "id", "code"]:
			fields[key] = flat[key]
	if not text_id.is_empty():
		fields["id"] = text_id
	return {
		"type": str(flat.get("type", "")),
		"id": int(flat["id"]),
		"code": int(flat["code"]),
		"fields": fields,
	}


## True for a plain integer that fits a 64-bit int; String.to_int() reports an engine error for anything else.
func _is_small_int(value: String) -> bool:
	return value.is_valid_int() and value.length() <= 18


func heartbeat_message() -> String:
	return "type: heartbeat"


## Default 4 s (AccelByte server recommendation), overridable in project.godot:
## [accelbyte] lobby_heartbeat_interval_sec=4.0
func heartbeat_interval_sec() -> float:
	return ProjectSettings.get_setting("accelbyte/lobby_heartbeat_interval_sec", 4.0)


func supports_correlation() -> bool:
	return true


func control_kind(decoded: Dictionary) -> String:
	match decoded.get("type", ""):
		"connectNotif":
			return "connected"
		"disconnectNotif":
			return "disconnected"
		"heartbeat":
			return "heartbeat"
	return ""


## Lobby announces the connection with connectNotif, not when the socket opens.
func connected_on_open() -> bool:
	return false
