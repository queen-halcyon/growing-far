extends Button

var save_id := "0"

func init(id):
	save_id = id


func _on_pressed() -> void:
	DataGlobal.save_id = save_id
	DataGlobal.is_new_game = false
	get_tree().change_scene_to_file("res://game_world.tscn")
