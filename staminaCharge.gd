extends Spatial

func _ready():
	pass

func _on_Area_body_entered(body):
	if body.get_name() == "0":
		body.add_stamina(10)
		pass # Replace with function body.
