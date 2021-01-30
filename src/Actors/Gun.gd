class_name Gun
extends Position2D
# Represents a weapon that spawns and shoots bullets.
# The Cooldown timer controls the cooldown duration between shots.


const BULLET_VELOCITY = 400.0
const Bullet = preload("res://src/Objects/Bullet.tscn")

const ANGLE_FORWARDS = deg2rad(25)
const ANGLE_UPWARDS = deg2rad(65)
const ANGLE_DOWNWARDS = deg2rad(-15)
const ANGLES = [ANGLE_FORWARDS, ANGLE_UPWARDS, ANGLE_DOWNWARDS]

onready var sound_shoot = $Shoot
onready var timer = $Cooldown


# This method is only called by Player.gd.
func shoot(direction = 1, angle = 0):
	if not timer.is_stopped():
		return null
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.linear_velocity = Vector2(
		direction * BULLET_VELOCITY * cos(ANGLES[angle]),
		-BULLET_VELOCITY * sin(ANGLES[angle]))

	bullet.set_as_toplevel(true)
	add_child(bullet)
	sound_shoot.play()
	return bullet
