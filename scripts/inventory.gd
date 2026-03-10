class_name Inventory
extends Resource

@export var slots: Array[Dictionary] = []
var max_slots: int = 24

func add_item(item: ItemData, amount: int = 1) -> bool:
	# Try to stack first
	if item.stackable:
		for slot in slots:
			if slot["item"].id == item.id and slot["quantity"] < item.max_stack:
				slot["quantity"] += amount
				return true
	# New slot
	if slots.size() >= max_slots:
		return false
	slots.append({"item": item, "quantity": amount})
	return true

func remove_item(item_id: String, amount: int = 1) -> void:
	for slot in slots:
		if slot["item"].id == item_id:
			slot["quantity"] -= amount
			if slot["quantity"] <= 0:
				slots.erase(slot)
			return
