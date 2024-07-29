class_name Hero

extends Node

var card = preload("res://Scripts/Card.gd")

class Slot:
	var card: Card
	var slotType: Card.CardType


@export var maxHealth: int = 0

var slots: Array[Slot] = []

@export var health: int = 0
@export var damage: int = 0
@export var defense: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func createHero(maxHealth: int, damage:int, defense:int, slots: Array[Slot]) -> void:
	health = maxHealth
	damage = damage
	defense = defense
	slots = slots
	# Add logic to initialize the card with the given type
	
func equip(card: Card, targetSlot: int):
	# Example of using the equip function
	if(slots[targetSlot].slotType == card.type):
		slots[targetSlot].card = card
		return true
	return false

func listStatus():
	print("base:")
	print("healt:" + str(health))
	print("damage:" + str(damage))
	print("defense:" + str(defense))
	
	pass
