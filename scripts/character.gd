extends CharacterBody2D
class_name Character

@export var _speed = 300.0

var _movement : Vector2
var facing = Vector2(0,0)
var anim = {
	Vector2(0,0): "idle_f",
	Vector2(1,0): "walk_s",
	Vector2(-1,0): "walk_s",
	Vector2(0,1): "walk_f",
	Vector2(0,-1): "walk_b"
}
func _physics_process(_delta):
	if anim.has(_movement):
		$Sprite.play(anim[_movement.round()])
	velocity = _movement * _speed
	move_and_slide()

# Call this with a normalized vector containing movement direction
# The vector should have a length between 0 and 1. Anything greater
# will make the player move faster than they should, there are no
# checks in here
func move(movement : Vector2):
	_movement = movement
