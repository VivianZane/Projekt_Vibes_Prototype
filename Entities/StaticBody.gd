extends Node3D


var health = 100


func _ready():
	print()


 
func _process(delta):
	if health <= 0:
		queue_free()
