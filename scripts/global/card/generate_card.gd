class_name GenerateCard
extends Node

var teste : NewCardGen = NewCardGen.new()
@export var card_folder: String = "res://scripts/card/card_storage"

func _ready():
	pass
	
func new_generate_card() -> NewCard:
	var card = NewCard.new()
	var randon_card = teste.get_random_card_from_folder(card_folder)
	var base_card = teste.new_generate_base_card(randon_card)
	var base_card_with_rarity = card.update_rarity(base_card)
	var full_base_card = card.calculate_attribute_value(base_card_with_rarity)
	var full_base_card_with_affix = teste.attach_affixes_to_card(full_base_card)
	var full_base_card_with_affix_tiers = teste.process_card_data(full_base_card_with_affix)
	card.name = full_base_card_with_affix_tiers.get("name")
	card.category = full_base_card_with_affix_tiers.get("category")
	card.type = full_base_card_with_affix_tiers.get("type")
	for i in full_base_card_with_affix_tiers.get("slot"):
		card.slot.push_back(i)
	card.rarity = full_base_card_with_affix_tiers.get("rarity")
	card.is_dual_handed = full_base_card_with_affix_tiers.get("is_dual_handed")
	card.image = full_base_card_with_affix_tiers.get("image")
	card.attributes.push_front(full_base_card_with_affix_tiers.get("attributes"))
	card.prefixes.push_front(full_base_card_with_affix_tiers.get("prefixes"))
	card.suffixes.push_front(full_base_card_with_affix_tiers.get("suffix"))
	return card

