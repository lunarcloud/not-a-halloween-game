extends Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false



func _on_StoryExample_bob_destroy_totem():
	visible = false


func _on_StoryExample_bob_show_totem():
	visible = true
