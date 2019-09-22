extends Sprite

onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_StoryExample_witch_throw_fireball():
	visible = true
	# TODO move toward Bob
	timer.start()

func _on_Timer_timeout():
	visible = false
