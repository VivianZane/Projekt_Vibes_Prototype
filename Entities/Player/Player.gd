extends CharacterBody3D

# Constants
const px:float = float(1)/16
const py:float = float(2) / 32 * sin( 90 - asin(float(9)/16) )
const pz:float = float(1)/9

const pi:float = 3.14

const jumpG:float = py * 16 * -1
const fallG:float = py * 16 * -2
const stoneG:float = py * 16 * -3

const maxRise:float = py * 16 * 20
const maxFall:float = py * 16 * -20
const stoneRise:float = py * 16 * 80
const stoneFall:float = py * 16 * -80

const maxSpd_x:float = px * 16 * 100
const maxSpd_z:float = pz * 18 * 100

const defaultSpd_x:float = px * 16 * 5
const defaultSpd_z :float= pz * 18 * 5

const xAccel:float = px * 16 * 1
const zAccel:float = pz * 16 * 1
const xDecel:float = px * 16 * 2
const zDecel:float = pz * 16 * 2

const jump:float = py * 16 * 20

var health = 3

# Movement Variables
var direction:Vector2 = Vector2.ZERO
var velocity:Vector3 = Vector3.ZERO
var maxVelocity:Vector3 = Vector3.ZERO
var groundLevel:float = 0.0

# Skate Variables
const skateSpd_x:float = 16.0
const skateSpd_z:float = 20.0
const skateAccel_x:float = 0.4
const skateAccel_z:float = 0.5
const skateTurn:int = 2                #in degrees
const influence:int = 25

# Dash Variables
const dashSpd_x:float = px * 16 * 20
const dashSpd_z:float = pz * 16 * 20
const dash_xDecel:float = px * 16 * 1
const dash_zDecel:float = pz * 16 * 1
var dashable:bool = true
var dashMax:int = 1
var dashFrame:int = 0
var dashFrameMax:int = 21

# Float Variables
var floatable:bool = false
var floatFrame:int = 0
var floatFrameMax:int = 61

# Stone Variables
const stone_xDecel:float = px * 16 * 4
const stone_zDecel:float = pz * 16 * 4
var stoneable:bool = true

var stone_toppleFrame:int = 0
var stone_toppleFrameMax:int = 11

# Blast Variables
var blastable:bool = true

# On Ready Variables
@onready var states = $States

@onready var groundCheckers = $GroundCasts.get_children()
@onready var ledgeCheckers_high = $LedgeCasts_High.get_children()
@onready var ledgeCheckers_low = $LedgeCasts_Low.get_children()
@onready var aimcast = $Aimcast/RayCast3D
@onready var dropshadowcast = $DropShadowCast
@onready var dropshadow = $DropShadowCast/DropShadow

@onready var dashCoolTimer = $Cooldowns/Dash
@onready var stoneCoolTimer = $Cooldowns/Stone
@onready var blastCoolTimer = $Cooldowns/Blast

@onready var bullet = preload("res://Entities/Player/Bullet.tscn")

@onready var animPlayer = $AnimationPlayer
#String array of state names
var stateList:PackedStringArray = [
	"idle",
	"move",
	"jump",
	"fall",
	"dash",
	"float",
	"ledge_grab",
	"skate", "skate_jump", "skate_fall", "skate_dash", "skate_float",
	"stone_stand", "stone_air", "stone_topple", "stone_fallen", "stone_ledge", 
		"stone_skate", "stone_leap", "get_up"
]



# - - -
# State Machine Interaction
# - - -

func _ready() -> void:
	states.init(stateList)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func _unhandled_input(event:InputEvent) -> void:
	states.input(event)


# - - -
# Check Functions
# - - -

func check_moving_x() -> bool:
	return velocity.x != 0.0

func check_moving_y() -> bool:
	return velocity.y != 0.0

func check_moving_z() -> bool:
	return velocity.z != 0.0


func check_direction() -> bool:
	return direction != Vector2.ZERO

func check_moveInput_x() -> bool:
	return Input.is_action_pressed("left") != Input.is_action_pressed("right")

func check_moveInput_z() -> bool:
	return Input.is_action_pressed("up") != Input.is_action_pressed("down")

func check_jumpInput() -> bool:
	return Input.is_action_pressed("jump")


func check_falling() -> bool:
	return velocity.y < 0

func check_grounded() -> bool:
	for raycast in groundCheckers:
		if raycast.is_colliding():
			groundLevel = raycast.get_collision_point().y
			velocity.y = 0
			return true
	return false

func check_dropshadowcast() -> bool:
	return dropshadowcast.is_colliding()


func check_dash() -> bool:
	return dashable

func check_dashFrame() -> bool:
	return dashFrame > 0

func check_dash_decay() -> bool:
	return dashFrame <= 15


func check_float() -> bool:
	return floatable

