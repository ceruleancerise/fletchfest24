extends Control

signal s_brew_button_pressed()
signal s_clear_button_pressed()

@onready var sfx_clear = preload("res://assets/sfx_ui/cauldron_clear.wav")
@onready var sfx_brew = preload("res://assets/sfx_ui/cauldron_brew.ogg")

@export var audio_player: AudioStreamPlayer

func _on_brew_button_pressed() -> void:
	s_brew_button_pressed.emit()
	audio_player.set_stream(sfx_brew)
	audio_player.play()

func _on_clear_button_pressed() -> void:
	s_clear_button_pressed.emit()
	audio_player.set_stream(sfx_clear)
	audio_player.play()
