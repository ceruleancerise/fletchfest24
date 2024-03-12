extends Control

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
