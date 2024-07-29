extends Node

# Import the item scripts
const HoodItem = preload("res://Scripts/Cards/Cloth_Hood.gd")
const CircletItem = preload("res://Scripts/Cards/Cooper_Circlet.gd")

# Define lists of prefixes and suffixes
var prefixes = ["Strong", "Mystic", "Ethereal", "Warrior's"]
var suffixes = ["of Protection", "of Agility", "of the Owl", "of Fortitude"]

# List of item classes to choose from
var item_classes = [HoodItem, CircletItem]

func _ready():
	var random_item = generate_random_item()
	print("Generated item: ", random_item.name)

func generate_random_item():
	# Randomly select an item class
	var item_class = item_classes[randi() % item_classes.size()]
	var item = item_class.new()
	
	# Randomly select a prefix and a suffix
	var prefix = prefixes[randi() % prefixes.size()]
	var suffix = suffixes[randi() % suffixes.size()]
	
	# Combine to form the final item name
	item.name = prefix + " " + item.name + " " + suffix
	print(item)
	return item
