class_name NewCardGen
extends Node

func _ready():
	pass

func get_random_item_from_folder(folder_path: String) -> NewCard:
	var dir = DirAccess.open(folder_path)
	if dir == null:
		print("Failed to open folder: ", folder_path)
		return null
	
	var item_paths = []
	dir.list_dir_begin()
	
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".gd"):
			item_paths.append(folder_path + "/" + file_name)
		file_name = dir.get_next()

	dir.list_dir_end()

	if item_paths.size() == 0:
		print("No item scripts found in folder: ", folder_path)
		return null

	var random_index = randi() % item_paths.size()
	var random_item_script = load(item_paths[random_index])
	
	if random_item_script == null:
		print("Failed to load script: ", item_paths[random_index])
		return null

	var random_item = random_item_script.new()
	return random_item
