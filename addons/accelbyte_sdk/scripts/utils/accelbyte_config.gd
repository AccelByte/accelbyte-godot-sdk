## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## Runtime configuration: Project Settings first, launch arguments override them.
##
## The same build can run against another environment without editing project.godot:
##   godot --headless --path game --server -ab_base_url=https://demo.accelbyte.io -ab_namespace=mygame \
##         -ab_client_id=<id> -ab_client_secret=<secret> -ab_redirect_uri=http://127.0.0.1 -ab_log_level=Verbose
##
## Project Settings (section [accelbyte] of project.godot): base_url, namespace, client_id, client_secret, redirect_uri, log_level.
## Launch argument per value: -ab_<name>; the alias -accelbyte_<name> is accepted too, and for the client id, client secret,
## redirect uri and log level also the compact forms -abclientid, -abclientsecret, -abredirecturi, -abloglevel. Accepted
## syntax: -key=value, --key=value and -key value (keys are not case sensitive). An empty value is ignored.
##
## AccelByteSDK.initialize() applies this configuration (see AccelByteSDK.load_config); values set afterwards with
## set_base_url() and the other setters win. A client secret on a command line is visible in the process list: prefer the
## environment variables of AccelByteDedicatedServer (AB_CLIENT_SECRET) where that matters.
class_name AccelByteConfig
extends RefCounted

## The configuration keys.
const KEYS: PackedStringArray = [
	"base_url", "namespace", "client_id", "client_secret", "redirect_uri", "log_level"
]

## Launch argument names (lower case, without the leading dashes) that set a key.
const _ALIASES: Dictionary = {
	"base_url": ["ab_base_url", "accelbyte_base_url"],
	"namespace": ["ab_namespace", "accelbyte_namespace"],
	"client_id": ["ab_client_id", "accelbyte_client_id", "abclientid"],
	"client_secret": ["ab_client_secret", "accelbyte_client_secret", "abclientsecret"],
	"redirect_uri": ["ab_redirect_uri", "accelbyte_redirect_uri", "abredirecturi"],
	"log_level": ["ab_log_level", "accelbyte_log_level", "abloglevel"],
}


## Values from Project Settings (accelbyte/<key>). Keys that are not set are missing from the result.
static func read_project_settings() -> Dictionary:
	var result: Dictionary = {}
	for key in KEYS:
		var setting := "accelbyte/" + key
		if ProjectSettings.has_setting(setting):
			var value := str(ProjectSettings.get_setting(setting)).strip_edges()
			if not value.is_empty():
				result[key] = value
	return result


## Overrides found in `args`. Keys that were not given (or given without a value) are missing from the result.
static func parse_launch_args(args: PackedStringArray) -> Dictionary:
	var lookup: Dictionary = {}
	for key in _ALIASES:
		for alias in _ALIASES[key]:
			lookup[alias] = key
	var result: Dictionary = {}
	var i := 0
	while i < args.size():
		var arg := str(args[i])
		i += 1
		if not arg.begins_with("-"):
			continue
		var body := arg.lstrip("-")
		var name := body
		var value := ""
		var has_value := false
		var eq := body.find("=")
		if eq >= 0:
			name = body.substr(0, eq)
			value = body.substr(eq + 1)
			has_value = true
		name = name.to_lower()
		if not lookup.has(name):
			continue
		if not has_value and i < args.size() and not str(args[i]).begins_with("-"):
			value = str(args[i])
			has_value = true
			i += 1
		value = value.strip_edges()
		if has_value and not value.is_empty():
			result[lookup[name]] = value
	return result


## Project Settings with the launch arguments laid over them. `args` defaults to the engine and user arguments of this process.
static func load_config(
	args: PackedStringArray = PackedStringArray(), use_launch_args: bool = true
) -> Dictionary:
	var config := read_project_settings()
	if use_launch_args:
		var source := args
		if source.is_empty():
			source = OS.get_cmdline_args() + OS.get_cmdline_user_args()
		config.merge(parse_launch_args(source), true)
	if config.has("base_url"):
		config["base_url"] = normalize_base_url(str(config["base_url"]))
	return config


## Trim spaces and trailing slashes.
static func normalize_base_url(url: String) -> String:
	var result := url.strip_edges()
	while result.ends_with("/"):
		result = result.substr(0, result.length() - 1)
	return result


## Whether a log level name means "log every request". Verbose, Log and All do; Off, None, Error and Warning do not.
## Returns -1 for an unknown name (keep the default).
static func http_logging_for_level(level: String) -> int:
	match level.strip_edges().to_lower():
		"verbose", "log", "all", "debug", "info":
			return 1
		"off", "none", "error", "warning", "warn":
			return 0
	return -1
