## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## Server-side lifecycle of a dedicated server (DS) hosted by AccelByte Multiplayer Servers (AMS).
##
## A DS needs two connections and a login, in this order:
##   1. log in with the server IAM client (client credentials);
##   2. DSHub (DshubWsService): where the session service tells the DS it was claimed for a game session;
##   3. the AMS watchdog (AmsWatchdogWsService): the DS reports `ready`, then heartbeats keep it alive.
## This class does all of it and reports the outcome as signals, so the game only starts its own listener
## (see AccelByteGameTransport.create_server) and reacts to `claimed`, `session_ended` and `drain_requested`.
##
## DSHub keeps the connection of a DS only while it hears from it, so the transport sends WebSocket pings, and a drop after
## start() is not fatal: the DS logs in again and reconnects (dshub_connection_lost, dshub_reconnected). The watchdog is
## unchanged: losing the watchdog connection still ends in `failed`.
##
## Usage (in the headless server scene):
##   var server := AccelByteDedicatedServer.new()
##   server.initialize(sdk)
##   server.claimed.connect(func(session_id, game_mode): start_the_match(session_id))
##   server.drain_requested.connect(func(): get_tree().quit())
##   if not await server.start():
##       get_tree().quit(1)
##
## Launch arguments (what AMS and the local AMSSim pass): -dsid=<id> (or the DS_ID environment variable) -watchdog_url=<ws url>
## [-heartbeat=<seconds>, default 5]
## and, for local runs, -ab_base_url, -ab_client_id and -ab_client_secret (or the environment variables AB_BASE_URL,
## AB_CLIENT_ID and AB_CLIENT_SECRET, which keep the secret out of the process list). Values given to start() take precedence.
class_name AccelByteDedicatedServer
extends RefCounted

enum State { IDLE, STARTING, READY, CLAIMED, DRAINING, STOPPED, FAILED }

## The state changed (the new State value).
signal state_changed(new_state: int)
## The session service claimed this DS for a game session.
signal claimed(session_id: String, game_mode: String)
## The game session this DS serves ended.
signal session_ended(session_id: String)
## AMS asks the DS to drain: finish the current session and exit.
signal drain_requested
## start() failed or a required connection dropped. DSHub drops do not end up here once the DS is READY, CLAIMED or
## DRAINING, except when a READY DS cannot reconnect (see dshub_connection_lost).
signal failed(reason: String)
## The DSHub connection closed after start() succeeded. The DS reconnects by itself with a fresh server token.
signal dshub_connection_lost(reason: String)
## The DSHub connection is back after dshub_connection_lost.
signal dshub_reconnected
## DSHub could not be reconnected within reconnect_timeout_sec while CLAIMED or DRAINING. The DS keeps running (the game
## session goes on; only the notifications from DSHub, such as session_ended, are missing). While READY the same case
## emits `failed`, because an unclaimed DS that cannot be claimed is useless.
signal dshub_reconnect_failed(reason: String)

var state: int = State.IDLE
var ds_id: String = ""
var session_id: String = ""
var game_mode: String = ""
var last_error: String = ""

## Seconds to wait for each connection step.
var step_timeout_sec: float = 20.0
## DSHub reconnection after a drop: seconds before the first attempt (it doubles up to the maximum), the maximum delay
## between attempts, and the total time to try before giving up.
var reconnect_initial_delay_sec: float = 1.0
var reconnect_max_delay_sec: float = 15.0
var reconnect_timeout_sec: float = 120.0
## Replace the server login (for example for a custom auth flow or tests). Called as login.call(client_id, client_secret),
## awaited, and returns a Dictionary with `success` and `access_token`.
var login_override: Callable = Callable()

var _sdk: RefCounted
var _watchdog: RefCounted
var _dshub: RefCounted
var _base_url: String = ""
var _client_id: String = ""
var _client_secret: String = ""
var _hub_connected: bool = false
var _reconnecting: bool = false


## `sdk` is an AccelByteSDK (or AccelByteSDKWrapper). `services` can inject the watchdog and DSHub services
## ({"watchdog": ..., "dshub": ...}); by default they come from sdk.get_service().
func initialize(sdk: RefCounted, services: Dictionary = {}) -> void:
	_sdk = sdk
	_watchdog = services.get("watchdog", null)
	_dshub = services.get("dshub", null)


