extends KinematicBody2D

onready var camera = get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StoryExample_witch_enter_attacking_bob():
	visible = true
	pass # Replace with function body.


func _on_StoryExample_witch_enter_laughing():
	visible = true
	pass # Replace with function body.


func _on_StoryExample_witch_throw_fireball():
	pass # Replace with function body.


func _on_StoryExample_witch_back_to_hotel():
	visible = false


func _on_StoryExample_camera_witch():
	camera._set_current(true)
