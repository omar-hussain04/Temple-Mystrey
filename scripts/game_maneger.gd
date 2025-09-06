extends Node


@onready var level_door: StaticBody2D = $"../doors/level door"
@onready var no_of_coins: Label = %NoOfCoins
@onready var key_lbl: Sprite2D = %"key lbl"
@onready var love_always_wins: Sprite2D = %"Love-always-wins"
@onready var love_always_wins_2: Sprite2D = %"Love-always-wins2"
@onready var love_always_wins_3: Sprite2D = %"Love-always-wins3"
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"


var score = 0
func add_point():
	score+=1
	update_score_ui()


	
	
	

#هون بنعرف و بنخلي المفتاح بنقدر نتبع ععددهم
var key = 0
func get_key():
	key+=1
	update_key_ui()

#بيخلي المفتاح يبين بس توخذه
func update_key_ui():
	key_lbl.visible = true


#هاي فنكشن بحط قيمة السكور في الليبل
func update_score_ui():
	no_of_coins.text = str(score)
