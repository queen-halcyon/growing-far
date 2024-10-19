extends HBoxContainer

var uninteractive_card_display = preload("res://assets/ui/uninteractive_card.tscn")

func _ready() -> void:
	Events.connect("card_added", on_card_added)

func on_card_added(card):
	var new_card_display = uninteractive_card_display.instantiate()
	
	new_card_display.card = card
	new_card_display.display_symbols()
	
	add_child(new_card_display)
