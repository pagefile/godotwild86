extends Character
class_name NPC

#Add a child Mask for the ai.
#Also add a Path2D if it's being used in the Mask.
#NOTE: pls fix the anim

var navigation_agent: NavigationAgent2D
var path: Path2D
var path_follow: PathFollow2D = PathFollow2D.new()

func _ready() -> void:
	var _nav_agent = get_node_or_null("NavigationAgent2D")
	if _nav_agent:
		navigation_agent = _nav_agent
	
	var _path = get_node_or_null("Path2D")
	if _path:
		
		path = _path
		
		path.add_child(path_follow)
		call_deferred("_reparent_path")
	else:
		print("In npc {0}, no path has been set.".format([self]))

func _interact(player: Character) -> void:
	
	if mask:
		modulate = Color.GRAY
		
		remove_from_group("Interactable")
		player.mask = mask
		mask.reparent(player)
		mask.character = player
		mask.navigation_agent.reparent(player)
		mask = null
		_movement = Vector2.ZERO
		get_node("CollisionShape").disabled = true

func _reparent_path() -> void:
	
	path.reparent(get_parent())
