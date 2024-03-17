extends Control

signal s_menu_button_pressed()

@export var screen_id: String = "RESULTS"

func _on_menu_button_pressed() -> void:
	s_menu_button_pressed.emit()
