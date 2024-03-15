extends Control

var p_IngredientSlot = preload("res://IngredientSlot/IngredientSlot.tscn")

@export var ingredients: Array[Ingredient]

@onready var ingredent_grid = $IngredientGrid

func _ready() -> void:
	for ingredient in ingredients:
		var slot = p_IngredientSlot.instantiate()
		ingredent_grid.add_child(slot)
		slot.set_ingredient(ingredient)
 
