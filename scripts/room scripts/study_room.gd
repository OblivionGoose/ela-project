extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var button1 = $Button
	var button2 = $Button2
	button1.pressed.connect(_button_pressed)
	button2.pressed.connect(_button_pressed2)

func _button_pressed():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/Basement_room.tscn")
	globals.new_room = "basement"

func _button_pressed2():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/foyer_room.tscn")
	globals.new_room = "Foyer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
