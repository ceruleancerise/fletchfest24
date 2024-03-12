extends Control

var p_IngredientSlot = preload("res://IngredientSlot/IngredientSlot.tscn")

@export var ingredients: Array[Ingredient]

@onready var grid = $Grid

func _ready() -> void:
	for ingredient in ingredients:
		var slot = p_IngredientSlot.instantiate()
		grid.add_child(slot)
		slot.set_ingredient(ingredient)
