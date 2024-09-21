extends HBoxContainer

@onready var current_turn_label = $CurrentTurn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	# This node doesn't need to be doing anything every frame
	
	Events.start_turn.connect(_on_start_turn)


# 
func _on_start_turn(current_turn):
	current_turn_label.text = str(current_turn)
