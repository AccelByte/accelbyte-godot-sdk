# AccelByte SDK for Godot

A pure GDScript SDK that connects Godot 4 games to [AccelByte Gaming Services](https://accelbyte.io/gaming-services): REST services, WebSocket services (Lobby, Chat, DSHub, AMS watchdog), dedicated-server helpers and peer-to-peer (P2P) networking. No native code and no build step.

> **Status:** beta, version 0.2.0. The API may still change based on feedback.

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Quick start](#quick-start)
- [Multiplayer: dedicated servers and P2P](#multiplayer-dedicated-servers-and-p2p)
- [Examples](#examples)
- [Available services](#available-services)
- [Platform support](#platform-support)
- [Architecture](#architecture)
- [Troubleshooting](#troubleshooting)
- [Support](#support)
- [License](#license)

## Requirements

- Godot 4.4 or newer (tested with 4.4, 4.5.1 and 4.6).
- An AccelByte namespace with a game client (and, for a dedicated server, a separate server client). See the [AccelByte documentation](https://docs.accelbyte.io/gaming-services/getting-started/).
- **P2P on desktop:** the Godot WebRTC extension (see [P2P](#p2p)). Web exports include WebRTC.
- **Dedicated servers:** a Linux headless build of your game, run by AccelByte Multiplayer Servers (AMS) or the AMS Simulator for local work.

## Installation

Copy the `addons/accelbyte_sdk/` folder of this repository into your project's `addons/` folder:

```
your-project/
├── addons/
│   └── accelbyte_sdk/    ← copy this folder
└── project.godot
```

The addon is a set of scripts with global classes (`AccelByteSDK`, `IamService`, ...); there is no editor plugin to enable. You can also add this repository as a Git submodule anywhere in your project.

## Configuration

The SDK reads its settings from the `[accelbyte]` section of `project.godot`. Launch arguments override them, so one build can run against another environment:

```ini
[accelbyte]
base_url="https://your-environment.accelbyte.io"
namespace="your-namespace"
client_id="your-client-id"
client_secret=""
```

| Setting | Launch flag | Meaning |
|---|---|---|
| `base_url` | `-ab_base_url=` | Environment URL (a trailing `/` is removed) |
| `namespace` | `-ab_namespace=` | Game namespace |
| `client_id` | `-ab_client_id=` | OAuth client id |
| `client_secret` | `-ab_client_secret=` | OAuth client secret; leave empty for a public client |
| `redirect_uri` | `-ab_redirect_uri=` | OAuth redirect URI |
| `log_level` | `-ab_log_level=` | `Verbose`, `Log`, `All`, `Debug`, `Info` turn request logging on; `Off`, `None`, `Error`, `Warning` turn it off |

Flags are case-insensitive, accept `-key=value`, `--key=value` or `-key value`, and also work as `-accelbyte_<name>`. You can configure the SDK in code instead with `set_base_url()`, `set_namespace()` and `set_client_credentials()` (called after `initialize()`, they win). A client secret on a command line is visible in the process list; a dedicated server can read it from the `AB_CLIENT_SECRET` environment variable instead.

## Quick start

```gdscript
extends Node

var sdk: AccelByteSDKWrapper

func _ready() -> void:
    sdk = AccelByteSDKWrapper.new()
    sdk.initialize(self)   # any Node; reads the project settings and launch arguments

    # Device login (an anonymous account tied to the device).
    # Parameters: platform_id, code_challenge, code_challenge_method, additional_data, app_id,
    #             client_id, code_verifier, create_headless, device_id
    var iam = sdk.get_service(IamService)
    var result = await iam.platform_token_grant_v4("device", "", "", "", "", "", "", true, OS.get_unique_id())

    if result.get("success", false):
        print("Logged in, user id: ", sdk.get_user_id())   # tokens are stored by the SDK
    else:
        print("Login failed: ", result.get("error", "unknown error"))
```

`AccelByteSDKWrapper` is an alias of `AccelByteSDK`. Get a service with `sdk.get_service(IamService)` or a typed accessor such as `sdk.get_iam_service()`. Parameters are positional, and each method has a doc comment with its description and parameters.

> Optional parameters are listed in alphabetical order, so an API change can shift positional arguments (`platform_token_grant_v4` gained `app_id` in 0.2). After an upgrade, check the signatures of the methods you call.

**Every REST call returns a Dictionary** and is `await`ed:

```gdscript
{ "success": bool,      # true for HTTP 2xx
  "status_code": int,
  "data": Variant,      # parsed JSON (Dictionary or Array)
  "body": String,       # raw body
  "error": String }     # message when success is false
```

Token-granting endpoints store the tokens and token-revoking endpoints clear them; you do not set tokens by hand.

**Lobby WebSocket:**

```gdscript
sdk.lobby_connected.connect(func(data): print("Lobby session id: ", data.get("lobbysessionid", "")))
var err := sdk.lobby_connect()                       # "" when the connection started
sdk.get_lobby_ws_service().personal_chat_notif.connect(func(from, payload, received_at, to):
    print("Chat from %s: %s" % [from, payload]))
# ...
sdk.lobby_disconnect()
```

`sdk.is_lobby_connected()` tells whether the connection is up. Field names of Lobby messages are lower-cased (for example `lobbysessionid`).

Chat, DSHub and the AMS watchdog have their own generated services: `sdk.get_service(ChatWsService)`, `DshubWsService` and `AmsWatchdogWsService`.

## Multiplayer: dedicated servers and P2P

Your game keeps Godot's own high-level multiplayer (`@rpc`, `MultiplayerSpawner`, `MultiplayerSynchronizer`). The SDK supplies the AccelByte side: matchmaking and sessions, finding the server, signaling and TURN credentials. A dedicated-server game uses an `ENetMultiplayerPeer`; a P2P game uses a `WebRTCMultiplayerPeer`.

### Dedicated server

```gdscript
# Server (headless Linux build, started by AMS or by the AMS Simulator)
var server := AccelByteDedicatedServer.new()
server.initialize(sdk)
server.claimed.connect(func(session_id, game_mode): start_match(session_id))
server.drain_requested.connect(func(): get_tree().quit())
server.failed.connect(func(reason): push_error(reason); get_tree().quit(1))
multiplayer.multiplayer_peer = AccelByteGameTransport.create_server(7777)
await server.start()      # login, DSHub, AMS watchdog, then "ready"

# Client, after matchmaking returned the game session id
var transport := AccelByteGameTransport.new()
transport.initialize(sdk)
var peer := await transport.connect_to_ds(session_id)   # waits for the session to report the server address
multiplayer.multiplayer_peer = peer
```

`AccelByteDedicatedServer` keeps the DSHub connection alive with WebSocket pings and reconnects after a drop; `connect_to_ds` ends early with a clear error when the game session is gone. Web exports cannot use ENet, so a web client cannot join a dedicated server with these helpers.

### P2P

```gdscript
var p2p := AccelByteMultiplayerP2P.new()
p2p.initialize(AccelByteP2PLobbySignaling.new(sdk.get_lobby_ws_service()), self, sdk.get_user_id())
await p2p.configure_ice_servers(sdk)                 # TURN/STUN credentials from the Turn Manager
if is_host:
    multiplayer.multiplayer_peer = p2p.host()         # the host is peer id 1
else:
    multiplayer.multiplayer_peer = p2p.join(host_user_id)
```

Both players must be logged in and connected to the Lobby. On desktop, P2P needs the Godot WebRTC extension from the [Asset Library](https://godotengine.org/asset-library/asset/2103) or [GitHub releases](https://github.com/godotengine/webrtc-native/releases) (maintained by the Godot project): copy it to `addons/webrtc`, then open the editor once or run `godot --headless --import --quit`. `AccelByteP2PManager` is an older, message-based API kept for compatibility.

## Examples

The `accelbyte-sdk-examples/` folder holds self-contained scripts. Add one to a node of your scene after configuring `project.godot`. See its [README](accelbyte-sdk-examples/README.md) for a local dedicated-server walkthrough with the AMS Simulator.

| Example | Shows |
|---|---|
| `device_login_example.gd` | Device (anonymous) login |
| `leaderboard_example.gd` | Updating a stat and reading a leaderboard |
| `lobby_friend_example.gd` | Lobby WebSocket and friend requests |
| `matchmaking_example.gd` | Matchmaking v2: create a ticket and wait for a match |
| `connect_to_ds_example.gd` | Client: matchmake, then connect to the match's dedicated server |
| `dedicated_server_example.gd` | Server: register a dedicated server with AccelByte (AMS or AMS Simulator) |
| `p2p_connection_example.gd` | P2P with `WebRTCMultiplayerPeer` and Lobby signaling |

## Available services

30 REST services, each a class reachable through `sdk.get_service(<Class>)` or `sdk.get_<name>_service()`:

| Class | Backend service |
|---|---|
| `AchievementService` | Achievement |
| `AmsService` | AMS fleet manager |
| `BasicService` | Basic (namespaces, user profiles) |
| `BuildinfoService` | Build info |
| `ChallengeService` | Challenge |
| `ChatService` | Chat (REST) |
| `CloudsaveService` | Cloud Save |
| `CsmService` | Custom Service Manager |
| `DifferService` | Differ |
| `EventlogService` | Event Log |
| `GametelemetryService` | Game Telemetry |
| `GdprService` | GDPR |
| `GroupService` | Group (guilds and clans) |
| `IamService` | Identity and Access Management |
| `InventoryService` | Inventory (early access) |
| `LeaderboardService` | Leaderboard |
| `LegalService` | Legal |
| `LobbyService` | Lobby (REST) |
| `LoginqueueService` | Login Queue |
| `Match2Service` | Matchmaking v2 |
| `MatchmakingService` | Matchmaking (v1) |
| `PlatformService` | Platform (store, entitlements, wallets) |
| `ReportingService` | Reporting |
| `SeasonpassService` | Season Pass |
| `SessionService` | Session |
| `SessionbrowserService` | Session Browser |
| `SessionhistoryService` | Session History |
| `SocialService` | Statistics |
| `TurnManagerService` | TURN Manager |
| `UgcService` | User Generated Content |

WebSocket services: `LobbyWsService` (through the facade), `ChatWsService`, `DshubWsService`, `AmsWatchdogWsService`. See the [AccelByte documentation](https://docs.accelbyte.io/gaming-services/getting-started/) for what each service does.

## Platform support

The SDK is plain GDScript, so it does not depend on the platform. What has been tested:

| Platform | Status |
|---|---|
| Windows (x86_64) | Tested: REST, Lobby, P2P (with the WebRTC extension), dedicated-server client |
| Linux, headless | Tested: dedicated server on an AMS fleet and on the AMS Simulator |
| Web (HTML5) | Supported for REST, Lobby and P2P. ENet is not available in browsers |
| macOS, Android, iOS | Not tested yet (P2P on these needs a WebRTC extension build for the platform) |

## Architecture

```
Your game (GDScript)
        │
        ▼
AccelByteSDK  (alias AccelByteSDKWrapper)           ← facade
        │
        ├── 30 generated REST services              ← AccelbyteHttp: pooled HTTPClient on desktop and servers,
        │                                              HTTPRequest on the web export
        ├── generated WebSocket services            ← AccelByteWsTransport + one codec per wire format
        │     (Lobby, Chat, DSHub, AMS watchdog)
        ├── AccelByteDedicatedServer, AccelByteGameTransport   ← dedicated servers (ENet)
        └── AccelByteMultiplayerP2P, AccelByteP2PLobbySignaling ← P2P (WebRTC, Lobby signaling)
```

## Troubleshooting

- **"No default WebRTC extension configured", or `host()` returns null:** the WebRTC extension is missing on desktop. Install it and register it as described above.
- **A positional call broke after an update:** optional parameters are sorted alphabetically, so a new parameter can shift the ones after it. Compare your call with the method's parameter list.
- **A dedicated server exits with code 1 right after start:** it needs `-dsid`, `-watchdog_url` and the server client credentials (`-ab_client_id`, `-ab_client_secret`, or the `AB_*` environment variables).
- **"Token granted but user_id is empty" on a server:** expected, a client-credentials token has no user.

## Support

Questions or need help? Contact the AccelByte team at [hello@accelbyte.io](mailto:hello@accelbyte.io).

## License

See [LICENSE.md](LICENSE.md).
