extends Spatial

onready var player1Pos = $player1Pos
onready var player2Pos = $player2Pos

func _ready():
	var player1 = preload("res://player.tscn").instance()
	player1.set_name("player_" + str(get_tree().get_network_unique_id()))
	player1.set_network_master(get_tree().get_network_unique_id())
	player1.global_transform = player1Pos.global_transform
	add_child(player1)
	
	var player2 = preload("res://player.tscn").instance()
	player2.set_name("player_" + str(Globals.player2id))
	player2.set_network_master(Globals.player2id)
	player2.global_transform = player2Pos.global_transform
	add_child(player2)
