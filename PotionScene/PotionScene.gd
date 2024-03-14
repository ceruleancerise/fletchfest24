class_name PotionScene extends Control

signal s_potion_brewed(ingredients: Array[Ingredient])

@export var ingredient_cauldron: IngredientCauldron

func _on_clear_button_pressed() -> void:
	ingredient_cauldron.clear_slots()

func _on_brew_button_pressed() -> void:
	var ingredients = ingredient_cauldron.get_ingredients_from_slots()
	s_potion_brewed.emit(ingredients)
