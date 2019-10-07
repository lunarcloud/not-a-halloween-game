#Author: Rodrigo Torres
#Version: 1.0.5
#For Godot 3.x
extends Node2D

signal move
signal pressed
signal released

onready var bigCircle = get_node("BigCircle")
onready var smallCircle = get_node("SmallCircle")
var originalPosition

var resetPosCircle
var pressed = 0
var halfBigCircleSize
var thereIsEventInput = false
var vectorToEmit
var bigCircPos
var distance

export var side = "left"
export var dissapear_when_not_pressed = false

func _ready():
	halfBigCircleSize = bigCircle.texture.get_size().x / 2
	originalPosition = self.get_global_position()
	updateCachedCirclesPositions()

func _input(event):
	if event is InputEventKey:
		return
	
	_on_Pressed(event)
	
	if event is InputEventScreenTouch:
		if !correctSide(event.position):
			_stop_handling()
			return
		toggleVisible(event.pressed)
		setSelfPosition(event.position)
		updateCachedCirclesPositions()
		if not event.pressed:
			_stop_handling()
			return

	if getIsDrag(event) and pressed == 1:
		if !correctSide(event.position):
			_stop_handling()
			return
		var dirBigCir_dirEnvt = event.position - bigCircle.get_global_position()
		distance = getDistance(dirBigCir_dirEnvt.x, 0, dirBigCir_dirEnvt.y, 0)
		if distance > halfBigCircleSize:
			smallCircle.set_position(dirBigCir_dirEnvt.normalized() * halfBigCircleSize)
		else:
			smallCircle.set_global_position(event.position)
			
	if isReleased(event):
		_stop_handling()

	vectorToEmit = smallCircle.get_position()
	thereIsEventInput = true if event else false

func _stop_handling():
	pressed = 0
	smallCircle.set_global_position(resetPosCircle)
	setSelfPosition(originalPosition)
	emit_signal_move(Vector2(0, 0))
	emit_signal('released')

func _process(delta):
	#normalized() # reduces the magnitude of the vector to 1 while maintaining the direction
	if thereIsEventInput and vectorToEmit:
		emit_signal_move(vectorToEmit / halfBigCircleSize)

func toggleVisible(value):
	if dissapear_when_not_pressed:
		self.visible = value

func setSelfPosition(position):
	self.position = position
	smallCircle.set_global_position(position)

func updateCachedCirclesPositions():
	resetPosCircle = smallCircle.get_global_position()
	bigCircPos = bigCircle.get_global_position()
	pass

func easing(t):
	return t*t*t

func emit_signal_move(value):
	emit_signal('move', easing(value))

func getIsDrag(event):
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		return true

func _on_Pressed(event):
	if event is InputEventJoypadMotion:
		return
		
	var eventPos = event.get_position()

	if not eventPos or not eventPos.x or not eventPos.y:
		return
		
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		pressed = 1
		emit_signal('pressed')

func isReleased(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		return !event.pressed

func getDistance(x1, x2, y1, y2):
	return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2))
	
func correctSide(pos):
	if side == "left":
		return pos.x < get_viewport_rect().size.x / 2
	elif side == "right":
		return pos.x > get_viewport_rect().size.x / 2
	return true # else, not specified