extends Node2D


func _ready():
	var button1 = $Button
	button1.pressed.connect(_button_pressed)

func _button_pressed():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/Upstairs_Hallway.tscn")
	globals.new_room = "Upstairs_Hallway"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
