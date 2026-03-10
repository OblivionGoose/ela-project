extends Node2D

@onready var button1 = $Button
@onready var button2 = $Button2
@onready var button3 = $Button3
@onready var background = $Sprite
@onready var black_screen = $BlackTransition
var fade: bool = false
var opacity: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	button1.pressed.connect(_button_pressed)
	button2.pressed.connect(_button_pressed2)
	button3.pressed.connect(window)
	black_screen.modulate = Color(1,1,1,1)

func _button_pressed():
	fade = true
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene1)
func move_scene1():
	globals.scene_room = "Basement"
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/basement_room.tscn")

func _button_pressed2():
	fade = true
	button1.set_disabled(true)
	var timer = $Timer
	timer.start()
	timer.timeout.connect(move_scene2)
func move_scene2():
	globals.scene_room = "Foyer"
	globals.game_controller.change_2d_scene("res://scenes/Room Scenes/foyer_room.tscn")

func window():
	background.hide()
	button1.hide()
	button2.hide()
	button3.hide()
	var window_button = Button.new() 
	add_child(window_button)
	window_button.scale = Vector2(20, 10)
	window_button.pressed.connect(unwindow) # unpause and remove button on pressed
	window_button.pressed.connect(window_button.queue_free)

# very informative func name, processes leaving window view
func unwindow():
	background.show()
	button1.show()
	button2.show()
	button3.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if fade:
		opacity += 0.02
		black_screen.modulate = Color(1,1,1,opacity)
	else:
		black_screen.modulate = Color(1,1,1,0)
