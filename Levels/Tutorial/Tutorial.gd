extends Node3D

func _ready() -> void:
	$WinScreen.hide()
	
func _on_OutofBounds_body_entered(body):
	body.position = get_node("Respawns/oob").get_position()
	body.health -= 1
	body.health_check()
	print(body.health)


func _on_Wall_Spike_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns/FloatRespawn").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_FloorSpike_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns/FloatRespawn").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_Block_body_entered(body):
	if(body.name == "Player"):
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_Dashoob_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns/DashRes").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_SkateHaz_body_entered(body):
	if(body.name == "Player" && get_node("Tutorial/RoomManager/Skate/SkateHaz").visible == true):
		body.position = get_node("Respawns/SkateRes").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_SkateHole_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns/SkateRes").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_StoneHaz_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_stand"):
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_Pressure_body_entered(body):
	print(body.return_state())
	if(body.name == "Player" && body.return_state() == "stone_air"):
		get_node("Tutorial/RoomManager/StoneLedge/StoneStopper").visible = false
		get_node("Tutorial/RoomManager/StoneLedge/StoneStopper/StoneStopCol").disabled = true


func _on_StoneDrop_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_air"):
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_winArea_body_entered(body):
	if(body.name == "Player"):
		$WinScreen.show()
