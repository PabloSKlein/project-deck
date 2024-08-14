extends NewCard

func _init():
	name = "Kris"
	category = "Weapon"
	type = "Dagger"
	slot = ["MainHand", "OffHand"]
	rarity = 0
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "dagger"

	var fire_damage = NewCardAttibute.new()
	fire_damage.kind = "Base"
	fire_damage.name = "Fire Damage"
	fire_damage.type = "fire"
	fire_damage.function = "damage"
	fire_damage.description = "Adds fire damage to attacks"
	fire_damage.method = "Added"
	fire_damage.icon = "icon1"
	fire_damage.min = 5
	fire_damage.max = 10

	attributes.append(fire_damage)
