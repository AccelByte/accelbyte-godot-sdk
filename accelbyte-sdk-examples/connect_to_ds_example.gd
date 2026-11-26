## Example: matchmake, then connect to the dedicated server (DS) of the match (client side)
##
## Extends matchmaking_example.gd: after a match is found, AccelByteGameTransport waits until the game session reports the
## address of the DS and returns an ENetMultiplayerPeer connected to it. Godot's high-level multiplayer takes it from there.
##
## Setup: same as matchmaking_example.gd, with a match pool whose session template is of type DS. The server side is
## dedicated_server_example.gd (run it with the AMS Simulator, see README.md). Run two clients (two matchmaking
## tickets) if the pool needs two players.
extends "matchmaking_example.gd"


func run() -> void:
	if not await login_with_device():
		return
	var session_id := await find_match(get_pool())
	if session_id.is_empty():
		print("No match found.")
		return
	print("Match found. Game session: ", session_id)

	var transport := AccelByteGameTransport.new()
	transport.initialize(sdk)
	# Polls the session until it holds the DS ip and port (the DS must have been claimed), then opens an ENet client.
	var peer := await transport.connect_to_ds(session_id, 45.0)
	if peer == null:
		print("Could not reach the DS: ", transport.last_error)
		return

	multiplayer.connected_to_server.connect(func(): print("Connected to the DS as peer ", multiplayer.get_unique_id()))
	multiplayer.connection_failed.connect(func(): print("Connection to the DS failed."))
	multiplayer.server_disconnected.connect(func(): print("The DS closed the connection."))
	multiplayer.multiplayer_peer = peer
