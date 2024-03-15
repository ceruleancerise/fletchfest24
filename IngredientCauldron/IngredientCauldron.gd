class_name IngredientCauldron extends Control

var p_IngredientSlot = preload("res://IngredientSlot/IngredientSlot.tscn")

@export var max_ingredient_count: int = 0
@export var slot: IngredientSlot

var ingredients: Array[Ingredient] = []

var slots: Array[Node]

func clear_slots() -> void:
	ingredients = []
	slot.clear_ingredient()

func get_ingredients() -> Array[Ingredient]:
	return ingredients
	
func _on_ingredient_changed(ingredient: Ingredient) -> void:
	if (ingredients.size() < max_ingredient_count):
		ingredients.push_back(ingredient)
		print("Added " + ingredient.title)
	else:
		print("Already at max capacity")
