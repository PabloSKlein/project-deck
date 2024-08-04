class_name CardType extends Node

enum Enum {HELMET, BODY, GLOVES, BOOTS, BELT, MAIN_HAND, OFF_HAND, AMULET, RING, POTION}

const card_types = {
	Enum.HELMET: "Helmet",
	Enum.BODY: "Body",
	Enum.GLOVES: "Gloves",
	Enum.BOOTS: "Boots",
	Enum.BELT: "Belt",
	Enum.MAIN_HAND: "MainHand",
	Enum.OFF_HAND: "OffHand",
	Enum.AMULET: "Amulet",
	Enum.RING: "Ring",
	Enum.POTION: "Potion"
}

static func get_type_by_description(description: String) -> Enum:
	for key in card_types.keys():
		if card_types[key] == description:
			return key
	return Enum.HELMET	

static func get_type_description(type: Enum) -> String:
	if type in card_types:
		return card_types[type]
	else:
		return "Unknown Item"
