extends Resource
class_name CardAttibute

@export var kind: String
@export var name: String
@export var type: String
@export var function: String
@export var description: String
@export var method: String
@export var icon: String
@export var min: int = 0
@export var max: int = 0
@export var value: float

static func from_dictionary(dict: Dictionary):
	var instance = CardAttibute.new()
	instance.kind = dict.get("kind", "")
	instance.name = dict.get("name", "")
	instance.type = dict.get("type", "")
	instance.function = dict.get("function", "")
	instance.description = dict.get("description", "")
	instance.method = dict.get("method", "")
	instance.icon = dict.get("icon", "")
	instance.min = dict.get("min", 0)
	instance.max = dict.get("max", 0)
	instance.value = dict.get("value", 0.0)
	return instance

func get_value():
	return value
