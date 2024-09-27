extends Control

var hovered_activity
var activity
var is_dragging = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - pivot_offset


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		get_viewport().set_input_as_handled()
		var was_dragging = is_dragging
		is_dragging = not is_dragging
		
		
		if was_dragging and not is_dragging:
			# If the user stopped dragging
			Events.emit_signal("bubble_deselected")
			
			if hovered_activity:
				activity = hovered_activity
				
			else:
				activity = null
				
		elif not was_dragging and is_dragging:
			# If the user started dragging
			Events.emit_signal("bubble_selected")


func _on_activity_entered(area):
	if "activity_type" in area:
		hovered_activity = area.activity_type


func _on_activity_exited(_area):
	hovered_activity = null
