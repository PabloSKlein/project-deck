extends Node

class_name GenerateCard

func _ready():
	pass

func generate_card() -> Card:
	var card = Card.new()
	var base = generate_card_base()
	var rarity = generate_card_rarity(base, card)
	var final_card = resolve_card_attributes(base, rarity)
	print(final_card)
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
	var affixes = generate_affixes(final_card_data, rarity)
	var full_card = merge_card_with_affixes(final_card_data, affixes)
	var final_card = rarity_calculation(full_card, rarity)
	return final_card

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

func generate_affixes(final_card_data, rarity):
	var affix_data = {}
	var max_affixes = get_max_affixes_based_on_rarity(rarity)
	var num_prefixes = randi() % (max_affixes + 1)
	var num_suffixes = max_affixes - num_prefixes
	var valid_prefixes = get_valid_affixes(PrefixData.prefix_data, final_card_data["card_category"], "prefix")
	var valid_suffixes = get_valid_affixes(SuffixData.suffix_data, final_card_data["card_category"], "suffix")
	randomize()
	valid_prefixes.shuffle()
	valid_suffixes.shuffle()
	var used_affix_names = {}
	# Add unique prefixes
	for i in range(min(num_prefixes, valid_prefixes.size())):
		var prefix = valid_prefixes[i]
		if not prefix["name"] in used_affix_names:
			affix_data[prefix["name"]] = {
				"description": prefix["description"],
				"value_status": pick_random_value(prefix["tiers"], rarity),
				"increased": prefix["increased"]
			}
			used_affix_names[prefix["name"]] = true
	
	# Add unique suffixes
	for i in range(min(num_suffixes, valid_suffixes.size())):
		var suffix = valid_suffixes[i]
		if not suffix["name"] in used_affix_names:
			affix_data[suffix["name"]] = {
				"description": suffix["description"],
				"value_status": pick_random_value(suffix["tiers"], rarity),
				"increased": suffix["increased"]
			}
			used_affix_names[suffix["name"]] = true
	return affix_data

func get_max_affixes_based_on_rarity(rarity):
	match rarity:
		1:
			return 2
		2:
			return 4
		3:
			return 6
	return 0

func get_valid_affixes(affix_json, item_category, affix_type):
	var valid_affixes = []
	var affix_data = affix_json[affix_type]  # Access the affix type ('prefix' or 'suffix')
	if affix_data:
		for key in affix_data.keys():
			var affix = affix_data[key]
			if item_category in affix["item_capacity"]:
				for name in affix["names"]:
					valid_affixes.append({
						"name": name,
						"description": affix["description"],
						"tiers": affix["tiers"],
						"increased": affix["increased"]
					})
		return valid_affixes
	return []

func pick_random_name(names):
	var random_index = randi() % names.size()
	return names[random_index]

func get_tier_value(tiers, rarity, value_type):
	var tier = str(rarity)
	if tier in tiers:
		return tiers[tier][value_type]
	return 0

func pick_random_value(tiers, rarity):
	var tier = str(rarity)
	if tier in tiers:
		var min_value = tiers[tier]["min"]
		var max_value = tiers[tier]["max"]
		return randi_range(min_value, max_value)
	return 0

func merge_card_with_affixes(final_card, affixes):
	var merged_card = final_card.duplicate()
	merged_card["affixes"] = affixes
	print(merged_card)
	return merged_card
