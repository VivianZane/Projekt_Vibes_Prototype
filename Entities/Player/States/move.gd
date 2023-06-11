extends BaseState

func enter():
	host.playAnim("move-D")
	host.reset_GroundCasts()
	if !host.check_dash():
		host.start_dashCooldown()
	if !host.check_float():
		host.toggle_float()
	host.play_sound("moving_sound")
	

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		return "dash"
	if !host.check_moveInput_x() and !host.check_moveInput_z():
		return "idle"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		return "stone_stand"
	if Input.is_action_just_pressed("skate"):
		return "skate"	
	if Input.is_action_just_pressed("blast") and host.check_blast():
		host.disable_blast()
		host.start_blastCooldown()
		host.blast()
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.get_direction()
	host.rotate_LedgeCasts()
	host.rotate_Aimcast()
	host.get_maxVelocity()
	
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
	
	if !host.check_grounded():
		nextState = "fall"
	
	host.velocity_clamp()
	host.move()
	return nextState
