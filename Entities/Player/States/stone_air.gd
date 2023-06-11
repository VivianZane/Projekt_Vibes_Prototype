extends BaseState

func enter():
	host.disable_stone()
	host.playAnim("stone-idle-D")
	host.play_sound("stone_turn_sound")

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("stone"):
		host.start_stoneCooldown()
		return "fall"
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.get_maxVelocity()
	host.apply_stoneG()
	host.set_GroundCasts(delta)
	
#	if host.is_on_wall():
#		host.set_velocity(Vector3(0, host.velocity.y, 0))
	
	if host.check_grounded():
		host.ground()
		if host.check_moving_x() or host.check_moving_z():
			nextState = "stone_topple"
		else:
			nextState = "stone_stand"
	
	host.velocity_clamp()
	host.move()
	return nextState
