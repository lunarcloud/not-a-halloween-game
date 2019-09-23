extends KinematicBody2D

onready var camera = get_node("Camera2D")
onready var initial_position = get_global_position()
onready var beach_position = get_parent().get_node("Locations/WitchPos2").get_global_position()

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


func _on_StoryExample_cutscene_destroy_hotel():
	set_global_position(initial_position)
	visible = true
	camera._set_current(true)


func _on_StoryExample_witch_to_beach():
	set_global_position(beach_position)
	visible = true


func _on_StoryExample_fishmen_enter_from_sea():
	set_global_position(beach_position)
	visible = true
