extends Node2D

func _ready():
	var button = $StartButton
	var cred = $CreditButton
	button.text = "Click me"
	cred.pressed.connect(_credit_pressed)
	button.pressed.connect(_button_pressed)
	add_child(button)

func _credit_pressed():
	get_tree().change_scene_to_file("res://scenes/credit.tscn")

func _button_pressed():
	print("Hello world!")
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
