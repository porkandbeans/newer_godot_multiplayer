extends Control

onready var stamBar = $StaminaBar
onready var player = get_node("../")

func _ready():
	player.connect("stamchange", self, "_on_player_stamina_change")
	stamBar.max_value = player.max_stamina
	
func _on_player_stamina_change(stamina):
	stamBar.value = stamina

