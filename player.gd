extends KinematicBody

export var max_speed = 12
export var gravity = 70
export var jump_impulse = 25

var velocity = Vector3.ZERO

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector3.UP)


func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return input_vector.normalized()

func apply_movement(input_vector):
	velocity.x = input_vector.x * max_speed
	velocity.z = input_vector.z * max_speed
	
	
func apply_gravity(delta):
	velocity.y -= gravity * delta

remote func _set_position(pos):
	global_transform.origin = pos

	
	if velocity != Vector3.ZERO:
		if is_network_master():
			move_and_slide(velocity * max_speed, Vector3.UP)
			rpc_unreliable("_set_position", global_transform.origin)