## Parse launch arguments into a Dictionary with lower-case keys and String values. Accepts -key=value, --key=value and
## -key value; a flag without a value becomes "true".
static func parse_launch_args(args: PackedStringArray = OS.get_cmdline_args()) -> Dictionary:
	var result: Dictionary = {}
	var i := 0
	while i < args.size():
		var arg: String = args[i]
		i += 1
		if not arg.begins_with("-"):
			continue
		var body := arg.lstrip("-")
		if body.is_empty():
			continue
		var eq := body.find("=")
		if eq >= 0:
			result[body.substr(0, eq).to_lower()] = body.substr(eq + 1)
		elif i < args.size() and not str(args[i]).begins_with("-"):
			result[body.to_lower()] = args[i]
			i += 1
		else:
			result[body.to_lower()] = "true"
	return result


## Run the start-up sequence. Returns true when the DS is registered and `ready` was sent.
## options (all optional, launch arguments fill what is missing):
##   ds_id, watchdog_url, base_url, client_id, client_secret, heartbeat_sec
func start(options: Dictionary = {}) -> bool:
	var args := parse_launch_args()
	# AMS passes the id as -dsid and as the DS_ID environment variable.
	ds_id = (
		str(options.get("ds_id", args.get("dsid", args.get("abdsid", OS.get_environment("DS_ID")))))
		. strip_edges()
	)
	var watchdog_url := str(options.get("watchdog_url", args.get("watchdog_url", ""))).strip_edges()
	var base_url := (
		str(options.get("base_url", args.get("ab_base_url", OS.get_environment("AB_BASE_URL"))))
		. strip_edges()
	)
	if base_url.is_empty() and _sdk != null and _sdk.has_method("get_base_url"):
		base_url = str(_sdk.get_base_url())
	var client_id := str(
		options.get("client_id", args.get("ab_client_id", OS.get_environment("AB_CLIENT_ID")))
	)
	var client_secret := str(
		options.get(
			"client_secret", args.get("ab_client_secret", OS.get_environment("AB_CLIENT_SECRET"))
		)
	)
	# A real watchdog kills a server that misses heartbeats; 5 s is well inside its timeouts. Set 0 to use the transport default.
	var heartbeat := float(options.get("heartbeat_sec", args.get("heartbeat", "5")))

	_set_state(State.STARTING)
	if ds_id.is_empty():
		return _fail("missing the DS id (launch argument -dsid)")
	if watchdog_url.is_empty():
		return _fail("missing the watchdog url (launch argument -watchdog_url)")

	# 1. server login
	var token := await _login(client_id, client_secret)
	if token.is_empty():
		return _fail("server login failed: %s" % last_error)

	# 2. DSHub
	if _dshub == null:
		_dshub = _sdk.get_service(DshubWsService)
	_base_url = base_url
	_client_id = client_id
	_client_secret = client_secret
	_hub_connected = false
	_dshub.ws_connected.connect(_on_dshub_connected)
	_dshub.ws_disconnected.connect(_on_dshub_disconnected)
	_dshub.server_claimed_notif.connect(_on_claimed)
	_dshub.session_ended_notif.connect(_on_session_ended)
	# The transport's own reconnect would reuse the first token; this class reconnects with a fresh one.
	_dshub.get_ws_transport().auto_reconnect = false
	var err: int = _dshub.connect_service(
		{"base_url": base_url, "server_id": ds_id, "access_token": token}
	)
	if err != OK:
		return _fail("DSHub connect_service failed (%s)" % error_string(err))
	if not await _wait_until(func(): return _hub_connected):
		return _fail("DSHub did not connect within %.0f s" % step_timeout_sec)

	# 3. AMS watchdog, then ready
	if _watchdog == null:
		_watchdog = _sdk.get_service(AmsWatchdogWsService)
	var wd_up := {"up": false}
	_watchdog.ws_connected.connect(func(_fields): wd_up["up"] = true)
	_watchdog.ws_disconnected.connect(_on_watchdog_disconnected)
	_watchdog.drain_notif.connect(_on_drain)
	_watchdog.get_ws_transport().auto_reconnect = false
	if heartbeat > 0.0:
		_watchdog.get_ws_transport().heartbeat_interval_sec = heartbeat
	err = _watchdog.connect_service({"url": watchdog_url, "ds_id": ds_id})
	if err != OK:
		return _fail("watchdog connect_service failed (%s)" % error_string(err))
	if not await _wait_until(func(): return wd_up["up"]):
		return _fail("the AMS watchdog did not connect within %.0f s" % step_timeout_sec)
	_watchdog.ready_request(ds_id)
	_set_state(State.READY)
	return true


