extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var animation_player1 = $Magic_Draw/AnimationPlayer
	var animation_player2 = $Rare_draw/AnimationPlayer
	var animation_player3 = $Unique_draw/AnimationPlayer
	animation_player1.play("card_flip")  # Replace with the name of your animation
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
