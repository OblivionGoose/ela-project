extends Node2D

func _ready():
	var button1 = $Button
	var button2 = $Button2
	var button3 = $Button3
	button1.pressed.connect(_button_pressed)
	button2.pressed.connect(_button_pressed2)
	button3.pressed.connect(_button_pressed3)


func _button_pressed():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/bedroom.tscn")
	globals.new_room = "bedroom"

func _button_pressed2():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/bathroom.tscn")
	globals.new_room = "Bathroom"
	
func _button_pressed3():
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/foyer_room.tscn")
	globals.new_room = "Foyer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
