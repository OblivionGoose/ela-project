extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var button1 = $Button
	button1.pressed.connect(_button_pressed)

func _button_pressed():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/Study_room.tscn")
	globals.new_room = "Study"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
