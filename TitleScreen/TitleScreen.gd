extends Control

signal s_start_button_pressed()

@export var start_button: TextureButton

@export var screen_id: String = "TITLE"

func _on_start_button_pressed() -> void:
	s_start_button_pressed.emit()
