extends Node

var player_inventory: Inventory = Inventory.new()
const SAVE_PATH = "user://save.tres"

func save_game() -> void:
	ResourceSaver.save(player_inventory, SAVE_PATH)

func load_game() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		player_inventory = ResourceLoader.load(SAVE_PATH)
	else:
		player_inventory = Inventory.new()
