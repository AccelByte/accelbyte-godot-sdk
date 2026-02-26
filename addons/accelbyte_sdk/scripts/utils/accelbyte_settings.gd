## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_settings.gd
## AccelByte SDK configuration store
## =============================================================================
##
## Simple config store for SDK settings. Replaces CNL InMemorySettings.
## Used by AccelByteSDKWrapper to hold server URLs, credentials, and namespace.
## =============================================================================

class_name AccelByteSettings
extends RefCounted

## AccelByte server base URL (e.g. "https://demo.accelbyte.io")
var base_url: String = ""

## Lobby WebSocket URL (e.g. "wss://demo.accelbyte.io/lobby/")
var lobby_url: String = ""

## Chat WebSocket URL
var chat_url: String = ""

## OAuth client ID
var client_id: String = ""

## OAuth client secret (write-only for security)
var _client_secret: String = ""

## Publisher namespace client ID (for publisher-level operations)
var publisher_id: String = ""

## Publisher namespace client secret (write-only for security)
var _publisher_secret: String = ""

## Publisher namespace
var publisher_namespace: String = ""

## Game namespace
var game_namespace: String = ""

## Enable request/response logging. Can be configured via project.godot [accelbyte] section:
## enable_http_logging=true/false. Defaults to debug builds only if not specified.
var enable_http_logging: bool = ProjectSettings.get_setting("accelbyte/enable_http_logging", OS.is_debug_build())


## Validate that essential settings are configured.
## Returns empty string if valid, or an error message describing what's missing.
## Based on Unity SDK validation pattern.
func validate() -> String:
	if base_url.is_empty():
		return "base_url is required"
	if client_id.is_empty():
		return "client_id is required"
	if game_namespace.is_empty():
		return "game_namespace is required"
	# Validate base_url format
	if not (base_url.begins_with("http://") or base_url.begins_with("https://")):
		return "base_url must start with http:// or https://"
	return ""


## Get a validation summary for debugging.
## Returns a dictionary with configured/missing settings info.
func get_validation_summary() -> Dictionary:
	return {
		"base_url": "OK" if not base_url.is_empty() else "MISSING (required)",
		"client_id": "OK" if not client_id.is_empty() else "MISSING (required)",
		"game_namespace": "OK" if not game_namespace.is_empty() else "MISSING (required)",
		"client_secret": "OK" if not _client_secret.is_empty() else "EMPTY (optional)",
		"lobby_url": "OK" if not lobby_url.is_empty() else "EMPTY (auto-derived from base_url)",
		"publisher_namespace": "OK" if not publisher_namespace.is_empty() else "EMPTY (optional)",
		"publisher_id": "OK" if not publisher_id.is_empty() else "EMPTY (optional)",
		"publisher_secret": "OK" if not _publisher_secret.is_empty() else "EMPTY (optional)"
	}


## Write-only setter for client secret (security: prevents accidental exposure)
func set_client_secret(secret: String) -> void:
	_client_secret = secret


## Write-only setter for publisher secret (security: prevents accidental exposure)
func set_publisher_secret(secret: String) -> void:
	_publisher_secret = secret


## Internal getter for client secret (used by HTTP layer for OAuth only)
## WARNING: GDScript does not enforce private access - callers must be reviewed carefully
func _get_client_secret() -> String:
	return _client_secret


## Internal getter for publisher secret (used by HTTP layer for OAuth only)
## WARNING: GDScript does not enforce private access - callers must be reviewed carefully
func _get_publisher_secret() -> String:
	return _publisher_secret
