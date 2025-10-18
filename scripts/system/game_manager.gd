extends Node

const PREF_PATH = "user://options.ini"

var _main_menu_scene = load("uid://cuxlqfwmvyh2p")
var _preferences : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	read_preferences()
	var joypad_indeces = Input.get_connected_joypads()
	Debug.Log("Connected Joypad Names:")
	for id in joypad_indeces:
		Debug.Log("    Name: " + Input.get_joy_name(id) + "    " + "Raw Name: " + Input.get_joy_info(id)["raw_name"])

func update_prefs(prefs : Dictionary):
	for key in prefs.keys():
		_preferences[key] = prefs[key]
	var pref_file = FileAccess.open(PREF_PATH, FileAccess.WRITE)
	var json = JSON.stringify(_preferences)
	pref_file.store_line(json)
	pref_file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func read_preferences():
	if !FileAccess.file_exists(PREF_PATH):
		return
	var pref_file = FileAccess.open(PREF_PATH, FileAccess.READ)
	var json = pref_file.get_line()
	var data = JSON.parse_string(json)
	_preferences = data
	
	apply_sound_prefs()

func apply_sound_prefs():
	# Not very sophisticated but it works
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), _preferences["Master"])
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("music"), _preferences["music"])
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("sfx"), _preferences["sfx"])

func return_to_main_menu():
	get_tree().change_scene_to_packed(_main_menu_scene)
