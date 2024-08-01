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
	#var resolvcard = resolve(final_card_data, rarity) AQUI TEM QUE FAZER OS CALCULOS
	return final_card_data

func generate_card_rarity(base, card: Card):
	var rarity_roll = randi() % 100 + 1
	var drop_rate = card.drop_rates
	var cumulative = 0
	for rarity in drop_rate.keys():
		cumulative += drop_rate[rarity]
		if rarity_roll <= cumulative:
			return rarity
			
			
#func resolve(final_card_data, rarity):
	#print(final_card_data)
	#if final_card_data["card_category"] == "Armor":
		#print("Armor")
		#match rarity:
			#1:
				#print("magic calc")
				#card_armor_calculation(final_card_data["card_defense"], final_card_data["card_block"], final_card_data["card_magic_multi"])
			#2:
				#print("rare calc")
				#card_armor_calculation(final_card_data["card_defense"], final_card_data["card_block"], final_card_data["card_rare_multi"])
			#3:
				#print("unique calc")
				#card_armor_calculation(final_card_data["card_defense"], final_card_data["card_block"], final_card_data["card_unique_multi"])
	#else: if final_card_data["card_category"] == "Weapon":
		#print("Weapon")
		#match rarity:
			#1:
				#print("magic calc")
				#card_weapon_calculation(final_card_data["card_attack"], final_card_data["card_magic_multi"])
			#2:
				#print("magic calc")
				#card_weapon_calculation(final_card_data["card_attack"], final_card_data["card_magic_multi"])
			#3:
				#print("magic calc")
				#card_weapon_calculation(final_card_data["card_attack"], final_card_data["card_magic_multi"])
#
#func card_armor_calculation(defense, block, multi):
	#defense =  multi * defense
	#block =  multi * block
	#return [defense, block]
	#
#func card_weapon_calculation(attack, multi):
	#attack = multi * attack
	#return attack
