extends NewAffix

func _init():
	kind = "Suffix"
	name = "Critical Hit Chance"
	type = "critical"
	function = "chance"
	description = "Increases the chance of critical hits"
	names = ["Predator", "Assassin", "Rogue", "Shadow", "Venom"]
	capacity = "Armor, Weapon, Accessories, OffHand"
	increased = "Increased"
	icon = "icon3"

	tiers[1] = Tier.new()
	tiers[1].min = 1
	tiers[1].max = 3

	tiers[2] = Tier.new()
	tiers[2].min = 4
	tiers[2].max = 6

	tiers[3] = Tier.new()
	tiers[3].min = 7
	tiers[3].max = 9

	tiers[4] = Tier.new()
	tiers[4].min = 10
	tiers[4].max = 12

	tiers[5] = Tier.new()
	tiers[5].min = 13
	tiers[5].max = 15
