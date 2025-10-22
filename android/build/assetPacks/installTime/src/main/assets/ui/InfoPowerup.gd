extends CanvasLayer

# Powerup info
@onready var powerup_name = $PowerupData/PowerupName
@onready var powerup_description = $PowerupData/PowerupDescription
@onready var powerup_elixir = $PowerupData/PowerupElixir
@onready var select_button = $PowerupData/SelectButton
@onready var powerup_image = $PowerupImage

var powerup_selected: String
var all_powerup_selected = Save.game_data.powerups_selected
var all_powerups = Save.game_data.all_powerups
var blocked = false
var blocked_chapter: int

signal powerup_select(powerup, type)

func load_data(type):
	show()
	var chapter = Save.game_data.chapter
	# Editar el powerup info
	if type == "bomba":
		powerup_name.text = "Bomba"
		powerup_description.text = "Daña a todos los orcos que esten en el area de explosion"
		powerup_elixir.text = "COSTO DE ELIXIR: 2"
		powerup_selected = "bomba"
		if chapter >= 1:
			blocked = false
		else:
			blocked = true
			blocked_chapter = 1
		powerup_image.texture = load("res://assets/powerups/BombaInfo.png")
	elif type == "hielo":
		powerup_name.text = "Hielo"
		powerup_description.text = "Congela a todos los orcos que se encuentran en el mapa"
		powerup_elixir.text = "COSTO DE ELIXIR: 1"
		powerup_selected = "hielo"
		if chapter >= 2:
			blocked = false
		else:
			blocked = true
			blocked_chapter = 2
		powerup_image.texture = load("res://assets/powerups/HieloInfo.png")
	elif type == "fastshoot":
		powerup_name.text = "Velocidad"
		powerup_description.text = "Aumenta la velocidad de disparo para convertir en colador a los orcos"
		powerup_elixir.text = "COSTO DE ELIXIR: 1"
		powerup_selected = "fastshoot"
		if chapter >= 3:
			blocked = false
		else:
			blocked = true
			blocked_chapter = 3
		powerup_image.texture = load("res://assets/powerups/VelocidadInfo.png")
	elif type == "balaletal":
		powerup_name.text = "Bala Letal"
		powerup_description.text = "Elimina a cualqpowerupser orco de un disparo, limpio y sin dolor"
		powerup_elixir.text = "COSTO DE ELIXIR: 2"
		powerup_selected = "balaletal"
		if chapter >= 4:
			blocked = false
		else:
			blocked = true
			blocked_chapter = 4
		powerup_image.texture = load("res://assets/powerups/BombaInfo.png")
	elif type == "pala":
		powerup_name.text = "Pala"
		powerup_description.text = "Dañara lentamente a los orcos que esten en la zona de la pala"
		powerup_elixir.text = "COSTO DE ELIXIR: 3"
		powerup_selected = "pala"
		if chapter >= 5:
			blocked = false
		else:
			blocked = true
			blocked_chapter = 5
		powerup_image.texture = load("res://assets/powerups/PalaInfo.png")
	select_button.text = "USAR"
	select_button.disabled = false
	# Sera quitar cuando se encuentre en la lista
	if blocked:
		select_button.disabled = true
		select_button.text = "CAPITULO " + str(blocked_chapter)
	elif all_powerup_selected.find(powerup_selected) != -1:
		select_button.text = "QUITAR"
	# Estara desabilitado cuando se haya alcanzado el limite de 3, y no sea quitar
	elif all_powerup_selected.size() >= 3:
		select_button.disabled = true

# Cerrar ventana
func _on_texture_button_pressed():
	hide()

# Seleccionar
func _on_select_button_pressed():
	if select_button.text == "USAR":
		all_powerup_selected.append(powerup_selected)
		select_button.text = "QUITAR"
		powerup_select.emit(powerup_selected, true)
	else:
		all_powerup_selected.erase(powerup_selected)
		select_button.text = "USAR"
		powerup_select.emit(powerup_selected, false)
	Save.game_data.powerups_selected = all_powerup_selected
	Save.save_data()
