extends NewAffix

func _init():
	kind = "Suffix"
	name = "Health of Kill"
	type = "healt"
	function = "damage"
	description = "Health of Kill what this do"
	names = ["Phoenix", "Dragon", "Titan", "Mystic", "Eternal"]
	capacity = "Armor, Weapon, Accessories, OffHand"
	increased = "Added"
	icon = "icon1"

	tiers[1] = Tier.new()
	tiers[1].min = 5
	tiers[1].max = 10

	tiers[2] = Tier.new()
	tiers[2].min = 11
	tiers[2].max = 20

	tiers[3] = Tier.new()
	tiers[3].min = 21
	tiers[3].max = 30

	tiers[4] = Tier.new()
	tiers[4].min = 31
	tiers[4].max = 40

	tiers[5] = Tier.new()
	tiers[5].min = 41
	tiers[5].max = 60
