extends TextureRect

onready var Mat = get_material()
var initial_intensity = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_intensity = Mat.get_shader_param("Octaves")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _clear(intensity):
	Mat.set_shader_param("Octaves", 0)
	
func _reset(intensity):
	Mat.set_shader_param("Octaves", initial_intensity)

func _increase(intensity):
	Mat.set_shader_param("Octaves", Mat.get_shader_param("Octaves") + 1)

func _change(intensity):
	Mat.set_shader_param("Octaves", intensity)