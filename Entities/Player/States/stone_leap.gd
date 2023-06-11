extends BaseState

func enter():
	host.playAnim("long-jump-R")
	host.stone_topple_jump()

func input(event:InputEvent) -> String:
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.apply_fallG()
	if host.check_falling() and host.check_grounded():
		if host.check_moveInput_x() or host.check_moveInput_z():
			nextState = "move"
		else:
			nextState = "idle"
	
	host.move()
	return nextState
