# AccelByte SDK for Godot: quick start

A pure GDScript SDK for [AccelByte Gaming Services](https://accelbyte.io/gaming-services). It needs Godot 4.5 or newer. This addon is a set of scripts with global classes; there is no editor plugin to enable.

## Step 1: Configure your game

Add your environment to `project.godot`:

```ini
[accelbyte]
base_url="https://your-environment.accelbyte.io"
namespace="your-namespace"
client_id="your-client-id"
client_secret=""
```

The same values can be given as launch arguments (`-ab_base_url=`, `-ab_namespace=`, `-ab_client_id=`, `-ab_client_secret=`) or in code with `set_base_url()`, `set_namespace()` and `set_client_credentials()`. Need an account or a client? See the [AccelByte documentation](https://docs.accelbyte.io/gaming-services/getting-started/).

## Step 2: Test the connection

```gdscript
extends Node

func _ready() -> void:
    var sdk := AccelByteSDKWrapper.new()
    sdk.initialize(self)   # reads the settings from step 1

    # Device login. Parameters: platform_id, code_challenge, code_challenge_method, additional_data,
    # app_id, client_id, code_verifier, create_headless, device_id
    var iam = sdk.get_service(IamService)
    var result = await iam.platform_token_grant_v4("device", "", "", "", "", "", "", true, OS.get_unique_id())

    if result.get("success", false):
        print("Connected, user id: ", sdk.get_user_id())
    else:
        print("Error: ", result.get("error", "check your settings"))
```

## Step 3: Explore the examples

Working examples are in `accelbyte-sdk-examples/` in the plugin repository (not inside this addon folder):

- `device_login_example.gd`: device authentication
- `leaderboard_example.gd`: stats and leaderboards
- `lobby_friend_example.gd`: Lobby connection and friends
- `matchmaking_example.gd`: matchmaking v2
- `connect_to_ds_example.gd` and `dedicated_server_example.gd`: a dedicated-server game, client and server
- `p2p_connection_example.gd`: P2P networking

## Common services

```gdscript
var iam = sdk.get_service(IamService)                   # authentication and users
var social = sdk.get_service(SocialService)             # statistics
var leaderboard = sdk.get_service(LeaderboardService)   # rankings
var cloudsave = sdk.get_service(CloudsaveService)       # player and game data
var session = sdk.get_service(SessionService)           # game sessions
var match2 = sdk.get_service(Match2Service)             # matchmaking v2

sdk.lobby_connect()                                     # real-time Lobby WebSocket
var lobby = sdk.get_lobby_ws_service()
```

The full list of services, multiplayer (dedicated server and P2P) usage and the platform notes are in the repository README.

## Troubleshooting

- **`Identifier "AccelByteSDKWrapper" not declared`:** the addon is not in `addons/accelbyte_sdk/`, or Godot has not scanned the scripts yet. Reopen the project or run `godot --headless --import --quit`.
- **An authentication error:** check the `[accelbyte]` values (base URL, namespace, client id and secret), or set them in code.
- **P2P fails on desktop:** install the Godot WebRTC extension (Asset Library 2103); web exports include it.
