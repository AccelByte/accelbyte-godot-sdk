## Backwards-compatibility alias. Use AccelByteSDK directly for new code.
class_name AccelByteSDKWrapper
extends AccelByteSDK

## DEPRECATED: Use set_base_url() instead.
func set_server_url(url: String) -> void:
	push_warning("[AccelByteSDKWrapper] set_server_url() is deprecated. Use set_base_url() instead.")
	set_base_url(url)

## DEPRECATED: No longer needed - polling is automatic.
func poll() -> void:
	push_warning("[AccelByteSDKWrapper] poll() is deprecated. Token refresh is now automatic.")
	pass

## DEPRECATED: Use the wrapper instance directly.
func get_sdk() -> AccelByteSDK:
	push_warning("[AccelByteSDKWrapper] get_sdk() is deprecated. Use the AccelByteSDKWrapper instance directly.")
	return self
