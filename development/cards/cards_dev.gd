extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var animation_player = $V2/AnimationPlayer
	animation_player.play("new_animation")  # Replace with the name of your animation
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
