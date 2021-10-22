extends Node2D

var net

# Called when the node enters the scene tree for the first time.
func _ready():

	net = NetworkedMultiplayerENet.new()
	get_tree().connect("network_peer_connected", self, "_player_connected")
	pass # Replace with function body.

func _on_ButtonHost_pressed():
	net.create_server(6969, 2)
	get_tree().set_network_peer(net)
	print("hosting")

#	connect to Captain Britain
func _on_ButtonJoin_pressed():
	net.create_client("86.169.30.194", 6969)
	get_tree().set_network_peer(net)
	print("Connected")

func _player_connected(id):
	Globals.player2id = id # defined in globals.gd
	var game = preload("res://Game.tscn").instance()
	get_tree().get_root().add_child(game) # loads the new scene
	hide() # hides the lobby

#	connect to yourself
func _on_ButtonJoinLocal_pressed():
	net.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(net)
	print("Connected")

func _on_SoloButton_pressed():
	get_tree().change_scene("res://soloGame.tscn")
