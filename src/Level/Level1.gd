extends BaseLevel

const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 955
const LIMIT_BOTTOM = 690

func _ready():
	var spawn1: Node2D = $PlayerSpawns/Player1of1
	spawn_players([spawn1.position])

func set_camera_limits(player):
	var camera = player.get_node("Camera")
	camera.limit_left = LIMIT_LEFT
	camera.limit_top = LIMIT_TOP
	camera.limit_right = LIMIT_RIGHT
	camera.limit_bottom = LIMIT_BOTTOM
