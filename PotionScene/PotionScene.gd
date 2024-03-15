class_name PotionScene extends Control

signal s_potion_brewed(ingredients: Array[Ingredient])
signal s_potion_cleared()

@onready var ingredient_cauldron: IngredientCauldron = $Vbox/PotionSceneBottom/IngredientCauldron
@export var ingredient_shop: IngredientShop

func _on_clear_button_pressed() -> void:
	ingredient_cauldron.clear_slots()
	ingredient_shop.reset_ingredients()

func _on_brew_button_pressed() -> void:
	var ingredients = ingredient_cauldron.get_ingredients()
	s_potion_brewed.emit(ingredients)
