extends Node

@export var enemy_scenes: Array[PackedScene]


@onready var background_texture = $BackgroundTexture

@onready var player = $Player/Player
@onready var player_position = $Player/PlayerPosition
@onready var casa_rosada = $CasaContainer/CasaRosada

@onready var enemy_container = $EnemyContainer
@onready var shoot_container = $ShootContainer
@onready var powerup_container = $PowerupContainer

@onready var hud_ui = $HUD
@onready var pause_ui = $Pause
@onready var game_over_ui = $GameOver
@onready var game_victory = $GameVictory

@onready var enemy_spawn_timer = $Timers/EnemySpawnTimer
@onready var ice_timer = $Timers/IceTimer
@onready var letal_timer = $Timers/LetalTimer
@onready var fastshoot_timer = $Timers/FastShootTimer

var shoot_power := false
var score := 0
var level = Global.chapter
var highscore = false

func _ready():
	get_tree().paused = false
	Global.game_music.play()
	player.global_position = player_position.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	# Cargar mapa y recompensa del enemigo segun nivel
	match level:
		1: 
			background_texture.texture = load("res://assets/maps/Map1.png")
		2: 
			background_texture.texture = load("res://assets/maps/Map2.png")
		3: 
			background_texture.texture = load("res://assets/maps/Map3.png")
		4: 
			background_texture.texture = load("res://assets/maps/Map4.png")
		5: 
			background_texture.texture = load("res://assets/maps/Map5.png")

# INSTANCIAR ENEMIGO
func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 660), -50)
	e.killed.connect(_on_enemy_killed)
	e.hit.connect(_on_enemy_hit)
	enemy_container.add_child(e)

# DISPARO
func _on_player_laser_shot(laser_scene, location):
	Global.shoot_audio.play()
	var shoot = laser_scene.instantiate()
	shoot.global_position = location
	if shoot_power:
		shoot.damage = 9999
	shoot_container.add_child(shoot)

# DAÑO ENEMIGO
func _on_enemy_hit():
	Global.enemy_damage_audio.play()

# MUERTE ENEMIGO
func _on_enemy_killed(points):
	Global.enemy_damage_audio.play()
	# Sumar puntos
	score += points
	hud_ui.enemy_die(score, points)

# -------------------------
# Player
# -------------------------

func _on_casa_rosada_hit(health):
	Global.player_die_audio.play()
	hud_ui.player_damage(health)

func _on_casa_rosada_killed():
	# Validar highscore
	if score > Save.game_data.highscore: 
		Save.game_data.highscore = score
		highscore = true
	Global.player_die_audio.play()
	# Anular disparos
	player.victory_state = false
	player.die()
	hud_ui.hide()
	show_gameover(highscore)

# -------------------------
# UI
# -------------------------

func pause_game():
	pause_ui.show()
	get_tree().set_pause(true)

func show_gameover(is_highscore):
	game_over_ui.game_over(is_highscore, score)
	await get_tree().create_timer(1.5).timeout
	get_tree().set_pause(true)
	game_over_ui.visible = true

func _on_hud_new_chapter():
	for enemy_index in range(enemy_container.get_child_count()):
		var enemy = enemy_container.get_child(enemy_index)
		enemy.die()
	enemy_spawn_timer.stop()
	$Joystick.hide()
	player.set_physics_process(false)
	player.set_process(false)
	await get_tree().create_timer(2.5).timeout
	game_victory.show()
	game_victory.load_data()
	get_tree().paused = true
	if !enemy_spawn_timer.wait_time <= 0.2:
		enemy_spawn_timer.wait_time -= 0.2

# -------------------------
# Powerups
# -------------------------

func _on_hud_powerup_1(powerup):
	var powerup1 = powerup.instantiate()
	# Posicionar
	powerup1.global_position = player.global_position
	powerup_container.add_child(powerup1)
	_on_player_collect(powerup1)
	powerup1.recoger()

func _on_hud_powerup_2(powerup):
	var powerup2 = powerup.instantiate()
	powerup2.global_position = player.global_position
	powerup_container.add_child(powerup2)
	_on_player_collect(powerup2)
	powerup2.recoger()

func _on_hud_powerup_3(powerup):
	var powerup3 = powerup.instantiate()
	powerup3.global_position = player.global_position
	powerup_container.add_child(powerup3)
	_on_player_collect(powerup3)
	powerup3.recoger()

var power

# SABER EL NOMBRE DEL GRUPO 
func _on_player_collect(obj_collected):
	if obj_collected.is_in_group("fastshoot"):
		power = obj_collected.power
		fastshoot_powerup()
	elif obj_collected.is_in_group("hielo"):
		power = obj_collected.power
		hielo_powerup(true)
	elif obj_collected.is_in_group("bomba"):
		power = obj_collected.power
		Global.powerup_audio.play()
	elif obj_collected.is_in_group("pala"):
		power = obj_collected.power
		Global.powerup_audio.play()
	elif obj_collected.is_in_group("letal"):
		power = obj_collected.power
		letal_powerup()

# Metralleta
func fastshoot_powerup():
	Global.powerup_audio.play()
	player.rate_of_fire = 0.05
	fastshoot_timer.wait_time = power
	fastshoot_timer.start()

func _on_fast_shoot_timer_timeout():
	player.rate_of_fire = 0.10

# Letal
func letal_powerup():
	Global.powerup_audio.play()
	letal_timer.wait_time = power
	letal_timer.start()
	shoot_power = true
func _on_letal_timer_timeout():
	shoot_power = false

# Hielo
func hielo_powerup(pause):
	Global.powerup_audio.play()
	for child in enemy_container.get_children():
		if pause:
			child.frozen(false)
			casa_rosada.stop_detect(false)
		else:
			child.frozen(true)
			casa_rosada.stop_detect(true)
	ice_timer.wait_time = power
	ice_timer.start()
func _on_ice_timer_timeout():
	hielo_powerup(false)

# Aumentar enemigos
func _on_increase_enemy_timer_timeout():
	if enemy_spawn_timer.wait_time > 0.1:
		enemy_spawn_timer.wait_time -= 0.1

func _on_hud_new_higscore():
	pass
