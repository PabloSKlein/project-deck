extends NewAffix

func _init():
	kind = "Prefix"
	name = "Lightning Damage"
	type = "lightning"
	function = "damage"
	description = "Light Damage what this do"
	names = ["Shock", "Thunder", "Bolt", "Storm", "Flash"]
	capacity = "Armor, Weapon, Accessories, OffHand"
	increased = "Added"
	icon = "icon1"

	tiers[1] = Tier.new()
	tiers[1].min = 6
	tiers[1].max = 12

	tiers[2] = Tier.new()
	tiers[2].min = 13
	tiers[2].max = 22

	tiers[3] = Tier.new()
	tiers[3].min = 23
	tiers[3].max = 32

	tiers[4] = Tier.new()
	tiers[4].min = 33
	tiers[4].max = 42

	tiers[5] = Tier.new()
	tiers[5].min = 43
	tiers[5].max = 65
