extends Node2D
class_name GuideLight

@export var color : Color

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = color

func set_brightness(brightness : float):
	clamp(brightness, 0, 1)
	color.a = brightness
	modulate = color

func set_color(_color : Color):
	var brightness = color.a
	color = _color
	color.a = brightness
	modulate = color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
