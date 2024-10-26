extends TextureRect
class_name Conversation

var cards_played : Array[Symbol]
@export var scene : DialogScene

var successes = 0
var fails = 0

var conversation_is_over = false
var player_can_drop_card = true

signal card_added
signal conversation_over
signal card_played


func _ready() -> void:
	Events.connect("npc_dialog_turn_started", _on_npc_turn_start)
	Events.connect("player_dialog_turn_started", _on_player_turn_start)


func reset():
	successes = 0
	fails = 0
	cards_played.clear()
	conversation_is_over = false


func add_card(card: Symbol, index = -1):
	cards_played.append(card)
	Events.emit_signal("card_added", card, index)
	
	var size = cards_played.size() - 1
	
	if size > 0:
		var failed = is_discordant(cards_played[size - 1], cards_played[size])
		
		if failed: fails += 1
		else: successes += 1
		
		if scene:
			var should_end_conversation = scene.is_dialog_over(successes, fails)
			if should_end_conversation:
				conversation_is_over = true
				Events.emit_signal("conversation_over")
	
	Events.emit_signal("card_played")


func is_discordant(card1: Symbol, card2: Symbol):
	if card1.right_symbol != card2.left_symbol:
		return true
	
	return false


func get_top_card():
	return cards_played.back()


func _on_npc_turn_start():
	player_can_drop_card = false


func _on_player_turn_start():
	player_can_drop_card = true


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if not player_can_drop_card: return false
	
	if data.has("card"):
		return true
	return false


func _drop_data(at_position: Vector2, data: Variant) -> void:
	add_card(data["card"], data["index"])
