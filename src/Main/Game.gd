extends Node
# This class contains controls that should always be accessible, like pausing
# the game or toggling the window full-screen.


# The "_" prefix is a convention to indicate that variables are private,
# that is to say, another node or script should not access them.
onready var _pause_menu = $InterfaceLayer/PauseMenu
# Maybe the start menu should be its own scene.
onready var _start_menu = $InterfaceLayer/StartMenu
var _waiting_to_start = true


func _init():
	OS.min_window_size = OS.window_size
	OS.max_window_size = OS.get_screen_size()


func _ready():
	get_tree().paused = true
	_start_menu.open()


func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		# We need to clean up a little bit first to avoid Viewport errors.
		if name == "Splitscreen":
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()


func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()
	# The GlobalControls node, in the Stage scene, is set to process even
	# when the game is paused, so this code keeps running.
	# To see that, select GlobalControls, and scroll down to the Pause category
	# in the inspector.
	elif event.is_action_pressed("toggle_pause"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_tree().set_input_as_handled()

	elif event.is_action_pressed("splitscreen"):
		if name == "Splitscreen":
			# We need to clean up a little bit first to avoid Viewport errors.
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Game.tscn")
		else:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Splitscreen.tscn")

	# Close the start screen.
	elif _waiting_to_start and event.is_action_released("shoot"):
		_waiting_to_start = false
		var tree: SceneTree = get_tree()
		tree.paused = false
		tree.set_input_as_handled()
		_start_menu.close()

# TEMP: To change levels
func _input(_event):
	if Input.is_key_pressed(KEY_1):
		set_current_level("res://src/Level/Level1.tscn")
	elif Input.is_key_pressed(KEY_2):
		set_current_level("res://src/Level/Level2.tscn")

# Call this to change the active level.
func set_current_level(resource_path: String):
	var new_scene: PackedScene = load(resource_path)
	if null == new_scene:
		print("Error: Could not load level from ", resource_path)
		return
	var new_level: Node = new_scene.instance()
	if null == new_level:
		print("Error: Failed to create level from ", resource_path)
		return
	var old_level: Node = get_node("Level")
	if old_level:
		remove_child(old_level)
	new_level.name = "Level"
	add_child(new_level)
