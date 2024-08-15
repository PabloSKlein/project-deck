extends CardAttibute
class_name NewAffix

class Tier:
	var min: int
	var max: int

@export var names: Array = [] 
@export var capacity: String
@export var increased: String
@export var tiers: Dictionary = {}

func get_value():
	return tiers.get("value", 0)
