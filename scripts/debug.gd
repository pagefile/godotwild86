extends CanvasLayer

# Debug console that can toggle on and off and contain
# multiple pages of information. Each sibling under the CanvasLayer
# is considered a page

@export var _enable_in_release := false
var _pages : Array[Node]
var _current_page := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if!OS.is_debug_build() && !_enable_in_release:
		queue_free()
	visible = false
	_pages = %Pages.get_children()
	for page in _pages:
		page.visible = false
	_pages[0].visible = true

# ` to open and close the debug console
# PAGE UP and PAGE DOWN to cycle through pages
func _input(event: InputEvent):
	if !(event is InputEventKey):
		return
	var key_event : InputEventKey = event
	
	# Key.KEY_QUOTELEFT is ` key next to 1
	if key_event.keycode == Key.KEY_QUOTELEFT && key_event.pressed:
		visible = !visible
	# Don't cycle pages if the console isn't visible
	if !visible:
		return
	if key_event.keycode == Key.KEY_PAGEDOWN && key_event.pressed:
		_pages[_current_page].visible = false
		_current_page = wrap(_current_page + 1, 0, _pages.size())
		_pages[_current_page].visible = true
	if key_event.keycode == Key.KEY_PAGEUP && key_event.pressed:
		_pages[_current_page].visible = false
		_current_page = wrap(_current_page - 1, 0, _pages.size())
		_pages[_current_page].visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%FPS.text = "FPS: " + str(Engine.get_frames_per_second())

func Log(message : String):
	print(message)
