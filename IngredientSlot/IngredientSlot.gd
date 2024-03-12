extends Control

@export var ingredient: Ingredient = null

@export var is_clearable: bool = false

@onready var ingredient_texture = $IngredientTexture

func _ready() -> void:
	if (!!ingredient):
		ingredient_texture.set_texture(ingredient.texture)

func _get_drag_data(at_position: Vector2) -> Variant:
	
	var ingredient_copy = ingredient
	
	if (!!ingredient):
		var preview_texture = TextureRect.new()
		preview_texture.set_texture(ingredient.texture)
		preview_texture.set_expand_mode(TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL)
		preview_texture.set_size(Vector2(64, 64))
		preview_texture.set_position(Vector2(-64, 0))
		
		var preview = Control.new()
		preview.add_child(preview_texture)
	
		set_drag_preview(preview)
	
	if (is_clearable):
		ingredient = null
		ingredient_texture.set_texture(null)
	
	return ingredient_copy

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return (data is Ingredient)

func _drop_data(at_position: Vector2, data: Variant) -> void:
	set_ingredient(data)
	
func set_ingredient(new_ingredient: Ingredient):
	ingredient = new_ingredient
	ingredient_texture.set_texture(ingredient.texture)

func clear_ingredient():
	ingredient = null
	ingredient_texture.set_texture(null)
