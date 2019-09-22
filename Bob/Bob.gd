extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	print("Bob has touched " + area.get_parent().get_name())


func _on_StoryExample_bob_run_from_witch():
	pass # Replace with function body.


func _on_StoryExample_witch_throw_fireball():
	pass # Replace with function body.


func _on_StoryExample_bob_show_totem():
	pass # Replace with function body.


func _on_StoryExample_bob_destroy_totem():
	pass # Replace with function body.


func _on_StoryExample_bob_rest():
	pass # Replace with function body.


func _on_StoryExample_stab_bob():
	pass # Replace with function body.
