extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if visible && event.is_action_pressed("ui_cancel"):
			visible = !visible
			get_viewport().set_input_as_handled()

func _on_close_button_pressed():
	hide()
