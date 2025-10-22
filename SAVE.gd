extends Node

const SAVEFILE = "user://SAVEFILE.save"

# Esto se leera solo cuando no existe el archivo, para que lo lea debido a que pusiste una nueva llave, debemos iterar y compararlo con lo datos guardados y actualizar los datos guardados
var game_data = {
	"chapter": 1,
	"powerups_selected": ["bomba"],
	"all_powerups": {
		"bomba" = {
			"damage": 40
		},
		"hielo" = {
			"duration": 4
		},
		"fastshoot" = {
			"duration": 4
		},
		"balaletal" = {
			"duration": 4
		},
		"pala" = {
			"duration": 4
		}
	},
	"highscore": 2800
}

func _ready():
	
	load_data()

func load_data():
	# Abrir SAVEFILE
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	# Si no existe el archivo
	if file == null:
		# Crear archivo y guardar
		save_data()
	# Si existe
	else:
		# Actualizar game_data para su uso
		var data_saved = file.get_var()
		# Iterar por el diccionario
		for data in game_data.keys():
			# Si la key de game_data no se encuentra en el data saved, osea el game data tiene mas keys o uno nuevo
			if !data_saved.keys().has(data):
				# Colocar esa key por el del game_data
				data_saved[data] = game_data[data]
			# !!! Nueva key en game data
			# !!! Key eliminado de game data
			# !!! Ver si hay una nueva key en cada powerup
			# !!! Ver si se elimino una key en cada powerup en game_data
		# igualar game_data por data_saved
		game_data = data_saved
	# Guardar datos
	save_data()
	# Cerrar archivo
	file = null

func save_data():
	# Abrir archivo o crear si no existe
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	# Guardar datos del game_data
	file.store_var(game_data)
	# Cerrar archivo
	file = null
