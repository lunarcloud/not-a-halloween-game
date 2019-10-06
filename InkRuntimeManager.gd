extends Node

onready var InkRuntime = load("res://addons/inkgd/runtime.gd");
onready var Story = load("res://addons/inkgd/runtime/story.gd");
var story

export var json_story = "res://ink/main.json"
export var auto_continue_newline_text = true

signal ink_ready
signal ink_unavailable
signal ink_update_text(text)
signal ink_update_choices(choices)
signal ink_update_tags(tags)
signal ink_done

func _ready():
	call_deferred("_add_runtime")

func _exit_tree():
	call_deferred("_remove_runtime")

func _add_runtime():
	InkRuntime.init(get_tree().root)
	emit_signal("ink_ready")

func _remove_runtime():
	InkRuntime.deinit(get_tree().root)
	emit_signal("ink_unavailable")
	
func load_story():
	var ink_story = File.new()
	if ink_story.file_exists(json_story):
		ink_story.open(json_story, File.READ)
		var content = ink_story.get_as_text()
		ink_story.close()
		self.story = Story.new(content)
		return true
	else:
		ink_story.close()
		return false
	
func save_state(file_name="user://save.json"):
	var save_file = File.new()
	save_file.open(file_name, File.WRITE)
	var json = story.state.to_json();
	save_file.store_line(json);
	save_file.close()
	pass
	
func load_state(file_name="user://save.json"):
	var save_file = File.new()
	save_file.open(file_name, File.READ)
	var json = save_file.get_as_text();
	var save_exists = !json.empty();
	if save_exists: story.state.load_json(save_file.get_as_text())
	save_file.close()
	return save_exists

func has_choices():
	return story.current_choices != null && story.current_choices.size() > 0

func at_end():
	return !story.can_continue && !has_choices()

func continue(with_choice = null):
	if !at_end():
		if with_choice != null:
			story.choose_choice_index(with_choice)
		story.continue()
		emit_signal("ink_update_tags", story.current_tags)
		if story.current_text == "\n" && auto_continue_newline_text: 
			self.continue()
			return
		emit_signal("ink_update_text", story.current_text)
		emit_signal("ink_update_choices", story.current_choices)
		if at_end():
			emit_signal("ink_done")
