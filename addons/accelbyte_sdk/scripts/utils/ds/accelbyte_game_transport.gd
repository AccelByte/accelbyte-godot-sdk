## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## Turns an AccelByte game session into a Godot MultiplayerPeer, for dedicated-server (DS) games.
##
## Godot's MultiplayerPeer is the transport abstraction (ENetMultiplayerPeer, WebSocketMultiplayerPeer,
## WebRTCMultiplayerPeer, ...); this class supplies the part that depends on AccelByte: where the DS is.
##
## Client:
##   var transport := AccelByteGameTransport.new()
##   transport.initialize(sdk)
##   var peer := await transport.connect_to_ds(session_id)   # waits for the session to report the DS address
##   if peer == null: push_error(transport.last_error)
##   else: multiplayer.multiplayer_peer = peer
##
## Server (see AccelByteDedicatedServer for the AMS side):
##   multiplayer.multiplayer_peer = AccelByteGameTransport.create_server(7777)
class_name AccelByteGameTransport
extends RefCounted

var last_error: String = ""

## wait_for_ds_address() gives up after this many 404 answers in a row from the Session service while the session was never
## readable (after it was readable once, the first 404 ends the wait).
var not_found_polls_to_give_up: int = 3

var _sdk: RefCounted


func initialize(sdk: RefCounted) -> void:
	_sdk = sdk


## ENet server on `port` for a DS. Returns null (and pushes an error) when the port cannot be opened.
static func create_server(
	port: int, max_clients: int = 32, bind_ip: String = "*"
) -> ENetMultiplayerPeer:
	var peer := ENetMultiplayerPeer.new()
	if bind_ip != "*":
		peer.set_bind_ip(bind_ip)
	var err := peer.create_server(port, max_clients)
	if err != OK:
		push_error(
			"[AccelByteGameTransport] cannot listen on port %d: %s" % [port, error_string(err)]
		)
		return null
	return peer


## Read the DS address from a game session (the `data` of get_game_session). The session API names the block
## `DSInformation` with a `Server` inside; the lower-camel spelling is accepted too. Returns {ip, port, status}, or {}
## while the session does not report a usable address yet.
static func parse_ds_address(session: Dictionary) -> Dictionary:
	var info = session.get("DSInformation", session.get("dsInformation", {}))
	if not info is Dictionary:
		return {}
	var server = info.get("Server", info.get("server", {}))
	if not server is Dictionary:
		return {}
	var ip := str(server.get("ip", "")).strip_edges()
	var port := int(server.get("port", 0))
	if port <= 0:
		var ports = server.get("ports", {})
		if ports is Dictionary and not ports.is_empty():
			port = int(ports.get("default", ports.values()[0]))
	if ip.is_empty() or port <= 0:
		return {}
	return {"ip": ip, "port": port, "status": str(server.get("status", ""))}


