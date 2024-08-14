extends NewAffix

func _init():
	kind = "Suffix"
	name = "Mana Regeneration"
	type = "mana"
	function = "regeneration"
	description = "Mana Regeneration over time"
	names = ["Sage", "Mystic", "Arcane", "Sorcerer", "Wizard"]
	capacity = "Armor, Weapon, Accessories, OffHand"
	increased = "Increased"
	icon = "icon2"

	tiers[1] = Tier.new()
	tiers[1].min = 3
	tiers[1].max = 6

	tiers[2] = Tier.new()
	tiers[2].min = 7
	tiers[2].max = 12

	tiers[3] = Tier.new()
	tiers[3].min = 13
	tiers[3].max = 18

	tiers[4] = Tier.new()
	tiers[4].min = 19
	tiers[4].max = 25

	tiers[5] = Tier.new()
	tiers[5].min = 26
	tiers[5].max = 35
