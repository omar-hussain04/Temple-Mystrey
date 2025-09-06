extends Area2D


@onready var game_maneger: Node = %"game maneger"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body):
	game_maneger.add_point()
	
	animation_player.play("coin pickup")
