extends Node
## Example: Leaderboard with AccelByte SDK
##
## This script demonstrates how to submit scores and retrieve leaderboard
## rankings using the AccelByte SDK. Requires a logged-in user (see
## device_login_example.gd first).
##
## Prerequisites:
##   - A leaderboard configured in the AccelByte Admin Portal
##   - A statistic code linked to the leaderboard (e.g., "highscore")
##   - User must be logged in before calling these methods

var sdk: AccelByteSDKWrapper

## Submit a high score using the Social service's stat items API.
## [br][br]
## [param score] The score value to submit
func submit_score(score: int) -> bool:
	var social = sdk.get_service(SocialService)
	var user_id = sdk.get_user_id()
	var namespace_ = ProjectSettings.get_setting("accelbyte/namespace", "")

	var body = [
		{
			"statCode": "highscore",
			"inc": score,
			"updateStrategy": "MAX"
		}
	]

	var result = await social.bulk_update_user_stat_item_2(namespace_, user_id, body)
	if result.get("success", false):
		print("Score submitted: ", score)
		return true
	else:
		print("Failed to submit score: ", result.get("error", ""))
		return false

## Retrieve the top rankings from a leaderboard.
## [br][br]
## [param leaderboard_code] The leaderboard code from Admin Portal
## [param limit] Number of entries to retrieve (default: 10)
func get_rankings(leaderboard_code: String, limit: int = 10) -> Array:
	var leaderboard = sdk.get_service(LeaderboardService)
	var namespace_ = ProjectSettings.get_setting("accelbyte/namespace", "")

	var result = await leaderboard.get_all_time_leaderboard_ranking_public_v1(
		leaderboard_code, namespace_, limit
	)

	if result.get("success", false):
		var data = result.get("data", {}).get("data", [])
		for entry in data:
			print("#%d %s - %d" % [
				entry.get("rank", 0),
				entry.get("userId", ""),
				entry.get("point", 0)
			])
		return data
	else:
		print("Failed to get rankings: ", result.get("error", ""))
		return []
