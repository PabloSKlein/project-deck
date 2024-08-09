class_name Character extends Node

var health := 100
var max_health := 100
var character_name := "Test"
var attributes: Dictionary = {}
var inventory: Inventory

func set_fields(_character_name: String, _max_health: int) -> void:
	character_name = _character_name
	max_health = _max_health
	health = _max_health
	inventory = Inventory.new()

func take_damage(value):
	health -= value

func heal(value):
	health += value
	
func get_attribute(value: String) -> float:
	var attribute = attributes.get(value, 0.0)
	return attribute
	
func is_dead() -> bool:
	return health <= 0

func show_status():
	print(character_name + " Status:")
	print("health: " + str(health))
	
	for attribute in attributes:
		print(attribute + " : " + str(snapped(attributes[attribute], 0.01)))

func add_attribute(modifier: Modifier):
	if modifier.type in attributes:
		attributes[modifier.type] += modifier.amount
	else:
		attributes[modifier.type] = modifier.amount

func equip(card: Card):
	inventory.equip(card)
	update_attributes()

func update_attributes():
	for slot in inventory.slots:
		if(slot.is_empty):
			continue
		for modifier in slot.card.modifiers:
			add_attribute(modifier)
