extends Node

class_name GenerateCard

func _ready():
	pass

func generate_card() -> Card:
	var card = Card.new()
	var card_data = generate_card_base()
	var rarity = generate_card_rarity(card_data, card)
	card.modifiers = generate_modifiers(card_data, rarity)
	card.name_item = card_data.get("name")
	card.type = card_data.get("type")
	card.image = card_data.get("item_image")
	card.category = card_data.get("category")
	var slots : Array = card_data.get("equipment_slot")
	for slot in slots:
		card.slot_types.push_back(CardType.get_type_by_description(slot))
	card.rarity = rarity
	return card

func generate_card_base() -> Dictionary:
	var keys = CardData.card_data.keys()
	randomize()
	var random_index = randi() % keys.size()
	var random_key = keys[random_index]
	return CardData.card_data[random_key]
	
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
	
func generate_modifiers(card_map, rarity) -> Array[Modifier]:
	var attributes = card_map["attributes"]
	var modifiers : Array[Modifier]
	for atribute in attributes:
		var type = atribute["description"]
		var icon = atribute["attributeIcon"]
		var min_value = int(atribute["min"])
		var max_value = int(atribute["max"])
		var modifier = Modifier.new(type, icon, randi_range(min_value, max_value))
		modifiers.push_front(modifier)
	var affixes = generate_affixes(card_map, rarity)
	for key in affixes:
		var afix = affixes.get(key)
		var modifier = Modifier.new(afix["description"], afix["affix_icon"], int(afix["value_status"]))
		modifiers.push_front(modifier)
		
	return modifiers
	
func generate_card_rarity(base, card: Card) -> int:
	var rarity_roll = randi() % 100 + 1
	var drop_rate = card.drop_rates
	var cumulative = 0
	for rarity in drop_rate.keys():
		cumulative += drop_rate[rarity]
		if rarity_roll <= cumulative:
			return rarity
	return 0

func rarity_calculation(card_data, rarity):
	var multiplier = 1.0
	var result = {}
	
	# Determine the multiplier based on rarity
	match rarity:
		1:
			multiplier = card_data.get("magic_multi", 1.0)
		2:
			multiplier = card_data.get("rare_multi", 1.0)
		3:
			multiplier = card_data.get("unique_multi", 1.0)
	
	# Process the basic card stats
	for key in card_data.keys():
		if key.ends_with("_status"):
			result[key] = card_data[key] * multiplier
		else:
			result[key] = card_data[key]
	
	# Process affixes
	if "affixes" in card_data:
		result["affixes"] = {}
		for affix_key in card_data["affixes"].keys():
			var affix = card_data["affixes"][affix_key]
			if "value_status" in affix:
				result["affixes"][affix_key] = {
					"description": affix["description"],
					"value_status": affix["value_status"] * multiplier,
					"increased": affix["increased"]
				}
			else:
				result["affixes"][affix_key] = affix
	
	return result

func generate_affixes(card_data: Dictionary, rarity: int) -> Dictionary:
	var affix_data = {}
	var max_affixes = get_max_affixes_based_on_rarity(rarity)
	var num_prefixes = randi() % (max_affixes + 1)
	var num_suffixes = max_affixes - num_prefixes
	var valid_prefixes = get_valid_affixes(PrefixData.prefix_data, card_data["category"], "prefix")
	var valid_suffixes = get_valid_affixes(SuffixData.suffix_data, card_data["category"], "suffix")
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
				"value_status": pick_random_value(prefix["tiers"], rarity),  # Random tier for each prefix
				"increased": prefix["increased"],
				"affix_icon": prefix["affix_icon"]
			}
			used_affix_names[prefix["name"]] = true
	
	# Add unique suffixes
	for i in range(min(num_suffixes, valid_suffixes.size())):
		var suffix = valid_suffixes[i]
		if not suffix["name"] in used_affix_names:
			affix_data[suffix["name"]] = {
				"description": suffix["description"],
				"value_status": pick_random_value(suffix["tiers"], rarity),  # Random tier for each suffix
				"increased": suffix["increased"],
				"affix_icon": suffix["affix_icon"]
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
						"increased": affix["increased"],
						"affix_icon": affix["affix_icon"]
					})
		return valid_affixes
	return []

func pick_random_name(names):
	var random_index = randi() % names.size()
	return names[random_index]

func pick_random_value(tiers: Dictionary, rarity: int) -> int:
	# Randomize tier selection
	randomize()
	var tier_keys = tiers.keys()
	tier_keys.shuffle()  # Shuffle the keys to randomize selection
	var chosen_tier = tier_keys[randi() % tier_keys.size()]  # Randomly pick a tier from the shuffled keys
	
	var min_value = tiers[chosen_tier]["min"]
	var max_value = tiers[chosen_tier]["max"]
	
	# Return a random value within the selected tier's range
	return randi_range(min_value, max_value)

func merge_card_with_affixes(card_map, affixes):
	var merged_card = card_map.duplicate()
	merged_card["affixes"] = affixes
	return merged_card
