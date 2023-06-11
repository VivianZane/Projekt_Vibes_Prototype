extends PathFollow3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

var runSpeed = 1
func _process(delta: float) -> void:
	set_offset(get_offset() + runSpeed * delta)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
