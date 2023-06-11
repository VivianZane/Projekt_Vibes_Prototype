extends Path3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var B1Curve = Curve3D.new()
	self.set_curve(B1Curve)
	B1Curve.add_point(Vector3(0, 0, -10))
	B1Curve.add_point(Vector3(0, 0, 0))
	B1Curve.add_point(Vector3(0, 0, -10))
