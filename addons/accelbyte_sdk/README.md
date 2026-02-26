# AccelByte SDK for Godot - Quick Start

## Step 1: Configure Your Game

Add this to your `project.godot`:

```ini
[accelbyte]
base_url="https://your-environment.accelbyte.io"
namespace="your-namespace"
client_id="your-client-id"
client_secret=""
```

**Need credentials?** Register at: https://prod.gamingservices.accelbyte.io/auth/register

## Step 2: Test Connection

```gdscript
extends Node

func _ready():
    var sdk = AccelByteSDKWrapper.new()
    sdk.initialize(self)

    # Quick device login
    var iam = sdk.get_service(IamService)
    var result = await iam.platform_token_grant_v4("device", "", "", true, OS.get_unique_id())

    if result.get("success", false):
        print("Connected! User: ", sdk.get_user_id())
    else:
        print("Error: ", result.get("error", "Check your credentials"))
```

## Step 3: Explore Examples

Your project includes working examples in `accelbyte-sdk-examples/`:

- `device_login_example.gd` - Device authentication
- `leaderboard_example.gd` - Scores and rankings
- `lobby_friend_example.gd` - Social features
- `p2p_connection_example.gd` - Multiplayer networking

**Copy these into your scenes to see complete implementations.**

## Common Services

```gdscript
# Authentication and user management
var iam = sdk.get_service(IamService)

# Player statistics and leaderboards
var social = sdk.get_service(SocialService)
var leaderboard = sdk.get_service(LeaderboardService)

# Game data storage
var cloudsave = sdk.get_service(CloudSaveService)

# Real-time features
var lobby = sdk.get_service(LobbyService)
```

## Troubleshooting

**"Invalid access to property"** - Enable the plugin in Project Settings > Plugins

**"Authentication failed"** - Check your credentials in project.godot

**Need more help?** Join our Discord: https://discord.gg/nXMWQbqNPY