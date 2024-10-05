extends Button

var save_id := "0"

# Called when the node enters the scene tree for the first time.
func init(id):
	save_id = id


func _on_pressed() -> void:
	Events.emit_signal("delete_save", save_id)
