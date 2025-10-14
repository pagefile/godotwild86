extends CanvasLayer

@export var _first_level : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	# Load first level
	if _first_level == null:
		print("No start level specified. Can't start game")
		return
	get_tree().change_scene_to_packed(_first_level)


func _on_quit_button_pressed():
	get_tree().quit()
