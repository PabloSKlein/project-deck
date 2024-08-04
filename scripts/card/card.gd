class_name Card extends Node

signal reparent_requested(which_card_ui: Card)

enum CardRarity {BASIC, MAGIC, RARE, UNIQUE}

@export var name_item: String
@export var category: String
@export var type: String
@export var slot_types: Array[CardType.Enum]
@export var rarity: CardRarity
@export var prefixes: Array[Prefix] = [] # Added property
@export var suffixes: Array[Suffix] = [] # Added property
@export var modifiers: Array[Modifier] = []
@onready var targets: Array[Node] = []
@export var drop_rates = {
	CardRarity.MAGIC: 50, # % of droprate
	CardRarity.RARE: 30, # % of droprate
	CardRarity.UNIQUE: 20 # % of droprate
}
@onready var modifiers_stack : VBoxContainer = $VBoxContainer/Control/Modifiers
@onready var color : ColorRect = $Color
@onready var card_name_label : Label = $State
@onready var card_state_machine : CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector = $DropPointDetector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_state_machine.init(self)

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
	
func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
	
func set_name_item(value):
	self.name_item = value
	$VBoxContainer/Control/CardNameLabel.text = name_item

func set_type_item(value):
	self.type = value
	$VBoxContainer/Control/CardTypeLabel.text = type
	
func set_rarity_item(value):
	self.rarity = value
	var _rarity
	if	value == 1:
		_rarity = "Magic"
	elif value == 2:
		_rarity = "Rare"
	else:
		_rarity = "Unique"
	$VBoxContainer/Control/CardRarityLabel.text = _rarity

func set_modifier(value: Array[Modifier]):
	modifiers = value
	for modifier in modifiers:
		var label = Label.new()
		label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_ARBITRARY
		label.text = modifier.type + " " + str(modifier.amount)
		modifiers_stack.add_child(label)
			
func copy_from(_card : Card):
	set_name_item(_card.name_item)
	set_type_item(_card.type)
	set_rarity_item(_card.rarity)
	set_modifier(_card.modifiers)
	self.slot_types = _card.slot_types
	pass

func get_card_details() -> String:
	var details = "Card Name: " + name_item + "\n"
	details += "Type: " + str(type) + "\n"
	details += "Rarity: " + str(rarity) + "\n"
	details += "Modifiers:\n"
	for modifier in modifiers:
		details += "- " + str(modifier.type) + ": " + str(modifier.amount) + "\n"
	return details

func _on_draw_button_pressed():
	pass # Replace with function body.
