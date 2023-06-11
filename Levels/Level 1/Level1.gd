extends Node3D

func _ready() -> void:
	$WinScreen.hide()



func _on_MainOOB_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/MainOOBRespawn").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_StoneDrop_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_air"):
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_Block_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_stand"):
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_FloorSpike_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_air"):
		body.health -= 1
		body.health_check()
		print(body.health)





func _on_Area_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_stand"):
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_Bot1RespawnArea_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/Bot1Respawn").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_Mid1Respaqnarea_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/Mid1Respaqn").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_topresarea_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/topres").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_bot2area_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/bot2").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_mid2resarea_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/mid2res").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_top2area_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/top2res").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_bot3area_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/bot3res").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_mid3area_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/mid3res").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_mainskatearea_body_entered(body):
	if(body.name == "Player"):
		body.position = get_node("Respawns and OOB/mainskateres").get_position()
		body.health -= 1
		body.health_check()
		print(body.health)


func _on_Win_body_entered(body):
	if(body.name == "Player"):
		$WinScreen.show()
