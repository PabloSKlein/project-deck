# Mace.gd
extends NewCard

func _init():
	name = "Mace"
	category = "Weapon"
	item_type = "Two Handed Mace"
	equipment_slot = ["MainHand"]
	rarity = "" #this will be filled when the item is unique
	magic_multi = 1.2
	rare_multi = 1.5
	unique_multi = 1.8
	is_dual_handed = true
	item_image = "mace"

	var physical_damage = NewCardAttibute.new()
	physical_damage.kind = "Base"
	physical_damage.name = "Physical Damage"
	physical_damage.type = "physical"
	physical_damage.function = "damage"
	physical_damage.description = "what this thing do"
	physical_damage.method = "Added"
	physical_damage.icon = "icon_physical"
	physical_damage.min = 15
	physical_damage.max = 25

	var stun_chance = NewCardAttibute.new()
	stun_chance.kind = "Base"
	stun_chance.name = "Stun chance"
	stun_chance.type = "Stun"
	stun_chance.function = "damage"
	stun_chance.description = "what this thing do"
	stun_chance.method = "Chance"
	stun_chance.icon = "icon_stun"
	stun_chance.min = 15
	stun_chance.max = 25

	attributes.append(physical_damage)
	attributes.append(stun_chance)
