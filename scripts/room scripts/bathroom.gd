extends Node2D

@onready var black_screen = $BlackTransition
var fade: bool = false
var opacity: float = 0

func _ready():
	var button1 = $Button
	button1.pressed.connect(_button_pressed)
	black_screen.modulate = Color(1,1,1,1)

func _button_pressed():
	fade = true
	var button1 = $Button
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene1)
func move_scene1():
	globals.scene_room = "Upstairs_Hallway"
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/upstairs_Hallway.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if fade:
		opacity += 0.02
		black_screen.modulate = Color(1,1,1,opacity)
	else:
		black_screen.modulate = Color(1,1,1,0)
