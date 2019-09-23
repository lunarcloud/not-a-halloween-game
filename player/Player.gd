extends KinematicBody2D


onready var camera = get_node("Camera2D")
onready var motor = get_node("motor")

export var walkSpeed = 80
export var runSpeed = 120

var touchingName = ""

signal interact_with(name)

# Called when the node enters the scene tree for the first time.
func _ready():
	motor.set_speed(walkSpeed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_released("action"):
		if touchingName != "":
			print("Triggering " + touchingName)
			emit_signal("interact_with", touchingName)
			touchingName = ""
	elif event.is_action_pressed("run"):
		motor.set_speed(runSpeed)
	elif event.is_action_released("run"):
		motor.set_speed(walkSpeed)


func _on_Area2D_area_entered(area):
	if area.get_parent().visible:
		touchingName = area.get_parent().get_name()

func _on_Area2D_area_exited(area):
	var name = area.get_parent().get_name()
	if name == touchingName:
		touchingName = ""


func _on_StoryExample_cutscene_destroy_town():
	pass # Replace with function body.


func _on_StoryExample_cutscene_destroy_hotel():
	pass # Replace with function body.



func _on_StoryExample_camera_player():
	camera._set_current(true)


func _on_StoryExample_hide_dialog():
	motor.set_physics_process(true)


func _on_StoryExample_show_dialog():
	motor.set_physics_process(false)
