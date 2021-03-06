extends KinematicBody2D

onready var camera = get_node("Camera2D")
onready var near_totem1 = get_parent().get_node("Locations/BobPos2Totem1").get_global_position()
onready var near_totem2 = get_parent().get_node("Locations/BobPos2Totem2").get_global_position()
onready var south_beach_position = get_parent().get_node("SouthBeach").get_global_position()
onready var witch_position = get_parent().get_node("Witch").get_global_position()
var totem_position = near_totem1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	print("Bob has touched " + area.get_parent().get_name())


func _on_StoryExample_bob_run_from_witch():
	set_global_position( witch_position + Vector2(0, 32))


func _on_StoryExample_witch_throw_fireball():
	pass # Replace with function body.


func _on_StoryExample_bob_rest():
	pass # Replace with function body.


func _on_StoryExample_bob_to_beach():
	set_global_position(south_beach_position)

func _on_StoryExample_defeat_totem1():
	totem_position = near_totem1


func _on_StoryExample_defeat_totem2():
	totem_position = near_totem2

func _on_StoryExample_bob_to_totem():
	set_global_position(totem_position)


func _on_StoryExample_stab_bob():
	visible = false


func _on_StoryExample_camera_bob():
	camera._set_current(true)

