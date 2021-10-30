extends Spatial


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		body.jump_impulse += 5
		body.jumps = body.max_jumps
		body.stamina = body.max_stamina
		queue_free()
	pass # Replace with function body.dd
