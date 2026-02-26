# AccelByte SDK for Godot Engine

A pure GDScript plugin that provides AccelByte backend services to Godot 4.x games. Supports **Desktop** and **Web** with consistent cross-platform behavior.

## Disclaimer

This project is currently in **beta** version. Features are stable but may undergo refinement based on user feedback.

## Why Choose AccelByte SDK for Godot?

- **Game-Ready**: Built specifically for game developers, by game developers
- **Pure GDScript**: No native dependencies, works on every Godot platform
- **Quick Integration**: Get multiplayer features running in minutes, not months
- **Pay Only What You Use**: [Modular pricing](https://accelbyte.io/blog/accelbyte-gaming-services-is-now-modular) - start small, scale up
- **No Backend Maintenance**: Focus on gameplay, not server infrastructure

## Features

Based on [AccelByte's modular gaming services](https://accelbyte.io/gaming-services), choose only the modules you need:

### 🎯 Foundations (Core Services)
- **Identity & Access Management**: OAuth2 authentication, platform login, user accounts
- **Friends & Presence**: Player connections, status tracking, social interactions
- **Season Pass**: Progression tracking, seasonal rewards, battle pass systems
- **Analytics**: Player behavior insights, game balance optimization

### 🌐 Online Module
- **Cloud Save**: Cross-platform game data persistence and sync
- **Achievements**: Player progression, unlockables, reward systems
- **Leaderboards**: Rankings, competitions, seasonal events
- **User Generated Content**: Custom maps, mods, player creations
- **Economy**: Virtual currencies, item stores, cross-platform purchases

### ⚔️ Multiplayer Module
- **Matchmaking**: [Skill-based matching](https://docs.accelbyte.io/gaming-services/modules/multiplayer/matchmaking/) with custom rules
- **Dedicated Servers**: [Auto-provisioned game servers](https://docs.accelbyte.io/gaming-services/modules/multiplayer/multiplayer-servers/) across regions
- **P2P Networking**: [WebRTC-based peer connections](https://docs.accelbyte.io/gaming-services/modules/multiplayer/peer-to-peer/) with TURN/STUN
- **Chat**: Admin controls, message filtering, chat history
- **Guilds & Clans**: Player communities with roles and progression

### 🔧 Extend (Customization)
- **Custom Services**: Override existing behavior or add new functionality
- **External Integrations**: Connect third-party services without backend complexity
- **No Infrastructure Management**: Focus on game logic, not server operations

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
    sdk.initialize(self)

    # Configure SDK (or use project.godot settings)
    sdk.set_base_url("https://your-environment.accelbyte.io")
    sdk.set_client_credentials("your-client-id", "")
    sdk.set_namespace("your-namespace")

    # Device login
    var iam = sdk.get_service(IamService)
    var device_id = OS.get_unique_id()
    var result = await iam.platform_token_grant_v4("device", "", "", true, device_id)

    if result.get("success", false):
        # Tokens are automatically stored by the SDK
        print("Login successful! User ID: ", sdk.get_user_id())
    else:
        print("Login failed: ", result.get("error", "Unknown error"))
```

See the `accelbyte-sdk-examples/` directory for more usage patterns:

- `device_login_example.gd` - Device authentication
- `leaderboard_example.gd` - Leaderboard operations
- `lobby_friend_example.gd` - Lobby connection and friend requests
- `p2p_connection_example.gd` - P2P networking with automatic TURN server configuration

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
| Turn Manager | TURN/STUN server credentials for P2P |
| ... | 30+ services total |

Please refer to [Official AccelByte documentation](https://docs.accelbyte.io/gaming-services/getting-started/) to learn more about the available services.

## Platform Support

| Platform | Method | Status |
|----------|--------|--------|
| Windows x86_64 | GDScript | Supported |
| Web (HTML5) | GDScript | Supported |
| Linux | GDScript | - |
| macOS | GDScript | - |
| Android | GDScript | - |
| iOS | GDScript | - |

## P2P Networking

The SDK includes P2P (peer-to-peer) networking capabilities using WebRTC with automatic TURN/STUN server configuration.

### WebRTC Plugin Requirement

- **Desktop platforms** (Windows/Linux/macOS): Install the WebRTC plugin from Godot Asset Library
  - Asset Library ID: **2103** - [WebRTC GDExtension](https://godotengine.org/asset-library/asset/2103)
  - GitHub releases: https://github.com/godotengine/webrtc-native/releases
- **Web platform** (HTML5): WebRTC is built-in, no plugin required

### P2P Features

- **Automatic TURN server configuration** via AccelByte Turn Manager
- **NAT traversal** for connections across different network configurations
- **Multi-peer connections** with connection management
- **JSON message protocol** for structured game data
- **Signal-based architecture** for clean integration

See `accelbyte-sdk-examples/p2p_connection_example.gd` for a complete implementation.

## Architecture

```
Your Game (GDScript)
       │
       ▼
AccelByteSDKWrapper (pure GDScript)
       │
       └── All platforms: Pure GDScript → Godot HTTPRequest
```

**Pure GDScript implementation** ensures consistent behavior across all platforms with no native dependencies.

## License

See [LICENSE](LICENSE) for details.
