extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func close():
	visible = false

func open():
	visible = true
