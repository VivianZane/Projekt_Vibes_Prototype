extends BaseState

func enter():
	host.playAnim("idle-D")
	host.reset_GroundCasts()
	if !host.check_dash():
		host.start_dashCooldown()
	if !host.check_float():
		host.toggle_float()
	if host.get_node("States").previous_state_string == "fall":
		host.play_sound("land_sound")

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		return "dash"
	if host.check_moveInput_x() or host.check_moveInput_z():
		return "move"
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
	host.get_maxVelocity()
	
	if host.check_moving_x():
		host.stop_x()
	if host.check_moving_z():
		host.stop_z()
	
	if !host.check_grounded():
		nextState = "fall"
	
	host.velocity_clamp()
	host.move()

	return nextState
