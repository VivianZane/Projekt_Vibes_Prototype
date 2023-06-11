extends Path3D

var wall = preload("res://Levels/Tutorial/Skate.tscn")

func _ready():
	
	var B1Curve = Curve3D.new()
	self.set_curve(B1Curve)
	B1Curve.add_point(Vector3(0, 0, 0))
	B1Curve.add_point(Vector3(150, 0, 0))
	B1Curve.add_point(Vector3(0, 0, 0))
	


func _on_ChaseDetect_body_entered(body):
	if(body.name == "Player"):
		var newWall = wall.instantiate()
		add_child(newWall)
		
