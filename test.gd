extends Panel


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print("hm?")
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	print(data)
