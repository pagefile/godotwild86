extends Control

signal _close_pressed

# Audio bus names
const MUSIC = "music"
const SFX = "sfx"
const MASTER = "Master"

# Called when the node enters the scene tree for the first time.
func _ready():
	%Master.set_value_no_signal(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(MASTER)) * 100)
	%sfx.set_value_no_signal(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(SFX)) * 100)
	%music.set_value_no_signal(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(MUSIC)) * 100)


func _input(event):
	if visible && event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close()

func _on_close_button_pressed():
	close()
	_close_pressed.emit() # Do we need this?

func close():
	# TODO: Save options data
	hide()

func _on_music_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(MUSIC), value / 100)


func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(SFX), value / 100)


func _on_master_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(MASTER), value / 100)
