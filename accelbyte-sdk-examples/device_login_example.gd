extends Node
## Example: Device Login with AccelByte SDK
##
## This script demonstrates how to perform a device login using the AccelByte SDK.
## Device login creates an anonymous account tied to the device, useful for
## letting players try your game without requiring registration.
##
## Setup:
##   1. Copy addons/accelbyte_sdk/ into your project's addons/ folder
##   2. Configure your project.godot with AccelByte credentials (see below)
##   3. Attach this script to any Node in your scene

## Add this to your project.godot:
## [accelbyte]
## base_url="https://your-environment.accelbyte.io"
## namespace="your-namespace"
## client_id="your-client-id"
## client_secret=""

var sdk: AccelByteSDKWrapper

func _ready() -> void:
	sdk = AccelByteSDKWrapper.new()
	sdk.initialize(self)

	# Configure SDK from project settings
	var base_url = ProjectSettings.get_setting("accelbyte/base_url", "")
	var namespace_ = ProjectSettings.get_setting("accelbyte/namespace", "")
	var client_id = ProjectSettings.get_setting("accelbyte/client_id", "")
	var client_secret = ProjectSettings.get_setting("accelbyte/client_secret", "")

	sdk.set_base_url(base_url)
	sdk.set_client_credentials(client_id, client_secret)
	sdk.set_namespace(namespace_)

	# Perform device login
	await _login_with_device()

func _login_with_device() -> void:
	var iam = sdk.get_service(IamService)

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
		print("Login failed: ", result.get("error", "Unknown error"))
