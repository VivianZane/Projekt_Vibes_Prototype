extends BaseState

func enter():
	host.playAnim("skate-fall-D")
	host.play_sound("skate_land_sound")

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("dash") and host.check_dash():
		host.get_direction()
		return "skate_dash"
	if Input.is_action_just_pressed("jump") and host.check_float():
		host.cancel_floatFrame()
		return "skate_float"
	if Input.is_action_just_pressed("skate"):
		return "fall"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		return "stone_skate"
	return ""
	
func physics_process(delta:float) -> String:
	nextState = ""
	
	host.apply_fallG()
	
	if host.check_grounded():
		host.ground()
		host.move()
		nextState = "skate"
	
	host.skate()
	host.move()
	
	return nextState
