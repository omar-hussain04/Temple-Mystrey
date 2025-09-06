extends Area2D


@onready var timer: Timer = $Timer
@onready var love_always_wins: Sprite2D = $"../ui/Love-always-wins"


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("you died!")
		Engine.time_scale = 0.5
		timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	
	SceneManager.reload_scene()
