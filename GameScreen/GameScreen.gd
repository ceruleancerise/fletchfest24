extends Control

signal s_game_finished()

@onready var dialogue_scene = $Scenes/DialougeScene
@onready var potion_scene = $Scenes/PotionScene

@export var screen_id: String = "GAME"

func _enter_tree() -> void:
	Global.reset_counts()

func _on_potion_brewed(ingredients: Array[Ingredient]) -> void:
	dialogue_scene.submit_potion(ingredients)
	
func _on_game_finished() -> void:
	s_game_finished.emit()
