extends BaseState

func enter():
	host.playAnim("jump-D")
	host.reset_GroundCasts()
	host.jump()
	host.play_sound("jump_sound")


func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		return "dash"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		return "stone_air"
	if Input.is_action_just_pressed("blast") and host.check_blast():
		host.disable_blast()
		host.start_blastCooldown()
		host.blast()
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.get_direction()
	host.rotate_LedgeCasts()
	host.get_maxVelocity()
	host.apply_jumpG()
	
	if host.check_moveInput_x():
		host.move_x()
	else:
		host.stop_x()
	if host.check_moveInput_z():
		host.move_z()
	else:
		host.stop_z()
	
	if !host.check_jumpInput() or host.check_falling():
		nextState = "fall"
	if host.is_on_ceiling():
		host.set_velocity(Vector3(host.velocity.x, 0, host.velocity.z))
		nextState = "fall"
	
	host.velocity_clamp() 

	host.move()
	return nextState
