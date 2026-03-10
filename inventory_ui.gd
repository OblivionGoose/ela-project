extends Control

@onready var grid = $GridContainer

func _ready():
	print("InventoryUI ready!")
	hide()

func refresh():
	print("Refreshing inventory!")
	if grid == null:
		print("Grid is null!")
		return
	for child in grid.get_children():
		child.queue_free()
	for slot in get_node("/root/GameManager").player_inventory.slots:
		var slot_ui = preload("res://item_slot.tscn").instantiate()
		slot_ui.setup(slot["item"], slot["quantity"])
		grid.add_child(slot_ui)
