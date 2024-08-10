extends Control

@onready var button_hide = $"../ButtonHide"
@onready var button_show = $"../ButtonShow"

@onready var color_rect = $ColorRect
@onready var attributes_list = $AttributesList

var character: Character

# Called when the node enters the scene tree for the first time.
func _ready():
	button_show.visible = true
	button_hide.visible = false
	color_rect.visible = false
	attributes_list.visible = false
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
	button_show.visible = false
	button_hide.visible = true
	color_rect.visible = true
	attributes_list.visible = true
	pass
	
func _on_button_hide_pressed():
	button_show.visible = true
	button_hide.visible = false
	color_rect.visible = false
	attributes_list.visible = false
	pass