## Wait until the game session reports the DS address. Returns {ok, ip, port, status} or {ok: false, error}.
##
## The wait ends early in two cases:
## - the Session service ended the session: when the DS request fails (no DS claimed within the template's claim timeout, a DS crash)
##   it soft-deletes the session in one write together with its final DS status, so the public GET answers 404 and the status can never
##   be read. After the session was readable once, the first 404 is final. Before that a few 404s are tolerated (not_found_polls_to_give_up)
##   because nothing guarantees that a fresh session is readable the moment matchmaking returns its id.
## - the Lobby is connected and sends the `OnDSStatusChanged` session notification with an `Error`: the error is the only place that
##   gives the reason. The notification also wakes the wait to read the session at once. It is not replayed after a disconnect, so the
##   polling (every poll_sec) stays as the fallback.
## A 200 with a failed-looking status is not final: an AMS server that is briefly unreachable shows an error status and can recover.
func wait_for_ds_address(
	session_id: String, timeout_sec: float = 45.0, poll_sec: float = 2.0
) -> Dictionary:
	var tree := Engine.get_main_loop() as SceneTree
	var deadline := Time.get_ticks_msec() + int(timeout_sec * 1000.0)
	var service = _sdk.get_service(SessionService)
	var notif := {"error": "", "wake": false}
	var lobby = _connected_lobby()
	var listener := func(_from, payload, _sent_at, _to, topic, _sequence_id, _sequence_number):
		_on_session_notif(payload, topic, session_id, notif)
	if lobby != null:
		lobby.message_session_notif.connect(listener)
	var attempts := 0
	var not_found := 0
	var seen := false
	var outcome: Dictionary = {}
	while outcome.is_empty():
		attempts += 1
		var result: Dictionary = await service.get_game_session("", session_id)
		if result.get("success", false):
			seen = true
			not_found = 0
			var address := parse_ds_address(result.get("data", {}))
			if not address.is_empty():
				address["ok"] = true
				outcome = address
				break
		elif int(result.get("status_code", 0)) == 404:
			not_found += 1
			if seen or not_found >= not_found_polls_to_give_up:
				if lobby != null and str(notif["error"]).is_empty():
					await tree.create_timer(0.5).timeout  # the notification with the reason may arrive just after the 404
				last_error = _session_gone_message(session_id, seen, attempts, str(notif["error"]))
				outcome = {"ok": false, "error": last_error}
				break
		else:
			not_found = 0
		if not str(notif["error"]).is_empty():
			last_error = _session_gone_message(session_id, seen, attempts, str(notif["error"]))
			outcome = {"ok": false, "error": last_error}
			break
		if Time.get_ticks_msec() >= deadline:
			last_error = (
				"the session %s did not report a DS address within %.0f s (%d polls)"
				% [session_id, timeout_sec, attempts]
			)
			outcome = {"ok": false, "error": last_error}
			break
		await _sleep_or_wake(tree, poll_sec, notif)
	if lobby != null and lobby.message_session_notif.is_connected(listener):
		lobby.message_session_notif.disconnect(listener)
	return outcome


## The Lobby service when the SDK has one and it is connected, else null.
func _connected_lobby():
	if (
		_sdk == null
		or not _sdk.has_method("get_lobby_ws_service")
		or not _sdk.has_method("is_lobby_connected")
	):
		return null
	if not _sdk.is_lobby_connected():
		return null
	return _sdk.get_lobby_ws_service()


## Session notification handler: only `OnDSStatusChanged` of this session matters. Payload (JSON): SessionID, Error ("" on success),
## GameServer, Session.
func _on_session_notif(
	payload: String, topic: String, session_id: String, notif: Dictionary
) -> void:
	if topic != "OnDSStatusChanged":
		return
	var parsed = JSON.parse_string(payload)
	if not (parsed is Dictionary):
		return
	if str(parsed.get("SessionID", parsed.get("sessionID", ""))) != session_id:
		return
	notif["error"] = str(parsed.get("Error", parsed.get("error", "")))
	notif["wake"] = true


func _sleep_or_wake(tree: SceneTree, seconds: float, notif: Dictionary) -> void:
	var until := Time.get_ticks_msec() + int(seconds * 1000.0)
	while Time.get_ticks_msec() < until and not notif["wake"]:
		await tree.create_timer(minf(0.1, seconds)).timeout
	notif["wake"] = false


func _session_gone_message(session_id: String, seen: bool, polls: int, reason: String) -> String:
	var text := "game session %s " % session_id
	if seen:
		text += "ended before a DS address was reported (it answered 404 after it was readable)"
	else:
		text += "was not found (%d polls)" % polls
	text += ": the DS request probably failed or timed out (no DS claimed within the session template's claim timeout), the DS crashed, or the session was ended"
	if not reason.is_empty():
		text += ". Session service: " + reason
	return text


## Wait for the DS address and start an ENet client to it. Returns the peer (the connection completes afterwards; wait
## for the multiplayer `connected_to_server` signal) or null with `last_error` set.
func connect_to_ds(session_id: String, timeout_sec: float = 45.0) -> ENetMultiplayerPeer:
	var address := await wait_for_ds_address(session_id, timeout_sec)
	if not address.get("ok", false):
		return null
	var peer := ENetMultiplayerPeer.new()
	var err := peer.create_client(str(address["ip"]), int(address["port"]))
	if err != OK:
		last_error = (
			"ENet client to %s:%d failed: %s" % [address["ip"], address["port"], error_string(err)]
		)
		return null
	return peer
