class_name Battle extends Node2D

@onready var hero_scene = preload("res://scenes/hero.tscn")
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var pop_up_death_scene = preload("res://scenes/pop_up_death.tscn")
@onready var pop_up_win_scene = preload("res://scenes/pop_up_win.tscn")

@onready var battle_ui = $BattleUI
@onready var hero_ui = $HeroControl/CharacterUI
@onready var enemy_ui = $EnemyControl/CharacterUI
@onready var squire_ui = $BattleUI/SquireUI
@onready var inventory_ui = $HeroControl/InventoryUI
@onready var enemy_inventory_ui = $EnemyControl/Inventory
@onready var enemy_control = $EnemyControl
@onready var draw_button = $BattleUI/Buttons/DrawButton
@onready var end_turn_button = $BattleUI/Buttons/EndTurnButton
@onready var buttons = $BattleUI/Buttons

var squire : Squire = Squire.new()
var hero : Hero
var enemy : Enemy
var pop_up_death: PopUpDeath
var pop_up_win: PopUpWin

func _ready():
	conect_events()
	
	squire_ui.bind_squire(squire)
	
	self.hero = hero_scene.instantiate()
	hero.set_fields("Hero", 100)
	battle_ui.add_child(hero)
	hero_ui.bind_character(hero)
	inventory_ui.attach_inventory(hero)
		
	self.enemy = enemy_scene.instantiate()
	enemy.set_fields("Enemy", 100)
	battle_ui.add_child(enemy)
	enemy_ui.bind_character(enemy)
	enemy_inventory_ui.attach_inventory(enemy)
	enemy_inventory_ui.invert_text()
	enemy.equip(GenerateCard.new().generate_card())

func _process(delta):
	draw_button.disabled = squire.cards_in_hand.size() == squire.max_hand_size
	check_enemys()
	check_hero()
	pass

func _on_end_turn_button_pressed():
	squire_ui.discard_hand()

	hero.show_status()

	enemy.take_damage(hero.get_attribute("attack"))
	enemy_ui.update()
	if(enemy.is_dead()):
		enemy_control.queue_free()
		return
	hero.take_damage(enemy.get_attribute("attack"))
	hero_ui.update()
	
func _on_draw_button_pressed():
	squire_ui.draw_card()

func _on_child_signal(value):
	hero.equip(value)
	
func _on_rerun_pressed():
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_next_phase_pressed():
	get_tree().reload_current_scene() #TODO add new phases

func show_win_popup():
	buttons.visible = false
	self.pop_up_win = pop_up_win_scene.instantiate()
	add_child(pop_up_win)
	pop_up_win.connect("next_phase", self._on_next_phase_pressed)
	
func show_death_popup():
	buttons.visible = false
	self.pop_up_death = pop_up_death_scene.instantiate()
	add_child(pop_up_death)
	pop_up_death.connect("rerun_pressed", self._on_rerun_pressed)
	pop_up_death.connect("main_menu_pressed", self._on_main_menu_pressed)
	
func check_enemys():
	if enemy_control == null:
		show_win_popup()
		pass #TODO quando nenhum inimigo existir na tela, um pop up de proxima fase deve ser mostrado

func check_hero():
	var is_dead = hero.is_dead()
	if is_dead:
		show_death_popup()
		
func conect_events():
	draw_button.connect("pressed", self._on_draw_button_pressed)
	end_turn_button.connect("pressed", self._on_end_turn_button_pressed)
	Events.connect("card_droped", self._on_child_signal)
