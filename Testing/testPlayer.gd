extends CharacterBody3D
 
const MOVE_SPEED = 12
const JUMP_FORCE = 30
const GRAVITY = 0.98
const MAX_FALL_SPEED = 30
 
var y_velo = 0
 
func _physics_process(delta):
	var move_vec = Vector3()
	if Input.is_action_pressed("up"):
		move_vec.z -= 1
	if Input.is_action_pressed("down"):
		move_vec.z += 1
	if Input.is_action_pressed("right"):
		move_vec.x += 1
	if Input.is_action_pressed("left"):
		move_vec.x -= 1
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= MOVE_SPEED
	move_vec.y = y_velo
	set_velocity(move_vec)
	set_up_direction(Vector3(0, 1, 0))
	move_and_slide()
 
	var grounded = is_on_floor()
	y_velo -= GRAVITY
	var just_jumped = false
	if grounded and Input.is_action_just_pressed("jump"):
		just_jumped = true
		y_velo = JUMP_FORCE
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
