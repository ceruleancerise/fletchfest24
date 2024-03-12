extends Control

signal s_clear_button_pressed()
signal s_brew_button_pressed()

func _on_brew_button_pressed() -> void:
	s_brew_button_pressed.emit()

func _on_clear_button_pressed() -> void:
	s_clear_button_pressed.emit()
