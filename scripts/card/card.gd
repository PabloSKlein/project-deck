class_name Card extends Node
# TODO REMOVER ESSE
enum CardRarity {BASIC, MAGIC, RARE, EXALTED, UNIQUE}

@export var name_item: String
@export var category: String
@export var type: String
@export var image: String
@export var slot_types: Array[CardType.Enum]
@export var rarity: CardRarity
@export var modifiers: Array[Modifier] = []
@export var drop_rates = {
	CardRarity.MAGIC: 60, # % of droprate
	CardRarity.RARE: 29, # % of droprate
	CardRarity.EXALTED: 10 # % of droprate
}

func get_card_details() -> String:
	var details = "Card Name: " + name_item + "\n"
	details += "Type: " + str(type) + "\n"
	details += "Rarity: " + str(rarity) + "\n"
	details += "Modifiers:\n"
	for modifier in modifiers:
		details += "- " + str(modifier.type) + ": " + str(modifier.amount) + "\n"
	return details
