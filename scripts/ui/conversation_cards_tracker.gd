extends HBoxContainer

var uninteractive_card_display = preload("res://assets/ui/uninteractive_card.tscn")


func on_card_added(card):
	var new_card_display = uninteractive_card_display.instantiate()
	
	new_card_display.card = card
	new_card_display.display_symbols()
