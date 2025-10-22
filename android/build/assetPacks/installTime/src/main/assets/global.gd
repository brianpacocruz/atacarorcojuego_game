extends Node

@onready var shoot_audio = $ShootAudio
@onready var game_music = $GameMusic
@onready var menu_music = $MenuMusic
@onready var new_level_audio = $NewLevelAudio
@onready var player_damage_audio = $PlayerDamageAudio
@onready var enemy_damage_audio = $EnemyDamageAudio
@onready var rosada_damage_audio = $RosadaDamageAudio
@onready var player_die_audio = $PlayerDieAudio
@onready var enemy_die_audio = $EnemyDieAudio
@onready var button_audio = $ButtonAudio
@onready var powerup_audio = $PowerupAudio

# Arma
@export var velocity_weapon: int
@export var power_weapon: int

var chapter = Save.game_data.chapter
var shoot = false
