extends Node

var card_deck : CardDeck



func take_turn():
	print("player turn")
	Events.emit_signal("player_dialog_turn_started")
