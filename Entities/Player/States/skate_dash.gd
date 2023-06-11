extends BaseState

func enter():
	host.playAnim("skate-dash-R")
	host.reset_GroundCasts()
	host.set_dashFrame()
	host.toggle_dash()
	host.dash()

func exit():
	host.start_dashCooldown()

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.reduce_dashFrame()
	if host.check_dash_decay():
		host.dash_decay()
	if !host.check_dashFrame():
		if !host.check_grounded():
			if host.check_floatFrame():
				nextState = "skate_float"
			else:
				nextState = "skate_fall"
		else:
			nextState = "skate"
	
	host.move()
	
	return nextState
