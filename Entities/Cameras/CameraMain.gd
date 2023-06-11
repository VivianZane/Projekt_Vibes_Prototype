extends Camera3D

 
@export (NodePath) var TargetNodepath = null
var target_node
var camera_height = Vector3(0, 28.12, 41.34) 
var skate_camera_leadway = 10
@export (float) var lerpspeed = 0.05
 

func _ready():
	target_node  = get_node(TargetNodepath)

func _physics_process(delta):
	var player_state = target_node.return_state()
	var direction = Vector3(target_node.direction.x, 0, target_node.direction.y)
	if(player_state == "skate" or player_state == "skate_jump" or player_state == "skate_fall" or player_state == "skate_float" or player_state == "skate_dash"):
		self.global_position = lerp(self.global_position, target_node.global_position + camera_height + direction * skate_camera_leadway, lerpspeed)
	else:
		self.global_position = lerp(self.global_position, target_node.global_position + camera_height, lerpspeed)
