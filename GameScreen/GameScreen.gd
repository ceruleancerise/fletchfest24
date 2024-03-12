extends Control

@onready var ingredient_cauldron = $HBox/PotionBackground/PotionSection/PotionSectionBottom/IngredientCauldron

var potion_request: PotionRequest

func _on_brew_button_pressed() -> void:
	pass # Replace with function body.

func _on_clear_button_pressed() -> void:
	ingredient_cauldron.clear_slots()
