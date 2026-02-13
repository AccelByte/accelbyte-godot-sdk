# AccelByte SDK for Godot Engine

A GDExtension plugin that provides AccelByte backend services to Godot 4.x games. Supports **Windows (native)** and **Web (GDScript HTTP)** platforms.

## Disclaimer

This project is still in **alpha** version, some feature might be added or removed in the future update.

## Features

- **Identity & Access**: Secure OAuth2 authentication.
- **Progression & Persistence**: Cloud saves, player statistics, leaderboards, achievements, and more.
- **Economy & Commerce**: Manage virtual currencies, storefronts, entitlements, and cross-platform inventory sync.
- **Seamless Scalability**: Built on a microservices architecture to handle everything from playtests to millions of concurrent users.

## Installation

### From Asset Library
1. Open your Godot project
2. Go to **AssetLib** tab
3. Search for "AccelByte SDK"
4. Click **Download** and then **Install**

### Manual Installation
1. Download or clone this repository
2. Copy the `addons/accelbyte_sdk/` folder into your project's `addons/` directory

```
your-project/
├── addons/
│   └── accelbyte_sdk/    ← copy this folder
├── scenes/
├── scripts/
└── project.godot
```

## Configuration

Add the following to your `project.godot`:

```ini
[accelbyte]
base_url="https://your-environment.accelbyte.io"
namespace="your-namespace"
client_id="your-client-id"
client_secret=""
```

## Quick Start

```gdscript
var sdk: AccelByteSDKWrapper

func _ready():
    sdk = AccelByteSDKWrapper.new()
    add_child(sdk)

    sdk.set_server_url("https://your-environment.accelbyte.io")
    sdk.set_client_credentials("your-client-id", "")
    sdk.set_namespace("your-namespace")

    # Device login
    var iam = sdk.get_iam_service()
    var device_id = OS.get_unique_id()
    var result = await iam.platform_token_grant_v4("device", "", "", true, device_id)

    if result.get("success", false):
        var data = result.get("data", {})
        sdk.set_auth_tokens(
            data.get("access_token", ""),
            data.get("refresh_token", ""),
            data.get("user_id", ""),
            data.get("expires_in", 0)
        )
        print("Logged in as: ", sdk.get_user_id())
```

See the `accelbyte-sdk-examples/` directory for more usage patterns.

## Available Services

| Service | Description |
|---------|-------------|
| IAM | Authentication, user management, OAuth2 |
| Social | Statistics, user profiles |
| Leaderboard | Rankings, all-time and seasonal |
| Achievement | Player achievements and progression |
| CloudSave | Game and player data storage |
| Platform | Store, entitlements, wallets |
| Lobby | WebSocket-based lobby and notifications |
| Session | Session management and matchmaking |
| Chat | In-game messaging |
| ... | 38 more services |

Please refer to [Official AccelByte documentation](https://docs.accelbyte.io/gaming-services/getting-started/) to learn more about the available services.

## Platform Support

| Platform | Method | Status |
|----------|--------|--------|
| Windows x86_64 | Native C++ (CNL) | Supported |
| Web (HTML5) | GDScript HTTP | Supported |
| Linux | Planned | - |
| macOS | Planned | - |
| Android | Planned | - |
| iOS | Planned | - |

## Architecture

```
Your Game (GDScript)
       │
       ▼
AccelByteSDKWrapper (auto-routes by platform)
       │
       ├── Desktop: C++ GDExtension → AccelByte CNL (libcurl)
       │
       └── Web: GDScript → Godot HTTPRequest
```

## License

See [LICENSE](LICENSE) for details.
