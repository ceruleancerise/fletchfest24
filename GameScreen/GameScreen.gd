extends Control

@export var dialogue_scene: DialogueScene
@export var potion_scene: PotionScene

func _on_potion_brewed(ingredients: Array[Ingredient]) -> void:
	dialogue_scene.submit_potion(ingredients)
