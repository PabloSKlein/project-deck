# ItemManager.gd
extends Node

# Path where your item files are located
const ITEM_PATHS = [
	"res://Scripts/card/NEW_CARD/card_base/new_mace.gd"
]

var items: Dictionary = {}

func _ready():
	load_all_items()

func load_all_items():
	for path in ITEM_PATHS:
		var resource = load(path)
		if resource:
			var item = resource.new() # Create an instance of the resource
			if item:
				items[path] = item
				print("Loaded item: ", item.name)
			else:
				print("Failed to create item instance at path: ", path)
		else:
			print("Failed to load item at path: ", path)

# Retrieve an item by its path
func get_item(path: String) -> Resource:
	return items.get(path, null)
