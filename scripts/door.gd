extends StaticBody2D

var door_open : bool
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Map current scene name -> next scene path
var level_map: Dictionary = {
	"level0": "res://levels/level1.tscn" ,
	"level_1": "res://levels/level2.tscn",
	"level_2": "res://levels/level3.tscn",
	"level_3": "res://levels/level4.tscn",
	# Add more levels here
}
@onready var game_maneger: Node = %"game maneger"

func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var current_scene_name = get_tree().current_scene.name
		game_maneger.key -=1

		if level_map.has(current_scene_name):
			var next_scene = level_map[current_scene_name]
			SceneManager.call_deferred("change_scene", next_scene)
		else:
			# fallback: reload current scene if not found
			var next_scene = LevelManager.get_next_level_scene()
			SceneManager.call_deferred("change_scene", next_scene)

func _on_activate_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if   game_maneger.key >0 :
			
			animated_sprite_2d.play("open")
			door_open = true
			collision_shape_2d.set_deferred("disabled", true)

func _on_activate_door_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if door_open:
			animated_sprite_2d.play("close")
			door_open = false
			collision_shape_2d.set_deferred("disabled", false)
