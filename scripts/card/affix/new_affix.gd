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

static func from_dictionary(dict: Dictionary) -> NewAffix:
	var attribute = NewAffix.new()
	var instance : CardAttibute = super.from_dictionary2(dict, attribute)
	instance.tiers = dict.get("tiers", [])
	instance.value = instance.tiers.get("value", 0)
	return instance
