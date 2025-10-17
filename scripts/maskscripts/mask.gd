extends Node2D
class_name Mask

#Variables from character
var navigation_agent: NavigationAgent2D
var path: Path2D
var path_follow: PathFollow2D

@onready var character: Character = get_parent()
var finished_going_to_target: bool = false

func set_target_path(target_position: Vector2) -> void:
	navigation_agent.target_position = target_position

func get_distance_from_path() -> float:
	var distance = (path_follow.global_position-character.position).length()
	return distance

func _ready() -> void:
	call_deferred("_set_variables")
	call_deferred("_start")

func _set_variables() -> void:
	navigation_agent = character.navigation_agent
	path = character.path
	path_follow = character.path_follow
	character.mask =  self

func _process(delta: float) -> void:
	
	if finished_going_to_target:
		return
	
	_pathing(delta)
	if character is NPC:
		_movement()
	else:
		queue_redraw()
	
	if get_distance_from_path() <= 0.5:
		character.position = path_follow.global_position

func _draw() -> void:
	pass
	#FIXME: all offsetted when stolen
	#if !character is NPC:
		#draw_circle(path_follow.global_position-character.position,8,Color.WHITE)
		#draw_line(Vector2.ZERO,navigation_agent.get_next_path_position()-character.position,Color.BLACK,8)
		#
		#var path_line: PackedVector2Array = path.curve.get_baked_points()
		#for point in path_line.size():
			#path_line[point] -= character.position-path.global_position
			#draw_dashed_line(Vector2.ZERO,path_line[point],Color.AQUA)
		#
		#draw_polyline(path_line,Color.BLACK)

func _movement() -> void:
	
	var direction = (navigation_agent.get_next_path_position()-character.position).normalized()
	
	character.move(direction)

func _pathing(_delta: float) -> void:
	pass #Override this for the pathing/ai.

func _start() -> void:
	pass #Override this for starting.
