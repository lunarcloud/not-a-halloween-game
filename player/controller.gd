extends Node

onready var motor = get_parent()

# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	var x = 0
	var y = 0
	if Input.is_action_pressed("up"):
		y = -1
	if Input.is_action_pressed("down"):
		y = 1
	if Input.is_action_pressed("right"):
		x = 1
	if Input.is_action_pressed("left"):
		x = -1
	
	motor.set_motion(x,y)
