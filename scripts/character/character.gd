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

func take_damage(attack: Attack):
	var defense = get_defense(attack.type)
	health -= max(attack.amount - defense, 0)

func get_defense(type: String):
	return attributes.get(type + " Defense", 0)
	
func get_attack() -> Attack:
	var weapon_card
	for slot in inventory.slots:
		if slot.slot_type == CardType.Enum.MAIN_HAND:
			if slot.is_empty:
				return Attack.new(0, "Physical") 
			weapon_card = slot.card
			break
	#TODO set this for the weapon attack type
	var damage_type = "Physical"	
	for attribute in attributes.keys():
		if attribute == damage_type + " Damage":
			return Attack.new(attributes.get(attribute), damage_type)
			
	return Attack.new(0, damage_type)

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

func equip(card: NewCard):
	inventory.equip(card)
	update_attributes()

func update_attributes():
	attributes.clear()
	for slot in inventory.slots:
		if(slot.is_empty):
			continue
		for modifier in slot.card.modifiers:
			add_attribute(modifier)
