extends Node

var active_char


func initialize():
	active_char = get_child(0)
	
	for child in get_children():
		if "card_deck" in active_char:
			active_char.card_deck.ready_first_turn()


func hand_turn_over():
	if DataGlobal.current_conversation.conversation_is_over:
		for child in get_children():
			if "card_deck" in active_char:
				active_char.card_deck.end_conversation()
		
		return
	
	await Events.card_played
	
	
	var next_active_char_index = (active_char.get_index() + 1) % get_child_count()
	active_char = get_child(next_active_char_index)
	
	
	if "card_deck" in active_char:
		active_char.card_deck.draw_cards(1)
	
	if active_char.has_method("take_turn"):
		active_char.take_turn()
	
