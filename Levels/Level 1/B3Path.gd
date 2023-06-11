extends Path3D


func _ready():
	var B1Curve = Curve3D.new()
	self.set_curve(B1Curve)
	B1Curve.add_point(Vector3(0, 0, 10))
	B1Curve.add_point(Vector3(0, 0, 0))
	B1Curve.add_point(Vector3(0, 0, 10))
	pass # Replace with function body.
