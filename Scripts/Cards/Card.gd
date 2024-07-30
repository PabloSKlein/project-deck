class_name Card
extends Node

signal reparent_requested(which_card_ui: Card)
enum CardType {HELMET,BODY,GLOVES,BOOTS,BELT,WEAPON,POTION}
enum CardRarity {BASIC, MAGIC, RARE, UNIQUE}

@export var nameItem: String
@export var type: CardType
@export var rarity: CardRarity
@export var prefixes: Array[Prefix] = [] # Added property
@export var suffixes: Array[Suffix] = [] # Added property
@export var modifiers: Array[Modifier] = []

@onready var modifiersStack : VBoxContainer = $VBoxContainer/Modifiers
@onready var color : ColorRect = $Color
@onready var state : Label = $State
@onready var card_state_machine : CardStateMachine = $CardStateMachine as CardStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready function is executing")
	card_state_machine.init(self)

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _init() -> void:
	pass
	
func setNameItem(value):
	nameItem = value
	$VBoxContainer/CardNameLabel.text = nameItem
	
func setModifier(value: Array[Modifier]):
	modifiers = value
	for modifier in modifiers:
		var label = Label.new()
		label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_ARBITRARY
		label.text = modifier.type + " " + str(modifier.amount)
		modifiersStack.add_child(label)

func get_type_name() -> String:
	match type:
		CardType.HELMET:
			return "Helmet"
		CardType.BODY:
			return "Body Armor"
		CardType.GLOVES:
			return "Gloves"
		CardType.BOOTS:
			return "Boots"
		CardType.BELT:
			return "Belt"
		CardType.WEAPON:
			return "Weapon"
		CardType.POTION:
			return "Potion"
		_:
			return "Unknown Item"
			
func get_rarity_name() -> String:
	match rarity:
		CardRarity.BASIC:
			return "Basic"
		CardRarity.MAGIC:
			return "Magic"
		CardRarity.RARE:
			return "Rare"
		CardRarity.UNIQUE:
			return "Unique"
		_:
			return "Unknown Item"
			
func copyFrom(_card : Card):
	setNameItem(_card.nameItem)
	setModifier(_card.modifiers)
	pass

# Method to get detailed information about the card
func get_card_details() -> String:
	var details = "Card Name: " + nameItem + "\n"
	details += "Type: " + get_type_name() + "\n"
	details += "Rarity: " + get_rarity_name() + "\n"
	
	details += "Prefixes:\n"
	for prefix in prefixes:
		details += "- " + str(prefix.getId()) + ": " + str(snapped(prefix.bonus,0.01)) + "\n"
		#details += "- " + str(suffix.getId()) + " (Tier: " + str(suffix.tier) + ", Bonus: " + str(snapped(suffix.bonus,0.01)) + ")\n" to see the full tier(maybe usefull)
	details += "Suffixes:\n"
	for suffix in suffixes:
		details += "- " + str(suffix.getId()) + ": " + str(snapped(suffix.bonus,0.01)) + "\n"
	
	#details += "Modifiers:\n"
	#for modifier in modifiers:
		#details += "- " + str(modifier.getId()) + ": " + str(modifier.bonus) + "\n"
	
	return details


func _on_draw_button_pressed():
	pass # Replace with function body.
