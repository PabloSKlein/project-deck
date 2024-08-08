class_name CardUI extends Node

var card: Card

@onready var modifiers_stack : VBoxContainer = $VBoxContainer/Control/Modifiers
@onready var color : ColorRect = $Color
@onready var card_name_label : Label = $State
@onready var card_state_machine : CardStateMachine = $CardStateMachine
@onready var drop_point_detector = $DropPointDetector
@onready var background = $Background
@onready var targets: Array[Node] = []

signal reparent_requested(which_card_ui: CardUI)

func _ready():
	card_state_machine.init(self)
	update_ui()
	pass

func bind_card(_card: Card):
	self.card = _card

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

func update_ui():
	$VBoxContainer/Control/CardNameLabel.text = card.name_item
	$VBoxContainer/Control/CardTypeLabel.text = card.type
	update_modifiers()
	set_image_item(card.image)
	set_rarity_item(card.rarity)

func set_image_item(image):
	var texture_path = "res://resource/card/item/" + image + ".png"
	var texture = load(texture_path)
	$Item.texture = texture

func update_modifiers():
	for modifier in card.modifiers:
		var label = Label.new()
		label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_ARBITRARY
		label.text = modifier.type + " " + str(modifier.amount)
		modifiers_stack.add_child(label)
		modifiers_stack.add_child(label)

func set_rarity_item(value):
	var _rarity
	if	value == 1:
		_rarity = "Magic"
		var texture = load("res://resource/card/magic_background.png")
		$Background.texture = texture
	elif value == 2:
		_rarity = "Rare"
		var texture = load("res://resource/card/rare_background.png")
		$Background.texture = texture
	else:
		_rarity = "Unique"
	$VBoxContainer/Control/CardRarityLabel.text = _rarity
