extends Node2D

var fade: bool = false
var opacity: float = 0

func _ready():
	var button1 = $Button
	button1.pressed.connect(_button_pressed)
	var black_screen = $BlackTransition
	black_screen.modulate = Color(1,1,1,1)

func _button_pressed():
	fade = true
	var button1 = $Button
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene1)
func move_scene1():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/living_room.tscn")
	globals.new_room = "Living"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var black_screen = $BlackTransition
	
	if fade:
		opacity += 0.02
		black_screen.modulate = Color(1,1,1,opacity)
	else:
		black_screen.modulate = Color(1,1,1,0)
