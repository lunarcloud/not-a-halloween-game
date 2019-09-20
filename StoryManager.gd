extends Node

onready var story = get_node("Story")
onready var label = get_node("StoryText")
onready var continueButton = get_node("ContinueButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	story.LoadStory("ink/main.json")
	label.set_text("loading story...")
	print("loading story...")
	story.connect("InkContinued", self, "_on_story_continued")
	story.connect("InkChoices", self, "_on_choices")
	continueButton.connect("pressed", story, "Continue")	
	story.Continue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_story_continued(currentText, currentTags):
	label.set_text(currentText)
	continueButton.disabled = false
	

func _on_choices(currentChoices):
	for choice in currentChoices:
		label.set_text(label.get_text() + "\n\t" + choice) 
		continueButton.disabled = true