extends Node

onready var story = get_node("Story")
onready var player = get_node("GameMap/Player")
onready var dialogBox = get_node("CanvasLayer/DialogBox")
onready var label = get_node("CanvasLayer/DialogBox/StoryText")
onready var continueButton = get_node("CanvasLayer/DialogBox/ContinueButton")
onready var choicesContainer = get_node("CanvasLayer/DialogBox/ChoicesContainer")

# Must be in same index numbers as ordered in the ink file
var choices = PoolStringArray()

signal play_music(name)
signal fog_worse
signal fog_clear
signal bob_run_from_witch
signal witch_enter_attacking_bob
signal witch_throw_fireball
signal bob_show_totem
signal bob_destroy_totem
signal bob_rest
signal defeat_totem1
signal defeat_totem2
signal witch_enter_laughing
signal stab_bob
signal lightning
signal fadetoblack
signal fishmen_enter_from_sea
signal cutscene_destroy_hotel
signal cutscene_destroy_town


# Called when the node enters the scene tree for the first time.
func _ready():
	continueButton.connect("button_up", self, "_continue")
	story.connect("InkContinued", self, "_on_story_continued")
	story.connect("InkChoices", self, "_on_choices")
		
	var index = 0
	for choice in choicesContainer.get_children():
		choice.connect("button_up", self, "_select_choice", [index])
		choice.visible = false
		index += 1	
	
	if story.LoadStory():
		dialogBox.visible = false
		continueButton.set_text("Continue")
		story.LoadStateFromDisk("user://save.json")
		var loaded_position = Vector2(story.GetVariable("PlayerX"), story.GetVariable("PlayerY"))
		if loaded_position != Vector2(0,0):
			print("loaded story")
			player.position = Vector2(story.GetVariable("PlayerX"), story.GetVariable("PlayerY"))
			story.ChoosePathString("explore_map")
		else:
			print("new story")
		_continue()
	else:
		print("Story could not be loaded!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _quit_to_menu():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://TitleScreen.tscn")

func _input(event):
	if event.is_action_pressed("menu"):
		_quit_to_menu()
		

func _continue():
	if (story.CanContinue):
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
		choice.visible = false
	_process_tags(currentTags)
	if currentText == "\n":
		story.Continue()
	
func _process_tags(tags):
	for tag in tags:
		if (tag.begins_with("music:")):
			emit_signal("play_music", tag.trim_prefix("music:"))
		elif (tag == "fog:worse"):
			emit_signal("fog_worse")
		elif (tag == "fog:clear"):
			emit_signal("fog_clear")
		elif (tag == "bob:run_from_witch"):
			emit_signal("bob_run_from_witch")
		elif (tag == "witch:enter_attacking_bob"):
			emit_signal("witch_enter_attacking_bob")
		elif (tag == "witch:throw_fireball"):
			emit_signal("witch_throw_fireball")
		elif (tag == "bob:show_totem"):
			emit_signal("bob_show_totem")
		elif (tag == "bob:destroy_totem"):
			emit_signal("bob_destroy_totem")
		elif (tag == "bob:rest"):
			emit_signal("bob_rest")
		elif (tag == "defeat:totem1"):
			emit_signal("defeat_totem1")
		elif (tag == "defeat:totem2"):
			emit_signal("defeat_totem2")
		elif (tag == "witch:enter_laughing"):
			emit_signal("witch_enter_laughing")
		elif (tag == "stab_bob"):
			emit_signal("stab_bob")
		elif (tag == "lightning"):
			emit_signal("lightning")
		elif (tag == "fadetoblack"):
			emit_signal("fadetoblack")
		elif (tag == "fishmen:enter_from_sea"):
			emit_signal("fishmen_enter_from_sea")
		elif (tag == "cutscene:destroy_hotel"):
			emit_signal("cutscene_destroy_hotel")
		elif (tag == "cutscene:destroy_town"):
			emit_signal("cutscene_destroy_town")
		elif (tag == "hidedialog"):
			dialogBox.visible = false
		elif (tag == "showdialog"):
			dialogBox.visible = true
		elif (tag == "safe_to_save"):
			print("saved story")
			story.SetVariable("PlayerX", player.position.x)
			story.SetVariable("PlayerY", player.position.y)
			story.SaveStateOnDisk("user://save.json")
		else:
			print("Unknown tag " + tag)

func _on_choices(currentChoices):
	choices = currentChoices
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
		var index = 0
		for choice in choices:
			if choice == name:
				story.ChooseChoiceIndex(index)
				return
			index += 1
		print("Couldn't find " + name + " in current choices")
			


func _increase():
	pass # Replace with function body.
