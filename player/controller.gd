extends Node

onready var motor = get_parent()
var touch_on = false

# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	var x = 0
	var y = 0
	if Input.is_action_pressed("up"):
		set_touch(false)
		y = -1
	if Input.is_action_pressed("down"):
		set_touch(false)
		y = 1
	if Input.is_action_pressed("right"):
		set_touch(false)
		x = 1
	if Input.is_action_pressed("left"):
		set_touch(false)
		x = -1
	
	if !touch_on:
		motor.set_motion(x,y)

# Switch between touchscreen and joystick/keyboard controls (yes, on the same device even)
func set_touch(touch_on):
	self.touch_on = touch_on