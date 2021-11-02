extends Control

onready var stamBar = $StaminaBar
onready var jmpBar = $JumpsBar
onready var player = get_node("../")

func _ready():
	player.connect("stamchange", self, "_on_player_stamina_change")
	player.connect("jumpschange", self, "_on_player_jumps_change")
	
func _on_player_stamina_change(stamina):
	stamBar.value = stamina
	stamBar.max_value = player.max_stamina

func _on_player_jumps_change(jumps):
	jmpBar.value = jumps
	jmpBar.max_value = player.max_jumps
