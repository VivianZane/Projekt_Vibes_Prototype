extends BaseState

func enter():
	host.playAnim("dash-R")
	host.reset_GroundCasts()
	host.set_dashFrame()
	host.toggle_dash()
	host.dash()
	host.play_sound("dash_sound")

func exit():
	pass

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.reduce_dashFrame()
	if host.check_dash_decay():
		host.dash_decay()
	if !host.check_dashFrame():
		if !host.check_grounded():
			if host.check_floatFrame():
				nextState = "float"
			elif host.check_ledge_grabable():
				host.set_velocity(Vector3.ZERO)
				nextState = "ledge_grab"
			else:
				nextState = "fall"
		elif !host.check_moveInput_x() and !host.check_moveInput_z():
			nextState = "idle"
		else:
			nextState = "move"
	
	host.move()
	return nextState
