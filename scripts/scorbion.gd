extends Node2D

@export var SPEED: int = 60
var velocity := Vector2.ZERO

@onready var raycast_d: RayCast2D = $RayCastD
@onready var raycast_u: RayCast2D = $RayCastU
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hit: CollisionShape2D = $HitBoxs/CollisionShape2D

func _ready() -> void:
	add_to_group("monster")
	# start moving down by default
	velocity.y = SPEED  

func _process(delta: float) -> void:
	# Check bottom ray
	if raycast_d.is_colliding():
		velocity.y = SPEED
		animated_sprite.flip_h = false

	# Check top ray
	elif raycast_u.is_colliding():
		velocity.y = -SPEED
		animated_sprite.flip_h = true

	# Move along Y axis
	position.y += velocity.y * delta
	



func _on_hurtm_area_entered(area: Area2D) -> void:
	velocity.y = 0
	animated_sprite.play("death")
	hit.set_deferred("disabled" , true)
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.7).timeout
	queue_free()
