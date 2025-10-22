extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@export var elixir = 2
@export var powerup_name: String



func recoger():
	# Crear animacion
	var tween = create_tween()
	# Escalar
	tween.tween_property(animated_sprite, "scale", Vector2(.1,.1), .9)
	# Cuando haya lanzadao la señal finished, ejecutar eliminar
	tween.finished.connect(eliminar)

func eliminar():
	queue_free()
