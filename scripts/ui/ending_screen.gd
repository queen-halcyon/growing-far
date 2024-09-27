extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	
	if DataGlobal.ending:
		var title_label = $Title
		var description_label = $Description
		
		title_label.text = DataGlobal.ending.title
		description_label.text = DataGlobal.ending.message
