extends KinematicBody2D

const SNAP_LENGTH: float = 32.0
const TILE_SIZE: int = 64
const EPSILON : float = 1.0
const GRAVITY: float = 100.0

var velocity:Vector2 = Vector2()
var snap_vector = SNAP_LENGTH * Vector2.DOWN
var move_direction = 0
export var move_speed:float = TILE_SIZE * 2.0

onready var body = $Body/Art
onready var animation: AnimationPlayer = $Animation
onready var art : Sprite = $Body/Art
onready var chase_camera: Camera2D = $"Chase Camera"


func _ready():
	pass # Replace with function body.
	
func _get_input():
	move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))

#	CAM LOOK FORWARD
	var cam_offset = lerp(chase_camera.offset_h, move_direction, 0.05)
	if abs(cam_offset) < 0.1 and move_direction == 0:
		cam_offset = 0.1 * sign(cam_offset)
	chase_camera.offset_h = cam_offset
#	END OF CAM LOOK FORWARD

	velocity.x = lerp(velocity.x, move_direction *  move_speed, 0.2)
	velocity.y += GRAVITY
	
	if(move_direction != 0):
		body.scale.x = move_direction
		

func set_animation():
	var anim = "Idle"
	
	if(abs(velocity.x) >= EPSILON):
		anim = "Walk"
		
	if(animation.assigned_animation != anim && art.frame != 0):
		animation.play(anim)
		
	
func _physics_process(_delta):
	_get_input()
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true)
	set_animation()
	


# GETTERS

func get_move_direction():
	return move_direction
