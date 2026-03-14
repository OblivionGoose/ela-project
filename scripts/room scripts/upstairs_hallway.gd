extends Node2D

@onready var button1 = $Button
@onready var button2 = $Button2
@onready var button3 = $Button3
@onready var black_screen = $BlackTransition
var fade: bool = false
var opacity: float = 0

func _ready():
	button1.pressed.connect(_button_pressed)
	button2.pressed.connect(_button_pressed2)
	button3.pressed.connect(_button_pressed3)
	black_screen.modulate = Color(1,1,1,1)

func unbutton():
	button1.hide()
	button2.hide()
	button3.hide()

func rebutton():
	button1.show()
	button2.show()
	button3.show()

func _button_pressed():
	fade = true
	var button1 = $Button
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene1)
func move_scene1():
	if globals.hour == 6 or 21:
		if globals.minute == 0:
			fade = false
			black_screen.modulate = Color(1,1,1,0)
		else:
			globals.scene_room = "Bedroom"
			globals.game_controller.change_2d_scene("res://scenes/Room Scenes/bedroom.tscn")
	else: 
		globals.scene_room = "Bedroom"
		globals.game_controller.change_2d_scene("res://scenes/Room Scenes/bedroom.tscn")

func _button_pressed2():
	fade = true
	var button1 = $Button
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene2)
func move_scene2():
	if globals.hour == 6 or 21:
		if globals.minute == 0:
			fade = false
			black_screen.modulate = Color(1,1,1,0)
		else:
			globals.scene_room = "Bathroom"
			globals.game_controller.change_2d_scene("res://scenes/Room Scenes/bathroom.tscn")
	else:
		globals.scene_room = "Bathroom"
		globals.game_controller.change_2d_scene("res://scenes/Room Scenes/bathroom.tscn")

func _button_pressed3():
	fade = true
	var button1 = $Button
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene3)
func move_scene3():
	if globals.hour == 6 or 21:
		if globals.minute == 0:
			fade = false
			black_screen.modulate = Color(1,1,1,0)
		else:
			globals.scene_room = "Foyer"
			globals.game_controller.change_2d_scene("res://scenes/Room Scenes/foyer_room.tscn")
	else:
		globals.scene_room = "Foyer"
		globals.game_controller.change_2d_scene("res://scenes/Room Scenes/foyer_room.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if fade:
		opacity += 0.02
		black_screen.modulate = Color(1,1,1,opacity)
	else:
		black_screen.modulate = Color(1,1,1,0)
