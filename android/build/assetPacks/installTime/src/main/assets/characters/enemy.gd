#  class_name Enemy 
extends Area2D

signal killed(points)
signal hit

@onready var anim = $AnimatedSprite2D
@onready var progress_bar = $ProgressBar

@export var SPEED = 200
@export var hp = 3 # Vidas
@export var points = 1 # Puntos 
@export var enemy_name: int
@export var damage = 1

@onready var flagbol_timer = $FlagbolTimer
@onready var collision = $CollisionShape2D

# var level = Save.game_data.level
var die_enemy := false

var levels_1 = {
	"normal": {
		"hp": 30,
		"damage": 1,
		"anim": "res://characters/sprites/normal_sprite_level_1.tres",
		"points": 15 
	},
	"fuerte": {
		"hp": 40,
		"damage": 4,
		"anim": "res://characters/sprites/fuerte_sprite_level_1.tres",
		"points": 20
	},
	"agil": {
		"hp": 20,
		"damage": 4,
		"anim": "res://characters/sprites/agil_sprite_level_1.tres",
		"points": 10
	}
}
var levels_2 = {
	"normal": {
		"hp": 40,
		"damage": 2,
		"anim": "res://characters/sprites/normal_sprite_level_2.tres",
		"points": 25
	},
	"fuerte": {
		"hp": 50,
		"damage": 6,
		"anim": "res://characters/sprites/fuerte_sprite_level_2.tres",
		"points": 30
	},
	"agil": {
		"hp": 30,
		"damage": 4,
		"anim": "res://characters/sprites/agil_sprite_level_2.tres",
		"points": 20
	}
}
var levels_3 = {
	"normal": {
		"hp": 50,
		"damage": 3,
		"anim": "res://characters/sprites/normal_sprite_level_3.tres",
		"points": 35
	},
	"fuerte": {
		"hp": 60,
		"damage": 1,
		"anim": "res://characters/sprites/fuerte_sprite_level_3.tres",
		"points": 40
	},
	"agil": {
		"hp": 40,
		"damage": 4,
		"anim": "res://characters/sprites/agil_sprite_level_3.tres",
		"points": 30
	}
}
var levels_4 = {
	"normal": {
		"hp": 60,
		"damage": 4,
		"anim": "res://characters/sprites/normal_sprite_level_4.tres",
		"points": 45
	},
	"fuerte": {
		"hp": 70,
		"damage": 1,
		"anim": "res://characters/sprites/fuerte_sprite_level_4.tres",
		"points": 50
	},
	"agil": {
		"hp": 50,
		"damage": 4,
		"anim": "res://characters/sprites/agil_sprite_level_4.tres",
		"points": 40
	}
}
var levels_5 = {
	"normal": {
		"hp": 70,
		"damage": 4,
		"anim": "res://characters/sprites/normal_sprite_level_5.tres",
		"points": 55
	},
	"fuerte": {
		"hp": 80,
		"damage": 1,
		"anim": "res://characters/sprites/fuerte_sprite_level_5.tres",
		"points": 60
	},
	"agil": {
		"hp": 60,
		"damage": 4,
		"anim": "res://characters/sprites/agil_sprite_level_5.tres",
		"points": 50
	}
}

func _ready():
	var chapter = Global.chapter
	if enemy_name == 1:
		match chapter:
			1:
				data_level(levels_1.normal.anim, levels_1.normal.hp, levels_1.normal.damage, levels_1.normal.points)
			2:
				data_level(levels_2.normal.anim, levels_2.normal.hp, levels_2.normal.damage, levels_2.normal.points)
			3:
				data_level(levels_3.normal.anim, levels_3.normal.hp, levels_3.normal.damage, levels_3.normal.points)
			4:
				data_level(levels_4.normal.anim, levels_4.normal.hp, levels_4.normal.damage, levels_4.normal.points)
			5:
				data_level(levels_5.normal.anim, levels_5.normal.hp, levels_5.normal.damage, levels_5.normal.points)
	# Orco Fuerte
	elif enemy_name == 2:
		match chapter:
			1:
				data_level(levels_1.fuerte.anim, levels_1.fuerte.hp, levels_1.fuerte.damage, levels_1.fuerte.points)
			2:
				data_level(levels_2.fuerte.anim, levels_2.fuerte.hp, levels_2.fuerte.damage, levels_2.fuerte.points)
			3:
				data_level(levels_3.fuerte.anim, levels_3.fuerte.hp, levels_3.fuerte.damage, levels_3.fuerte.points)
			4:
				data_level(levels_4.fuerte.anim, levels_4.fuerte.hp, levels_4.fuerte.damage, levels_4.fuerte.points)
			5:
				data_level(levels_5.fuerte.anim, levels_5.fuerte.hp, levels_5.fuerte.damage, levels_5.fuerte.points)
	# Orco agil
	elif enemy_name == 3:
		match chapter:
			1:
				data_level(levels_1.agil.anim, levels_1.agil.hp, levels_1.agil.damage, levels_1.agil.points)
			2:
				data_level(levels_2.agil.anim, levels_2.agil.hp, levels_2.agil.damage, levels_2.agil.points)
			3:
				data_level(levels_3.agil.anim, levels_3.agil.hp, levels_3.agil.damage, levels_3.agil.points)
			4:
				data_level(levels_4.agil.anim, levels_4.agil.hp, levels_4.agil.damage, levels_4.agil.points)
			5:
				data_level(levels_5.agil.anim, levels_5.agil.hp, levels_5.agil.damage, levels_5.agil.points)

# PHYSICS: MOVIMIENTO
func _physics_process(delta):
	global_position.y += SPEED * delta

# MUERTE
func die():
	set_physics_process(false)
	anim.play("die")
	await anim.animation_finished
	queue_free()

func frozen(is_frozen):
	if !is_frozen:
		set_process(false)
		set_physics_process(false)
		anim.pause()
	else:
		set_process(true)
		set_physics_process(true)
		anim.play()

# PELEAR
func stop():
	if !die_enemy:
		set_physics_process(false)
		flagbol_timer.start()
		anim.play("fight")

# DAÑO
var count_damage = 0
func take_damage(amount):
	count_damage += 1
	# Restar vida
	hp -= amount
	progress_bar.show()
	progress_bar.value -= amount
	# Muerte
	if !die_enemy and hp <= 0:
		die_enemy = true
		killed.emit(points)
		die()
	# Emitir sonidos 
	hit.emit()

func _on_flagbol_timer_timeout():
	collision.disabled = true
	collision.disabled = false

# Cargar datos
func data_level(anim_level, hp_level, damage_level, points_level):
	progress_bar.max_value = hp_level
	progress_bar.value = hp_level
	anim.sprite_frames = load(anim_level)
	anim.play("walk")
	hp = hp_level
	damage = damage_level
	points = points_level

