extends Area2D

var SPEED = 600

@export var damage: int
@export var velocity: int
@export var area_damage: bool

# PHYSICS: MOVIMIENTO
func _physics_process(delta):
	global_position.y += -SPEED * delta

# SCREEN EXITED: ELIMINAR
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# COLISION: DAÑO, ejecutar la funcion del area entrante - MUERTE
func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.take_damage(damage) 
		queue_free()