## Disconnect from the watchdog and DSHub. Call when the process is about to exit.
func stop() -> void:
	_set_state(State.STOPPED)
	if _watchdog != null:
		_watchdog.disconnect_service()
	if _dshub != null:
		_dshub.disconnect_service()


func is_ready() -> bool:
	return state == State.READY or state == State.CLAIMED


func _login(client_id: String, client_secret: String) -> String:
	if login_override.is_valid():
		var res = await login_override.call(client_id, client_secret)
		if res is Dictionary and res.get("success", false):
			return str(res.get("access_token", ""))
		last_error = "login override failed"
		return ""
	if client_id.is_empty() or client_secret.is_empty():
		last_error = "no server client id and secret (-ab_client_id and -ab_client_secret)"
		return ""
	# token_grant_v3 takes the confidential client's id and secret as arguments.
	var result: Dictionary = await _sdk.get_service(IamService).token_grant_v3(
		"client_credentials", "", client_id, client_secret
	)
	if not result.get("success", false):
		last_error = "status %s" % str(result.get("status_code", "?"))
		return ""
	return str(_sdk.get_access_token())


func _wait_until(condition: Callable) -> bool:
	var tree := Engine.get_main_loop() as SceneTree
	var deadline := Time.get_ticks_msec() + int(step_timeout_sec * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if condition.call():
			return true
		await tree.process_frame
	return condition.call()


func _set_state(new_state: int) -> void:
	if state == new_state:
		return
	state = new_state
	state_changed.emit(new_state)


func _fail(reason: String) -> bool:
	last_error = reason
	_set_state(State.FAILED)
	failed.emit(reason)
	return false


func _on_claimed(
	_namespace: String, p_session_id: String, p_game_mode: String, _allies: Array
) -> void:
	session_id = p_session_id
	game_mode = p_game_mode
	_set_state(State.CLAIMED)
	claimed.emit(p_session_id, p_game_mode)


func _on_session_ended(p_session_id: String, _is_active: bool) -> void:
	session_ended.emit(p_session_id)


func _on_drain(_current_state: String) -> void:
	_set_state(State.DRAINING)
	drain_requested.emit()


func _on_dshub_connected(_fields: Dictionary) -> void:
	_hub_connected = true


func _on_dshub_disconnected(reason: String) -> void:
	_hub_connected = false
	match state:
		State.READY, State.CLAIMED, State.DRAINING:
			if _reconnecting:
				return  # the close of a reconnect attempt that did not work
			dshub_connection_lost.emit(reason)
			_reconnect_dshub(reason)
		State.STARTING:
			_fail("DSHub disconnected: %s" % reason)
		_:
			pass  # IDLE, STOPPED or FAILED


## Reconnect DSHub after a drop: log in again (the token may have expired), connect, retry with a growing delay.
## Gives up after reconnect_timeout_sec: a READY DS fails (nobody can claim it), a CLAIMED or DRAINING one only reports it.
func _reconnect_dshub(reason: String) -> void:
	_reconnecting = true
	var tree := Engine.get_main_loop() as SceneTree
	var deadline := Time.get_ticks_msec() + int(reconnect_timeout_sec * 1000.0)
	var delay := reconnect_initial_delay_sec
	while _is_alive() and Time.get_ticks_msec() < deadline:
		await tree.create_timer(delay).timeout
		if not _is_alive():
			break
		var token := await _login(_client_id, _client_secret)
		if _is_alive() and not token.is_empty():
			_dshub.disconnect_service()  # drop a half-open attempt; the transport reconnects on the next connect_service
			var err: int = _dshub.connect_service(
				{"base_url": _base_url, "server_id": ds_id, "access_token": token}
			)
			if err == OK and await _wait_until(func(): return _hub_connected):
				_reconnecting = false
				dshub_reconnected.emit()
				return
		delay = minf(delay * 2.0, reconnect_max_delay_sec)
	_reconnecting = false
	if not _is_alive():
		return
	var message := (
		"DSHub disconnected (%s) and did not come back within %.0f s"
		% [reason, reconnect_timeout_sec]
	)
	if state == State.READY:
		_fail(message)
	else:
		last_error = message
		dshub_reconnect_failed.emit(message)


func _is_alive() -> bool:
	return state == State.READY or state == State.CLAIMED or state == State.DRAINING


func _on_watchdog_disconnected(reason: String) -> void:
	if state != State.STOPPED:
		_fail("the AMS watchdog disconnected: %s" % reason)
