extends KinematicBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_StoryExample_fishmen_enter_from_sea():
	visible = true
