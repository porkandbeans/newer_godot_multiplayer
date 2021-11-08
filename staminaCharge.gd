extends Spatial

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		body.stamina = body.max_stamina
	
	if body.is_in_group("Player"):
		body.jumps = body.max_jumps
	pass # Replace with function body.dd
