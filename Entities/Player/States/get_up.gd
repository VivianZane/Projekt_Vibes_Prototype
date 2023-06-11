extends BaseState

func enter():
	host.playAnim("get-up-R")
	host.change_color(Color(1, 0, 1))
	host.reset_GroundCasts()

func exit():
	host.change_color(Color(1, 1, 1))

func input(event:InputEvent) -> String:
	return ""

func physics_process(delta:float) -> String:
	nextState = "idle"
	
	
	
	host.move()
	return nextState
