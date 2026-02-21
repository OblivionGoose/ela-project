extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_scene_change()

# Called when script detects a scene change
func _scene_change():
	var text_edit = $RichTextLabel
	text_edit.clear()
	text_edit.add_text(globals.scene_room)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if globals.new_room != globals.scene_room:
		globals.scene_room = globals.new_room
		_scene_change()
