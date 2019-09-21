extends Node

onready var story = get_node("Story")

onready var pretendExplorebutton = get_node("CanvasLayer/PretendExplore")
onready var dialogBox = get_node("CanvasLayer/DialogBox")
onready var label = get_node("CanvasLayer/DialogBox/StoryText")
onready var continueButton = get_node("CanvasLayer/DialogBox/ContinueButton")
onready var choicesContainer = get_node("CanvasLayer/DialogBox/ChoicesContainer")

signal play_music(name)

# Called when the node enters the scene tree for the first time.
func _ready():
	continueButton.connect("pressed", self, "_continue")
	pretendExplorebutton.connect("pressed", self, "_continue")
	story.connect("InkContinued", self, "_on_story_continued")
	story.connect("InkChoices", self, "_on_choices")
	
	pretendExplorebutton.visible = false
	continueButton.grab_focus()
	
	var index = 0
	for choice in choicesContainer.get_children():
		choice.connect("pressed", self, "_select_choice", [index])
		index += 1	
	
	if story.LoadStory("res://ink/main.json"): # TODO remove when above added
	
		# story.LoadStateFromDisk("user://save.json") # TODO add when pull-request merges
		story.LoadStateFromDisk("save.json")
		continueButton.set_text("Continue")
		_continue()
	else:
		print("Story could not be loaded!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _save_state():
	# story.SaveStateOnDisk("user://save.json") # TODO add when pull-request merges
	story.SaveStateOnDisk("save.json")

func _continue():
	_save_state()
	if (story.CanContinue || story.HasChoices):
		story.Continue()
		if (!story.CanContinue && !story.HasChoices):
			continueButton.set_text("End")
	else:
		#delete save file
		var dir = Directory.new()
		# dir.remove("user://save.json") # TODO add when pull-request merges
		dir.remove("res://save.json")
		#load menu
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
			emit_signal("play_music", tag.trim_prefix("music:"))
		elif (tag == "hidedialog"):
			dialogBox.visible = false
			pretendExplorebutton.visible = true
		elif (tag == "showdialog"):
			dialogBox.visible = true
			pretendExplorebutton.visible = false
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
		
	
func _select_choice(index):
	story.ChooseChoiceIndex(index)
	

	