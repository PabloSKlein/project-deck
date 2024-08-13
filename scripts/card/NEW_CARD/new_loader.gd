extends Node
const ITEM_PATHS = [
	"res://Scripts/card/NEW_CARD/card_base/new_mace.gd"
]

const AFFIX_PATHS = [
	"res://Scripts/card/NEW_CARD/affix/prefix/new_cold_damage.gd",
	"res://Scripts/card/NEW_CARD/affix/prefix/new_fire_damage.gd",
	"res://Scripts/card/NEW_CARD/affix/suffix/new_bleed_damage.gd"
]

var items: Dictionary = {}
var affixes: Dictionary = {}

func _ready():
	load_all_affix()
	load_all_items()

func load_all_affix():
	for path in AFFIX_PATHS:
		var resource = load(path)
		if resource:
			var affix = resource.new() # Create an instance of the resource
			if affix:
				items[path] = affix
				print("Loaded affix: ", affix.name)
			else:
				print("Failed to create affix instance at path: ", path)
		else:
			print("Failed to load affix at path: ", path)

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
	
# Retrieve an item by its path
func get_affix(path: String) -> Resource:
	return affixes.get(path, null)
