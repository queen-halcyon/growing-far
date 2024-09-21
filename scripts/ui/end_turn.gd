extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	# This node doesn't need to be doing anything every frame


func _on_pressed() -> void:
	Events.emit_signal("end_turn")
