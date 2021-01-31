class_name BaseLevel
extends Node2D

func spawn_players(positions):
	var player_scene = load("res://src/Actors/Player.tscn")
	for position in positions:
		var player = player_scene.instance()
		add_child(player)
		player.position = position
		set_camera_limits(player)

func set_camera_limits(_player):
	print("set_camera_limits should be overidden.")
