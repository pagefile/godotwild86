extends NPC

var _is_going_forward : bool = true

func _pathing(delta: float):
	
	var next_path_point = path_follow.global_position
	
	_character.position = next_path_point
	
	if _is_going_forward:
		path_follow.progress += _character._speed*delta/2
		if path_follow.progress_ratio >= 1:
			_is_going_forward = false
	else:
		path_follow.progress -= _character._speed*delta/2
		if path_follow.progress_ratio <= 0:
			_is_going_forward = true
	
	

func _ready():
	path_follow.loop = false