func check_floatFrame() -> bool:
	return floatFrame > 0


#Note: Make sure to toggle collision masks so ledge checkers ONLY interact with gridmaps!
func check_ledge_grabable() -> bool:
	var truth:bool = false
	for raycast in ledgeCheckers_low:
		if raycast.is_colliding():
			truth = true
	for raycast in ledgeCheckers_high:
		if raycast.is_colliding():
			truth = false
	return truth

func check_wall_direction() -> String:
	if $WallCasts/Wall_L.is_colliding():
		return "left"
	if $WallCasts/Wall_R.is_colliding():
		return "right"
	if $WallCasts/Wall_U.is_colliding():
		return "up"
	if $WallCasts/Wall_D.is_colliding():
		return "down"
	return ""



func check_stone() -> bool:
	return stoneable

func check_stone_toppleFrame() -> bool:
	return stone_toppleFrame > 0



func check_blast() -> bool:
	return blastable



func check_animPlayer_playing() -> bool:
	return animPlayer.is_playing()
  
  
  
# - - -
# Mechanical Functions
# - - -

func get_direction():
	var new_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if new_direction.x != Vector2.ZERO.x:
		direction.x = new_direction.x
	if new_direction.y != Vector2.ZERO.y:
		direction.y = new_direction.y
	direction.x *= abs(direction.normalized().x)
	direction.y *= abs(direction.normalized().y)

func skate_get_direction():
	var new_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	new_direction = new_direction.rotated(-direction.angle())
	
	if new_direction:
		if new_direction.y < 0:
			direction = direction.rotated(deg_to_rad(-skateTurn))
		if new_direction.y > 0:
			direction = direction.rotated(deg_to_rad(skateTurn))
	

func force_direction():
	var new_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	direction = new_direction

func set_direction(new_direction:Vector2):
	direction = new_direction

func rotate_LedgeCasts(rotate_direction := Vector2(direction.x, -direction.y)):
	$LedgeCasts_High.rotation.y = rotate_direction.angle() + pi/2
	$LedgeCasts_Low.rotation.y = $LedgeCasts_High.rotation.y



func get_maxVelocity():
	maxVelocity = Vector3(
		defaultSpd_x * direction.x,
		0,
		defaultSpd_z * direction.y
	)

func get_skate_maxVelocity():
	maxVelocity = Vector3(
		skateSpd_x * direction.x,
		0,
		skateSpd_z * direction.y
	)

func set_velocity(newVelocity:Vector3):
	velocity = newVelocity

func add_velocity(newVelocity:Vector3):
	if newVelocity != Vector3.ZERO:
		newVelocity = Vector3(
			newVelocity.x * direction.x,
			newVelocity.y,
			newVelocity.z * direction.y
		)
		velocity += newVelocity


func ground():
	position.y = groundLevel


func set_GroundCasts(delta:float):
	for raycast in groundCheckers:
		raycast.target_position.y = (velocity.y * delta) - 1.05
		if raycast.target_position.y > -1.1:
			raycast.target_position.y = -1.1


func reset_GroundCasts():
	for raycast in groundCheckers:
		raycast.target_position.y = -1.1


func apply_jumpG():
	velocity.y = clamp(velocity.y + jumpG, maxFall, maxRise)

func apply_fallG():
	velocity.y = clamp(velocity.y + fallG, maxFall, maxRise)

func apply_stoneG():
	velocity.y = clamp(velocity.y + stoneG, maxFall, maxRise)


func moveDropShadow():
	if (check_dropshadowcast()):
		dropshadow.visible = true
		dropshadow.global_position = dropshadowcast.get_collision_point()
		dropshadow.global_position.y += 0.1
	else:
		dropshadow.visible = false


func velocity_clamp():
	if (maxVelocity.x < 0 and velocity.x < maxVelocity.x) \
	or (maxVelocity.x > 0 and velocity.x > maxVelocity.x):
		velocity.x = maxVelocity.x
		
	if (maxVelocity.z < 0 and velocity.z < maxVelocity.z) \
	or (maxVelocity.z > 0 and velocity.z > maxVelocity.z):
		velocity.z = maxVelocity.z


func toggle_dash():
	dashable = !dashable

func set_dashFrame():
	dashFrame = dashFrameMax

func reduce_dashFrame():
	dashFrame -= 1



func toggle_float():
	floatable = !floatable

func set_floatFrame():
	floatFrame = floatFrameMax

func reduce_floatFrame():
	floatFrame -= 1

func cancel_floatFrame():
	floatFrame = 0



func disable_stone():
	stoneable = false

func set_stone_toppleFrame():
	stone_toppleFrame = stone_toppleFrameMax
	
func reduce_stone_toppleFrame():
	stone_toppleFrame -= 1



func disable_blast():
	blastable = false



