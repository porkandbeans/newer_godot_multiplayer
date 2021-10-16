extends KinematicBody

remote func _set_position(pos):
	global_transform.origin = pos
	#set_rotation_degrees(rot)
	#pivot.look_at(rot, Vector3.UP)

remote func _set_rotation(rot: Vector3):
	pivot.look_at(rot, Vector3.UP)

var max_speed = 4
var gravity = 70
var jump_impulse = 25

var look_position

var velocity =- Vector3.ZERO

onready var pivot = $Pivot


func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_gravity(delta)
	direction = move_and_slide(direction, Vector3.UP)


func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return input_vector.normalized()

func apply_movement(input_vector):
	direction.x = input_vector.x * max_speed
	direction.z = input_vector.z * max_speed
	
	
func apply_gravity(delta):
	direction.y -= gravity * delta

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_gravity(delta)
	jump()
	velocity = move_and_slide(velocity, Vector3.UP)

func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return input_vector.normalized()

func apply_movement(input_vector):
	velocity.x = input_vector.x * max_speed
	velocity.z = input_vector.z * max_speed
	
	if is_network_master():
		if input_vector != Vector3.ZERO:
			
			pivot.look_at(translation + input_vector, Vector3.UP)
			look_position = translation + input_vector
			rpc_unreliable("_set_rotation", look_position)
	
	
func apply_gravity(delta):
	velocity.y -= gravity * delta

	
	if velocity != Vector3.ZERO:
		if is_network_master():
			move_and_slide(velocity * max_speed, Vector3.UP)

			rpc_unreliable("_set_position", global_transform.origin)

func jump():
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y = jump_impulse
