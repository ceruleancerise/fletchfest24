extends Control

signal s_menu_button_pressed()

@export var screen_id: String = "RESULTS"

@export var score: Label

func _ready() -> void:
	score.set_text(str(Global.correct_count) + " / " + str(Global.MAX_TRY_COUNT))

func _on_menu_button_pressed() -> void:
	s_menu_button_pressed.emit()
