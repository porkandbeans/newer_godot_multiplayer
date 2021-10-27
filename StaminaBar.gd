extends Control

onready var stamBar = $StaminaBar
onready var player = get_node("../")

func _ready():
	player.connect("stamchange", self, "_on_player_stamina_change")
	
func _on_player_stamina_change(stamina):
	stamBar.value = stamina
