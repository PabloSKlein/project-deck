extends Node

class_name CardLoader

var items: Dictionary = {}
var prefix_data: Dictionary = {}
var suffix_data: Dictionary = {}

const item_paths = [
	"res://Scripts/card/NEW_CARD/card_base/new_mace.gd",
	"res://Scripts/card/NEW_CARD/card_base/new_battle_axe.gd",
	"res://Scripts/card/NEW_CARD/card_base/new_birch_bow.gd",
	"res://Scripts/card/NEW_CARD/card_base/new_gladios.gd",
	"res://Scripts/card/NEW_CARD/card_base/new_gloves.gd",
	"res://Scripts/card/NEW_CARD/card_base/new_ringmail.gd",
	"res://Scripts/card/NEW_CARD/card_base/new_shield.gd",
	"res://Scripts/card/NEW_CARD/card_base/new_ritual_stake.gd",
	]
	
const prefix_paths = [
	"res://scripts/card/NEW_CARD/affix/prefix/new_cold_damage.gd",
	"res://scripts/card/NEW_CARD/affix/prefix/new_fire_damage.gd",
	"res://scripts/card/NEW_CARD/affix/prefix/new_lightning_damage.gd",
	"res://scripts/card/NEW_CARD/affix/prefix/new_poison_damage.gd"
	
	]

var suffix_paths = [
	"res://Scripts/card/NEW_CARD/affix/suffix/new_chance_to_bleed.gd",
	"res://Scripts/card/NEW_CARD/affix/suffix/new_crit_chance.gd",
	"res://Scripts/card/NEW_CARD/affix/suffix/new_health_on_kill.gd",
	"res://Scripts/card/NEW_CARD/affix/suffix/new_mana_regen.gd",
	]

func _ready():
	load_all_items()
	load_all_affixes()

func load_all_items():
	for path in item_paths:
		var resource = load(path)
		if resource:
			items[path] = resource
			print("Loaded item: ", path)
		else:
			print("Failed to load item at path: ", path)

func load_all_affixes():
	for path in prefix_paths:
		var resource = load(path)
		if resource:
			prefix_data[path] = resource
			print("Loaded prefix: ", path)
		else:
			print("Failed to load prefix at path: ", path)

	for path in suffix_paths:
		var resource = load(path)
		if resource:
			suffix_data[path] = resource
			print("Loaded suffix: ", path)
		else:
			print("Failed to load suffix at path: ", path)
