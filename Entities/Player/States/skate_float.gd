extends BaseState

func enter():
	host.playAnim("skate-float-D")
	if !host.check_floatFrame():
		host.start_float()
		host.reset_GroundCasts()
		host.set_floatFrame()
	host.toggle_float()

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		host.get_direction()
		return "skate_dash"
	if Input.is_action_just_pressed("skate"):
		return "float"
	if !Input.is_action_pressed("jump"):
		host.cancel_floatFrame()
		return "skate_fall"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		host.cancel_floatFrame()
		return "stone_skate"
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.reduce_floatFrame()
	host.rotate_LedgeCasts()
	host.skate_get_direction()
	
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
			nextState = "skate"
		else:
			nextState = "skate_fall"
	
	host.skate()
	host.move()
	
	return nextState
