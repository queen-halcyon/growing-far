extends VBoxContainer

var save_files = {}
var save_slot_button = preload("res://assets/ui/save_slot_button.tscn")
var delete_save_button = preload("res://assets/ui/delete_save_button.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	
	DataGlobal.save_id = "0"
	DataGlobal.reset()
	
	var save_file_names = get_save_files()
	
	for file in save_file_names:
		add_save_to_dict(file)
	
	for save in save_files:
		create_save_slot(save)
	
	Events.connect("delete_save", delete_save)


func ensure_save_folder():
	var user_directory = DirAccess.open("user://")
	
	if not user_directory.dir_exists("saves"):
		user_directory.make_dir("saves")


func delete_save(save_id: String):
	# First find the slot that it matches
	var the_slot = get_node(save_id)
	
	# Delete it
	if the_slot:
		the_slot.queue_free()
	
	# Then find the dictionary entry
	if save_files.has(save_id):
		save_files[save_id] = null
	
	ensure_save_folder()
	
	var save_file_path = "user://saves/savegame_" + save_id + ".json"
	DirAccess.remove_absolute(save_file_path)


func get_save_files():
	ensure_save_folder()
	
	var directory = DirAccess.open("user://saves")
	var directory_files = directory.get_files()
	
	var saves = []
	
	for file_name in directory_files:
		if file_name.ends_with(".json"):
			saves.append(file_name)
	
	
	return saves


func add_save_to_dict(filename):
	var save_file_path = "user://saves/" + filename
	#var save_file_path = "user://saves/savegame_" + save_id + ".json"
	var save_file = FileAccess.open(save_file_path, FileAccess.READ)
	
	var json_string = save_file.get_as_text()
	var data = JSON.parse_string(json_string)
	
	save_file.close()
	
	if data:
		if not data.has("save_id") or not data.has("character_data"):
			DirAccess.remove_absolute(save_file_path)
		else:
			var file_info = [data["save_id"], data["character_data"]["player_name"]]
			save_files[data["save_id"]] = file_info
	else:
		DirAccess.remove_absolute(save_file_path)


func create_save_slot(save):
	var button = save_slot_button.instantiate()
	var delete_button = delete_save_button.instantiate()
	
	button.text = save_files[save][1] + " - " + save_files[save][0]
	button.init(save_files[save][0])
	delete_button.init(save_files[save][0])
	
	button.name = save_files[save][0]
	
	button.add_child(delete_button)
	
	add_child(button)


func _on_new_file_pressed() -> void:
	DataGlobal.save_id = generate_save_id()
	
	get_tree().change_scene_to_file("res://game_world.tscn")


func generate_save_id():
	var random_num = DataGlobal.rng.randi_range(10000, 99999)
	var stringed_id = str(random_num)
	
	if save_files.has(stringed_id):
		stringed_id = generate_save_id()
	
	return stringed_id
