class_name GameController extends Node

@export var world_2d : Node2D
@export var gui : Control
var current_2d_scene 
var current_gui_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.game_controller = self
	current_2d_scene = $World2D/Foyer_Room
	current_gui_scene = $GUI

func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if delete:
		current_2d_scene.queue_free() # deletes node entirely
	elif keep_running:
		current_2d_scene.visible = false #hides node, keeps in memory and running
	else :
		gui.remove_child(current_2d_scene) # keeps in memory, does not run
	var new = load(new_scene).instantiate()
	world_2d.add_child(new)
	current_2d_scene = new

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
