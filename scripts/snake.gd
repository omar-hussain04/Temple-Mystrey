extends Node2D

const SPEED = 60
@export var health: int = 3  # عدد الضربات قبل الموت

var direction = 1

@onready var raycast_r: RayCast2D = $raycastR
@onready var raycast_l: RayCast2D = $raycastL
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hit: CollisionShape2D = $HitBoxs/CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D






func _process(delta: float) -> void:
	# الحركة يمين/يسار حسب التصادم مع الجدران
	if raycast_r.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
		
	if raycast_l.is_colliding():
		direction = 1
		animated_sprite.flip_h = true

	position.x += direction * SPEED * delta




# دالة استدعاء عند تلقي ضربة
func take_damage(amount: int) -> void:
	health -= amount
	print("العدو انضرب! الصحة: %d" % health)
	if health <= 0:
		queue_free()  # حذف العدو من المشهد


func _on_ready() -> void:
	
	

	add_to_group("monster")




func _on_hurtm_area_entered(area: Area2D) -> void:
	direction = 0
	animated_sprite.play("death")
	hit.set_deferred("disabled" , true)
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.7).timeout
	queue_free()
