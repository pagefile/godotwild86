extends Node

var _character : Character

func _enter_tree():
	var parent = get_parent()
	if get_parent() is Character:
		_character = parent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_dir = Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
	_character.move(input_dir)
