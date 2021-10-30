extends Spatial

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		body.run_speed += 4
		body.stamina = body.max_stamina
		body.jumps = body.max_jumps
		queue_free()
	pass # Replace with function body.dd
