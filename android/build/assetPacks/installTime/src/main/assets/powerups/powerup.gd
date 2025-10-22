extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@export var elixir = 2
@export var powerup_name: String
var power

func _ready():
	match Save.game_data.chapter:
		1:
			power = 4
		2:
			power = 4.5
		3:
			power = 5
		4:
			power = 5.5
		5:
			power = 6

func recoger():
	var tween = create_tween()
	tween.tween_property(animated_sprite, "scale", Vector2(.1,.1), .9)
	tween.finished.connect(eliminar)

func eliminar():
	queue_free()
