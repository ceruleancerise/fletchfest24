class_name Ingredient extends Resource

@export var title: String
@export var tags: Array[String]
@export var texture: Texture2D

@export var sfx_pickup: AudioStream
@export var sfx_putdown: AudioStream

func has_tag(tag: String) -> bool:
	return tags.find(tag)
