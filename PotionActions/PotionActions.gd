extends Control

signal s_brew_button_pressed()
signal s_clear_button_pressed()

@onready var sfx_clear = preload("res://assets/sfx_ui/cauldron_clear.wav")
@onready var sfx_brew = preload("res://assets/sfx_ui/cauldron_brew.ogg")

@export var audio_player: AudioStreamPlayer
@export var try_count: Label

const MAX_POTION_COUNT = 10 
var potion_count = MAX_POTION_COUNT

func update_try_count():
	try_count.set_text(str(potion_count) + " Potions Left")

func _on_brew_button_pressed() -> void:
	s_brew_button_pressed.emit()
	audio_player.set_stream(sfx_brew)
	audio_player.play()
	potion_count -= 1
	update_try_count()

func _on_clear_button_pressed() -> void:
	s_clear_button_pressed.emit()
	audio_player.set_stream(sfx_clear)
	audio_player.play()


	
