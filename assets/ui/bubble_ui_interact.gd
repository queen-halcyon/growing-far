extends Control

var is_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_gui_input(event: InputEvent) -> void:
	var movement = event is InputEventMouseMotion
	
	if event.is_action_pressed("left_click"):
		is_dragging = not is_dragging
	
	if is_dragging and movement:
		global_position = get_global_mouse_position() - pivot_offset
