extends Node

class_name GenerateCard

# Preload the Prefix, Suffix, and Card classes
const Prefix = preload("res://Scripts/Prefixes/Prefix.gd")
const Suffix = preload("res://Scripts/Suffixes/Suffix.gd")
const Card = preload("res://Scripts/Cards/Card.gd")

# Define the number of prefixes and suffixes to be used
const MIN_PREFIXES = 1
const MAX_PREFIXES = 2
const MIN_SUFFIXES = 1
const MAX_SUFFIXES = 2

func _ready():
	randomize() # Ensure random number generation is properly seeded

	var generated_card = generate_card(null)
	print("Generated Card Name: ", generated_card.nameItem)
	print("Card Type: ", generated_card.get_type_name())
	print("Card Rarity: ", generated_card.get_rarity_name())

	# Print card prefixes
	var prefix_descriptions = []
	for prefix in generated_card.prefixes:
		prefix_descriptions.append(prefix.get_description())
	print("Card Prefixes: ", prefix_descriptions)

	# Print card suffixes
	var suffix_descriptions = []
	for suffix in generated_card.suffixes:
		suffix_descriptions.append(suffix.get_description())
	print("Card Suffixes: ", suffix_descriptions)

	print("Card Modifiers: ", generated_card.modifiers)

func generate_card(cardType) -> Card:
	 # Create a new card instance
	var card = Card.new()
	
	# Get all possible values for card types, prefixes, and suffixes
	var card_types = Card.CardType.values()
	var prefix_types = Prefix.PrefixType.values()
	var suffix_types = Suffix.SuffixesType.values()
	
	# Randomly choose card type if not provided
	card.type = cardType if cardType != null else card_types[randi() % card_types.size()]

	# Generate a random number of prefixes and suffixes
	var num_prefixes = randi_range(MIN_PREFIXES, MAX_PREFIXES)
	var num_suffixes = randi_range(MIN_SUFFIXES, MAX_SUFFIXES)

	# Ensure the number of prefixes and suffixes do not exceed available types
	num_prefixes = min(num_prefixes, prefix_types.size())
	num_suffixes = min(num_suffixes, suffix_types.size())
	
	# Track used prefix and suffix types to avoid duplicates
	var used_prefix_types = {}
	var used_suffix_types = {}

	# Create unique prefixes
	card.prefixes.clear()
	while card.prefixes.size() < num_prefixes:
		var prefix_type = prefix_types[randi() % prefix_types.size()]
		if not used_prefix_types.has(prefix_type):
			var tier = randi_range(1, 5)
			var prefix = Prefix.new(prefix_type, tier)
			card.prefixes.append(prefix)
			used_prefix_types[prefix_type] = true

	# Create unique suffixes
	card.suffixes.clear()
	while card.suffixes.size() < num_suffixes:
		var suffix_type = suffix_types[randi() % suffix_types.size()]
		if not used_suffix_types.has(suffix_type):
			var tier = randi_range(1, 5)
			var suffix = Suffix.new(suffix_type, tier)
			card.suffixes.append(suffix)
			used_suffix_types[suffix_type] = true

	# Determine card rarity based on the number of prefixes and suffixes
	card.rarity = Card.CardRarity.MAGIC if (num_prefixes + num_suffixes <= 3) else Card.CardRarity.RARE

	# Assign a name for demonstration
	card.nameItem = _generate_random_name(card.type)
	
	# Create and apply modifiers
	card.modifiers.clear()
	for suff in card.suffixes:
		card.modifiers.push_front(Modifier.new(str(suff.getId()), snapped(suff.bonus, 0.01)))
	for pref in card.prefixes:
		card.modifiers.push_front(Modifier.new(str(pref.getId()), snapped(pref.bonus, 0.01)))

	# Apply modifiers to the card
	_apply_modifiers(card)

	# Log the full details of the card
	print(card.get_card_details())

	return card

func _generate_random_name(card_type: Card.CardType) -> String:
	match card_type:
		Card.CardType.HELMET:
			return "Helmet of the " + _generate_random_name_suffix()
		Card.CardType.BODY:
			return "Body Armor of the " + _generate_random_name_suffix()
		Card.CardType.GLOVES:
			return "Gloves of the " + _generate_random_name_suffix()
		Card.CardType.BOOTS:
			return "Boots of the " + _generate_random_name_suffix()
		Card.CardType.BELT:
			return "Belt of the " + _generate_random_name_suffix()
		Card.CardType.WEAPON:
			return "Weapon of the " + _generate_random_name_suffix()
		Card.CardType.POTION:
			return "Potion of the " + _generate_random_name_suffix()
		_:
			return "Unknown Item"

func _generate_random_name_suffix() -> String:
	var suffix_names = Suffix.get_suffix_names(Suffix.SuffixesType.values()[randi() % Suffix.SuffixesType.values().size()])
	return suffix_names[randi() % suffix_names.size()]

func _apply_modifiers(card: Card) -> void:
	var total_bonus = 0.0
	for prefix in card.prefixes:
		total_bonus += prefix.bonus
	for suffix in card.suffixes:
		total_bonus += suffix.bonus

	print("Total Bonus: ", total_bonus)
