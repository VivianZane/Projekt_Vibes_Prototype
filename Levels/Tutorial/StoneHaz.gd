extends Path3D



func _ready():
	var B1Curve = Curve3D.new()
	self.set_curve(B1Curve)
	B1Curve.add_point(Vector3(0, 0, 0))
	B1Curve.add_point(Vector3(0, 0, 20))
	B1Curve.add_point(Vector3(0, 0, 0))


func _on_StoneHaz_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_stand"):
		body.health -= 1
		body.health_check()
		print(body.health)
