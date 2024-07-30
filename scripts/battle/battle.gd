extends Node2D

@onready var cardScene: PackedScene = preload("res://Scenes/Card.tscn")

@onready var handStack : HBoxContainer = $BattleUI/HandHStack
@onready var drawButton : Button = $BattleUI/DrawButton

@onready var generator: GenerateCard = GenerateCard.new()
@onready var squire: Squire = set_up_squire()

func _ready():
	
	pass

func _process(delta):
	drawButton.disabled = squire.cardsInHand.size() == squire.maxHandSize
	pass
	
func _on_draw_button_pressed():
	var card = cardScene.instantiate()
	card._ready()
	var generated = generator.generate_card(Card.CardType.HELMET)
	card.copyFrom(generated)
	
	squire.addToHand(card)
	pass

func _on_end_turn_button_pressed():
	squire.discardHand()
	pass

func set_up_squire():
	var hero = Hero.new(10, [
		Hero.Slot.new(Card.CardType.HELMET),
		Hero.Slot.new(Card.CardType.GLOVES),
		Hero.Slot.new(Card.CardType.BOOTS)
		])
	return Squire.new(hero, [], handStack)	
