extends HBoxContainer

@onready var current_turn_label = $CurrentTurn

@onready var defiant_label = $DefiantStat
@onready var helpful_label = $HelpfulStat
@onready var spirited_label = $SpiritedStat
@onready var cunning_label = $CunningStat


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	# This node doesn't need to be doing anything every frame
	
	Events.start_turn.connect(_on_start_turn)


# 
func _on_start_turn(current_turn):
	current_turn_label.text = str(current_turn)
	
	defiant_label.text = str(DataGlobal.defiant)
	helpful_label.text = str(DataGlobal.helpful)
	spirited_label.text = str(DataGlobal.spirited)
	cunning_label.text = str(DataGlobal.cunning)
