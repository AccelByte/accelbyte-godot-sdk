## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_token_store.gd
## AccelByte token storage and expiry tracking
## =============================================================================
##
## Stores OAuth tokens (access, refresh) and tracks expiration.
## Replaces CNL Token class. Used by AccelByteSDK for auth state management.
##
## Token lifecycle is automatic:
##   - Token-granting endpoints (detected from OpenAPI spec) auto-store tokens
##   - Token-revoking endpoints auto-clear tokens
##   - No manual set_auth_tokens() calls needed from game code
## =============================================================================

class_name AccelByteTokenStore
extends RefCounted

## Current OAuth access token
var access_token: String = ""

## OAuth refresh token (for token refresh flow)
var refresh_token: String = ""

## Authenticated user ID
var user_id: String = ""

## Token expiration timestamp (milliseconds since engine start via Time.get_ticks_msec()).
## WARNING: This is engine uptime, NOT wall-clock time. It is NOT suitable for
## persisting tokens to disk — the value becomes meaningless after a game restart.
## If token persistence is added in the future, use Time.get_unix_time_from_system() instead.
var _expires_at_ms: int = 0

## Proactive refresh threshold — refresh is triggered at 80% of token lifetime,
## matching the Unity SDK convention (ScheduleNormalRefresh uses 0.8 * expires_in).
var _refresh_at_ms: int = 0

## Endpoint URL that issued the tokens — used for refresh.
## e.g. "https://demo.accelbyte.io/iam/v4/oauth/token"
var _refresh_endpoint_url: String = ""


## Store tokens from a successful login/token grant response.
## [param access] The access token string.
## [param refresh] The refresh token string.
## [param uid] The user ID.
## [param expires_in] Token lifetime in seconds.
## [param endpoint_url] The endpoint URL that issued these tokens (for refresh tracking).
func set_tokens(access: String, refresh: String, uid: String, expires_in: int, endpoint_url: String = "") -> void:
	access_token = access
	refresh_token = refresh
	user_id = uid
	_refresh_endpoint_url = endpoint_url
	if expires_in > 0:
		var now_ms: int = Time.get_ticks_msec()
		_expires_at_ms = now_ms + (expires_in * 1000)
		# Refresh at 80% of lifetime — same threshold as Unity SDK
		_refresh_at_ms = now_ms + int(expires_in * 0.8 * 1000)
	else:
		_expires_at_ms = 0
		_refresh_at_ms = 0


## Clear all stored tokens (called on logout/revocation).
func clear() -> void:
	access_token = ""
	refresh_token = ""
	user_id = ""
	_expires_at_ms = 0
	_refresh_at_ms = 0
	_refresh_endpoint_url = ""


## Check if a user is currently logged in (has a non-empty access token).
func is_logged_in() -> bool:
	return not access_token.is_empty()


## Check if the current access token has expired.
func is_expired() -> bool:
	if _expires_at_ms <= 0:
		return false
	return Time.get_ticks_msec() >= _expires_at_ms


## Check if it is time to proactively refresh the token (at 80% of lifetime).
func should_refresh() -> bool:
	if _refresh_at_ms <= 0 or refresh_token.is_empty():
		return false
	return Time.get_ticks_msec() >= _refresh_at_ms


## Get the endpoint URL to use for token refresh.
## Returns the URL that issued the current tokens, or falls back to v4 if unknown.
func get_refresh_endpoint_url(base_url: String) -> String:
	if not _refresh_endpoint_url.is_empty():
		return _refresh_endpoint_url
	# Fallback to v4 (newer standard) if no endpoint was tracked
	return base_url + "/iam/v4/oauth/token"


## Get remaining token lifetime in seconds. Returns 0 if expired or no token.
func get_remaining_lifetime_seconds() -> float:
	if _expires_at_ms <= 0:
		return 0.0
	var remaining_ms = _expires_at_ms - Time.get_ticks_msec()
	return max(0.0, remaining_ms / 1000.0)


## Force the refresh threshold to now so should_refresh() returns true immediately.
## For testing only — simulates token nearing expiry without waiting for real time.
func _force_refresh_due() -> void:
	if _refresh_at_ms > 0:
		_refresh_at_ms = Time.get_ticks_msec() - 1


## Force token validation after app resume to handle device sleep/suspend.
## On mobile platforms, engine uptime may not advance during sleep, causing
## tokens to appear fresh when they are actually expired on the server.
## Call this method when your game regains focus on mobile platforms.
func validate_on_resume() -> void:
	if is_logged_in() and _refresh_at_ms > 0:
		_refresh_at_ms = Time.get_ticks_msec() - 1
		push_warning("[AccelByteTokenStore] Forcing token validation after app resume")
