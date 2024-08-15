class_name Battle extends Node2D

@onready var hero_scene = preload("res://scenes/hero.tscn")
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var pop_up_death_scene = preload("res://scenes/pop_up_death.tscn")
@onready var pop_up_win_scene = preload("res://scenes/pop_up_win.tscn")

@onready var battle_ui = $BattleUI
@onready var hero_ui = $CharactersUI/HeroControl/CharacterUI
@onready var enemy_ui = $CharactersUI/EnemyControl/CharacterUI
@onready var squire_ui = $BattleUI/SquireUI
@onready var inventory_ui = $CharactersUI/HeroControl/InventoryUI
@onready var enemy_inventory_ui = $CharactersUI/EnemyControl/Inventory
@onready var enemy_control = $CharactersUI/EnemyControl
@onready var draw_button = $BattleUI/Buttons/DrawButton
@onready var end_turn_button = $BattleUI/Buttons/EndTurnButton
@onready var buttons = $BattleUI/Buttons

var compare_ui
var squire : Squire = Squire.new()
var hero : Hero
var enemy : Enemy
var pop_up_death: PopUpDeath
var pop_up_win: PopUpWin
var rng = RandomNumberGenerator.new()
var is_battle_active = false

func _ready():
	conect_events()
	hero_setup()
	enemy_setup(Enemy.EnemyType.NORMAL)
	squire.hero = hero
	squire_ui.bind_squire(squire)

func _process(delta):
	draw_button.disabled = squire.cards_in_hand.size() == squire.max_hand_size
	check_enemys()
	check_hero()
	pass

func _on_end_turn_button_pressed():
	is_battle_active = true
	end_turn_button.disabled = true
	start_battle()
	squire_ui.discard_hand()
	hero.show_status()
	
func start_battle():
	while is_battle_active:
		buttons.hide()
		if hero.health > 0 and enemy.health > 0:
			enemy.take_damage(hero.get_attack())
			enemy_ui.update()
			await get_tree().create_timer(0.5).timeout
			if enemy.health > 0:
				hero.take_damage(enemy.get_attack())
				hero_ui.update()
				await get_tree().create_timer(0.5).timeout
		else:
			is_battle_active = false
			enemy_control.queue_free()
			end_battle()
	
func end_battle():
	buttons.show()
	if hero.health <= 0:
		print("Hero is defeated!")
	elif enemy.health <= 0:
		print("Enemy is defeated!")
	end_turn_button.disabled = false
		
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


func hero_setup():
	self.hero = hero_scene.instantiate()
	hero.set_fields("Hero", 100)
	battle_ui.add_child(hero)
	hero_ui.bind_character(hero)
	inventory_ui.attach_inventory(hero)

func enemy_setup(enemy_type: Enemy.EnemyType = Enemy.EnemyType.NORMAL):
	self.enemy = enemy_scene.instantiate()
	self.enemy._init(enemy_type)
	enemy.set_fields("Enemy", 100)
	battle_ui.add_child(enemy)
	enemy_ui.bind_character(enemy)
	enemy_inventory_ui.attach_inventory(enemy)
	enemy_inventory_ui.invert_text()
	
	var min_equip: int
	var max_equip: int

	match enemy_type:
		Enemy.EnemyType.NORMAL:
			min_equip = 1
			max_equip = 3
		Enemy.EnemyType.ELITE:
			min_equip = 3
			max_equip = 6
		Enemy.EnemyType.BOSS:
			min_equip = 6
			max_equip = 10

	var item_equip = rng.randi_range(min_equip, max_equip)
	
	for i in range(item_equip):
		var gen_card = MountCard.new().generate_card()
		enemy.equip(gen_card)
