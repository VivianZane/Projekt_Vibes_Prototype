extends BaseState

func enter():
	host.playAnim("float-D")
	if !host.check_floatFrame():
		host.start_float()
		host.reset_GroundCasts()
		host.set_floatFrame()
	host.toggle_float()
	host.play_sound("float_sound")

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		return "dash"
	if !Input.is_action_pressed("jump"):
		host.cancel_floatFrame()
		return "fall"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		host.cancel_floatFrame()
		return "stone_air"
	if Input.is_action_just_pressed("blast") and host.check_blast():
		host.disable_blast()
		host.start_blastCooldown()
		host.blast()
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.reduce_floatFrame()
	host.rotate_LedgeCasts()
	host.get_direction()
	host.get_maxVelocity()
	
	if host.check_moveInput_x():
		host.move_x()
	else:
		host.stop_x()
	if host.check_moveInput_z():
		host.move_z()
	else:
		host.stop_z()
	
	if !host.check_floatFrame():
		if host.check_grounded():
			if host.check_moveInput_x() or host.check_moveInput_z():
				nextState = "move"
			else:
				nextState = "idle"
		else:
			nextState = "fall"
	
	host.velocity_clamp()
	host.move()
	return nextState
