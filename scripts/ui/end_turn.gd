extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	# This node doesn't need to be doing anything every frame
	
	Events.connect("conversation_started", _on_conversation_started)
	Events.connect("player_ended_conversation", _on_conversation_ended)


func _on_pressed() -> void:
	Events.emit_signal("end_turn")


func _on_conversation_started():
	visible = false

func _on_conversation_ended():
	visible = true
