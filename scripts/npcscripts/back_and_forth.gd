extends NPCController

var is_going_forwards: bool = true

func _ready() -> void:
	
	character.path_follow.loop = false

func _pathing(delta: float) -> void:
	
	set_target_path(character.path_follow.global_position)
	
	if is_going_forwards:
		character.path_follow.progress += character._speed*delta
		if character.path_follow.progress_ratio >= 1:
			is_going_forwards = false
	else:
		character.path_follow.progress -= character._speed*delta
		if character.path_follow.progress_ratio <= 0:
			is_going_forwards = true
