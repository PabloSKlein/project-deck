extends Node

class_name Autoloader

# Dictionary to hold items
var items: Dictionary = {}
# Dictionary to hold affixes
var prefix_data: Dictionary = {}
var suffix_data: Dictionary = {}

func _ready():
	load_all_items()
	load_all_affixes()

func load_all_items():
	var item_paths = [
		"res://Scripts/card/NEW_CARD/card_base/new_mace.gd",
	]
	for path in item_paths:
		var resource = load(path)
		if resource:
			items[path] = resource
			print("Loaded item: ", path)
		else:
			print("Failed to load item at path: ", path)

func load_all_affixes():
	# Example paths; adjust to match your actual paths
	var prefix_paths = [
		"res://scripts/card/NEW_CARD/affix/prefix/new_cold_damage.gd",
	]
	var suffix_paths = [
		"res://Scripts/card/NEW_CARD/affix/suffix/new_bleed_damage.gd",
	]

	for path in prefix_paths:
		var resource = load(path)
		if resource:
			prefix_data[path] = resource
			print("Loaded prefix affix: ", path)
		else:
			print("Failed to load prefix affix at path: ", path)

	for path in suffix_paths:
		var resource = load(path)
		if resource:
			suffix_data[path] = resource
			print("Loaded suffix affix: ", path)
		else:
			print("Failed to load suffix affix at path: ", path)
