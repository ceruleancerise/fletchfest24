class_name IngredientCauldron extends Control

var p_IngredientSlot = preload("res://IngredientSlot/IngredientSlot.tscn")

@export var max_ingredient_count: int = 0

@export var slot_1: IngredientSlot
@export var slot_2: IngredientSlot

var ingredients: Array[Ingredient] = []

func clear_slots() -> void:
	ingredients = []
	slot_1.clear_ingredient()
	slot_2.clear_ingredient()

func get_ingredients() -> Array[Ingredient]:
	return [slot_1.ingredient, slot_2.ingredient]
	
func _on_ingredient_changed(ingredient: Ingredient) -> void:
	if (ingredients.size() < max_ingredient_count):
		ingredients.push_back(ingredient)
		print("Added " + ingredient.title)
	else:
		print("Already at max capacity")
