extends Control

onready var stamBar = $StaminaBar

func _on_stamina_changed(stamina, amount):
	stamBar.value = stamina
