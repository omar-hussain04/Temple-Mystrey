extends Node

# Array of all level scenes in order
@export var levels: Array[String] = [
	"res://levels/level0.tscn",
	"res://levels/level1.tscn",
	"res://levels/level2.tscn",
	"res://levels/level3.tscn"
]

var current_level_index: int = -1  # start as -1 so we can detect first scene

# Call this to get the next level scene
func get_next_level_scene() -> String:
	# If first time, detect the current scene automatically
	if current_level_index == -1:
		var current_scene_path = get_tree().current_scene.get_scene_file_path()
		var index = levels.find(current_scene_path)
		if index != -1:
			current_level_index = index
		else:
			current_level_index = 0

	# Move to next scene
	current_level_index += 1
	if current_level_index >= levels.size():
		current_level_index = 0  # loop back to first level

	return levels[current_level_index]
