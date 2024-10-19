extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	# This node doesn't need to be doing anything every frame


signal end_turn
signal start_turn
signal bubble_selected
signal bubble_deselected
signal next_slide

signal delete_save


signal card_selected
signal card_deselected


signal card_played
signal conversation_over
signal player_ended_conversation
signal player_dialog_turn_started
signal npc_dialog_turn_started
