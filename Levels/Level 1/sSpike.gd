extends Path3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var sSpikeCurve = Curve3D.new()
	self.set_curve(sSpikeCurve)
	sSpikeCurve.add_point(Vector3(0, 1.5, 0))
	sSpikeCurve.add_point(Vector3(0, 0, 0))
	sSpikeCurve.add_point(Vector3(0, 1.5, 0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_sSpikeArea_body_entered(body):
	if(body.name == "Player"):
		body.health -= 1
		body.health_check()
		print(body.health)
