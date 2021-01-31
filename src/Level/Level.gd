extends Node2D

const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 955
const LIMIT_BOTTOM = 690

func _ready():
	# Get the player, put them at their spawn and set up the camera.
	spawn_players([$PlayerSpawns/Player1of1.position])

func spawn_players(positions):
	var player_scene = load("res://src/Actors/Player.tscn")
	for position in positions:
		var player = player_scene.instance()
		add_child(player)
		player.position = position

func set_camera_limits(player):
	var camera = player.get_node("Camera")
	camera.limit_left = LIMIT_LEFT
	camera.limit_top = LIMIT_TOP
	camera.limit_right = LIMIT_RIGHT
	camera.limit_bottom = LIMIT_BOTTOM
