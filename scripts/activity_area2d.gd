extends Area2D


@export var activity_type: Activity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.bubble_selected.connect(on_bubble_selected)
	Events.bubble_deselected.connect(on_bubble_deselected)
	
	# "monitorable" adjusts whether other Area2ds can detect this Area2d
	monitorable = false 
	set_process(false)


func on_bubble_selected():
	monitorable = true


func on_bubble_deselected():
	monitorable = false
