extends CanvasLayer

@onready var highscore_label = $DataContainer/VBoxContainer/HighscoreLabel
@onready var score_label = $DataContainer/VBoxContainer/ScoreLabel


func _on_reset_button_pressed():
	get_tree().reload_current_scene()
	get_tree().set_pause(false)

func _on_home_button_pressed():
	Global.menu_music.play()
	Global.game_music.stop()
	get_tree().change_scene_to_file("res://ui/menu_inicio.tscn")
	get_tree().set_pause(false)

func game_over(highscore, score):
	# Score
	score_label.text = "Score " + str(score)
	# Highscore
		
	if Global.chapter == 5:
		# Si fue highscore, actualizar
		if highscore:
			highscore_label.show()
			Save.game_data.highscore = score
			Save.save_data()
		else:
			highscore_label.text = str(Save.game_data.highscore)
