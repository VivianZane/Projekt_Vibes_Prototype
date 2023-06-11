extends BaseState


func enter():
	
	host.playAnim("skate-R")
	host.skate()
	host.reset_GroundCasts()
	if !host.check_dash():
		host.start_dashCooldown()
	if !host.check_float():
		host.toggle_float()
	host.play_sound("skate_sound")



func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		host.get_direction()
		return "skate_dash"
	if Input.is_action_just_pressed("skate"):
		host.play_sound("skate_stop_sound")
		return "move"
	if Input.is_action_just_pressed("jump"):
		return "skate_jump"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		return "stone_skate"
	return ""



func physics_process(delta:float) -> String:
	nextState = ""
	host.flipAnim()
	host.skate_get_direction()
	host.rotate_LedgeCasts()
	host.get_skate_maxVelocity()
	
	host.skate()
	host.velocity_clamp()
	host.move()

	return nextState
