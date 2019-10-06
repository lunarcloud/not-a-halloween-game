extends Control

onready var play = get_node("Menu/PlayButton")
onready var reset = get_node("Menu/ResetButton")
onready var quit = get_node("Menu/QuitButton")
onready var fullscreenToggle = get_node("FullscreenToggle")
var normalResolution = Vector2(1280,720)

var loadFileEnabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	reset.connect("pressed", self, "_reset")
	
	if loadFileEnabled:
		play.connect("pressed", self, "_play")
		play.grab_focus()
		var dir = Directory.new()
		if dir.file_exists("user://save.json"):
			reset.visible = true
			play.set_text("Continue")
		else:
			reset.visible = false
			play.set_text("New Game")
	else:
		reset.grab_focus()
	
	if OS.get_name() == "HTML5":
		quit.visible = false;
	else:
		quit.connect("pressed", self, "_quit")
		
	if OS.get_name() == "Android" || OS.get_name() == "iOS" || OS.get_name() == "HTML5":
		fullscreenToggle.visible = false;
	else:
		fullscreenToggle.pressed = OS.window_fullscreen
		fullscreenToggle.connect("pressed", self, "_toggle_fullscreen")

func _play():
	get_tree().change_scene("res://StoryExample.tscn")
	
func _reset():
	var dir = Directory.new()
	if dir.file_exists("user://save.json"):
		dir.remove("user://save.json")
	_play()
	
func _quit():
	get_tree().quit()
	
func _toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
	if OS.window_fullscreen:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_EXPAND, normalResolution)
		if (OS.get_screen_size().x > normalResolution.x):
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,  SceneTree.STRETCH_ASPECT_EXPAND, OS.get_screen_size())
	else:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_KEEP, normalResolution)
	
