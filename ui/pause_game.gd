extends CanvasLayer

func _on_reset_button_pressed(): 
	get_tree().reload_current_scene()

func _on_home_button_pressed():
	Global.game_music.stop()
	Global.menu_music.play()
	get_tree().change_scene_to_file("res://ui/menu_inicio.tscn")

func _on_resume_button_pressed():
	Global.button_audio.play()
	hide()
	get_tree().set_pause(false)
