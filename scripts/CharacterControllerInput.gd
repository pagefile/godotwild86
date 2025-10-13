extends Node

var _character : Character
var interacting: Node2D

func _enter_tree():
	var parent = get_parent()
	if get_parent() is Character:
		_character = parent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact"):
		interact()
	#if event is InputEventKey and event.is_action("ui_cancel"):
		#get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var input_dir = Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
	_character.facing = input_dir
	_character.move(input_dir)

func interact() -> void:
	if interacting:
		interacting._interact(_character)

func _on_interaction_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactable"):
		interacting = body
		body.modulate = Color.AQUA

func _on_interaction_body_exited(body: Node2D) -> void:
	if body.is_in_group("Interactable"):
		if interacting == body:
			interacting = null
			body.modulate = Color.WHITE
