extends Node

onready var story = get_node("Story")
onready var label = get_node("StoryText")
onready var continueButton = get_node("ContinueButton")
onready var choicesContainer = get_node("ChoicesContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	story.LoadStory("ink/main.json")
	label.set_text("loading story...")
	print("loading story...")
	
	story.connect("InkContinued", self, "_on_story_continued")
	story.connect("InkChoices", self, "_on_choices")
	story.Continue()
	
	continueButton.grab_focus()
	continueButton.connect("pressed", self, "_continue")
	
	
	var index = 0
	for choice in choicesContainer.get_children():
		choice.connect("pressed", self, "_select_choice", [index])
		index += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _continue():
	if (story.CanContinue || story.HasChoices):
		story.Continue()
		if (!story.CanContinue && !story.HasChoices):
			continueButton.set_text("End")
	else:
		get_tree().change_scene("res://TitleScreen.tscn")

func _on_story_continued(currentText, currentTags):
	label.set_text(currentText)
	continueButton.visible = true
	choicesContainer.visible = false
	for choice in choicesContainer.get_children():
		choice.visible = false;
	_process_tags(currentTags)
	
func _process_tags(tags):
	for tag in tags:
		if (tag.begins_with("music:")):
			play_music(tag.trim_prefix("music:"))
		else:
			# TODO More tags, game specific tags
			print("Unknown tag " + tag)

func _on_choices(currentChoices):
	var index = 0
	continueButton.visible = false
	choicesContainer.visible = true
	for choice in currentChoices:
		choicesContainer.get_child(index).visible = true
		choicesContainer.get_child(index).set_text(choice)
		index += 1
		
func play_music(song):
	print("Playing music " + song)
	
func _select_choice(index):
	story.ChooseChoiceIndex(index)
	