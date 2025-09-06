extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D




func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		animated_sprite_2d.play_backwards("open")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animated_sprite_2d.play("open")
		collision_shape_2d.set_deferred("disabled" , true)
		await get_tree().create_timer(0.5).timeout
		animated_sprite_2d.z_index = 0
