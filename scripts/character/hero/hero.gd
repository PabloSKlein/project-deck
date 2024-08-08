class_name Hero extends Character

@onready var pop_up_death = preload("res://scenes/pop_up.tscn")
var pop_up: PopUp

func _process(delta):
	var is_dead = is_dead()
	if is_dead:
		show_death_popup()

func show_death_popup():
	self.pop_up = pop_up_death.instantiate()
	add_child(pop_up)
	pop_up.connect("rerun_pressed", self._on_rerun_pressed)
	pop_up.connect("main_menu_pressed", self._on_main_menu_pressed)

func _on_rerun_pressed():
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
