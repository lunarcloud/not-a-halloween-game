extends KinematicBody2D

onready var hotel_position = get_parent().get_node("Witch").get_global_position()

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_StoryExample_fishmen_enter_from_sea():
	visible = true

func _on_StoryExample_cutscene_destroy_hotel():
	set_global_position( hotel_position + Vector2(-32, -32))


func _on_StoryExample_cutscene_destroy_town():
	pass # Replace with function body.
