extends Node

var defiant = 0
var spirited = 0
var helpful = 0
var cunning = 0
var stress = 0

var player_name = "PlayerName"
var player_pronoun_set = 2
var current_turn = 1

var save_id := "0"
var is_new_game = true

var rng = RandomNumberGenerator.new()


var ending : Ending

# Going to use these for RegEx later!
var pronoun_set = [
	["he", "him", "his", "his"],
	["she", "her", "her", "hers"],
	["they", "them", "their", "theirs"]
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)

func reset():
	defiant = 0
	spirited = 0
	helpful = 0
	cunning = 0
	stress = 0
	
	current_turn = 1
	player_pronoun_set = 2
	player_name = ""



func save_game():
	var version := 3.0
	var save_file_path = "user://saves/savegame_" + save_id + ".json"
	var save_file = FileAccess.open(save_file_path, FileAccess.WRITE)
	
	var data = {
		"version": version,
		"save_id": save_id,
		"character_data": {
			"player_name": player_name,
			"player_pronoun_set": player_pronoun_set,
			"defiant": defiant,
			"spirited": spirited,
			"helpful": helpful,
			"cunning": cunning
		},
		"game_data": {
			"current_turn": current_turn
		}
	}
	
	
	var json_string = JSON.stringify(data)
	save_file.store_string(json_string)
	save_file.close()


func load_game():
	var save_file_path = "user://saves/savegame_" + save_id + ".json"
	
	var save_file = FileAccess.open(save_file_path, FileAccess.READ)
	
	if not save_file:
		return
	
	var json_string = save_file.get_as_text()
	var data = JSON.parse_string(json_string)
	
	defiant = data["character_data"]["defiant"]
	helpful = data["character_data"]["helpful"]
	spirited = data["character_data"]["spirited"]
	cunning = data["character_data"]["cunning"]
	player_pronoun_set = data["character_data"]["player_pronoun_set"]
	player_name = data["character_data"]["player_name"]
	
	current_turn = data["game_data"]["current_turn"]
	
	save_file.close()
	
	Events.emit_signal("start_turn", current_turn)
