extends Node2D

func _ready():
	var button = $StartButton
	var cred = $CreditButton
	var quit = $Quitbutton
	quit.pressed.connect(_quit_pressed)
	cred.pressed.connect(_credit_pressed)
	button.pressed.connect(_button_pressed)
	add_child(button)

func _quit_pressed():
	get_tree().quit(0)

func _credit_pressed():
	get_tree().change_scene_to_file("res://scenes/credit.tscn")

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/save_file_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
