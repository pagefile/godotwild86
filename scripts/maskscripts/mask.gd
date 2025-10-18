extends Node2D
class_name Mask

@export var patrol_path : Path2D
@export var patrol_color : Color
# Increment value for creating the guide path. A value of 1
# means a guide is placed at every baked point along the
# path
@export var guidepath_step_count = 1
# How many points behind the lead light up
@export var illumination_trail = 2
@export var guide_light_packed_scene : PackedScene
@export var add_light_at_end : bool = false

# Tracking lights to illuminate them based on
# Where the player needs to be
var _guide_lights : Array[GuideLight]

#Variables from character
var navigation_agent: NavigationAgent2D
var path_follow: PathFollow2D = PathFollow2D.new()

@onready var character: Character = get_parent()
var finished_going_to_target: bool = false

func set_target_path(target_position: Vector2) -> void:
	navigation_agent.target_position = target_position

func get_distance_from_path() -> float:
	var distance = (path_follow.global_position-character.position).length()
	return distance

func _ready() -> void:
	patrol_path.add_child(path_follow)
	call_deferred("_set_variables")
	call_deferred("_start")

func _set_variables() -> void:
	navigation_agent = $NavigationAgent2D
	character.mask =  self

func _process(delta: float) -> void:
	
	if finished_going_to_target:
		return
	
	# Find the closest guide light and illuminate it
	# First translate the progress ratio to an index
	# for the lights arra
	var ratio = path_follow.progress_ratio;
	var index = round(ratio * _guide_lights.size())
	# Turn off all lights. Just brute force.
	# No elegant solution today
	for light in _guide_lights:
		light.set_brightness(0)
	# Turn on the closest light
	if index < _guide_lights.size():
		_guide_lights[index].set_brightness(1)
	
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
	# Get the baked points of the path and create guide lights on them
	var points = patrol_path.curve.get_baked_points()
	var index = 0
	if guidepath_step_count < 1:
		guidepath_step_count = 1
	while index < points.size():
		var light = guide_light_packed_scene.instantiate() as GuideLight
		get_tree().current_scene.add_child(light)
		light.global_position = patrol_path.global_transform * points[index]
		index += guidepath_step_count
		_guide_lights.push_back(light)
		light.set_brightness(0)
		light.set_color(patrol_color)
	if add_light_at_end:
		var light = guide_light_packed_scene.instantiate() as GuideLight
		get_tree().current_scene.add_child(light)
		light.global_position = patrol_path.global_transform * points[points.size() - 1]
		light.set_brightness(0)
		light.set_color(patrol_color)
		_guide_lights.push_back(light)
