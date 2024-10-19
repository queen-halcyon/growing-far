extends Resource
class_name CardDeck


@export var draw_pile : Array[Symbol]
var hand : Array[Symbol]
var discard_pile : Array[Symbol]

signal draw_card_to_hand
signal remove_card_from_hand


func ready_first_turn():
	for card in hand:
		draw_pile.append(card)
	
	for card in discard_pile:
		draw_pile.append(card)
	
	hand.clear()
	discard_pile.clear()
	
	draw_pile.shuffle()
	draw_cards(5)


func end_conversation():
	
	for card in hand:
		draw_pile.append(card)
	
	for card in discard_pile:
		draw_pile.append(card)
	
	hand.clear()
	discard_pile.clear()


func shuffle_discard():
	for card in discard_pile:
		draw_pile.append(card)
	
	draw_pile.shuffle()
	
	discard_pile.clear()


func draw_cards(num: int):
	for i in range(num):
		if draw_pile.size() < 1:
			shuffle_discard()
		
		var card = draw_pile.pop_front()
		hand.append(card)
		var new_index = hand.size() - 1
		emit_signal("draw_card_to_hand", card, new_index)


func discard(which: int):
	which = abs(which)
	
	if which > hand.size():
		which = hand.size()
	
	var card = hand.pop_at(which)
	discard_pile.append(card)


func swap_card(to: int, card: Symbol):
	if draw_pile[to]:
		draw_pile[to] = card
