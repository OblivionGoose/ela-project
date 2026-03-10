extends Area2D

@export var item: ItemData
@export var quantity: int = 1

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var success = GameManager.player_inventory.add_item(item, quantity)
		if success:
			queue_free()
