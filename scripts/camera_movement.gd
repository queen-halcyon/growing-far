extends Camera2D

var move_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("scroll_left"):
		self.position = position - Vector2(move_speed, 0)
			
	elif event.is_action("scroll_right"):
		self.position = position + Vector2(move_speed, 0)
