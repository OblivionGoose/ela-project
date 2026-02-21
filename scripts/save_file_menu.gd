extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	var button2 = $Button2
	var button3 = $Button3
	var button4 = $Button4
	button.pressed.connect(_button_pressed)
	button2.pressed.connect(_button_pressed2)
	button3.pressed.connect(_button_pressed)
	button4.pressed.connect(_button_pressed2)

func _save_file_start(String):
	print("hi")

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")

func _button_pressed2():
	get_tree().change_scene_to_file("res://scenes/game_controller.tscn")
