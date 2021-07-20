extends Camera2D

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var chase_camera: Camera2D = get_parent().get_node("Chase Camera")
onready var fps_layer: Control = get_parent().get_node("Chase Camera/FPS Layer/FPS Counter")

var move_direction = 0
var fps_visible:bool = false

func _get_input():
	if(Input.is_action_just_released("show_fps") and !fps_visible):
		fps_visible = true
		fps_layer.visible = true
	elif(Input.is_action_just_released("show_fps") and fps_visible):
		fps_visible = false
		fps_layer.visible = false


func _physics_process(_delta):
	move_direction = player.get_move_direction()
	position.x = floor(player.position.x)

#	CAM LOOK FORWARD
	var cam_offset = lerp(chase_camera.offset_h, move_direction, 0.05)
	if abs(cam_offset) < 0.1 and move_direction == 0:
		cam_offset = 0.1 * sign(cam_offset)
	chase_camera.offset_h = cam_offset
#	END OF CAM LOOK FORWARD

	_get_input()
