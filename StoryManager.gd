extends Node

onready var ink_manager = get_node("InkRuntimeManager")

onready var timer = get_node("StoryTimer")
onready var player = get_node("GameMap/Player")
onready var dialogBox = get_node("CanvasLayer/DialogBox")
onready var touchControls = get_node("CanvasLayer/TouchControls")
onready var label = get_node("CanvasLayer/DialogBox/StoryText")
onready var continueButton = get_node("CanvasLayer/DialogBox/ContinueButton")
onready var choicesContainer = get_node("CanvasLayer/DialogBox/ChoicesContainer")

# Must be in same index numbers as ordered in the ink file
var choices = PoolStringArray()

var timerAction = ""

signal play_music(name)
signal fog_worse
signal fog_clear
signal bob_run_from_witch
signal witch_enter_attacking_bob
signal witch_throw_fireball
signal witch_back_to_hotel
signal witch_to_beach
signal bob_extinguish
signal bob_show_totem
signal bob_destroy_totem
signal bob_rest
signal bob_to_beach
signal bob_to_totem
signal defeat_totem1
signal defeat_totem2
signal witch_enter_laughing
signal stab_bob
signal lightning
signal fadetoblack
signal fishmen_enter_from_sea
signal cutscene_destroy_hotel
signal cutscene_destroy_town

#camera signals
signal camera_player
signal camera_bob
signal camera_witch
signal camera_graveyard
signal camera_fishpeople
signal camera_totem1
signal camera_totem2

#dialog box
signal hide_dialog
signal show_dialog

func _ready():
	ink_manager.connect("ink_ready", self, "start_story")
	ink_manager.connect("ink_done", self, "end_of_story")
	ink_manager.connect("ink_update_text", self, "_on_story_continued")
	ink_manager.connect("ink_update_tags", self, "_process_tags")
	ink_manager.connect("ink_update_choices", self, "_on_choices")

func start_story():
	continueButton.connect("button_up", self, "_continue")

	var index = 0
	for choice in choicesContainer.get_children():
		choice.connect("button_up", self, "_select_choice", [index])
		choice.visible = false
		index += 1

	if ink_manager.load_story():
		dialogBox.visible = false
		touchControls.visible = true
		continueButton.set_text("Continue")
		ink_manager.load_state()
		var loaded_position = Vector2(
			ink_manager.story.variables_state.get("PlayerX"), 
			ink_manager.story.variables_state.get("PlayerY"))
		if loaded_position != Vector2(0,0):
			print("loaded story")
			player.position = Vector2(
				ink_manager.story.variables_state.get("PlayerX"), 
				ink_manager.story.variables_state.get("PlayerY"))
			ink_manager.story.choose_path_string("explore_map")
		else:
			print("new story")
		ink_manager.continue()
	else:
		label.set_text("Story could not be loaded!")
		dialogBox.visible = true
		touchControls.visible = false
		print("Story could not be loaded!")


func _quit_to_menu():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://TitleScreen.tscn")

func _input(event):
	if event.is_action_pressed("menu"):
		_quit_to_menu()

func _continue():
	if continueButton.text == "End":
		#delete save file
		var dir = Directory.new()
		dir.remove("user://save.json")
		#back to menu
		_quit_to_menu()
	else:
		ink_manager.continue()

func _select_choice(index):
	ink_manager.continue(index)
	
func end_of_story():
	continueButton.text = "End"

func _on_story_continued(currentText):
	label.set_text(currentText)
	continueButton.visible = true
	continueButton.grab_focus()
	
func _on_no_choices():
	choicesContainer.visible = false
	for choice in choicesContainer.get_children():
		choice.visible = false

func _on_choices(currentChoices):
	#clear choices
	choicesContainer.visible = false
	for choice in choicesContainer.get_children():
		choice.visible = false
		
	if currentChoices.size() > 0:
		choices = currentChoices
		var index = 0
		continueButton.visible = false
		choicesContainer.visible = true
		for choice in currentChoices:
			if index < 4:
				choicesContainer.get_child(index).visible = true
				choicesContainer.get_child(index).set_text(choice.text)
			index += 1
		choicesContainer.get_child(0).grab_focus()

func _on_Player_interact_with(name):
	if !ink_manager.has_choices(): return
	
	if name.begins_with("Fishman"):
		name = "Fishman1"
	if dialogBox.visible == false:
		var index = 0
		for choice in choices:
			if choice.text == name:
				_select_choice(index)
				return
			index += 1
		print("Couldn't find " + name + " in current choices")

func _on_StoryTimer_timeout():
	if timerAction == "contshowdialog":
		ink_manager.continue()
		dialogBox.visible = true
		touchControls.visible = false

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
		elif (tag == "witch:back_to_hotel"):
			emit_signal("witch_back_to_hotel")
		elif (tag == "bob:extinguish"):
			emit_signal("bob_extinguish")
		elif (tag == "bob:show_totem"):
			emit_signal("bob_show_totem")
		elif (tag == "bob:destroy_totem"):
			emit_signal("bob_destroy_totem")
		elif (tag == "bob:rest"):
			emit_signal("bob_rest")
		elif (tag == "bob:to_beach"):
			emit_signal("bob_to_beach")
		elif (tag == "bob:to_totem"):
			emit_signal("bob_to_totem")
		elif (tag == "defeat:totem1"):
			emit_signal("defeat_totem1")
		elif (tag == "defeat:totem2"):
			emit_signal("defeat_totem2")
		elif (tag == "witch:enter_laughing"):
			emit_signal("witch_enter_laughing")
		elif (tag == "bob:stab"):
			emit_signal("stab_bob")
		elif (tag == "witch:to_beach"):
			emit_signal("witch_to_beach")
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
			emit_signal("hide_dialog")
			dialogBox.visible = false
			touchControls.visible = true
		elif (tag == "showdialog"):
			emit_signal("show_dialog")
			dialogBox.visible = true
			touchControls.visible = false
		elif (tag.begins_with("contshowdialog:")):
			timerAction = "contshowdialog"
			timer.start(float(tag.trim_prefix("contshowdialog:")))
		elif (tag == "camera:player"):
			emit_signal("camera_player")
		elif (tag == "camera:bob"):
			emit_signal("camera_bob")
		elif (tag == "camera:witch"):
			emit_signal("camera_witch")
		elif (tag == "camera:graveyard"):
			emit_signal("camera_graveyard")
		elif (tag == "camera:fishpeople"):
			emit_signal("camera_fishpeople")
		elif (tag == "camera:totem1"):
			emit_signal("camera_totem1")
		elif (tag == "camera:totem2"):
			emit_signal("camera_totem2")
		elif (tag == "safe_to_save"):
			print("saved story")
			ink_manager.story.variables_state.set("PlayerX", player.position.x)
			ink_manager.story.variables_state.set("PlayerY", player.position.y)
			ink_manager.save_state()
		else:
			print("Unknown tag " + tag)