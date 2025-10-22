extends Control

@onready var all_powerups_node = $AllPowerups/ScrollContainer/GridContainer
@onready var powerups_container = $AllPowerups/ScrollContainer/GridContainer
@onready var info_powerup = $InfoPowerup

@onready var bomba_select = $AllPowerups/ScrollContainer/GridContainer/PowerupItem/ButtonSkin/Sprite2D
@onready var hielo_select = $AllPowerups/ScrollContainer/GridContainer/PowerupItem2/ButtonSkin/Sprite2D
@onready var fastshoot_select = $AllPowerups/ScrollContainer/GridContainer/PowerupItem3/ButtonSkin/Sprite2D
@onready var balaletal_select = $AllPowerups/ScrollContainer/GridContainer/PowerupItem4/ButtonSkin/Sprite2D
@onready var pala_select = $AllPowerups/ScrollContainer/GridContainer/PowerupItem5/ButtonSkin/Sprite2D

@onready var bomba_button = $AllPowerups/ScrollContainer/GridContainer/PowerupItem/ButtonSkin
@onready var hielo_button = $AllPowerups/ScrollContainer/GridContainer/PowerupItem2/ButtonSkin
@onready var fastshoot_button = $AllPowerups/ScrollContainer/GridContainer/PowerupItem3/ButtonSkin
@onready var balaletal_button = $AllPowerups/ScrollContainer/GridContainer/PowerupItem4/ButtonSkin
@onready var pala_button = $AllPowerups/ScrollContainer/GridContainer/PowerupItem5/ButtonSkin

var all_powerup_selected = Save.game_data.powerups_selected

func _ready():
	# Ver si el powerup esta seleccionado
	for powerup in all_powerup_selected:
		iterate_powerups(powerup, true)
	# Desabilitar powerups bloqueados
	var level = Save.game_data.chapter
	if level < 2:
		hielo_button.texture_normal = load("res://assets/powerups/HieloD.png")
	if level < 3:
		fastshoot_button.texture_normal = load("res://assets/powerups/VelocidadD.png")
	if level < 4:
		balaletal_button.texture_normal = load("res://assets/powerups/BalaLetalD.png")
	if level < 5:
		pala_button.texture_normal = load("res://assets/powerups/PalaD.png")

func iterate_powerups(powerup, selected):
	match powerup:
		"bomba":
			if selected:
				bomba_select.show()
			else:
				bomba_select.hide()
		"hielo":
			if selected:
				hielo_select.show()
			else:
				hielo_select.hide()
		"fastshoot":
			if selected:
				fastshoot_select.show()
			else:
				fastshoot_select.hide()
		"balaletal":
			if selected:
				balaletal_select.show()
			else:
				balaletal_select.hide()
		"pala":
			if selected:
				pala_select.show()
			else:
				pala_select.hide()
			
# VER POWERUP
func _on_button_skin_pressed(type):
	info_powerup.load_data(type)

# CASA
func _on_home_button_pressed():
	Global.button_audio.play()
	get_tree().change_scene_to_file("res://ui/menu_inicio.tscn")
	
func _on_info_powerup_powerup_select(powerup, type):
	iterate_powerups(powerup, type)
