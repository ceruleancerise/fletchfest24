class_name IngredientSlot extends Control

signal s_ingredient_changed(ingredient: Ingredient)

@export var audio_player: AudioStreamPlayer
@export var ingredient: Ingredient = null
@export var is_clearable: bool = false

@onready var cauldron_clear_sfx = preload("res://assets/sfx_ui/cauldron_clear.wav")

@onready var ingredient_texture = $IngredientTexture

func _ready() -> void:
	if (!!ingredient):
		ingredient_texture.set_texture(ingredient.texture)

func _get_drag_data(at_position: Vector2) -> Variant:
	
	if (!ingredient): return
	
	audio_player.set_stream(ingredient.sfx_pickup)
	audio_player.play()
	
	var ingredient_copy = ingredient
	
	if (!!ingredient):
		var preview_texture = TextureRect.new()
		preview_texture.set_texture(ingredient.texture)
		preview_texture.set_expand_mode(TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL)
		preview_texture.set_size(Vector2(200, 200))
		preview_texture.set_position(Vector2(-100, -100))
		
		var preview = Control.new()
		preview.add_child(preview_texture)
	
		set_drag_preview(preview)
	
	ingredient_texture.set_texture(null)
	
	return ingredient_copy

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return (data is Ingredient) && (!!is_clearable) 

func _drop_data(at_position: Vector2, data: Variant) -> void:
	audio_player.set_stream(data.sfx_putdown)
	audio_player.play()
	
	set_ingredient(data)
	s_ingredient_changed.emit(data)
	
func set_ingredient(new_ingredient: Ingredient):
	ingredient = new_ingredient
	ingredient_texture.set_texture(ingredient.texture)

func clear_ingredient():
	ingredient = null
	ingredient_texture.set_texture(null)

func reset_texture():
	ingredient_texture.set_texture(ingredient.texture)
