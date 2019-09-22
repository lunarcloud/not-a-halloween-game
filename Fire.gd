extends Sprite

onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Player_interact_with(name):
	if name == get_name():
		timer.start()


func _on_Timer_timeout():
	visible = false
