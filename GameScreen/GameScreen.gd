extends Control

@onready var dialogue_scene = $Scenes/DialougeScene
@onready var potion_scene = $Scenes/PotionScene

func _on_potion_brewed(ingredients: Array[Ingredient]) -> void:
	dialogue_scene.submit_potion(ingredients)
