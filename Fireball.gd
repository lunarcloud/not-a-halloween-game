extends Sprite

onready var timer = get_node("Timer")
onready var sfx = get_node("FireSound2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_StoryExample_witch_throw_fireball():
	visible = true
	sfx.play(0)

func _on_StoryExample_bob_extinguish():
	visible = false
	sfx.stop()
