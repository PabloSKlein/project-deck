extends Resource
class_name NewCard

var drop_rates = {
	1: 60, # Magic
	2: 29, # Rare
	3: 11  # Exalted
}

@export var name: String
@export var category: String
@export var type: String
@export var slot: Array
@export var rarity: int
@export var magic_multi: float = 1.0
@export var rare_multi: float = 1.0
@export var unique_multi: float = 1.0
@export var is_dual_handed: bool = false
@export var image: String
@export var attributes: Array[Resource] = []

func get_card_details() -> String:
	var details = "Card Name: " + name + "\n"
	details += "Category: " + category + "\n"
	details += "Type: " + type + "\n"
	details += "Rarity: " + str(rarity) + "\n"
	details += "Attributes:\n"
	for attribute in attributes:
		if attribute is NewCardAttibute:
			details += "- " + attribute.name + ": " + attribute.description + "\n"
			details += "  Type: " + attribute.type + "\n"
			details += "  Function: " + attribute.function + "\n"
			details += "  Method: " + attribute.method + "\n"
			details += "  Icon: " + attribute.icon + "\n"
			details += "  Min: " + str(attribute.min) + "\n"
			details += "  Max: " + str(attribute.max) + "\n"
	return details

func get_rarity() -> String:
	var roll = randi() % 100
	var cumulative = 0
	for rarity in drop_rates.keys():
		cumulative += drop_rates[rarity]
		if roll < cumulative:
			return str(rarity)
	return "Unknown"

func update_rarity(base_item: Dictionary) -> Dictionary:
	if base_item.has("rarity") and base_item["rarity"] == 0:
		var new_rarity_str = get_rarity()
		var new_rarity = int(new_rarity_str)
		base_item["rarity"] = new_rarity
	if base_item["rarity"] == 0:
		base_item["rarity"] = 1
	return base_item
