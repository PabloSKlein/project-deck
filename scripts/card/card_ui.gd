class_name CardUI extends Node

var card: Card

@onready var modifiers_stack : VBoxContainer = $VBoxContainer/Control/Modifiers
@onready var color : ColorRect = $Color
@onready var card_name_label : Label = $State
@onready var card_state_machine : CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector = $DropPointDetector
@onready var background = $Background
@onready var rare_card = $RareCard
@onready var magic_card = $MagicCard
@onready var unique_card = $UniqueCard
@onready var exalted_card = $ExaltedCard
@onready var item = $Item
@onready var item_category_damage = $ItemCategoryDamage
@onready var item_category_acessorie = $ItemCategoryAcessorie
@onready var item_category_armor = $ItemCategoryArmor

@onready var targets: Array[Node] = []
var mouse_inside_tooltip = false
var mouse_inside_card = false

var tooltip: Label

var test = true
var is_comparing = false

func _ready():
	if test:
		card_state_machine.init(self)
	update_ui()
	add_child(tooltip)
	pass

func bind_card(_card: Card):
	self.card = _card

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ALT:
			if event.pressed and mouse_inside_card && !is_comparing:
				is_comparing = true
				print("pressed")
				_on_alt_pressed()
			elif event.is_released():
				is_comparing = false
				print("released")
				_on_alt_released()
	else:
		card_state_machine.on_input(event)
	
func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)

func update_ui():
	$VBoxContainer/Control/CardNameLabel.text = card.name
	$VBoxContainer/Control/CardTypeLabel.text = card.type
	update_modifiers()
	set_image_item(card.image)
	print(card.rarity)
	set_rarity_item(card.rarity)
	set_tooltip()

func set_image_item(image):
	var texture_path = "res://resource/card/item/" + image + ".png"
	var texture = load(texture_path)
	$Item.texture = texture

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_alt_pressed():
	Events.compare_card.emit(self)
	
func _on_alt_released():
	Events.stop_compare_card.emit()
		
func _on_sprite_mouse_entered(modifier):
	mouse_inside_tooltip = true
	tooltip.text = modifier
	tooltip.visible = true

func _on_sprite_mouse_exited():
	mouse_inside_tooltip = false
	tooltip.visible = false

func _on_mouse_entered() -> void:
	if not mouse_inside_card and not mouse_inside_tooltip:

		mouse_inside_card = true
		card_state_machine.on_mouse_entered()
		
func _on_mouse_exited(text: String) -> void:
	if text == "tooltip":
		_on_sprite_mouse_exited()
	else:
		if mouse_inside_card and not mouse_inside_tooltip:
			mouse_inside_card = false
			is_comparing = false
			card_state_machine.on_mouse_exited()
			_on_alt_released()

func update_modifiers():
	for modifier in card.attributes:
		var control = Control.new()
		control.custom_minimum_size = Vector2(50, 20)  # Increase size to cover the desired area
		
		var label = Label.new()
		label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_ARBITRARY
		label.text = "  " + str(modifier.value)
		label.custom_minimum_size = Vector2(35, 0)
		label.position = Vector2(10, 2)  # Adjust the position inside the larger control

		var rect = ColorRect.new()
		rect.position  = Vector2(10, 2)
		rect.custom_minimum_size = Vector2(35, 0)
		
		var sprite = Sprite2D.new()
		var icon = load("res://resource/card/icon/" + modifier.icon + ".png")
		sprite.texture = icon
		sprite.scale = Vector2(0.10, 0.10)
		sprite.position = Vector2(10, 15)  # Adjust position inside the larger control

		control.add_child(rect)
		control.add_child(sprite)
		control.add_child(label)

		modifiers_stack.add_child(control)

		var spacer = Control.new()
		spacer.custom_minimum_size = Vector2(0, 10) 
		
		modifiers_stack.add_child(spacer)

		control.connect("mouse_entered", self._on_sprite_mouse_entered.bind(modifier.type))
		control.connect("mouse_exited", self._on_mouse_exited.bind("tooltip"))
		control.connect("gui_input", self._on_gui_input)
		
		self.connect("mouse_entered", self._on_mouse_entered)
		self.connect("mouse_exited", self._on_mouse_exited.bind("card"))
		
func set_rarity_item(value):
	var _rarity
	print(_rarity)
	if	value == 1:
		_rarity = "Magic"
		unique_card.hide()
		rare_card.hide()
		exalted_card.hide()
	elif value == 2:
		_rarity = "Rare"
		unique_card.hide()
		magic_card.hide()
		exalted_card.hide()
	
func set_category_item(value):
	self.category = value
	match self.category:
		"Armor":
			item_category_damage.hide()
			item_category_acessorie.hide()
			item_category_armor.show()
		"Shield":
			item_category_damage.hide()
			item_category_acessorie.hide()
			item_category_armor.show()
		"Acessories":
			item_category_damage.hide()
			item_category_acessorie.show()
			item_category_armor.hide()
		"Weapon":
			item_category_damage.show()
			item_category_acessorie.hide()
			item_category_armor.hide()
	return "Other"

func set_tooltip():
	tooltip = Label.new()
	tooltip.text = "" 
	tooltip.visible = false
