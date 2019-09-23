extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_StoryExample_cutscene_destroy_hotel():
	visible = true


func _on_StoryExample_cutscene_destroy_town():
	visible = true
