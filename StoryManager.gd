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
	story.Continue()
	
	continueButton.grab_focus()
	continueButton.connect("pressed", story, "Continue")	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_story_continued(currentText, currentTags):
	label.set_text(currentText)
	continueButton.disabled = false
	_process_tags(currentTags)
	
func _process_tags(tags):
	for tag in tags:
		if (tag.begins_with("music:")):
			play_music(tag.trim_prefix("music:"))
		else:
			print("Unknown tag " + tag)

func _on_choices(currentChoices):
	for choice in currentChoices:
		label.set_text(label.get_text() + "\n\t" + choice) 
		# TODO make choice buttons
		continueButton.disabled = true
		
func play_music(song):
	print("Playing music " + song)