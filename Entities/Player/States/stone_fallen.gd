extends BaseState

func enter():
	host.playAnim("stone-fallen-R")
	host.reset_GroundCasts()
	host.play_sound("stone_land_sound")

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("stone"):
		host.start_stoneCooldown()
		return "get_up"
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	
	
	host.move()
	return nextState
