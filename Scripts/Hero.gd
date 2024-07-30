class_name Hero

extends Node

class Slot:
	var card: Card
	var slotType: Card.CardType
	func _init(_slotType : Card.CardType ) -> void:
		slotType = _slotType

@export var maxHealth: int = 0
@export var health: int = 0
	
var attributes: Dictionary
var slots: Array[Slot] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _init(_maxHealth: int, _slots: Array[Slot]) -> void:
	maxHealth = _maxHealth
	health = _maxHealth
	slots = _slots
	
func equip(card: Card, targetSlot: int):
	if(slots[targetSlot].slotType == card.type):
		slots[targetSlot].card = card
		for attribute in card.modifiers:
			addAttribute(attribute)
		return true
	return false
	
func addAttribute(modifier: Modifier):
	if modifier.type in attributes:
		attributes[modifier.type] += modifier.amount
	else:
		attributes[modifier.type] = modifier.amount
	pass

func showStatus():
	print("Hero Status:")
	print("healt:" + str(health))
	
	for attribute in attributes:
		print(attribute + " : " + str(attributes[attribute]))
	for slot in slots:
		var name = "Empty" if slot.card == null else slot.card.nameItem 
		print("type: " + str(slot.slotType) + " / card: " + name)
	pass
