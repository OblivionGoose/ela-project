extends Node2D

@onready var black_screen = $BlackTransition
var fade: bool = false
var opacity: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var button1 = $Button
	var button2 = $Button2
	var button3 = $Button3
	button1.pressed.connect(_button_pressed)
	button2.pressed.connect(_button_pressed2)
	button3.pressed.connect(_button_pressed3)
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

func _button_pressed2():
	fade = true
	var button1 = $Button
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene2)
func move_scene2():
	globals.scene_room = "Study"
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/study_room.tscn")

func _button_pressed3():
	fade = true
	var button1 = $Button
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene3)
func move_scene3():
	globals.scene_room = "Living"
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/living_room.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fade:
		opacity += 0.02
		black_screen.modulate = Color(1,1,1,opacity)
	else:
		black_screen.modulate = Color(1,1,1,0)
