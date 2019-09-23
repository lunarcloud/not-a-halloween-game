extends KinematicBody2D

onready var fishman_index = int(get_name().trim_prefix("Fishman"))
onready var hotel_position = get_parent().get_node("Witch").get_global_position()
onready var motor = get_node("motor")
onready var move_timer = get_node("motor/Timer")
var in_town
var near_hotel


# Called when the node enters the scene tree for the first time.
func _ready():
	move_timer.connect("timeout", self, "_done_entering_from_sea")
	visible = false
	var smoke_name = "TownSmoke" + str(fishman_index)
	var smoke_position = get_parent().get_node(smoke_name).get_global_position()
	in_town = smoke_position + Vector2(-32, 64)
	var fish_hotel_x = -48 + (16 * fishman_index)
	near_hotel = hotel_position + Vector2(fish_hotel_x, 16)


func _on_StoryExample_fishmen_enter_from_sea():
	visible = true
	motor.set_speed(40)
	motor.set_motion(0, -1)
	move_timer.start(4)

func _done_entering_from_sea():
	motor.set_speed(0)
	motor.set_motion(0,0)
	set_global_position(in_town)
	

func _on_StoryExample_cutscene_destroy_hotel():
	set_global_position(near_hotel)


func _on_StoryExample_cutscene_destroy_town():
	set_global_position(in_town) # should already be there by end of enter_from_sea
