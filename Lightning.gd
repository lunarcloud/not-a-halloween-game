extends ColorRect

onready var timer = get_node("Timer")
onready var sfx = get_parent().get_parent().get_parent().get_node("SFX")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _flash():
	visible = true
	timer.start()
	sfx._play_sfx("thunder")

func _on_timer_timeout():
	visible = false