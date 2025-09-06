extends CharacterBody2D
@onready var health: Health = $Health
@onready var love_always_wins: Sprite2D = $"../ui/Love-always-wins"
@onready var love_always_wins_2: Sprite2D = $"../ui/Love-always-wins2"
@onready var love_always_wins_3: Sprite2D = $"../ui/Love-always-wins3"
@onready var man_hurt: AudioStreamPlayer2D = $"man hurt"
@onready var collision_shape_2d: CollisionShape2D = $attack/CollisionShape2D



@export var speed: float = 200.0
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackAreaء
#func _ready() -> void:
	#attack_area.monitoring = false 
	#attack_area.body_entered.connect(_on_attack_area_hit_body)
	#attack_area.area_entered.connect(_on_attack_area_hit_area)

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var is_hurt: bool = false        # Flag to block animation override
var was_running: bool = false    # Track if player was running

func _physics_process(delta: float) -> void:
	# الحركة (movement always works)
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		
		collision_shape_2d.set_deferred("disabled" , false)

		await get_tree().create_timer(0.3).timeout
		
		collision_shape_2d.set_deferred("disabled" , true)

	# الأنيميشن
	if is_hurt:
		# if hurt → don’t override the animation (still moving allowed)
		return

	if direction == Vector2.ZERO:
		anim_sprite.play("idle")
		was_running = false
		if audio_stream_player_2d.playing:
			audio_stream_player_2d.stop()
	else:
		anim_sprite.play("run")
		was_running = true
		if not audio_stream_player_2d.playing:
			audio_stream_player_2d.play()
		if direction.x != 0.0:
			anim_sprite.flip_h = direction.x > 0.0
				

func _on_ready() -> void:
	add_to_group("player")


func _on_health_health_depleted() -> void:
	SceneManager.reload_scene()
	

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_health_health_changed(diff: int) -> void:
	man_hurt.play()
	_play_hurt_animation()

	if  health.get_health() == 2:
		love_always_wins.visible = false
		love_always_wins_2.visible = true
		love_always_wins_3.visible = true
	elif health.get_health() == 1:
		love_always_wins.visible = false
		love_always_wins_2.visible = false
		love_always_wins_3.visible = true
	elif health.get_health() == 0:
		love_always_wins.visible = false
		love_always_wins_2.visible = false
		love_always_wins_3.visible = false


func _play_hurt_animation() -> void:
	is_hurt = true
	
	if was_running:
		anim_sprite.play("run hurt")
	else:
		anim_sprite.play("hurt")

	# play for a short duration then allow normal animations again
	await get_tree().create_timer(0.3).timeout
	is_hurt = false
