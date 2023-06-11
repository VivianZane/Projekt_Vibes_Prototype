extends BaseState

func enter():
	host.playAnim("stone-topple-R")
	host.reset_GroundCasts()
	host.set_stone_toppleFrame()
	host.play_sound("stone_topple_sound")

func input(event:InputEvent) -> String:
	if Input.is_action_just_pressed("stone"):
		host.start_stoneCooldown()
		return "stone_leap"
	return ""

func physics_process(delta:float) -> String:
	nextState = ""
	
	host.set_velocity(Vector3.ZERO)
	
	if !host.check_animPlayer_playing():
		nextState = "stone_fallen"
	
	host.move()
	return nextState
