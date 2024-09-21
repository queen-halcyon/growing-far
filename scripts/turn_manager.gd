extends Node2D

var current_turn = 1
var final_turn = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	# This node doesn't need to be doing anything every frame
	
	Events.connect("end_turn", on_turn_ended)


# Called when the user clicks "end turn"
func on_turn_ended():
	current_turn += 1
	
	if current_turn >= final_turn:
		get_tree().change_scene_to_file("res://game.tscn")
	else:
		Events.emit_signal("start_turn", current_turn)
