extends Node2D

func _ready():
	var button = $Button
	button.pressed.connect(_button_pressed)

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
