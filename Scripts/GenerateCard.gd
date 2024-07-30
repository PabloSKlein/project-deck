class_name GenerateCard

extends Node

# Preload the Prefix and Suffix classes
const Prefix = preload("res://Scripts/Prefixes/Prefix.gd")
const Suffix = preload("res://Scripts/Suffixes/Suffix.gd")
const Card = preload("res://Scripts/Cards/Card.gd")

# Define the number of prefixes and suffixes to be used
const MIN_PREFIXES = 1
const MAX_PREFIXES = 2
const MIN_SUFFIXES = 1
const MAX_SUFFIXES = 2

# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	# Randomly choose card type
	card.type = cardType if cardType != null else Card.CardType.values()[randi() % Card.CardType.values().size()]

	# Generate a random number of prefixes and suffixes
	var num_prefixes = randi_range(MIN_PREFIXES, MAX_PREFIXES)
	var num_suffixes = randi_range(MIN_SUFFIXES, MAX_SUFFIXES)

	# Ensure the number of prefixes and suffixes do not exceed the card's maximum allowed types
	num_prefixes = min(num_prefixes, Prefix.PrefixType.values().size())
	num_suffixes = min(num_suffixes, Suffix.SuffixesType.values().size())
	
	# Track used prefix and suffix types to avoid duplicates
	var used_prefix_types = {}
	var used_suffix_types = {}

	# Create unique prefixes
	card.prefixes.clear()
	while card.prefixes.size() < num_prefixes:
		var prefix_type = Prefix.PrefixType.values()[randi() % Prefix.PrefixType.values().size()]
		if not used_prefix_types.has(prefix_type):
			var tier = randi_range(1, 5)
			var prefix = Prefix.new(prefix_type, tier)
			card.prefixes.append(prefix)
			used_prefix_types[prefix_type] = true

	# Create unique suffixes
	card.suffixes.clear()
	while card.suffixes.size() < num_suffixes:
		var suffix_type = Suffix.SuffixesType.values()[randi() % Suffix.SuffixesType.values().size()]
		if not used_suffix_types.has(suffix_type):
			var tier = randi_range(1, 5)
			var suffix = Suffix.new(suffix_type, tier)
			card.suffixes.append(suffix)
			used_suffix_types[suffix_type] = true

	# Determine card rarity
	if num_prefixes + num_suffixes <= 3:
		card.rarity = Card.CardRarity.MAGIC
	else:
		card.rarity = Card.CardRarity.RARE

	# Assign a name for demonstration
	card.nameItem = _generate_random_name(card.type)
	
	for suff in card.suffixes:
		var mod = Modifier.new(str(suff.getId()), suff.bonus)
		card.modifiers.push_front(mod)
	for pref in card.prefixes:
		var mod = Modifier.new(str(pref.getId()), pref.bonus)
		card.modifiers.push_front(mod)

	# Apply modifiers
	_apply_modifiers(card)

	return card

func _generate_random_name(card_type: Card.CardType) -> String:
	# Generate a name based on the card type
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
	# Get suffix names and pick a random one
	var suffix_names = Suffix.get_suffix_names(Suffix.SuffixesType.values()[randi() % Suffix.SuffixesType.values().size()])
	return suffix_names[randi() % suffix_names.size()]

func _apply_modifiers(card: Card) -> void:
	# Example of applying modifiers
	var total_bonus = 0.0
	for prefix in card.prefixes:
		total_bonus += prefix.bonus
	for suffix in card.suffixes:
		total_bonus += suffix.bonus

	# Example: Printing the total bonus
	print("Total Bonus: ", total_bonus)
