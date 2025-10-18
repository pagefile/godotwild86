extends Mask

var is_going_forwards: bool = true

@export var loop_path : bool = false

func _start() -> void:
	super._start()
	path_follow.loop = loop_path

func _pathing(delta: float) -> void:
	
	set_target_path(path_follow.global_position)
	
	
	if get_distance_from_path() < 16:
		if is_going_forwards:
			path_follow.progress += character._speed*delta
			if path_follow.progress_ratio >= 1:
				is_going_forwards = !(loop_path == false)
		else:
			path_follow.progress -= character._speed*delta
			if path_follow.progress_ratio <= 0:
				is_going_forwards = true
