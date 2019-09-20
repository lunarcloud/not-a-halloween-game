extends Node

onready var story = get_node("Story")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while (story.CanContinue):
		story.Continue()
		print(story.CurrentText)
