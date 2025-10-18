extends Character
class_name NPC

#Add a child Mask for the ai.
#Also add a Path2D if it's being used in the Mask.
#NOTE: pls fix the anim

#var navigation_agent: NavigationAgent2D
var path: Path2D

func _ready() -> void:
	pass
#	var _nav_agent = get_node_or_null("NavigationAgent2D")
#	if _nav_agent:
#		navigation_agent = _nav_agent

func _interact(player: Character) -> void:
	
	if mask:
		modulate = Color.GRAY
		
		remove_from_group("Interactable")
		player.mask = mask
		mask.reparent(player)
		mask.character = player
#		mask.navigation_agent.reparent(player)
		mask = null
		_movement = Vector2.ZERO
		get_node("CollisionShape").disabled = true

func _reparent_path() -> void:
	pass
