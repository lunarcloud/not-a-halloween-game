extends Node2D

func _ready():
	visible = OS.has_touchscreen_ui_hint()

func show_if_touch():
	if OS.has_touchscreen_ui_hint():
		visible = true

func hide():
	visible = false