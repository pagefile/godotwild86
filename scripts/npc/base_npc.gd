extends Node
class_name NPC

var _character : Character
var path : Path2D
var path_follow : PathFollow2D = PathFollow2D.new()

var path_global_position : Vector2

func _reparent_path():
	path.reparent(_character.get_parent())

func _enter_tree():
	var parent = get_parent()
	if get_parent() is Character:
		_character = parent
		
		#Get the path2d of the character and creates a pathfollow2d
		var _path = _character.get_node_or_null("Path2D")
		if _path:
			path = _path
			path.add_child(path_follow)
			call_deferred("_reparent_path")

func _process(delta: float):
	_pathing(delta)

func _pathing(delta: float):
	pass #Use this for pathing purposes
