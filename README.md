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

func _ready() -> void:
	sdk = AccelByteSDKWrapper.new()
	sdk.initialize(self)

	# Configure SDK from project settings
	var base_url = ProjectSettings.get_setting("accelbyte/base_url", "")
	var namespace_ = ProjectSettings.get_setting("accelbyte/namespace", "")
	var client_id = ProjectSettings.get_setting("accelbyte/client_id", "")
	var client_secret = ProjectSettings.get_setting("accelbyte/client_secret", "")

	sdk.set_server_url(base_url)
	sdk.set_client_credentials(client_id, client_secret)
	sdk.set_namespace(namespace_)

	# Perform device login
	var iam = sdk.get_iam_service()

	# Generate a unique device ID (or use OS-specific ID)
	var device_id = OS.get_unique_id()
	if device_id.is_empty():
		device_id = str(Time.get_unix_time_from_system()).md5_text()

	print("Logging in with device ID: ", device_id)

	var result = await iam.platform_token_grant_v4("device", "", "", true, device_id)

	if result.get("success", false):
		# Tokens are automatically stored by the SDK
		print("Login successful! User ID: ", sdk.get_user_id())
	else:
		print("Login failed: ", result.get("error_message", "Unknown error"))
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
