extends HBoxContainer

var card_deck : CardDeck
var card_display = preload("res://assets/ui/card.tscn")

var my_canvas_layer = get_parent()


func initialize():
	for i in get_children():
		i.queue_free()
	
	
	var hand_size = card_deck.hand.size() - 1
	
	for i in range(hand_size):
		add_card_to_hand(card_deck.hand[i], i)
	
	card_deck.connect("draw_card_to_hand", add_card_to_hand)


func play_card(i):
	card_deck.discard(i)


func add_card_to_hand(card, i):
	var new_card_display = card_display.instantiate()
	new_card_display.canvas_layer = my_canvas_layer
	new_card_display.hand_display = self
	
	new_card_display.card = card
	new_card_display.index = i
	
	new_card_display.display_symbols()
	new_card_display.connect("discarded", play_card)
	
	add_child(new_card_display)
