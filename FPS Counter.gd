extends Control

onready var fps_label = $FPSLabel

func _process(_delta):
	fps_label.text = str(Engine.get_frames_per_second()) + " FPS"
