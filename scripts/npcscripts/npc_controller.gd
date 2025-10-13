extends Node2D
class_name NPCController

@onready var character: NPC = get_parent()
var finished_going_to_target: bool = false

func set_target_path(target_position: Vector2) -> void:
	character.navigation_agent.target_position = target_position

func get_distance_from_path() -> float:
	var distance = (character.path_follow.global_position-character.position).length()
	return distance

func _process(delta: float) -> void:
	
	
	if finished_going_to_target:
		return
	
	_pathing(delta)
	_movement()
	queue_redraw()
	
	
	if get_distance_from_path() <= 0.5:
		character.position = character.path_follow.global_position

func _draw() -> void:
	pass
	#NOTE: Debug draws.
	#var direction = (character.navigation_agent.get_next_path_position()).normalized()
	#print(character.navigation_agent.get_next_path_position())
	##Nav next path pos
	#draw_line(Vector2.ZERO,character.navigation_agent.get_next_path_position()-character.position,Color.BLACK)
	##Path follow position
	#draw_circle(character.path_follow.global_position-character.position,8,Color.WHITE)

func _movement() -> void:
	
	var direction = (character.navigation_agent.get_next_path_position()-character.position).normalized()
	
	character.move(direction)

func _pathing(delta: float) -> void:
	pass #Override this for the pathing/ai.
