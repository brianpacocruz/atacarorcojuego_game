extends Control

@onready var chapter_label = $VBoxContainer/VBoxContainer/LevelLabel
@onready var chapter_img = $VBoxContainer/HBoxContainer/LevelImg
@onready var pre_chapter_button = $VBoxContainer/HBoxContainer/PreChapterButton
@onready var next_chapter_button = $VBoxContainer/HBoxContainer/NextChapterButton
@onready var start_button = $VBoxContainer2/StartButton

var all_chapters = [
	{
		"chapter": 1,
		"texture": "res://assets/ui/LevelImg.png",
	},
	{
		"chapter": 2,
		"texture": "res://assets/ui/LevelImg2.png",
	},
	{
		"chapter": 3,
		"texture": "res://assets/ui/LevelImg3.png",
	},
	{
		"chapter": 4,
		"texture": "res://assets/ui/LevelImg4.png",
	},
	{
		"chapter": 5,
		"texture": "res://assets/ui/LevelImg5.png",
	}
]
var current_chapter = Save.game_data.chapter

func _ready():
#	Save.game_data = {
#	"chapter": 1,
#	"powerups_selected": ["bomba"],
#	"all_powerups": {
#		"bomba" = {
#			"blocked": false,
#			"damage": 40
#		},
#		"hielo" = {
#			"blocked": true,
#			"duration": 5
#		},
#		"fastshoot" = {
#			"blocked": true,
#			"duration": 5
#		},
#		"balaletal" = {
#			"blocked": true,
#			"duration": 5
#		},
#		"pala" = {
#			"blocked": true,
#			"duration": 5
#		}
#	},
#	"highscore": 150
#}
#	Save.game_data.money = 200
#	Save.game_data.powerups_selected = ["bomba"]
#	Save.game_data.chapter = 5
#	Save.save_data()
	get_tree().paused = false
	var chapter = Save.game_data.chapter
	current_chapter = chapter - 1
	match chapter:
		1: chapter_img.texture = load("res://assets/ui/LevelImg.png")
		2: chapter_img.texture = load("res://assets/ui/LevelImg2.png")
		3: chapter_img.texture = load("res://assets/ui/LevelImg3.png")
		4: chapter_img.texture = load("res://assets/ui/LevelImg4.png")
		5: 
			chapter_img.texture = load("res://assets/ui/LevelImg5.png")
	pre_button_disabled()

func _on_start_button_pressed():
	Global.button_audio.play()
	Global.menu_music.stop()
	Global.chapter = all_chapters[current_chapter].chapter
	get_tree().change_scene_to_file("res://scenes/main2.tscn")

func _on_powerup_button_pressed():
	get_tree().change_scene_to_file("res://ui/powerups_menu.tscn")

func pre_button_disabled():
	# Desactivar boton pre
	if current_chapter == 0:
		pre_chapter_button.disabled = true
	else:
		pre_chapter_button.disabled = false
	# Desactivar boton next
	if current_chapter == 4:
		next_chapter_button.disabled = true
	else:
		next_chapter_button.disabled = false
	# Desactivar boton start
	if current_chapter > Save.game_data.chapter - 1:
		start_button.disabled = true
	else:
		start_button.disabled = false
	# Actualizar label
	chapter_label.text = "CAPITULO " + str(current_chapter + 1)

func _on_pre_chapter_button_pressed():
	current_chapter -= 1
	chapter_img.texture = load(all_chapters[current_chapter].texture)
	pre_button_disabled()

func _on_next_chapter_button_pressed():
	current_chapter += 1
	chapter_img.texture = load(all_chapters[current_chapter].texture)
	pre_button_disabled()

func _on_chat_button_pressed():
	$SupportGame.show()
