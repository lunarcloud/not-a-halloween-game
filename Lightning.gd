extends ColorRect

onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _flash():
	visible = true
	timer.start()

func _on_timer_timeout():
	visible = false