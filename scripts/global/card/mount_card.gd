class_name MountCard
extends Node

var cardGenerator : CardGenerator = CardGenerator.new()
@export var card_folder: String = "res://scripts/card/card_storage"

func _ready():
	pass
	
func generate_card() -> Card:
	var card = Card.new()
	var randon_card = cardGenerator.get_random_card_from_folder(card_folder)
	var base_card = cardGenerator.new_generate_base_card(randon_card)
	var base_card_with_rarity = card.update_rarity(base_card)
	var full_base_card = card.calculate_attribute_value(base_card_with_rarity)
	var full_base_card_with_affix = cardGenerator.attach_affixes_to_card(full_base_card)
	var full_base_card_with_affix_tiers = cardGenerator.process_card_data(full_base_card_with_affix)
	card.name = full_base_card_with_affix_tiers.get("name")
	card.category = full_base_card_with_affix_tiers.get("category")
	card.type = full_base_card_with_affix_tiers.get("type")
	for i in full_base_card_with_affix_tiers.get("slot"):
		card.slot.push_back(i)
	card.rarity = full_base_card_with_affix_tiers.get("rarity")
	card.is_dual_handed = full_base_card_with_affix_tiers.get("is_dual_handed")
	card.image = full_base_card_with_affix_tiers.get("image")
	
	print(full_base_card_with_affix_tiers.get("prefixes"))
	add_attributes(card, full_base_card_with_affix_tiers.get("attributes"))
	add_affixes(card, full_base_card_with_affix_tiers.get("suffixes"))
	add_affixes(card, full_base_card_with_affix_tiers.get("prefixes"))
		
	card.prefixes.push_front(full_base_card_with_affix_tiers.get("prefixes"))
	card.suffixes.push_front(full_base_card_with_affix_tiers.get("suffixes"))
	return card

func add_attributes(card: Card, resource):
	for i in resource:
		var attribute = CardAttibute.from_dictionary(i)
		if attribute.get_value() > 0:
			card.attributes.push_front(attribute)
			
func add_affixes(card: Card, resource):
	for i in resource:
		var attribute = NewAffix.from_dictionary(i)
		if attribute.get_value() > 0:
			card.attributes.push_front(attribute)

