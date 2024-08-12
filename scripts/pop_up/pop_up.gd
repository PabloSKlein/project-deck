class_name PopUp
extends Node2D

signal closed

func _ready():
	pass

func show_popup():
	self.visible = true

func hide_popup():
	self.visible = false
	emit_signal("closed")
