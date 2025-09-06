class_name pHurtBox
extends Area2D


signal received_damage(damage: int)

@onready var man_hurt: AudioStreamPlayer2D = $"../man hurt"

@export var health: Health


func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: mHitBox) -> void:
	
	#if hitbox != null:
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
		
