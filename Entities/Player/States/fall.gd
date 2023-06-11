extends BaseState

func enter():
	host.playAnim("fall-D")

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		return "dash"
	if Input.is_action_just_pressed("jump") and host.check_float():
		host.cancel_floatFrame()
		return "float"
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
	host.apply_fallG()
	host.set_GroundCasts(delta)
	
	if host.check_moveInput_x():
		host.move_x()
	else:
		host.stop_x()
	if host.check_moveInput_z():
		host.move_z()
	else:
		host.stop_z()

#	if host.is_on_wall():
#		host.set_velocity(Vector3(0, host.velocity.y, 0))
	
	if host.check_ledge_grabable():
		host.set_velocity(Vector3.ZERO)
		nextState = "ledge_grab"
	
	if host.check_grounded():
		host.ground()
		host.move()
		if host.check_moveInput_x() or host.check_moveInput_z():
			nextState = "move"
		else:
			nextState = "idle"
	
	host.velocity_clamp()
	host.move()
	
	return nextState
