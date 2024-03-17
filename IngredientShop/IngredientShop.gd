class_name IngredientShop extends Control

var p_IngredientSlot = preload("res://IngredientSlot/IngredientSlot.tscn")

@export var slots: Array[IngredientSlot]

func reset_ingredients():
	for slot in slots:
		slot.reset_texture()
