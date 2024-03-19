extends Control

signal s_brew_button_pressed()
signal s_clear_button_pressed()

@onready var sfx_clear = preload("res://assets/sfx_ui/cauldron_clear.wav")
@onready var sfx_brew = preload("res://assets/sfx_ui/cauldron_brew.ogg")

@export var audio_player: AudioStreamPlayer
@export var try_count: Label

func update_try_count():
	try_count.set_text(str(Global.try_count) + " Potions Left")

func _on_brew_button_pressed() -> void:
	if (!Global.is_action_allowed): return
	s_brew_button_pressed.emit()
	audio_player.set_stream(sfx_brew)
	audio_player.play()
	Global.try_count -= 1
	update_try_count()

func _on_clear_button_pressed() -> void:
	s_clear_button_pressed.emit()
	audio_player.set_stream(sfx_clear)
	audio_player.play()


	
