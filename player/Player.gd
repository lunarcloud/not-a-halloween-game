extends KinematicBody2D

var touchingName = ""

signal interact_with(name)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("action"):
		print("Triggering " + touchingName)
		emit_signal("interact_with", touchingName)


func _on_Area2D_area_entered(area):
	touchingName = area.get_parent().get_name()