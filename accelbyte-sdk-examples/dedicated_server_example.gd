## Example: a dedicated server (DS) that registers itself with AccelByte (server side)
##
## Run it headless, the way AMS (or the local AMS Simulator) launches a game server:
##
##   godot --headless --path <project> -- -dsid=ds_<uuid> -port=2223 -watchdog_url=ws://127.0.0.1:5555/watchdog
##
## For a local run the server logs in with the server IAM client; give it through the environment so the secret stays out
## of the process list: AB_BASE_URL, AB_CLIENT_ID, AB_CLIENT_SECRET (and AB_NAMESPACE, or accelbyte/namespace).
## AccelByteDedicatedServer then connects DSHub and the watchdog and sends `ready`. When a match is made the session service
## claims this server and `claimed` fires with the game session id.
extends Node

var sdk: AccelByteSDKWrapper
var server: AccelByteDedicatedServer


func _ready() -> void:
	var args := AccelByteDedicatedServer.parse_launch_args(OS.get_cmdline_args() + OS.get_cmdline_user_args())
	var base_url := OS.get_environment("AB_BASE_URL")
	var namespace_ := OS.get_environment("AB_NAMESPACE")
	if namespace_.is_empty():
		namespace_ = str(ProjectSettings.get_setting("accelbyte/namespace", ""))
	sdk = AccelByteSDKWrapper.new()
	sdk.initialize(self)
	sdk.set_base_url(base_url)
	sdk.set_namespace(namespace_)

	# 1. open the game port first, so clients can connect as soon as the DS is claimed
	var port := int(args.get("port", 2223))
	var peer := AccelByteGameTransport.create_server(port)
	if peer == null:
		get_tree().quit(1)
		return
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(func(id): print("Player connected: ", id))
	multiplayer.peer_disconnected.connect(func(id): print("Player left: ", id))
	print("Listening on UDP ", port)

	# 2. register with AccelByte: login, DSHub, watchdog `ready`
	server = AccelByteDedicatedServer.new()
	server.initialize(sdk)
	server.claimed.connect(func(session_id, game_mode): print("Claimed for session ", session_id, " (", game_mode, ")"))
	server.session_ended.connect(func(session_id): print("Session ended: ", session_id))
	# AMS asks the DS to shut down (scale down, new build): finish up, then quit.
	server.drain_requested.connect(func(): get_tree().quit())
	server.failed.connect(func(reason): print("DS failed: ", reason))
	# Arguments after `--` are "user arguments", which start() does not read by itself, so pass them as options. The credentials
	# (AB_CLIENT_ID, AB_CLIENT_SECRET) and AB_BASE_URL come from the environment.
	var options := {}
	if args.has("dsid"):
		options["ds_id"] = args["dsid"]
	if args.has("watchdog_url"):
		options["watchdog_url"] = args["watchdog_url"]
	if args.has("heartbeat"):
		options["heartbeat_sec"] = float(args["heartbeat"])
	if not await server.start(options):
		print("Start-up failed: ", server.last_error)
		get_tree().quit(1)
		return
	print("DS ", server.ds_id, " is ready.")
