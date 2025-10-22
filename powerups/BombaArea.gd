extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var area_damage = $AreaDamage
@onready var life_timer = $LifeTimer

@export var elixir = 1
@export var powerup_name: String

var power
func _ready():
	match Save.game_data.chapter:
		1:
			power = 20
		2:
			power = 30
		3:
			power = 40
		4:
			power = 50
		5:
			power = 60

func recoger():
	# Crear animacion
	var tween = create_tween()
	# Escalar
	tween.tween_property(animated_sprite, "scale", Vector2(.1,.1), .9)
	# Cuando haya lanzadao la señal finished, ejecutar eliminar
	tween.finished.connect(eliminar)

func eliminar():
	life_timer.start()

func _on_area_damage_area_entered(area):
	if area.is_in_group("enemy"):
		area.take_damage(power)

func _on_life_timer_timeout():
	queue_free()
