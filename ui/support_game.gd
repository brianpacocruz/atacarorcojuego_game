extends CanvasLayer

func _on_button_pressed():
	Global.button_audio.play()
	var url = "https://beacons.ai/challengecompletedarg"
	OS.shell_open(url)
	
func _on_texture_button_pressed():
	hide()
