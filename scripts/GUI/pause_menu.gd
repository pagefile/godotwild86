extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
			visible = !visible
			get_viewport().set_input_as_handled()

func _on_visibility_changed():
	get_tree().paused = visible


func _on_resume_button_pressed():
	visible = false


func _on_quit_button_pressed():
	get_tree().paused = false
	GameManager.return_to_main_menu()


func _on_options_panel__audio_button_pressed():
	%AudioPanel.show()


func _on_options_button_pressed():
	%OptionsPanel.show()


func _on_options_panel__controls_button_pressed():
	%ControlsMenu.show()
