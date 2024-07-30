class_name Hand
extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		var card_ui := child as Card
		#ESSE CARA AQUI EM BAIXO NAO ESTA FUNCIONANDO NAO SEI PQ, SE QUISER REFERENCIA PARA O VIDEO É ESSE https://www.youtube.com/watch?v=Pa0P1lUoC-M&t=2097s
		#card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_card_ui_reparent_requested(child: Card) -> void:
	child.reparent(self)
