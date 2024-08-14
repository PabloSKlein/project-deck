class_name CardGenerator
extends Node

func _ready():
	pass

func get_random_card_from_folder(folder_path: String) -> Card:
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

func new_generate_base_card(resource: Resource) -> Dictionary:
	var result = {}
	if resource == null:
		result["error"] = "Resource is null."
		return result

	var desired_properties = [
		"name", "category", "type", "slot", "rarity", "magic_multi", "rare_multi", "unique_multi", "is_dual_handed", "image", "attributes", 
		"kind", "function", "description", "method", "icon", "min", "max"]
	var property_list = resource.get_property_list()
	for property_info in property_list:
		var property_name = property_info.name
		if desired_properties.has(property_name):
			var property_value = resource.get(property_name)
			if typeof(property_value) == TYPE_ARRAY:
				var array_result = []
				for item in property_value:
					if item is Resource:
						array_result.append(new_generate_base_card(item))
					else:
						array_result.append(item)
				result[property_name] = array_result
			elif typeof(property_value) == TYPE_DICTIONARY:
				var dict_result = {}
				for key in property_value.keys():
					var dict_value = property_value[key]
					if dict_value is Resource:
						dict_result[key] = new_generate_base_card(dict_value)
					else:
						dict_result[key] = dict_value
				result[property_name] = dict_result
			elif property_value is Resource:
				result[property_name] = new_generate_base_card(property_value)
			else:
				result[property_name] = property_value
	
	# Process attributes for min/max value calculation
	if "attributes" in result:
		for attribute in result["attributes"]:
			if attribute.has("min") and attribute.has("max"):
				var min_value = attribute["min"]
				var max_value = attribute["max"]
				var range_value = min_value + randi() % (max_value - min_value + 1)
				var multiplier = 1.0
				
				match result["rarity"]:
					1:  # Magic
						multiplier = result["magic_multi"]
					2:  # Rare
						multiplier = result["rare_multi"]
					3:  # Unique
						multiplier = result["unique_multi"]
					_:
						multiplier = 1.0  # Default multiplier for other rarities
				
				attribute["value"] = range_value * multiplier
				attribute.erase("min")
				attribute.erase("max")
	
	return result

func attach_affixes_to_card(card_dict: Dictionary) -> Dictionary:
	var rarity = card_dict.get("rarity", 0)
	var prefix_folder = "res://scripts/card/affix/prefix"
	var suffix_folder = "res://scripts/card/affix/suffix"
	
	var prefixes = get_items_from_folder(prefix_folder)
	var suffix = get_items_from_folder(suffix_folder)
	
	if prefixes.size() == 0 or suffix.size() == 0:
		print("No prefixes or affixes found.")
		return card_dict
	
	var num_affixes = 0
	match rarity:
		1:  # Magic
			num_affixes = randi() % 2 + 1  # Random between 1 and 2
		2:  # Rare
			num_affixes = randi() % 2 + 3  # Random between 3 and 4
		3:  # Unique
			num_affixes = randi() % 2 + 3  # Random between 3 and 4 (if you need more customization, adjust this)
	
	var random_prefixes = []
	var random_suffix = []

	if prefixes.size() > 0:
		for i in range(randi() % 2 + 1):  # Randomly select 1 or 2 prefixes
			random_prefixes.append(get_resource_info(prefixes[randi() % prefixes.size()]))
	
	if suffix.size() > 0:
		for i in range(num_affixes):  # Randomly select the calculated number of affixes
			random_suffix.append(get_resource_info(suffix[randi() % suffix.size()]))
	
	# Attach prefixes and affixes to the card dictionary
	card_dict["prefixes"] = random_prefixes
	card_dict["suffixes"] = random_suffix
	
	return card_dict

func get_items_from_folder(folder_path: String) -> Array:
	var dir = DirAccess.open(folder_path)
	if dir == null:
		print("Failed to open folder: ", folder_path)
		return []
	
	var item_paths = []
	dir.list_dir_begin()
	
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".gd"):
			item_paths.append(folder_path + "/" + file_name)
		file_name = dir.get_next()

	dir.list_dir_end()
	
	var items = []
	for path in item_paths:
		var script = load(path)
		if script:
			items.append(script.new())
	
	return items

func get_resource_info(resource: Resource) -> Dictionary:
	var info = {}
	if resource == null:
		return info

	var desired_properties = [
		"name", "type", "function", "description", "kind", "tiers"
	]

	var properties = resource.get_property_list()
	for prop in properties:
		var name = prop.name
		if name in desired_properties:
			var value = resource.get(name)

			if name == "tiers":
				if typeof(value) == TYPE_DICTIONARY:
					var tiers_info = {}
					for key in value.keys():
						var tier = value[key]
						if tier:
							var min_value = tier.min
							var max_value = tier.max

							var tier_info = {
								"min": min_value,
								"max": max_value
							}
							tiers_info[key] = tier_info
					info[name] = tiers_info
				else:
					info[name] = "Invalid format for tiers"
			else:
				info[name] = value

	return info

func get_random_value(min: int, max: int) -> int:
	return randi() % (max - min + 1) + min

func select_random_tier_value(tiers: Dictionary) -> Dictionary:
	var tier_keys = tiers.keys()
	if tier_keys.size() == 0:
		return {}  # Return empty dictionary if no tiers are present

	var random_key = tier_keys[randi() % tier_keys.size()]
	var selected_tier = tiers[random_key]
	
	if selected_tier is Dictionary:
		var min_value = selected_tier.get("min", 0)
		var max_value = selected_tier.get("max", 0)
		var tier_value = get_random_value(min_value, max_value)
		return { "tier" + str(random_key): { "value": tier_value } }
	
	return {}

func process_tiers(tiers: Dictionary) -> Dictionary:
	var processed_tiers = select_random_tier_value(tiers)
	return processed_tiers

func process_card_data(card_data: Dictionary) -> Dictionary:
	if card_data.has("prefixes"):
		for i in range(card_data["prefixes"].size()):
			var prefix = card_data["prefixes"][i]
			if prefix.has("tiers"):
				prefix["tiers"] = process_tiers(prefix["tiers"])

	if card_data.has("suffixes"):
		for i in range(card_data["suffixes"].size()):
			var suffix = card_data["suffixes"][i]
			if suffix.has("tiers"):
				suffix["tiers"] = process_tiers(suffix["tiers"])

	return card_data
