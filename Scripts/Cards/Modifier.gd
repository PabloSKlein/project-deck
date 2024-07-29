class_name Modifier

extends Node

enum AttributeType {DEFENSE, DAMAGE}
enum AmountType {VALUE, PERCENTAGE}

@export var type: AttributeType
@export var amount: float
@export var amountType: AmountType


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
