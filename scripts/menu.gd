extends CanvasLayer


@onready var quit: TextureButton = $TextureButton
@onready var start: TextureButton = $TextureButton2




func _ready() -> void:
	# Connect the button signals
	quit.pressed.connect(_on_quit_pressed)
	start.pressed.connect(_on_start_pressed)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	print("Start button pressed") # later replace with your scene change
