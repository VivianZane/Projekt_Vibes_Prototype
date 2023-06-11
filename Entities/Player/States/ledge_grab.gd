extends BaseState

func enter():
	host.playAnim("ledge-grab-R")
	host.reset_GroundCasts()
	var wallDirection:String = host.check_wall_direction()
	
	if wallDirection == "left":
		host.rotate_LedgeCasts(Vector2.RIGHT)
	if wallDirection == "right":
		host.rotate_LedgeCasts(Vector2.LEFT)
	if wallDirection == "up":
		host.rotate_LedgeCasts(Vector2.DOWN)
	if wallDirection == "down":
		host.rotate_LedgeCasts(Vector2.UP)
	
	if !host.check_dash():
		host.toggle_dash()
	if !host.check_float():
		host.toggle_float()
	host.play_sound("ledge_grab_sound")

func input(event:InputEvent)->String:
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if Input.is_action_just_pressed("dash") and host.check_dash():
		host.force_direction()
		host.rotate_LedgeCasts()
		if host.check_direction():
			return "dash"
	if Input.is_action_just_pressed("stone") and host.check_stone():
		return "stone_ledge"
	return ""

func physics_process(delta:float)->String:
	nextState = ""
	host.move()
	return nextState
