class_name HurtBox
extends Area2D


signal received_damage(damage: int)

@onready var man_hurt: AudioStreamPlayer2D = $"../man hurt"

@export var health: Health



func _ready():
	connect("area_entered", _on_area_entered)





func _on_area_entered(hitbox: HitBoxs) -> void:
	
	if hitbox != null:
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
		


func _on_power_ups_body_entered(body: Node2D) -> void:
	health.health +=1
