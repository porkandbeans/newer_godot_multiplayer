extends KinematicBodys

var gravity = 10
var velocity = Vector3.ZERO

func _physics_process(delta):
	apply_gravity(delta)
	
func apply_gravity(delta):
	velocity.y -= gravity * delta
