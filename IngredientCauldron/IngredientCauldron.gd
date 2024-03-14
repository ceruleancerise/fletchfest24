class_name IngredientCauldron extends Control

var p_IngredientSlot = preload("res://IngredientSlot/IngredientSlot.tscn")

@export var slot_number: int

@onready var grid = $Grid

var slots: Array[Node]

func _ready() -> void:
	for i in range(slot_number):
		var slot = p_IngredientSlot.instantiate()
		slot.is_clearable = true
		grid.add_child(slot)
		slots.push_back(slot)

func clear_slots() -> void:
	for slot in slots:
		slot.clear_ingredient()

func get_ingredients_from_slots() -> Array[Ingredient]:
	var ingredients: Array[Ingredient] = []
	for slot in slots:
		ingredients.push_back(slot.ingredient)
	return ingredients
	
	
