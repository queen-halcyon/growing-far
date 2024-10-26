extends Node


var card_deck : CardDeck
var conversation


func init(deck):
	card_deck = deck
	conversation = DataGlobal.current_conversation
	
	card_deck.ready_first_turn()


func take_turn():
	Events.emit_signal("npc_dialog_turn_started")
	
	await get_tree().create_timer(1.5).timeout
	
	var top_card = conversation.get_top_card()
	var good_cards = []
	
	var chosen_card = DataGlobal.rng.randi_range(0, card_deck.hand.size() - 1)
	
	if top_card:
		for i in range(card_deck.hand.size() - 1):
			var discordant = conversation.is_discordant(top_card, card_deck.hand[i])
			
			if not discordant:
				good_cards.append(i)
	
	
	if good_cards.size() > 1:
		chosen_card = DataGlobal.rng.randi_range(0, good_cards.size() - 1)
	
	
	var card = card_deck.hand[chosen_card]
	card_deck.discard(chosen_card)
	conversation.add_card(card)
