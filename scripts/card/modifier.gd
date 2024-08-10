class_name Modifier

extends Node

enum AttributeType {DEFENSE, DAMAGE}
enum SubType {BASIC, FIRE, ICE}
enum AmountType {VALUE, PERCENTAGE}
enum AditionType {BASE, ADDITIONAL, TEMPORARY}

@export var type: String
@export var subtype: String
@export var aditionType: String
@export var icon: String
@export var amount: float
@export var amountType: AmountType

func _ready():
	pass

func _process(delta):
	pass
	
func _init(_type : String, _icon : String, _amount : float):
	type = _type
	icon = _icon
	amount = _amount
