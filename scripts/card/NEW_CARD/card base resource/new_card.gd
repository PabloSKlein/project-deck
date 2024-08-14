extends Resource
class_name NewCard

@export var name: String
@export var category: String
@export var type: String
@export var slot: Array
@export var rarity: int
@export var magic_multi: float = 1.0
@export var rare_multi: float = 1.0
@export var unique_multi: float = 1.0
@export var is_dual_handed: bool = false
@export var image: String
@export var attributes: Array[Resource] = []
