# AccelByte Godot SDK examples

Each script is a self-contained example. Add it to a node of your scene (or load it from a small runner) after configuring
`project.godot` as shown in `device_login_example.gd`.

| Example | Shows |
|---|---|
| `device_login_example.gd` | Device (anonymous) login |
| `lobby_friend_example.gd` | Lobby WebSocket and friends |
| `leaderboard_example.gd` | Updating a stat and reading a leaderboard |
| `p2p_connection_example.gd` | P2P with `WebRTCMultiplayerPeer` and Lobby signaling |
| `matchmaking_example.gd` | Matchmaking v2: create a ticket and wait for a match |
| `connect_to_ds_example.gd` | Client: matchmake, then connect to the match's dedicated server |
| `dedicated_server_example.gd` | Server: register a dedicated server with AccelByte (AMS or AMS Simulator) |

## Try a dedicated server locally with the AMS Simulator

The AMS Simulator (AMSSim) stands in for the AMS watchdog on your PC, so no fleet is needed. In cloud-integrated mode it logs in
to your namespace, accepts the DS's `ready` message and tells the session service where the DS is.

1. **Session template** (type `DS`), with `dsSource` = `AMS` and `preferredClaimKeys` containing the claim key of the simulator.
   Leave `requestedRegions` empty. **Match pool** that uses this template.
2. **AMSSim config** (JSON, no BOM):

   ```json
   {
     "WatchdogPort": 5555,
     "AGSEnvironmentURL": "<host of the base url, e.g. development.accelbyte.io>",
     "AGSNamespace": "<namespace>",
     "IAM": { "ClientID": "<server IAM client id>", "ClientSecret": "<its secret>" },
     "LocalDSHost": "127.0.0.1",
     "LocalDSPort": 2223,
     "ClaimKeys": ["<claim key>"],
     "ServerName": "local-sim",
     "HeartbeatTimeoutSeconds": 30
   }
   ```

   `LocalDSHost` is the address the clients are told to connect to; use the LAN address of the PC for clients on other machines.
   Start it with `amssim run --headless --configPath <config.json>`.
3. **Server**: the DS id must look like `ds_<uuid with hyphens>`.

   ```
   godot --headless --path <project> -- -dsid=ds_<uuid> -port=2223 -watchdog_url=ws://127.0.0.1:5555/watchdog
   ```

   with `AB_BASE_URL`, `AB_CLIENT_ID`, `AB_CLIENT_SECRET` set (script: `dedicated_server_example.gd`). It prints `DS ... is ready`.
4. **Clients**: run `connect_to_ds_example.gd` twice (or once, if the pool needs one player) with `-pool <name>`. Each ticket must
   carry `latencies` with the region `local` (the simulator's region); the example sets it. The clients print
   `Connected to the DS`.

Notes: the session API returns the address under `DSInformation` / `Server` (capitalised); `AccelByteGameTransport` reads both
spellings. Never commit the server client secret.

The server prints `Token granted but user_id is empty`: a server (client-credentials) token has no user, so this is expected.
