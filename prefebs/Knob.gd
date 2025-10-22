extends Sprite2D

@onready var parent = $".."


var pressing = false

@export var max_length = 50
var deadzone = 15

func _ready():
	# deadzone = parent.deadzone
	# Hacer que el knob vaya al tope del ring
	max_length *= parent.scale.x

func _process(delta):
	if pressing:
		# MOVER KNOB con el mouse
		if get_global_mouse_position().distance_to(parent.global_position) <= max_length:
			global_position = get_global_mouse_position()
		# Mover el knob si el mouse se mueve mientras se presiona
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle)*max_length
			global_position.y = parent.global_position.y + sin(angle)*max_length
		calculateVector()
	# VOLVER AL CENTRO si no se presiona
	else:
		global_position = lerp(global_position, parent.global_position, delta*50)
		parent.posVector = Vector2(0,0)
	# print(parent.posVector.normalized())

# OBTENER DIRECCION: Obtener un vector2 con la posicion a la que tiene que ir el personaje
func calculateVector():
	if abs((global_position.x - parent.global_position.x)) >= deadzone:
		parent.posVector.x = (global_position.x - parent.global_position.x)/max_length
	if abs((global_position.y - parent.global_position.y)) >= deadzone:
		parent.posVector.y = (global_position.y - parent.global_position.y)/max_length

func _on_button_button_down():
	pressing = true
	Global.shoot = true

func _on_button_button_up():
	pressing = false
	Global.shoot = false
