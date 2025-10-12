extends CharacterBody2D
class_name Character

@export var _speed = 300.0

var _movement : Vector2

func _physics_process(delta):
	velocity = _movement * _speed
	move_and_slide()

# Call this with a normalized vector containing movement direction
# The vector should have a length between 0 and 1. Anything greater
# will make the player move faster than they should, there are no
# checks in here
func move(move : Vector2):
	_movement = move
