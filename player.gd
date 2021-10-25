extends KinematicBody

remote func _set_position(pos):
	if (Globals.online):
		global_transform.origin = pos
		#set_rotation_degrees(rot)
		#pivot.look_at(rot, Vector3.UP)

remote func _set_rotation(rot: Vector3):
	if (Globals.online):
		pivot.look_at(rot, Vector3.UP)

func add_stamina(value):
	stamina += value

var max_stamina = 50
var stamina = 50
var speed
var walk_speed = 6
var run_speed = 13
#var running = false

var gravity = 25
var jump_impulse = 15
var jump_num = 0
var fall = Vector3()


var look_position

var velocity =- Vector3.ZERO

onready var pivot = $Pivot

func _ready():
	pass

func _physics_process(delta):
	
	speed = walk_speed
	
	if is_on_floor():
		jump_num = 0
	var input_vector = get_input_vector()
	
	if Input.is_action_pressed("sprint"):
		speed = run_speed
		
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
	velocity.x = input_vector.x * speed
	velocity.z = input_vector.z * speed
	
	if input_vector != Vector3.ZERO:
		pivot.look_at(translation + input_vector, Vector3.UP)
		look_position = translation + input_vector
		if (Globals.online && is_network_master()):
			rpc_unreliable("_set_rotation", look_position)
	
	
func apply_gravity(delta):
	velocity.y -= gravity * delta

	
	if velocity != Vector3.ZERO:
		move_and_slide(velocity * 4, Vector3.UP)
		if (Globals.online && is_network_master()):
			rpc_unreliable("_set_position", global_transform.origin)

func jump():
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		if jump_num == 0:
			velocity.y = jump_impulse
			jump_num = 1
			stamina -= 10

	if not is_on_floor() and Input.is_action_just_pressed("Jump"):
		if  jump_num <= stamina:
			velocity.y = jump_impulse
			jump_num += 1
			stamina -= 10
