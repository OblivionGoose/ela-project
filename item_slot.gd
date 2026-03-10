extends Panel

func setup(item: ItemData, quantity: int) -> void:
	$TextureRect.texture = item.icon
	$Label.text = "x" + str(quantity) if quantity > 1 else ""
