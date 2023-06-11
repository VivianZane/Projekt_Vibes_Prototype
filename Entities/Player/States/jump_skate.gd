extends BaseState

func enter():
	host.reset_GroundCasts()
	host.add_velocity(Vector3(0, host.jump, 0))



func physics_process(delta:float) -> String:
	nextState = ""
	
	host.get_direction()
	host.rotate_LedgeCasts()
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
	

	host.move()
	return nextState
