class_name IngredientShop extends Control

var p_IngredientSlot = preload("res://IngredientSlot/IngredientSlot.tscn")

@export var ingredients: Array[Ingredient]

@onready var ingredent_grid = $IngredientGrid

var slots: Array[IngredientSlot]

func _ready() -> void:
	for ingredient in ingredients:
		var slot = p_IngredientSlot.instantiate()
		ingredent_grid.add_child(slot)
		slot.set_ingredient(ingredient)
		slots.push_back(slot)
 
func reset_ingredients():
	for slot in slots:
		slot.reset_texture()
