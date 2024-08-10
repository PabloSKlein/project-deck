extends Node

@onready var button_show = $"../ButtonShow"

@onready var color_rect = $ColorRect
@onready var attributes_list = $AttributesList
@onready var status_ui = $"."

var character: Character

# Called when the node enters the scene tree for the first time.
func _ready():
	button_show.visible = true
	attributes_list.visible = false
	status_ui.custom_minimum_size  = Vector2.ZERO
	pass

func _process(delta):
	pass
	
func bind_character(_character):
	character = _character
	update_ui()

func update_ui():
	for child in attributes_list.get_children():
		attributes_list.remove_child(child)
		child.queue_free()
	for attribute in character.attributes:
		var label := Label.new()
		label.text = attribute + " " + str(character.get_attribute(attribute))
		attributes_list.add_child(label)

func _on_button_show_pressed():
	attributes_list.visible = !attributes_list.visible
	if(attributes_list.visible):
		button_show.text = "<<"
		status_ui.custom_minimum_size = Vector2(200,200)
	else:
		button_show.text = ">>"
		status_ui.custom_minimum_size  = Vector2.ZERO
	pass
