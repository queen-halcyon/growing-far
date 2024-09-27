extends Node2D

var current_turn = 1
const FINAL_TURN := 7

@export var default_activity : Activity
@export var activity_slides : Node

@export var defiant_endings : Array[Ending]
@export var helpful_endings : Array[Ending]
@export var spirited_endings : Array[Ending]
@export var cunning_endings : Array[Ending]

var schedule = []

var current_state = GameState.PLAYING_TURN

enum GameState {
	PLAYING_TURN,
	AWAITING_SLIDE,
	ANIMATING_SLIDE,
	SHOWING_SLIDE
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	# This node doesn't need to be doing anything every frame
	
	Events.connect("end_turn", on_turn_ended)
	Events.connect("next_slide", play_chosen_schedule)


# Called when the user clicks "end turn"
func on_turn_ended():
	if current_state != GameState.PLAYING_TURN: 
		return
	
	current_state = GameState.AWAITING_SLIDE
	current_turn += 1
	
	# Generate schedule
	var bubbles = get_tree().get_nodes_in_group("activity_bubble")
	schedule.clear()
	
	for bubble in bubbles:
		if bubble.activity:
			schedule.append(bubble.activity)
		else:
			schedule.append(default_activity)
	
	play_chosen_schedule()


func finish_turn():
	current_state = GameState.PLAYING_TURN
	
	if current_turn >= FINAL_TURN:
		var ending = determine_ending(determine_ending_category())
		DataGlobal.ending = ending
		
		get_tree().change_scene_to_file("res://ending_screen.tscn")
	else:
		Events.emit_signal("start_turn", current_turn)


func play_chosen_schedule():
	# We're actually just going to treat the schedule as the queue
	if current_state == GameState.SHOWING_SLIDE:
		DataGlobal.defiant += schedule[0].defiant
		DataGlobal.helpful += schedule[0].helpful
		DataGlobal.spirited += schedule[0].spirited
		DataGlobal.cunning += schedule[0].cunning
		
		if DataGlobal.defiant < 0:
			DataGlobal.defiant = 0
		
		if DataGlobal.helpful < 0:
			DataGlobal.helpful = 0
		
		if DataGlobal.spirited < 0:
			DataGlobal.spirited = 0
		
		if DataGlobal.cunning < 0:
			DataGlobal.cunning = 0
		
		schedule.pop_front()
		
		current_state = GameState.AWAITING_SLIDE
	
	
	
	if schedule.is_empty():
		finish_turn()
		return
	
	play_slide(schedule[0])


func play_slide(activity: Activity):
	current_state = GameState.SHOWING_SLIDE
	activity_slides.display_activity(activity)


# Given a list of possible endings, this function finds the endings that
# the user is eligible for. The ending with the highest requirements
# is given priority.
func determine_ending(ending_list: Array[Ending]):
	var chosen_ending
	var ending_sum = -1
	
	for ending in ending_list:
		if DataGlobal.defiant >= ending.min_defiant and DataGlobal.helpful >= ending.min_helpful and DataGlobal.spirited >= ending.min_spirited and DataGlobal.cunning >= ending.min_cunning:
			var this_ending_sum = ending.min_defiant + ending.min_helpful + ending.min_spirited + ending.min_cunning
			if this_ending_sum > ending_sum:
				chosen_ending = ending
				ending_sum = this_ending_sum
	
	
	return chosen_ending


# Endings are divided into 4 categories, based on which of the 4 stats is highest
# So this function determines the highest stat, and then returns the appropriate category
func determine_ending_category():
	var highest_int = DataGlobal.defiant
	var highest_stat = "defiant"
	
	if DataGlobal.helpful > highest_int:
		highest_int = DataGlobal.helpful
		highest_stat = "helpful"
	
	if DataGlobal.spirited > highest_int:
		highest_int = DataGlobal.spirited
		highest_stat = "spirited"
	
	if DataGlobal.cunning > highest_int:
		highest_int = DataGlobal.cunning
		highest_stat = "cunning"
	
	
	if highest_stat == "cunning":
		return cunning_endings
	elif highest_stat == "helpful":
		return helpful_endings
	elif highest_stat == "spirited":
		return spirited_endings
	else:
		return defiant_endings
