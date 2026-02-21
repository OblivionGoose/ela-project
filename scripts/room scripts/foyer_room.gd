extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var button1 = $Button
	var button2 = $Button2
	var button3 = $Button3
	button1.pressed.connect(_button_pressed)
	button2.pressed.connect(_button_pressed2)
	button3.pressed.connect(_button_pressed3)

func _button_pressed():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/Upstairs_Hallway.tscn")
	globals.new_room = "Upstairs_Hallway"

func _button_pressed2():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/study_room.tscn")
	globals.new_room = "Study"

func _button_pressed3():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/living_room.tscn")
	globals.new_room = "Living"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
