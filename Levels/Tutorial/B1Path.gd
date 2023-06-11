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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Block_body_entered(body):
	if(body.name == "Player" && body.return_state() != "stone_stand"):
		body.health -= 1
		body.health_check()
		print(body.health)
