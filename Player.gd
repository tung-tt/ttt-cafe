extends CharacterBody2D
# Variables
@export var speed = 300
@export var sprint_multiplier = 1.5
@export var acceleration = 1000
@export var friction = 1500
@export var shadow_offset = Vector2(5, 15)

var horizontal_velocity = 0.0 
var vertical_velocity = 0.0
func _ready():
	update_shadow_position()
	
func _process(delta):
	# Input Direction
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
		
	# Ensure Consistent/Stable speed
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
	var current_speed = speed
	if Input.is_action_pressed("sprint"):
		current_speed *= sprint_multiplier
		
	# Apply velocity separately for horizontal & vertical
	if input_vector.x != 0:
		horizontal_velocity = move_toward(horizontal_velocity, input_vector.x * current_speed, acceleration * delta)
	else:
		horizontal_velocity = move_toward(horizontal_velocity, 0, friction * delta)
	if input_vector.y != 0:
		vertical_velocity = input_vector.y * current_speed
	else:
		vertical_velocity = 0
	# Combine Horizontal and Vertical velocities
	velocity.x = horizontal_velocity
	velocity.y = vertical_velocity
	# Move
	move_and_slide()
	# Shadow
	update_shadow_position()
# Wrap the player's position around the 640x360 area
	# Wrap the player's position around the 640x360 area
	if global_position.x < 0:
		global_position.x = 640
	elif global_position.x > 640:
		global_position.x = 0
	if global_position.y < -30:
		global_position.y = 360
	elif  global_position.y > 360:
		global_position.y = 0
			
func update_shadow_position():
	var shadow = $Shadow
	shadow.global_position = global_position + (shadow_offset)
		
		
