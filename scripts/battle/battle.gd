extends Node2D

@onready var cardScene: PackedScene = preload("res://scenes/card.tscn")

@onready var handStack : HBoxContainer = $BattleUI/HandHStack
@onready var drawButton : Button = $BattleUI/DrawButton

@onready var generator: GenerateCard = GenerateCard.new()
@onready var squire: Squire = set_up_squire()
@onready var inventory = $BattleUI/Inventory

func _ready():	
	pass
func _process(delta):
	drawButton.disabled = squire.cardsInHand.size() == squire.maxHandSize
	pass
	
func _on_draw_button_pressed():
	var card = cardScene.instantiate()
	Events.connect("card_droped", self._on_child_signal)
	
	card._ready()
	var generated = generator.generate_card_test()
	card.copyFrom(generated)
	
	squire.addToHand(card)
	handStack.add_child(card)

	print(handStack.get_child_count())  # Check number of children before and after adding
	pass
	
func _on_child_signal(value):
	print("Signal Recieved:" + str(value))
	inventory.equip(value)
	#squire.hero.equip(value)
	pass	

func _on_end_turn_button_pressed():
	squire.discardHand()
	for child in handStack.get_children():
		handStack.remove_child(child)
	pass

func set_up_squire():
	var hero = Hero.new(10, [
		InventorySlot.new(Card.CardType.HELMET),
		InventorySlot.new(Card.CardType.GLOVES),
		InventorySlot.new(Card.CardType.BOOTS)
		])
	return Squire.new(hero, [])	
