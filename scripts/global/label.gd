extends Label

func _ready():
	adjust_font_size_to_fit()

func adjust_font_size_to_fit():
	var font_size = get_theme_font_size("font", "card_name")
	var font = get_theme_font("font", "card_name")
	# TODO METODO PARA DIMINUIR O TAMANHO DA FONTE QUANDO ELA QUEBRAR

	while font.get_string_size(text).x > size.x and font_size > 1:
		font_size -= 1
		font.set_size(font_size)
		add_theme_font_override("font", font)
