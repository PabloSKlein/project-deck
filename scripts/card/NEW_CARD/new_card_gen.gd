extends Node

class_name GenerateCardNew

func _ready():
	pass

func generate_card() -> Card:
	var card = Card.new()
	var base_card_data = generate_card_base()
	
	# Set up card basics
	card.name_item = base_card_data.name
	card.type = base_card_data.type
	card.image = base_card_data.image
	card.category = base_card_data.category
	
	# Set up slots
	for slot in base_card_data.slot:
		card.slot_types.push_back(CardType.get_type_by_description(slot))
	
	# Determine rarity and apply rarity multiplier
	var rarity = generate_card_rarity(base_card_data, card)
	card.rarity = rarity
	
	# Generate and resolve attributes
	var resolved_attributes = resolve_card_attributes(base_card_data, rarity)
	card.modifiers = generate_modifiers(resolved_attributes, rarity)
	
	return card

func generate_card_base() -> NewCard:
	var keys = CardData.card_data.keys()
	randomize()
	var random_index = randi() % keys.size()
	var random_key = keys[random_index]
	return CardData.card_data[random_key].new()  # Instantiate the specific card class

func resolve_card_attributes(base_card: NewCard, rarity: int) -> Dictionary:
	var final_card_data = {}
	
	# Resolve base attributes
	for attribute in base_card.attributes:
		var min_value = attribute.min
		var max_value = attribute.max
		final_card_data[attribute.name] = randi_range(min_value, max_value)

	# Apply rarity-based calculations
	var final_card = rarity_calculation(final_card_data, rarity)
	
	# Generate and apply affixes
	var affixes = generate_affixes(base_card, rarity)
	final_card["affixes"] = affixes
	
	return final_card

func generate_modifiers(card_map: Dictionary, rarity: int) -> Array[Modifier]:
	var modifiers : Array[Modifier] = []

	# Process base attributes
	for key in card_map.keys():
		if key != "affixes":
			var min_value = card_map[key]
			var icon = "default_icon"  # Replace with logic to assign correct icons
			var modifier = Modifier.new(key, min_value, icon)
			modifiers.push_back(modifier)

	# Process affixes
	if "affixes" in card_map:
		for affix_key in card_map["affixes"].keys():
			var affix = card_map["affixes"][affix_key]
			var modifier = Modifier.new(affix["description"], affix["value_status"], affix["affix_icon"])
			modifiers.push_back(modifier)
	
	return modifiers

func generate_card_rarity(base: NewCard, card: Card) -> int:
	var rarity_roll = randi() % 100 + 1
	var drop_rate = card.drop_rates
	var cumulative = 0
	
	for rarity in drop_rate.keys():
		cumulative += drop_rate[rarity]
		if rarity_roll <= cumulative:
			return rarity
	return 0

func rarity_calculation(card_data: Dictionary, rarity: int) -> Dictionary:
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
		result[key] = card_data[key] * multiplier
	
	# Process affixes
	if "affixes" in card_data:
		for affix_key in card_data["affixes"].keys():
			var affix = card_data["affixes"][affix_key]
			result["affixes"][affix_key] = {
				"description": affix["description"],
				"value_status": affix["value_status"] * multiplier,
				"increased": affix["increased"]
			}
	
	return result

func generate_affixes(card_data: NewCard, rarity: int) -> Dictionary:
	var affix_data = {}
	var max_affixes = get_max_affixes_based_on_rarity(rarity)
	var num_prefixes = randi() % (max_affixes + 1)
	var num_suffixes = max_affixes - num_prefixes
	
	# Example: Fetch valid prefixes and suffixes based on the card's category
	var valid_prefixes = get_valid_affixes(PrefixData.prefix_data, card_data.category, "prefix")
	var valid_suffixes = get_valid_affixes(SuffixData.suffix_data, card_data.category, "suffix")
	
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

func get_max_affixes_based_on_rarity(rarity: int) -> int:
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

func pick_random_value(tiers: Dictionary, rarity: int) -> int:
	randomize()
	var tier_keys = tiers.keys()
	tier_keys.shuffle()
	var chosen_tier = tier_keys[randi() % tier_keys.size()]
	var min_value = tiers[chosen_tier]["min"]
	var max_value = tiers[chosen_tier]["max"]
	return randi_range(min_value, max_value)
