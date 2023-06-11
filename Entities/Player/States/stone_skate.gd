extends BaseState

func enter():
	host.disable_stone()
	host.playAnim("stone-idle-R")
	host.reset_GroundCasts()

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("stone"):
		host.start_stoneCooldown()
		return "skate"
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.apply_fallG()
	
	if host.check_moving_x() or host.check_moving_z():
		host.stop_stone()
	
	if host.check_grounded():
		host.ground()
	
	host.skate()
	host.move()
	
	return nextState
