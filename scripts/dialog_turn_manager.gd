extends Node

var active_char
var turn_announcer
var anim_player : AnimationPlayer

func _ready() -> void:
	Events.connect("card_played", _on_card_played)


func initialize():
	active_char = get_child(0)
	anim_player = turn_announcer.get_node("AnimationPlayer")
	
	for child in get_children():
		if "card_deck" in active_char:
			active_char.card_deck.ready_first_turn()
	
	turn_start()


func _on_card_played():
	if turn_end():
		turn_start()
		give_turn()



func turn_start():
	if "card_deck" in active_char:
		active_char.card_deck.draw_cards(1)
	
	if turn_announcer:
		anim_player.play("announce")



func turn_end():
	# Check if the conversation is over
	if DataGlobal.current_conversation.conversation_is_over:
		for child in get_children():
			if "card_deck" in child:
				child.card_deck.end_conversation()
		
		return false
	
	# Set up the turn for the next player
	var next_active_char_index = (active_char.get_index() + 1) % get_child_count()
	active_char = get_child(next_active_char_index)
	
	return true


func give_turn():
	if active_char.has_method("take_turn"):
		active_char.take_turn()
