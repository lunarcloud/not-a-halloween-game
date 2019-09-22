extends KinematicBody2D

onready var camera = get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	print("Bob has touched " + area.get_parent().get_name())


func _on_StoryExample_bob_run_from_witch():
	var witch_position = get_parent().get_node("Witch").get_global_position()
	set_global_position( witch_position + Vector2(0, 32))


func _on_StoryExample_witch_throw_fireball():
	pass # Replace with function body.


func _on_StoryExample_bob_rest():
	pass # Replace with function body.


func _on_StoryExample_bob_to_beach():
	pass # Replace with function body.


func _on_StoryExample_stab_bob():
	pass # Replace with function body.


func _on_StoryExample_bob_destroy_totem():
	pass # Replace with function body.


func _on_StoryExample_bob_show_totem():
	pass # Replace with function body.


func _on_StoryExample_camera_bob():
	camera._set_current(true)

