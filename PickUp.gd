extends Spatial

func _ready():
	pass

func _on_Area_body_entered(body):
	if body.get_name() == "cunt":
		body.add_stamina(10)
		queue_free()
		pass # Replace with function body.