func start_dashCooldown():
	dashCoolTimer.start()

func start_stoneCooldown():
	stoneCoolTimer.start()

func start_blastCooldown():
	blastCoolTimer.start()



func move():
	set_velocity(velocity)
	set_up_direction(Vector3(0, 1, 0))
	move_and_slide()
	moveDropShadow()

# - - -
# Macro Functions
# - - -

func move_x():
	if (maxVelocity.x > 0 and velocity.x > 0) \
	or (maxVelocity.x < 0 and velocity.x < 0):
		add_velocity(Vector3(xAccel, 0, 0))
		return
	add_velocity(Vector3(xDecel, 0, 0))


func move_z():
	if (maxVelocity.z > 0 and velocity.z > 0) \
	or (maxVelocity.z < 0 and velocity.z < 0):
		add_velocity(Vector3(0, 0, zAccel))
		return
	add_velocity(Vector3(0, 0, zDecel))

func jump():
	add_velocity(Vector3(0, jump, 0))


func stop_x(decel := xDecel):
	if velocity.x == 0:
		return
	if abs(velocity.x) >= decel:
		add_velocity(Vector3(-decel, 0, 0))
		return
	set_velocity(Vector3(0, velocity.y, velocity.z))


func stop_z(decel := zDecel):
	if velocity.z == 0:
		return
	if abs(velocity.z) >= decel:
		add_velocity(Vector3(0, 0, -decel))
		return
	set_velocity(Vector3(velocity.x, velocity.y, 0))



func dash():
	set_velocity(Vector3(dashSpd_x * direction.x, 0, dashSpd_z * direction.y))


func dash_decay():
	set_velocity(Vector3(velocity.x - (dash_xDecel * direction.x), 0, \
	velocity.z - (dash_zDecel * direction.y)))


func skate():
	#If player's current speed is less than skateSpd times direction, then add velocity.
	add_velocity(Vector3(skateAccel_x, 0, skateAccel_z))
	if (velocity.x > maxVelocity.x and maxVelocity.x > 0) \
		or (velocity.x < maxVelocity.x and maxVelocity.x < 0):
		set_velocity(Vector3(maxVelocity.x, velocity.y, maxVelocity.z))


func start_float():
	set_velocity(Vector3(velocity.x, 0, velocity.z))


func stop_stone():
	stop_x(stone_xDecel)
	stop_z(stone_zDecel)


func stone_topple_jump():
	set_velocity(Vector3(skateSpd_x * direction.x, jump, skateSpd_z * direction.y))



func blast():
	if aimcast.is_colliding():
		var b = bullet.instantiate()
		aimcast.add_child(b)
		b.look_at(aimcast.get_collision_point(), Vector3.UP)
		b.shoot = true
		play_sound("blast_sound")



func rotate_Aimcast(rotate_direction := Vector2(direction.x, -direction.y)):
	$Aimcast.rotation.y = rotate_direction.angle() + pi/2

# - - -
# Animation Functions
# - - -

func playAnim(anim:String):
	flipAnim()
	animPlayer.play(anim)
	
func stopAnim():
	animPlayer.stop()

func flipAnim():
	if(direction.x < 0):
		$ExplorerSprite.flip_h = true
	else:
		$ExplorerSprite.flip_h = false

func toggleAnim():
	if animPlayer.is_playing():
		animPlayer.stop(false)
		return
	animPlayer.play()

# Function to determine which animated direction of a state to render.
# Not implementing unless I make enough sprites. Unlikely in our timeframe.
func setAnimDirection(anim:String):
	# Use match case (switch case) to get player direction within certain angles.
	# Based on angle, append direction code to end of anim string.
	# Call playAnim for the provided string and return,
		# OR
	# Return the edited string.
	pass



# - - -
# Signal Functions
# - - -

func _on_SkateHaz_body_entered(body):
	self.position = Vector3(-116, 7, 0)
	print("Entered " + body.name)


func _on_OutofBounds_body_entered(body):
	self.position = Vector3(2, 7, 8)
	health -= 1
	health_check()
	print(health)

func return_state():
	return $States.current_state_string

# IMPLEMENT A DEATH SCREEN
func health_check():
	if health == 2:
		$UI/HealthBar3.visible = false
	if health == 1:
		$UI/HealthBar2.visible = false
	if health == 0:
		get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
		
# Sounds
func play_sound(sound:String):
	get_node("Sounds/"+sound).play()


func _on_Dash_timeout():
	dashable = true


func _on_Stone_timeout():
	stoneable = true


func _on_Blast_timeout():
	blastable = true



# - - -
# Testing Functions
# - - -

func change_color(color:Color):
	$ExplorerSprite.modulate = color

func dropshadow_change_color(color:Color):
	dropshadow.modulate = color
