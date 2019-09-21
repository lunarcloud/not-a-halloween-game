extends Node

const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const STOP = Vector2(0,0)

onready var motor = get_parent()

onready var actions = [UP, STOP, DOWN, STOP, RIGHT, STOP, LEFT, STOP]
onready var times = [1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1,0]
onready var speeds = [150, 80, 80, 150, 80, 80, 10, 0]
onready var currentActionIndex = 0

onready var timer = get_node("Timer")

export var isLooping = true

func _on_Timer_timeout():
	#set speed if different
	if abs(motor.speed - speeds[currentActionIndex]) > 0:
		motor.set_speed(speeds[currentActionIndex])
	# move the object
	motor.set_motion(actions[currentActionIndex].x, actions[currentActionIndex].y)
	# set the timer
	timer.set_wait_time(times[currentActionIndex])

	# move the index
	currentActionIndex += 1
	if currentActionIndex > actions.size() - 1:
		currentActionIndex = 0
		if isLooping == false:
			return
	timer.start()
	

