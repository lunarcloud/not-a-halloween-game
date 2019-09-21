extends Node

onready var story = get_node("Story")
onready var player = get_node("GameMap/Player")
onready var dialogBox = get_node("CanvasLayer/DialogBox")
onready var label = get_node("CanvasLayer/DialogBox/StoryText")
onready var continueButton = get_node("CanvasLayer/DialogBox/ContinueButton")
onready var choicesContainer = get_node("CanvasLayer/DialogBox/ChoicesContainer")

# Must be in same index order as in the ink file
var interactables = ["Bob", "Totem1", "Totem2", "Witch"]

enum Interactor {
	Bob = 0,
	Totem1 = 1,
	Totem2 = 2,
	Witch = 3
}

signal play_music(name)

# Called when the node enters the scene tree for the first time.
func _ready():
	continueButton.connect("button_up", self, "_continue")
	story.connect("InkContinued", self, "_on_story_continued")
	story.connect("InkChoices", self, "_on_choices")
		
	var index = 0
	for choice in choicesContainer.get_children():
		choice.connect("button_up", self, "_select_choice", [index])
		index += 1	
	
	if story.LoadStory("res://ink/main.json"):	
		story.LoadStateFromDisk("user://save.json")
		var savedPosition = Vector2(story.GetVariable("PlayerX"), story.GetVariable("PlayerY"))
		if savedPosition != Vector2(0,0):
			player.position = savedPosition
		dialogBox.visible = false
		continueButton.set_text("Continue")
		_continue()
	else:
		print("Story could not be loaded!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _quit_to_menu():
	get_tree().change_scene("res://TitleScreen.tscn")

func _input(event):
	if event.is_action_pressed("menu"):
		_quit_to_menu()
		

func _save_state():
	story.SetVariable("PlayerX", player.position.x)
	story.SetVariable("PlayerY", player.position.y)
	story.SaveStateOnDisk("user://save.json")

func _exit_tree():
	_save_state()

func _continue():
	if (story.CanContinue || story.HasChoices):
		story.Continue()
		if (!story.CanContinue && !story.HasChoices):
			continueButton.set_text("End")
	else:
		#delete save file
		var dir = Directory.new()
		dir.remove("user://save.json")
		#load menu
		_quit_to_menu()

func _on_story_continued(currentText, currentTags):
	label.set_text(currentText)
	continueButton.visible = true
	continueButton.grab_focus()
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
		elif (tag == "showdialog"):
			dialogBox.visible = true
		else:
			# TODO More tags, game specific tags
			print("Unknown tag " + tag)

func _on_choices(currentChoices):
	var index = 0
	continueButton.visible = false
	choicesContainer.visible = true
	for choice in currentChoices:
		if index < 4:
			choicesContainer.get_child(index).visible = true
			choicesContainer.get_child(index).set_text(choice)
		index += 1
	choicesContainer.get_child(0).grab_focus()

func _select_choice(index):
	story.ChooseChoiceIndex(index)
	
func _on_Player_interact_with(name):
	if dialogBox.visible == false:
		if Interactor.has(name):
			story.ChooseChoiceIndex(Interactor.get(name))
		else:
			print("No such interactable: " + name)
