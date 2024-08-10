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
@onready var item = $Item
@onready var item_category_damage = $ItemCategoryDamage
@onready var item_category_acessorie = $ItemCategoryAcessorie
@onready var item_category_armor = $ItemCategoryArmor
@onready var targets: Array[Node] = []
var tooltip: Label

func _ready():
	card_state_machine.init(self)
	update_ui()
	add_child(tooltip)
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
	set_tooltip()

func set_image_item(image):
	var texture_path = "res://resource/card/item/" + image + ".png"
	var texture = load(texture_path)
	$Item.texture = texture
		
func _on_sprite_mouse_entered(modifier):
	tooltip.text = modifier
	tooltip.visible = true

func _on_sprite_mouse_exited():
	tooltip.visible = false

func update_modifiers():
	for modifier in card.modifiers:
		var control = Control.new()
		control.custom_minimum_size = Vector2(50, 20)  # Increase size to cover the desired area
		
		var label = Label.new()
		label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_ARBITRARY
		label.text = "  " + str(modifier.amount)
		label.custom_minimum_size = Vector2(35, 0)
		label.position = Vector2(10, 2)  # Adjust the position inside the larger control


		var sprite = Sprite2D.new()
		var icon = load("res://resource/card/icon/" + modifier.icon + ".png")
		sprite.texture = icon
		sprite.scale = Vector2(0.10, 0.10)
		sprite.position = Vector2(10, 15)  # Adjust position inside the larger control

		control.add_child(sprite)
		control.add_child(label)

		modifiers_stack.add_child(control)

		var spacer = Control.new()
		spacer.custom_minimum_size = Vector2(0, 10) 
		
		modifiers_stack.add_child(spacer)

		control.connect("mouse_entered", self._on_sprite_mouse_entered.bind(modifier.type))
		control.connect("mouse_exited", self._on_sprite_mouse_exited)
		
func set_rarity_item(value):
	var _rarity
	if	value == 1:
		_rarity = "Magic"
		unique_card.hide()
		rare_card.hide()
	elif value == 2:
		_rarity = "Rare"
		unique_card.hide()
		magic_card.hide()
	else:
		_rarity = "Unique"
		rare_card.hide()
		magic_card.hide()
	
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
