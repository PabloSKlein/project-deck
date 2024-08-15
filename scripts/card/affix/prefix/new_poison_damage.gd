extends NewAffix

func _init():
	kind = "Prefix"
	name = "Poison Damage"
	type = "poison"
	function = "damage"
	description = "Adds poison damage to attacks"
	names = ["Venom", "Toxin", "Corruption", "Viper", "Plague"]
	capacity = "Armor, Weapon, Accessories, OffHand"
	increased = "Added"
	icon = "icon4"

	tiers[1] = Tier.new()
	tiers[1].min = 4
	tiers[1].max = 8

	tiers[2] = Tier.new()
	tiers[2].min = 9
	tiers[2].max = 16

	tiers[3] = Tier.new()
	tiers[3].min = 17
	tiers[3].max = 24

	tiers[4] = Tier.new()
	tiers[4].min = 25
	tiers[4].max = 32

	tiers[5] = Tier.new()
	tiers[5].min = 33
	tiers[5].max = 50
