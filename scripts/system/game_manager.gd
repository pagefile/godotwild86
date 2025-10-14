extends Node

var _main_menu_scene = load("uid://cuxlqfwmvyh2p")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func return_to_main_menu():
	get_tree().change_scene_to_packed(_main_menu_scene)
