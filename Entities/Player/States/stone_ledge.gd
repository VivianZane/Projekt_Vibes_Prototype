extends BaseState

func enter():
	host.disable_stone()
	host.playAnim("stone-idle-R")
	host.reset_GroundCasts()

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("stone"):
		host.start_stoneCooldown()
		return "ledge_grab"
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	host.move()
	return nextState
