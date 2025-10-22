extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var polygon = $Polygon2D
@onready var area_damage = $AreaDamage
@onready var duration_timer = $DurationTimer
@onready var damage_timer = $DamageTimer

@export var elixir = 3
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

var screensize = Vector2(720, 1280)

func recoger():
	polygon.scale = Vector2(1.5, 1.5)
	duration_timer.wait_time = power
	duration_timer.start()

func _on_area_damage_area_entered(area):
	if area.is_in_group("enemy"):
		area.take_damage(10)
		damage_timer.start()
		area_damage.set_deferred("monitoring", false)

func _on_duration_timer_timeout():
	# Crear animacion
	var tween = create_tween()
	# Escalar
	tween.tween_property(animated_sprite, "scale", Vector2(.1,.1), .7)
	# Cuando haya lanzadao la señal finished, ejecutar eliminar
	tween.finished.connect(eliminar)

func eliminar():
	queue_free()

func _on_damage_timer_timeout():
	area_damage.monitoring = true
