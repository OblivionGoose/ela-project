extends Node2D

@onready var living_window = $Living_window
@onready var study_window =$Study_window
var rng = RandomNumberGenerator.new()
var Monster_room: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_scene_change()
	globals.imp = true
	globals.game_controller.scene_change.connect(_scene_change)

func _scene_change():
	if globals.scene_room == "Basement":
		_dies()
	elif globals.scene_room == "Living":
		living_window.show()
	elif globals.scene_room == "Study":
		study_window.show()
	elif globals.scene_room == "Bedroom":
		_kills()
	else:
		living_window.hide()
		study_window.hide()

signal imp_kills

signal imp_dies

#process the imp's death
func _dies():
	emit_signal("imp_dies")
	globals.imp = false
	self.queue_free()

#process the imp killing the player
func _kills():
	globals.cause_of_death = "imp"
	emit_signal("imp_kills")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
