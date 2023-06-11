extends BaseState

func enter():
	host.playAnim("skate-jump-D")
	host.reset_GroundCasts()
	host.jump()

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		host.get_direction()
		return "skate_dash"
	if Input.is_action_just_pressed("skate"):
		return "jump"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		return "stone_skate"
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.apply_jumpG()
	
	if !host.check_jumpInput() or host.check_falling():
		nextState = "skate_fall"
	if host.is_on_ceiling():
		host.set_velocity(Vector3(host.velocity.x, 0, host.velocity.z))
		nextState = "skate_fall"
	
	host.skate()
	host.move()
	
	return nextState
