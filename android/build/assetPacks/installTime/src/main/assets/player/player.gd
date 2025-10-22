class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal killed
signal hit
signal collect

@onready var spawn_shoot = $SpawnShoot
@onready var collision = $CollisionShape2D
@onready var anim = $AnimatedSprite2D


# Jugador
@export var SPEED = 400.0
@export var rate_of_fire := 0.10 # tiempo entre disparo
@export var hp := 3

var direction := Vector2()

var laser_scene = preload("res://weapons/weapon.tscn")
var const_shoot := false
var victory_state = true
var died := false

func _process(_delta):
	# Disparo
	if victory_state:
		if Global.shoot or Input.is_action_pressed("shoot"):
			# DISPARO CONSTANTE
			if !const_shoot:
				# Para evitar que dispare todo el tiempo
				const_shoot = true 
				# CARGAR BALA por señal, pasando la escena y la posicion
				shoot() 
				# TIEMPO DE ESPERA ENTRE BALAS
				await get_tree().create_timer(rate_of_fire).timeout #Tiempo entre disparo
				# Perimitir otra bala
				const_shoot = false
	# Animacion
	if !died and direction.length() > 0:
		anim.play("walk")
		if direction.x != 0:
			anim.flip_h = direction.x < 0
	elif !died:
		anim.play("idle")

func _physics_process(_delta):
	# Controles
	if victory_state: 
		direction = $"../../Joystick".posVector
		# direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		# Mover
		velocity = direction * SPEED
		move_and_slide()
		# global_position = global_position.clamp(Vector2(10,10), get_viewport_rect().size)

func die():
	died = true
	anim.play("die")
	victory_state = false
	set_physics_process(false)

func shoot():
	laser_shot.emit(laser_scene, spawn_shoot.global_position)
