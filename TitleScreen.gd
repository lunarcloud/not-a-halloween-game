extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/PlayButton.grab_focus()
	$Menu/PlayButton.connect("pressed", self, "_play")
	$Menu/QuitButton.connect("pressed", self, "_quit")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _play():
	get_tree().change_scene("res://BlankScene.tscn")
	
func _quit():
	get_tree().quit()