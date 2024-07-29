extends Node2D

var generator: GenerateCard
var squire: Squire

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Start:")
	
	setUpSquire()
	generator = GenerateCard.new()
	for i in 3:
		squire.addToInventory(generator.generate_card())
		
	squire.draw(3)
	squire.showHand()
	squire.hero.showStatus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func setUpSquire():
	var hero = Hero.new(10, [
		Hero.Slot.new(Card.CardType.HELMET),
		Hero.Slot.new(Card.CardType.GLOVES),
		Hero.Slot.new(Card.CardType.BOOTS)
		])
	squire = Squire.new(hero, [])
