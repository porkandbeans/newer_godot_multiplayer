extends Spatial

onready var player1Pos = $player1Pos

func _ready():
	var player1 = preload("res://player.tscn").instance()
	player1.set_name("player")
	player1.global_transform = player1Pos.global_transform
	add_child(player1)
