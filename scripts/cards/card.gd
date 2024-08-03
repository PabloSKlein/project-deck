class_name Card extends Node

signal reparent_requested(which_card_ui: Card)

enum CardType {HELMET,BODY,GLOVES,BOOTS,BELT,WEAPON,POTION}
enum CardRarity {BASIC, MAGIC, RARE, UNIQUE}

@export var nameItem: String
@export var type: CardType
@export var typeNew: String
@export var rarity: CardRarity
@export var rarityNew: int
@export var prefixes: Array[Prefix] = [] # Added property
@export var suffixes: Array[Suffix] = [] # Added property
@export var modifiers: Array[Modifier] = []
@onready var targets: Array[Node] = []
@export var drop_rates = {
	CardRarity.MAGIC: 50, # % of droprate
	CardRarity.RARE: 30, # % of droprate
	CardRarity.UNIQUE: 20 # % of droprate
}
@onready var modifiersStack : VBoxContainer = $VBoxContainer/Modifiers
@onready var color : ColorRect = $Color
@onready var CardNameLabel : Label = $State
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

func _process(delta):
	pass

func _init() -> void:
	pass
	
func setNameItem(value):
	nameItem = value
	$VBoxContainer/CardNameLabel.text = nameItem

func setTypeItem(value):
	typeNew = value
	$VBoxContainer/CardTypeLabel.text = typeNew
	
func setRarityItem(value):
	rarityNew = value
	var rarity
	if	rarityNew == 1:
		rarity = "Magic"
	elif rarityNew == 2:
		rarity = "Rare"
	else:
		rarity = "Unique"
	$VBoxContainer/CardRarityLabel.text = rarity

func setModifier(value: Array[Modifier]):
	modifiers = value
	for modifier in modifiers:
		var label = Label.new()
		label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_ARBITRARY
		label.text = modifier.type + " " + str(modifier.amount)
		modifiersStack.add_child(label)
			
func copyFrom(_card : Card):
	setNameItem(_card.nameItem)
	setTypeItem(_card.typeNew)
	setRarityItem(_card.rarityNew)
	setModifier(_card.modifiers)
	pass

func get_card_details() -> String:
	var details = "Card Name: " + nameItem + "\n"
	details += "Type: " + typeNew + "\n"
	details += "Rarity: " + str(rarityNew) + "\n"
	details += "Modifiers:\n"
	for modifier in modifiers:
		details += "- " + str(modifier.type) + ": " + str(modifier.amount) + "\n"
	return details

func _on_draw_button_pressed():
	pass # Replace with function body.
