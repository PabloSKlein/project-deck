extends Node

class_name CardLoader

var items: Dictionary = {}
var prefix_data: Dictionary = {}
var suffix_data: Dictionary = {}

const item_paths = [
	"res://Scripts/card/NEW_CARD/card_base/new_mace.gd",
	]
	
const prefix_paths = [
	"res://scripts/card/NEW_CARD/affix/prefix/new_cold_damage.gd",
	]

var suffix_paths = [
	"res://Scripts/card/NEW_CARD/affix/suffix/new_bleed_damage.gd",
	]

func _ready():
	load_all_items()
	load_all_affixes()

func load_all_items():
	for path in item_paths:
		var resource = load(path)
		if resource:
			items[path] = resource
			print("Loaded item: ", path)
		else:
			print("Failed to load item at path: ", path)

func load_all_affixes():
	for path in prefix_paths:
		var resource = load(path)
		if resource:
			prefix_data[path] = resource
			print("Loaded prefix: ", path)
		else:
			print("Failed to load prefix at path: ", path)

	for path in suffix_paths:
		var resource = load(path)
		if resource:
			suffix_data[path] = resource
			print("Loaded suffix: ", path)
		else:
			print("Failed to load suffix at path: ", path)
