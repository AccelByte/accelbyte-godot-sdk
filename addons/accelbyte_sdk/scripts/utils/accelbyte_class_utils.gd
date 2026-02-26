## Copyright (c) 2026 AccelByte Inc. All Rights Reserved.
## This is licensed software from AccelByte Inc, for limitations
## and restrictions contact your company contract manager.

## =============================================================================
## accelbyte_class_utils.gd
## AccelByte Class Utilities — helper functions for working with classes
## =============================================================================
##
## Static utility functions for class detection and management in Godot 4.
## Provides cross-platform compatible methods for checking custom classes.
## =============================================================================

class_name AccelByteClassUtils
extends RefCounted

## Check if a custom GDScript class exists (Godot 4 compatible).
## ClassDB.class_exists() only works for built-in engine classes, not custom classes with class_name.
##
## Usage:
##   if AccelByteClassUtils.custom_class_exists("MyService"):
##       var service = MyService.new()
##
## Returns true if the class is registered as a global script class, false otherwise.
static func custom_class_exists(_class_name: String) -> bool:
	# Godot 4 uses get_global_class_list() instead of get_setting("_global_script_classes")
	var global_classes = ProjectSettings.get_global_class_list()
	for class_info in global_classes:
		if class_info.get("class", "") == _class_name:
			return true
	return false

## Get the script path for a custom GDScript class.
## Returns the file path of the class if found, empty string otherwise.
static func get_custom_class_path(_class_name: String) -> String:
	var global_classes = ProjectSettings.get_global_class_list()
	for class_info in global_classes:
		if class_info.get("class", "") == _class_name:
			return class_info.get("path", "")
	return ""

## Get all registered global script classes.
## Returns an array of dictionaries with "class" and "path" keys.
static func get_all_custom_classes() -> Array:
	return ProjectSettings.get_global_class_list()


## Get a custom class reference by name for dynamic loading.
## Returns the loaded script as a GDScript, or null if not found.
## Use this to avoid parse-time dependencies on optional classes.
static func get_custom_class_by_name(_class_name: String):
	var class_path = get_custom_class_path(_class_name)
	if class_path.is_empty():
		return null

	var script = load(class_path)
	return script
