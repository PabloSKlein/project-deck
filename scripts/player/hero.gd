class_name Hero extends Node

@export var max_health: int = 0
@export var health: int = 0
	
var attributes: Dictionary
var slots: Array[InventorySlot] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _init(_max_health: int, _slots: Array[InventorySlot]) -> void:
	max_health = _max_health
	health = _max_health
	slots = _slots
	
func equip(card: Card, target_slot: int):
	if slots[target_slot].slot_type == card.type:
		slots[target_slot].card = card
		for attribute in card.modifiers:
			add_attribute(attribute)
		return true
	return false
	
func add_attribute(modifier: Modifier):
	if modifier.type in attributes:
		attributes[modifier.type] += modifier.amount
	else:
		attributes[modifier.type] = modifier.amount
	pass

func show_status():
	print("Hero Status:")
	print("health:" + str(health))
	
	for attribute in attributes:
		print(attribute + " : " + str(snapped(attributes[attribute], 0.01)))
	for slot in slots:
		var name = "Empty" if slot.card == null else slot.card.name_item 
		print("type: " + str(slot.slot_type) + " / card: " + name)
	pass
