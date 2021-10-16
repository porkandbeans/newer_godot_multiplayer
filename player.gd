extends KinematicBody

remote func _set_position(pos):
	global_transform.origin = pos

var max_speed = 4
var gravity = 70
var jump_impulse = 25

var velocity =- Vector3.ZERO


onready var pivot = $Pivot

func _ready():
	pass

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
	
	if input_vector != Vector3.ZERO:
		pivot.look_at(translation + input_vector, Vector3.UP)
	
	
func apply_gravity(delta):
	velocity.y -= gravity * delta

	
	if velocity != Vector3.ZERO:
		if is_network_master():
			move_and_slide(velocity * max_speed, Vector3.UP)
			rpc_unreliable("_set_position", global_transform.origin)

func jump():
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y = jump_impulse
