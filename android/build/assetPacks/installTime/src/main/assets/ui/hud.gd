extends CanvasLayer

@onready var elixir_bar = $HBoxContainer2/ElixirBar
@onready var elixir_label = $HBoxContainer2/ElixirBar/Label
@onready var health_label = $HBoxContainer/HealthLabel
@onready var progress_bar = $HBoxContainer/ProgressBar
@onready var value_progress_bar = $HBoxContainer/ProgressBar/ValueProgressBar

@onready var powerup_button = $HBoxContainer2/PowerupButton
@onready var powerup_button2 = $HBoxContainer2/PowerupButton2
@onready var powerup_button3 = $HBoxContainer2/PowerupButton3

@onready var elixir_powerup = $ElixirLabel
@onready var elixir_powerup2 = $ElixirLabel2
@onready var elixir_powerup3 = $ElixirLabel3

#@onready var player_health_bar = $VBoxContainer/HBoxContainer/HealthPlayer/PlayerHealthBar
#@onready var rosada_health_bar = $VBoxContainer/HBoxContainer/HealthPlayer2/RosadaHealthBar

signal new_chapter
signal new_higscore
signal powerup1
signal powerup2
signal powerup3

# ABSORVER CAMBIOS AUTOMATICOS
var elixir := 0
var chapter := 1
var start_infinite = false
var infinite_game = false
var win_game = false
var progress_score := 0
var multiplicate_score := 1

var Powerup1
var Powerup2 
var Powerup3
var powerup1_scene
var powerup2_scene
var powerup3_scene
var powerups_selected: Array

func _ready():
	# Cargar progress max value
	match Global.chapter:
		1: 
			print(progress_bar.max_value)
			progress_bar.max_value = 1600
			value_progress_bar.text =  "0/" + str(1600)
		2: 
			progress_bar.max_value = 1900
			value_progress_bar.text = "0/" + str(1900)
		3: 
			progress_bar.max_value = 2200
			value_progress_bar.text = "0/" + str(2200)
		4: 
			progress_bar.max_value = 2500
			value_progress_bar.text = "0/" + str(2500)
		5: 
			progress_bar.max_value = Save.game_data.highscore
			value_progress_bar.text = "0/" + str(Save.game_data.highscore)
			infinite_game = true
	# Cargar tarjetas powerup
	powerups_selected = Save.game_data.powerups_selected
	for powerup in powerups_selected:
		match powerup:
			"bomba":
				if !Powerup3:
					Powerup3 = preload("res://powerups/powerup3.tscn")
					powerup3_scene = Powerup3.instantiate()
					elixir_powerup3.text = str(powerup3_scene.elixir)
					powerup_button3.texture_normal = load("res://assets/powerups/Bomba.png")
					powerup_button3.texture_disabled = load("res://assets/powerups/BombaD.png")
					elixir_powerup3.show()
				elif !Powerup2:
					Powerup2 = preload("res://powerups/powerup3.tscn")
					powerup2_scene = Powerup2.instantiate()
					elixir_powerup2.text = str(powerup2_scene.elixir)
					powerup_button2.texture_normal = load("res://assets/powerups/Bomba.png")
					powerup_button2.texture_disabled = load("res://assets/powerups/BombaD.png")
					elixir_powerup2.show()
				elif !Powerup1:
					Powerup1 = preload("res://powerups/powerup3.tscn")
					powerup1_scene = Powerup1.instantiate()
					elixir_powerup.text = str(powerup1_scene.elixir)
					powerup_button.texture_normal = load("res://assets/powerups/Bomba.png")
					powerup_button.texture_disabled = load("res://assets/powerups/BombaD.png")
					elixir_powerup.show()
			"hielo":
				if !Powerup3:
					Powerup3 = preload("res://powerups/powerup2.tscn")
					powerup3_scene = Powerup3.instantiate()
					elixir_powerup3.text = str(powerup3_scene.elixir)
					powerup_button3.texture_normal = load("res://assets/powerups/Hielo.png")
					powerup_button3.texture_disabled = load("res://assets/powerups/HieloD.png")
					elixir_powerup3.show()
				elif !Powerup2:
					Powerup2 = preload("res://powerups/powerup2.tscn")
					powerup2_scene = Powerup2.instantiate()
					elixir_powerup2.text = str(powerup2_scene.elixir)
					powerup_button2.texture_normal = load("res://assets/powerups/Hielo.png")
					powerup_button2.texture_disabled = load("res://assets/powerups/HieloD.png")
					elixir_powerup2.show()
				elif !Powerup1:
					Powerup1 = preload("res://powerups/powerup2.tscn")
					powerup1_scene = Powerup1.instantiate()
					elixir_powerup.text = str(powerup1_scene.elixir)
					powerup_button.texture_normal = load("res://assets/powerups/Hielo.png")
					powerup_button.texture_disabled = load("res://assets/powerups/HieloD.png")
					elixir_powerup.show()
			"fastshoot":
				if !Powerup3:
					Powerup3 = preload("res://powerups/powerup.tscn")
					powerup3_scene = Powerup3.instantiate()
					elixir_powerup3.text = str(powerup3_scene.elixir)
					powerup_button3.texture_normal = load("res://assets/powerups/Velocidad.png")
					powerup_button3.texture_disabled = load("res://assets/powerups/VelocidadD.png")
					elixir_powerup3.show()
				elif !Powerup2:
					Powerup2 = preload("res://powerups/powerup.tscn")
					powerup2_scene = Powerup2.instantiate()
					elixir_powerup2.text = str(powerup2_scene.elixir)
					powerup_button2.texture_normal = load("res://assets/powerups/Velocidad.png")
					powerup_button2.texture_disabled = load("res://assets/powerups/VelocidadD.png")
					elixir_powerup2.show()
				elif !Powerup1:
					Powerup1 = preload("res://powerups/powerup.tscn")
					powerup1_scene = Powerup1.instantiate()
					elixir_powerup.text = str(powerup1_scene.elixir)
					powerup_button.texture_normal = load("res://assets/powerups/Velocidad.png")
					powerup_button.texture_disabled = load("res://assets/powerups/VelocidadD.png")
					elixir_powerup.show()
			"balaletal":
				if !Powerup3:
					Powerup3 = preload("res://powerups/powerup4.tscn")
					powerup3_scene = Powerup3.instantiate()
					elixir_powerup3.text = str(powerup3_scene.elixir)
					powerup_button3.texture_normal = load("res://assets/powerups/BalaLetal.png")
					powerup_button3.texture_disabled = load("res://assets/powerups/BalaLetalD.png")
					elixir_powerup3.show()
				elif !Powerup2:
					Powerup2 = preload("res://powerups/powerup4.tscn")
					powerup2_scene = Powerup2.instantiate()
					elixir_powerup2.text = str(powerup2_scene.elixir)
					powerup_button2.texture_normal = load("res://assets/powerups/BalaLetal.png")
					powerup_button2.texture_disabled = load("res://assets/powerups/BalaLetalD.png")
					elixir_powerup2.show()
				elif !Powerup1:
					Powerup1 = preload("res://powerups/powerup4.tscn")
					powerup1_scene = Powerup1.instantiate()
					elixir_powerup.text = str(powerup1_scene.elixir)
					powerup_button.texture_normal = load("res://assets/powerups/BalaLetal.png")
					powerup_button.texture_disabled = load("res://assets/powerups/BalaLetalD.png")
					elixir_powerup.show()
			"pala":
				if !Powerup3:
					Powerup3 = preload("res://powerups/powerup5.tscn")
					powerup3_scene = Powerup3.instantiate()
					elixir_powerup3.text = str(powerup3_scene.elixir)
					powerup_button3.texture_normal = load("res://assets/powerups/Pala.png")
					powerup_button3.texture_disabled = load("res://assets/powerups/PalaD.png")
					elixir_powerup3.show()
				elif !Powerup2:
					Powerup2 = preload("res://powerups/powerup5.tscn")
					powerup2_scene = Powerup2.instantiate()
					elixir_powerup2.text = str(powerup2_scene.elixir)
					powerup_button2.texture_normal = load("res://assets/powerups/Pala.png")
					powerup_button2.texture_disabled = load("res://assets/powerups/PalaD.png")
					elixir_powerup2.show()
				elif !Powerup1:
					Powerup1 = preload("res://powerups/powerup5.tscn")
					powerup1_scene = Powerup1.instantiate()
					elixir_powerup.text = str(powerup1_scene.elixir)
					powerup_button.texture_normal = load("res://assets/powerups/Pala.png")
					powerup_button.texture_disabled = load("res://assets/powerups/PalaD.png")
					elixir_powerup.show()
	# Desabilitar los botones donde no hay un powerup
	if powerups_selected.size() == 2:
		powerup_button.disabled = true
	elif powerups_selected.size() == 1:
		powerup_button.disabled = true
		powerup_button2.disabled = true
	
