## Example: Matchmaking (Matchmaking v2) with the AccelByte SDK
##
## Logs in with a device id, creates a match ticket in a match pool and waits until a match is found. The result is the
## id of the game session the players were put into.
##
## Setup:
##   1. Add this script to a Node in your scene (or run it from a script that adds the node).
##   2. Configure project.godot (see device_login_example.gd): accelbyte/base_url, namespace, client_id, client_secret.
##   3. A match pool must exist in the namespace (Admin Portal: Matchmaking). Give its name with the launch argument
##      `-pool <name>` or the project setting accelbyte/match_pool. Two players must queue before a match is found.
##   4. For a dedicated-server pool (session template of type DS) the ticket needs `latencies`, the latency in
##      milliseconds to each region; "local" is the region of a local AMS Simulator server (see README.md).
##
## Next step: connect_to_ds_example.gd turns the session into a connection to the dedicated server.
extends Node

## Latency in ms to each region. Replace with measured values (AMS QoS) in a real game.
var latencies: Dictionary = {"local": 5, "us-west-2": 20, "us-east-1": 40}

var sdk: AccelByteSDKWrapper
var ticket_id: String = ""


func _ready() -> void:
	sdk = AccelByteSDKWrapper.new()
	sdk.initialize(self)
	sdk.set_base_url(ProjectSettings.get_setting("accelbyte/base_url", ""))
	sdk.set_client_credentials(
		ProjectSettings.get_setting("accelbyte/client_id", ""), ProjectSettings.get_setting("accelbyte/client_secret", "")
	)
	sdk.set_namespace(ProjectSettings.get_setting("accelbyte/namespace", ""))
	await run()


## What this example does. Subclasses (connect_to_ds_example.gd) override it.
func run() -> void:
	if not await login_with_device():
		return
	var session_id := await find_match(get_pool())
	if session_id.is_empty():
		print("No match found.")
	else:
		print("Match found. Game session: ", session_id)


## `-pool <name>` or `-pool=<name>` on the command line, else the project setting.
func get_pool() -> String:
	var args := AccelByteDedicatedServer.parse_launch_args(OS.get_cmdline_args() + OS.get_cmdline_user_args())
	return str(args.get("pool", ProjectSettings.get_setting("accelbyte/match_pool", "")))


## Device login: an anonymous account tied to the device. Several instances on one PC need different ids.
func login_with_device() -> bool:
	var device_id := str(Time.get_unix_time_from_system()).md5_text() + str(randi())
	# Parameters: platform_id, code_challenge, code_challenge_method, additional_data, app_id, client_id, code_verifier,
	# create_headless, device_id.
	var result: Dictionary = await sdk.get_service(IamService).platform_token_grant_v4("device", "", "", "", "", "", "", true, device_id)
	if not result.get("success", false):
		print("Login failed: ", result.get("error", "unknown error"))
		return false
	print("Logged in as ", sdk.get_user_id())
	return true


## Create a ticket and poll it until a match is found. Returns the session id, or "" on timeout or error.
func find_match(pool: String, timeout_sec: float = 120.0) -> String:
	if pool.is_empty():
		print("No match pool: pass -pool <name> or set accelbyte/match_pool.")
		return ""
	var match2 = sdk.get_service(Match2Service)
	# A new pool can take a moment to become usable, so retry the ticket a few times.
	for attempt in 6:
		var created: Dictionary = await match2.create_match_ticket(
			"", {"matchPool": pool, "attributes": {}, "latencies": latencies}  # "" = the namespace set above
		)
		if created.get("success", false):
			ticket_id = str(created.get("data", {}).get("matchTicketID", ""))
			break
		print("Ticket attempt %d failed (status %s)" % [attempt + 1, str(created.get("status_code", "?"))])
		await get_tree().create_timer(2.0).timeout
	if ticket_id.is_empty():
		return ""
	print("Ticket ", ticket_id, " created in pool ", pool, ", waiting for a match...")

	var waited := 0.0
	while waited < timeout_sec:
		var details: Dictionary = (await match2.match_ticket_details("", ticket_id)).get("data", {})
		if details.get("matchFound", false):
			return str(details.get("sessionID", ""))
		await get_tree().create_timer(2.0).timeout
		waited += 2.0
	await cancel()
	return ""


## Leave the queue.
func cancel() -> void:
	if not ticket_id.is_empty():
		await sdk.get_service(Match2Service).delete_match_ticket("", ticket_id)
		ticket_id = ""
