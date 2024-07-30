class_name Card

extends Node

enum CardType {HELMET, BODY, GLOVES, BOOTS, BELT, WEAPON, POTION}
enum CardRarity {BASIC, MAGIC, RARE, UNIQUE}

@export var nameItem: String
@export var type: CardType
@export var rarity: CardRarity
@export var prefixes: Array[Prefix] = []  # Assuming Prefix is a defined class
@export var suffixes: Array[Suffix] = []  # Assuming Suffix is a defined class
@export var modifiers: Array[Modifier] = []  # Assuming Modifier is a defined class

func _ready():
	pass

func _process(delta):
	pass

func _init() -> void:
	pass

func get_type_name() -> String:
	match type:
		CardType.HELMET:
			return "Helmet"
		CardType.BODY:
			return "Body Armor"
		CardType.GLOVES:
			return "Gloves"
		CardType.BOOTS:
			return "Boots"
		CardType.BELT:
			return "Belt"
		CardType.WEAPON:
			return "Weapon"
		CardType.POTION:
			return "Potion"
		_:
			return "Unknown Item"
			
func get_rarity_name() -> String:
	match rarity:
		CardRarity.BASIC:
			return "Basic"
		CardRarity.MAGIC:
			return "Magic"
		CardRarity.RARE:
			return "Rare"
		CardRarity.UNIQUE:
			return "Unique"
		_:
			return "Unknown Rarity"

# Method to get detailed information about the card
func get_card_details() -> String:
	var details = "Card Name: " + nameItem + "\n"
	details += "Type: " + get_type_name() + "\n"
	details += "Rarity: " + get_rarity_name() + "\n"
	
	details += "Prefixes:\n"
	for prefix in prefixes:
		details += "- " + str(prefix.getId()) + " (Tier: " + str(prefix.tier) + ")\n"  # Assuming Prefix has getId() and tier properties

	details += "Suffixes:\n"
	for suffix in suffixes:
		details += "- " + str(suffix.getId()) + " (Tier: " + str(suffix.tier) + ")\n"  # Assuming Suffix has getId() and tier properties
	
	#details += "Modifiers:\n"
	#for modifier in modifiers:
		#details += "- " + str(modifier.getId()) + ": " + str(modifier.bonus) + "\n"  # Assuming Modifier has getId() and bonus properties
	
	return details
