extends Node

# put as a direct child of the thing you want to move
onready var object : KinematicBody2D = get_parent()
onready var direction = Vector2(0,0)
export var speed = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var motion
	motion = speed * direction * delta
	object.move_and_collide(motion)
	
func set_motion(x, y):
	direction = Vector2(x, y)

func set_speed(amount):
	speed = amount
