extends Mask

var is_going_forwards: bool = true

func _start() -> void:
	
	path_follow.loop = false

func _pathing(delta: float) -> void:
	
	set_target_path(path_follow.global_position)
	
	
	if get_distance_from_path() < 16:
		if is_going_forwards:
			path_follow.progress += character._speed*delta
			if path_follow.progress_ratio >= 1:
				is_going_forwards = false
		else:
			path_follow.progress -= character._speed*delta
			if path_follow.progress_ratio <= 0:
				is_going_forwards = true
