class_name Character extends Node

var health := 100
var max_health := 100
var character_name := "Test"
var attributes: Dictionary
var inventory: Inventory

func _ready():
	inventory = inventory.new()
	pass # Replace with function body.
	
func take_damage(value):
	health -= value
	pass

func heal(value):
	health += value
	pass
	
func get_attribute(value : String) -> float:
	var attribute = attributes.get(value, 0.0)
	return attribute
	
func is_dead() -> bool:
	return health <= 0

func show_status():
	print(character_name + " Status:")
	print("health:" + str(health))
	
	for attribute in attributes:
		print(attribute + " : " + str(snapped(attributes[attribute], 0.01)))
	inventory.show_inventory()
	pass

func equip(card: Card):
	inventory.equip(card)
	for attribute in card.modifiers:
		add_attribute(attribute)
	
func add_attribute(modifier: Modifier):
	if modifier.type in attributes:
		attributes[modifier.type] += modifier.amount
	else:
		attributes[modifier.type] = modifier.amount
	pass
