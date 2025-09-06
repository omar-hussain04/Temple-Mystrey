extends Control





func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	SceneManager.change_scene("res://levels/level0.tscn")
	
