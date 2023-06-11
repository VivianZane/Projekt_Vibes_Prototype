extends PathFollow3D


var runSpeed = 2
func _process(delta: float) -> void:
	set_offset(get_offset() + runSpeed * delta)