func player_damage(health):
	health_label.text = str(health)

func _on_pause_button_pressed():
	$"..".pause_game()

# Muerte de un enemigo
func enemy_die(score, points):
	# Actualizar progress var
	if !start_infinite:
		progress_bar.value += points
		value_progress_bar.text = str(score) + "/" + str(progress_bar.max_value * multiplicate_score)
	# Nuevo nivel
	if !win_game and Global.chapter != 5 and progress_bar.value == progress_bar.max_value:
		# Evitar que se ejecute 2 veces
		win_game = true
		# Moneda
		new_chapter.emit()
		hide()
	if infinite_game and progress_bar.value == progress_bar.max_value:
		progress_bar.get("theme_override_styles/fill").set("bg_color", Color(1, 0.88, 0, 1))
		multiplicate_score += 1
		progress_bar.value = 0
		new_higscore.emit()

func _on_powerup_button_pressed():
	powerup1.emit(Powerup1)
	rest_elixir(powerup1_scene.elixir)
	
func _on_powerup_button_2_pressed():
	powerup2.emit(Powerup2)
	rest_elixir(powerup2_scene.elixir)

func _on_powerup_button_3_pressed():
	powerup3.emit(Powerup3)
	rest_elixir(powerup3_scene.elixir)

func _on_elixir_timer_timeout():
	if elixir_bar.value == 1:
		elixir_bar.value = 0
		elixir += 1
		elixir_label.text = str(elixir)
		enabled_buttons()
	else:
		elixir_bar.value += .10
		
func rest_elixir(value):
	elixir -= value
	elixir_label.text = str(elixir)
	disabled_buttons()

func disabled_buttons():
	if powerup1_scene and powerup1_scene.elixir > elixir:
		powerup_button.disabled = true
	if powerup2_scene and powerup2_scene.elixir > elixir:
		powerup_button2.disabled = true
	if powerup3_scene and powerup3_scene.elixir > elixir:
		powerup_button3.disabled = true

func enabled_buttons():
	if powerup1_scene and powerup1_scene.elixir <= elixir:
		powerup_button.disabled = false
	if powerup2_scene and powerup2_scene.elixir <= elixir:
		powerup_button2.disabled = false
	if powerup3_scene and powerup3_scene.elixir <= elixir:
		powerup_button3.disabled = false
