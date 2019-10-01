extends Node

var InkRuntime = load("res://addons/inkgd/runtime.gd");
var Story = load("res://addons/inkgd/runtime/story.gd");
var story

onready var timer = get_node("StoryTimer")
onready var player = get_node("GameMap/Player")
onready var dialogBox = get_node("CanvasLayer/DialogBox")
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
	call_deferred("start_story")

func _exit_tree():
	call_deferred("_remove_runtime")

func _add_runtime():
	InkRuntime.init(get_tree().root)

func _remove_runtime():
	InkRuntime.deinit(get_tree().root)

func _load_story():
	var ink_story = File.new()
	ink_story.open("res://ink/main.json", File.READ)
	var content = ink_story.get_as_text()
	ink_story.close()

	self.story = Story.new(content)
	return true
	
func _save_state():
	var save_file = File.new()
	save_file.open("user://save.json", File.WRITE)
	var json = story.state.to_json();
	save_file.store_line(json);
	save_file.close()
	pass
	
func _load_state():
	var save_file = File.new()
	save_file.open("user://save.json", File.READ)
	var json = save_file.get_as_text();
	var save_exists = !json.empty();
	if save_exists: story.state.load_json(save_file.get_as_text())
	save_file.close()
	return save_exists

func start_story():
	_add_runtime()

	continueButton.connect("button_up", self, "_continue")

	var index = 0
	for choice in choicesContainer.get_children():
		choice.connect("button_up", self, "_select_choice", [index])
		choice.visible = false
		index += 1

	if _load_story():
		story.connect("InkContinued", self, "_on_story_continued")
		story.connect("InkChoices", self, "_on_choices")

		dialogBox.visible = false
		continueButton.set_text("Continue")
		_load_state()
		var loaded_position = Vector2(story.variables_state.get("PlayerX"), story.variables_state.get("PlayerY"))
		if loaded_position != Vector2(0,0):
			print("loaded story")
			player.position = Vector2(story.variables_state.get("PlayerX"), story.variables_state.get("PlayerY"))
			story.choose_path_string("explore_map")
		else:
			print("new story")
		_continue()
	else:
		print("Story could not be loaded!")


func _quit_to_menu():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://TitleScreen.tscn")

func _input(event):
	if event.is_action_pressed("menu"):
		_quit_to_menu()

func _has_choices():
	return story.current_choices.size() > 0

func _continue():
	if (story.can_continue):
		var text = story.continue()
		_on_story_continued(text)
		_process_tags(story.current_tags)
		if text == "\n": 
			_continue()
			return
		if _has_choices(): 
			_on_choices(story.current_choices)
		elif (!story.can_continue):
			continueButton.set_text("End")
	else:
		#delete save file
		var dir = Directory.new()
		dir.remove("user://save.json")
		#load menu
		_quit_to_menu()

func _on_story_continued(currentText):
	label.set_text(currentText)
	continueButton.visible = true
	continueButton.grab_focus()
	choicesContainer.visible = false
	for choice in choicesContainer.get_children():
		choice.visible = false


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
		elif (tag == "showdialog"):
			emit_signal("show_dialog")
			dialogBox.visible = true
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
			story.variables_state.set("PlayerX", player.position.x)
			story.variables_state.set("PlayerY", player.position.y)
			_save_state()
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
			choicesContainer.get_child(index).set_text(choice.text)
		index += 1
	choicesContainer.get_child(0).grab_focus()

func _select_choice(index):
	story.choose_choice_index(index)
	_continue()

func _on_Player_interact_with(name):
	if !_has_choices(): return
	
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
		_continue()
		dialogBox.visible = true
