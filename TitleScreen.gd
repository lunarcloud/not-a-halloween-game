extends Control

onready var play = get_node("Menu/PlayButton")
onready var quit = get_node("Menu/QuitButton")
onready var fullscreenToggle = get_node("FullscreenToggle")

# Called when the node enters the scene tree for the first time.
func _ready():
	play.grab_focus()
	play.connect("pressed", self, "_play")
	quit.connect("pressed", self, "_quit")
	fullscreenToggle.pressed = OS.window_fullscreen
	fullscreenToggle.connect("pressed", self, "_toggle_fullscreen")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _play():
	get_tree().change_scene("res://StoryExample.tscn")
	
func _quit():
	get_tree().quit()
	
func _toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
	if OS.window_fullscreen:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_EXPAND, OS.window_size)
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,  SceneTree.STRETCH_ASPECT_EXPAND, OS.window_size)
	else:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_KEEP, Vector2(1280,720))
	
