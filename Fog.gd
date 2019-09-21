extends TextureRect

onready var Mat = get_material()
var initial_intensity = 1
var current_intensity = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_intensity = Mat.get_shader_param("OCTAVES")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _clear(intensity):
	_change(0)
	
func _reset(intensity):
	_change(initial_intensity)

func _increase():
	_change(Mat.get_shader_param("OCTAVES") + 1)

func _change(intensity):
	print("changing fog octave to " + str(intensity))
	current_intensity = intensity
	var Mat = get_material()
	Mat.set_shader_param("OCTAVES", intensity)