extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("card_played", _on_card_played)


func _on_card_played():
	var successes_needed = DataGlobal.current_conversation.scene.successes_needed
	var fails_needed = DataGlobal.current_conversation.scene.fails_needed
	
	$Successes/Label.text = str(DataGlobal.current_conversation.successes) + "/" + str(successes_needed) + " successes"
	$Fails/Label.text = str(DataGlobal.current_conversation.fails) + "/" + str(fails_needed) + " fails"
