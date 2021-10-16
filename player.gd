extends KinematicBody

var max_speed = 12
var gravity = 70
var jump_impulse = 25

var direction = Vector3()

func _ready():
	pass
	
remote func _set_position(pos):
	global_transform.origin = pos

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_gravity(delta)
	direction = move_and_slide(direction, Vector3.UP)


func get_input_vector():
	var input_vector = Vector3()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return input_vector.normalized()

func apply_movement(input_vector):
	direction.x = input_vector.x * max_speed
	direction.z = input_vector.z * max_speed
	
	
func apply_gravity(delta):
	direction.y -= gravity * delta

	
	if direction != Vector3():
		if is_network_master():
			move_and_slide(direction * max_speed, Vector3.UP)
			rpc_unreliable("_set_position", global_transform.origin)
