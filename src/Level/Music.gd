extends AudioStreamPlayer

# Do not change. Represents doubling of sound pressure.
const DOUBLE_VOLUME_DB = 6

export(int) var base_volume_db = -4
export(int) var step_volume_db = 1

func _ready():
	# To avoid AudioStreamPlayer2D sounds playing on top of each other and
	# being very loud, let's decrease the volume for splitscreen mode, but
	# increase the music volume to keep the music at the same volume.
	if _is_splitscreen():
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), base_volume_db - DOUBLE_VOLUME_DB)
		volume_db = DOUBLE_VOLUME_DB
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), base_volume_db)
		volume_db = 0

# GUI event
func _process(_delta):
	if Input.is_action_just_pressed("volume_down"):
		volume_db -= step_volume_db
	elif Input.is_action_just_pressed("volume_up"):
		volume_db += step_volume_db

# This detects if the game is in splitscreen mode or node.
# Not robust but it should get us through the jam.
func _is_splitscreen():
	var parent: Node = get_parent()
	var owner: Node = parent.get_owner()
	if owner:
		return owner.name == "Splitscreen"
	while parent:
		parent = parent.get_parent()
		if parent.name == "Splitscreen":
			return true
		elif parent.name == "Game":
			return false
	return false
