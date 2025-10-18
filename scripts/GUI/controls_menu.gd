extends Control

# Actions that will appear in the menu.
@export var _actions : Array[StringName]
@export var _control_entry_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	read_input_map()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func read_input_map():
	for action in InputMap.get_actions():
		if _actions.find(action) == -1:
			continue
		var events := InputMap.action_get_events(action)
		var events_size = events.size()
		var primary = get_event_label(events[0]) if events_size >= 1 else ""
		var secondary = events[1].as_text() if events_size >= 2 else ""
		var entry = _control_entry_scene.instantiate()
		entry.get_node("%ControlLabel").text = action
		entry.get_node("%PrimaryKey").text = primary
		entry.get_node("%SecondaryKey").text = secondary
		%ControlEntries.add_child(entry)

func get_event_label(event : InputEvent):
	pass

func try_get_key_label(event : InputEvent):
	if !(event is InputEventKey):
		return null
	var key_event = event as InputEventKey
	var key_code = DisplayServer.keyboard_get_keycode_from_physical(key_event.physical_keycode)
	return OS.get_keycode_string(key_code)
	
func try_get_joypad_button_label(event : InputEvent):
	if !(event is InputEventJoypadButton):
		return null
	var joybutton_event = event as InputEventJoypadButton
	
	
func try_get_joypad_motion_label(event : InputEvent):
	pass

func try_get_mouse_button_label(event : InputEvent):
	pass

func _input(event):
	if visible && event.is_action_pressed("ui_cancel"):
		visible = !visible
		get_viewport().set_input_as_handled()

func _on_close_button_pressed():
	hide()
