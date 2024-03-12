class_name Ingredient extends Resource

@export var title: String
@export var tags: Array[String]
@export var texture: Texture2D

func has_tag(tag: String) -> bool:
	return tags.find(tag)
