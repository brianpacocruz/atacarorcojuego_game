extends StaticBody2D

@onready var damage_area = $DamageArea
@onready var collision = $DamageArea/CollisionShape2D2

signal killed
signal hit

@export var hp := 3
var flagbol := false
var game_over = false

func take_damage(amount):
	if !flagbol:
		# Restar vida
		hp -= amount
		# Muerte
		if hp <= 0 and !game_over:
			game_over = true
			killed.emit()
			die()
		# Daño
		hit.emit(hp)

func die():
	pass
	# $"..".gameover_game()

func stop_detect(is_detect):
	if !is_detect:
		damage_area.monitoring = false
	else:
		damage_area.monitoring = true

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		area.stop()
		take_damage(1)
