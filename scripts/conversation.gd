extends Area2D
class_name Conversation

var cards_played : Array[Symbol]
@export var scene : DialogScene

var successes = 0
var fails = 0

var conversation_is_over = false

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


func add_card(card: Symbol):
	cards_played.append(card)
	Events.emit_signal("card_added", card)
	
	var size = cards_played.size() - 1
	
	if size > 0:
		var failed = is_discordant(cards_played[size - 1], cards_played[size])
		
		if failed: fails += 1
		else: successes += 1
		
		if scene:
			var should_end_conversation = scene.is_dialog_over(successes, fails)
			if should_end_conversation:
				Events.emit_signal("conversation_over")
	
	Events.emit_signal("card_played")


func is_discordant(card1: Symbol, card2: Symbol):
	if card1.right_symbol != card2.left_symbol:
		return true
	
	return false


func get_top_card():
	return cards_played.back()


func _on_npc_turn_start():
	#monitorable = false
	#monitoring = false
	pass


func _on_player_turn_start():
	#monitorable = true
	#monitoring = true
	pass
