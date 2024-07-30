extends Node2D

@onready var cardScene: PackedScene = preload("res://Scenes/Card.tscn")
@onready var handStack : HBoxContainer = $BattleUI/HandHStack

var generator: GenerateCard
var squire: Squire

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Start:")
	
	set_up_squire()
	generator = GenerateCard.new()
	for i in 3:
		squire.addToInventory(generator.generate_card(Card.CardType.HELMET))
		
	squire.draw(3)
	squire.showHand()
	squire.hero.showStatus()
	squire.equipFromHand(0, 0)
	squire.hero.showStatus()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_draw_button_pressed():
	var card = cardScene.instantiate()
	card._ready()
	var generated = generator.generate_card(Card.CardType.HELMET)
	card.copyFrom(generated)
	handStack.add_child(card)
	pass # Replace with function body.

func set_up_squire():
	var hero = Hero.new(10, [
		Hero.Slot.new(Card.CardType.HELMET),
		Hero.Slot.new(Card.CardType.GLOVES),
		Hero.Slot.new(Card.CardType.BOOTS)
		])
	squire = Squire.new(hero, [])	
