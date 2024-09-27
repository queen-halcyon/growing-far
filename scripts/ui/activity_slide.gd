extends MarginContainer

@onready var stat_container = $Panel/MarginContainer/VBoxContainer/VBoxContainer
@onready var activity_name = $Panel/MarginContainer/VBoxContainer/Label
@onready var activity_picture = $Panel/MarginContainer/VBoxContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	self.visible = false
	
	Events.connect("next_slide", hide_activity_slide)

func display_activity(activity : Activity):
	activity_name.text = activity.name
	activity_picture.texture = activity.image
	
	# Delete all previous stat labels
	for child in stat_container.get_children():
		child.queue_free()
	
	self.visible = true
	
	if activity.defiant != 0:
		create_stat_label("Defiant", DataGlobal.defiant, activity.defiant)
	if activity.helpful != 0:
		create_stat_label("Helpful", DataGlobal.helpful, activity.helpful)
	if activity.spirited != 0:
		create_stat_label("Spirited", DataGlobal.spirited, activity.spirited)
	if activity.cunning != 0:
		create_stat_label("Cunning", DataGlobal.cunning, activity.cunning)


func create_stat_label(stat_name, original_stat, stat_change):
	var new_stat = original_stat + stat_change
	var stat_change_text = ""
	
	if stat_change >= 0:
		stat_change_text = "(+" + str(stat_change) + ")"
	else:
		stat_change_text = "(" + str(stat_change) + ")"
	
	var text = str(original_stat) + " " + stat_name + " > " + str(new_stat) + " " + stat_name
	text = text + " " + stat_change_text
	
	var label = Label.new()
	label.text = text
	
	stat_container.add_child(label)


func hide_activity_slide():
	self.visible = false
