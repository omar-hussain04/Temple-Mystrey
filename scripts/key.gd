extends Area2D

@onready var game_maneger: Node = %"game maneger"
@onready var animation_player: AnimationPlayer = $AnimationPlayer




func _on_body_entered(body: Node2D) -> void:
	game_maneger.get_key()
	animation_player.play("pickup key")
