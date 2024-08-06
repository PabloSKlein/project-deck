class_name Modifier

extends Node

enum AttributeType {DEFENSE, DAMAGE}
enum AmountType {VALUE, PERCENTAGE}

@export var type: String
@export var amount: float
@export var amountType: AmountType

func _ready():
	pass

func _process(delta):
	pass
	
func _init(_type : String, _amount : float):
	type = _type
	amount = _amount
