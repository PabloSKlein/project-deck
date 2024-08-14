extends NewAffix

func _init():
	kind = "Suffix"
	name = "Chance to Bleed"
	type = "bleed"
	function = "damage"
	description = "Chance to Bleed on Hit wha this do"
	names = ["Bleed", "Tear", "Pierce", "Wound", "Rupture"]
	capacity = "Armor, Weapon, Accessories, OffHand"
	increased = "Increased"
	icon = "icon1"

	tiers[1] = Tier.new()
	tiers[1].min = 8
	tiers[1].max = 15

	tiers[2] = Tier.new()
	tiers[2].min = 16
	tiers[2].max = 25

	tiers[3] = Tier.new()
	tiers[3].min = 26
	tiers[3].max = 35

	tiers[4] = Tier.new()
	tiers[4].min = 36
	tiers[4].max = 45

	tiers[5] = Tier.new()
	tiers[5].min = 46
	tiers[5].max = 70
