extends Control

var sprites = [
	preload("res://assets/ui/suit_spades.png"),
	preload("res://assets/ui/suit_hearts.png"),
	preload("res://assets/ui/suit_diamonds.png"),
	preload("res://assets/ui/suit_clubs.png")
]

var is_dragging = false
var card_drop = null
var can_drag = true

const DRAG_TIMER = 1
var current_drag_time = 0


var card : Symbol
var index : int

var canvas_layer
var hand_display

signal discarded


func _process(delta: float) -> void:
	if is_dragging:
		current_drag_time += delta
		global_position = get_global_mouse_position() - pivot_offset
	
	if Input.is_action_pressed("left_click") and is_dragging and current_drag_time >= DRAG_TIMER:
		_on_left_click()


func display_symbols():
	$LeftSymbol.texture = sprites[card.left_symbol]
	$RightSymbol.texture = sprites[card.right_symbol]


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and can_drag:
		if not is_dragging and DataGlobal.dragging_already:
			return
		
		_on_left_click()


func _on_left_click():
	current_drag_time = 0
	get_viewport().set_input_as_handled()
	var was_dragging = is_dragging
	is_dragging = not is_dragging
	DataGlobal.dragging_already = is_dragging
	
	if is_dragging and canvas_layer:
		reparent(canvas_layer)
	
	if was_dragging and not is_dragging:
		# If the user stopped dragging		
		if card_drop:
			can_drag = false
			
			card_drop.add_card(card)
			emit_signal("discarded", index)
			queue_free()
			
		else:
			if hand_display:
				reparent(hand_display)
			


func _on_area_2d_area_entered(area: Area2D) -> void:
	card_drop = area


func _on_area_2d_area_exited(area: Area2D) -> void:
	card_drop = null
