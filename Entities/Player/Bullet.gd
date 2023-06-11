extends RigidBody3D


var shoot = false
var speed = 600
var homingSpeed = 800
var direction:Vector3 = Vector3.ZERO

const DAMAGE = 100
const pi:float = 3.14

# preset directions to determine which sprite
# to release and in what oritentation
var main_directions = {
	"top_left": -40.91,
	"top":0,
	"top_right": 40.91,
	"right": 90,
	"bottom_right": 139.177,
	"bottom": 180,
	"bottom_left": 221.49,
	"left": -90
}

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shoot:
		direction = Vector3(-transform.basis.z)
		activate_sprite()
		apply_central_force(direction * speed)
		shoot = false


func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -=DAMAGE
		queue_free()
		
	queue_free()

func _on_Target_Detection_body_entered(body):
	if body.is_in_group("Enemy"):
		shoot = false;
		apply_central_force(transform.basis.z * speed)
		var target_location_vector = body.get_global_translation() - transform.origin
		look_at(target_location_vector, Vector3.UP)
		apply_central_force(target_location_vector * homingSpeed)

# -------------------- #
#   Sprite handling 
# -------------------- #

func activate_sprite():
	var direction_angle = (Vector2(direction.x, direction.z).angle() + pi/2) * 180/pi
	
	var closest_directions_key = "left"
	var smallest_difference = abs(main_directions["left"] - direction_angle)
	
	# determines the direction that the player is facing when blast() is called 
	# this is to know what orientation to put the sprite in
	for key in main_directions:
		var value = main_directions[key]
		if abs(value - direction_angle) < smallest_difference:
			smallest_difference = abs(value - direction_angle)
			closest_directions_key = key
	
	# handles orientation (perpendicular or angled) of the sprite when being shot
	if "_" in closest_directions_key:
		var direction_sprite = get_node("GreenAngled")
		direction_sprite.visible = true
		
		# Handles fliping of sprite to specified orientation # top left isn't handled because it is the default
		match(closest_directions_key):
			"top_right":
				direction_sprite.set_flip_h(true)
			"bottom_right":
				direction_sprite.set_flip_h(true)
				direction_sprite.set_flip_v(true)
			"bottom_left":
				direction_sprite.set_flip_v(true)

	else:
		# Handles fliping of sprite to specified orientation # top left isn't handled because it is the default
		match(closest_directions_key):
			"top":
				var direction_sprite = get_node("GreenPerpTopDown")
				direction_sprite.visible = true
			"right":
				var direction_sprite = get_node("GreenPerp")
				direction_sprite.set_flip_h(true)
				direction_sprite.visible = true
			"bottom":
				var direction_sprite = get_node("GreenPerpTopDown")
				direction_sprite.set_flip_v(true)
				direction_sprite.visible = true
			"left":
				var direction_sprite = get_node("GreenPerp")
				direction_sprite.visible = true
	
