extends Node

class_name GenerateCard

func _ready():
	pass

func generate_card_test() -> Card:
	var card = Card.new()
	var base = generate_card_base()
	var rarity = generate_card_rarity(base, card)
	var final_card = resolve_card_attributes(base, rarity)
	card.nameItem = final_card["card_name"]
	card.typeNew = final_card["card_category"]
	card.rarityNew = rarity
	return card

func generate_card_base():
	var keys = CardData.card_data.keys()
	randomize()
	var random_index = randi() % keys.size()
	var random_key = keys[random_index]
	var base_card = CardData.card_data[random_key]
	return base_card
	
func resolve_card_attributes(base_card, rarity):
	var final_card_data = {}
	for key in base_card:
		var value = base_card[key]
		if value == null:
			continue
		if key.ends_with("_min"):
			var attribute_base = key.substr(0, key.length() - 4)
			var max_key = attribute_base + "_max"
			if max_key in base_card:
				var min_value = int(base_card[key])
				var max_value = int(base_card[max_key])
				final_card_data[attribute_base] = randi_range(min_value, max_value)
			else:
				continue
		elif not key.ends_with("_max"):
			final_card_data[key] = value
	var resolvcard = rarity_calculation(final_card_data, rarity)
	print(resolvcard)
	return final_card_data

func generate_card_rarity(base, card: Card):
	var rarity_roll = randi() % 100 + 1
	var drop_rate = card.drop_rates
	var cumulative = 0
	for rarity in drop_rate.keys():
		cumulative += drop_rate[rarity]
		if rarity_roll <= cumulative:
			return rarity

func rarity_calculation(card_data, rarity):
	var multiplier = 1.0
	var result = {}
	match rarity:
		1 :
			multiplier = card_data.get("card_magic_multi")
		2 :
			multiplier = card_data.get("card_rare_multi")
		3 :
			multiplier = card_data.get("card_unique_multi")
	for key in card_data.keys():
		if key.ends_with("_status") and typeof(card_data[key]):
			result[key] = card_data[key] * multiplier
		else:
			result[key] = card_data[key]
	return result
