extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
