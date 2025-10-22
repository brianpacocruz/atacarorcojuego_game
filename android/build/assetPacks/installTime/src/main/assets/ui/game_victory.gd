extends CanvasLayer

@onready var powerups_button = $TextureRect/VBoxContainer/VBoxContainer/PowerupsButton
@onready var powerup_image = $TextureRect/VBoxContainer/PowerupImage

func load_data():
	unbloqued_powerup()

func unbloqued_powerup():
	# Mostrar logo
	if Save.game_data.chapter == 1:
		powerup_image.texture = load("res://assets/ui/HieloDesbloqueada.png")
	elif Save.game_data.chapter == 2:
		powerup_image.texture = load("res://assets/ui/VelocidadDesbloqueada.png")
	elif Save.game_data.chapter == 3:
		powerup_image.texture = load("res://assets/ui/BalaLetalDesbloqueada.png")
	elif Save.game_data.chapter == 4:
		powerup_image.texture = load("res://assets/ui/PalaDesbloqueada.png")
	else:
		powerup_image.hide()
		powerups_button.hide()
	# Nivel
	var chapter = Save.game_data.chapter 
	if Global.chapter == chapter and chapter < 5:
		Save.game_data.chapter += 1
		Global.chapter += 1
		Save.save_data()
		powerups_button.show()
	elif Global.chapter != chapter and chapter < 5:
		Global.chapter += 1
		powerup_image.hide()

func _on_next_button_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_home_button_pressed():
	Global.menu_music.play()
	Global.game_music.stop()
	get_tree().change_scene_to_file("res://ui/menu_inicio.tscn")
	get_tree().paused = false

func _on_powerups_button_pressed():
	get_tree().change_scene_to_file("res://ui/powerups_menu.tscn")
	Global.game_music.stop()
	Global.menu_music.start()
	get_tree().paused = false
