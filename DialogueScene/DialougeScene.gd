class_name DialogueScene extends Control

@export var request: PotionRequest

@export var customer: TextureRect

@export var dialogue: Label

func _ready() -> void:
	set_request(request)

func submit_potion(ingredients: Array[Ingredient]):
	print("Potion submitted:")
	var i_1 = ingredients[0].title if (!!ingredients[0]) else "empty"
	var i_2 = ingredients[1].title if (!!ingredients[1]) else "empty"
	print(i_1 + ", " + i_2)
	
	var matching_tags = get_matching_ingredient_tags(ingredients)
	print("Matching tags:")
	print(matching_tags)
	
	var is_sufficient = is_matching_tags_sufficient(matching_tags)
	print ("Is sufficient:")
	print(is_sufficient)

# Terrible algorithm 
func get_matching_ingredient_tags(ingredients: Array[Ingredient]) -> Array[String]:
	var matching_tags: Array[String] = []
	
	for required_tag in request.tags_required:
		for ingredient in ingredients:
			if (!ingredient): continue
			for tag in ingredient.tags:
				if (required_tag == tag):
					if (!matching_tags.has(tag)):
						matching_tags.push_back(tag)

	return matching_tags

# Terrible algorithm 
func is_matching_tags_sufficient(tags: Array[String]) -> bool:
	var is_sufficient = true
	
	for required_tag in request.tags_required:
		if (!tags.has(required_tag)):
			is_sufficient = false
	
	return is_sufficient

func set_request(new_request: PotionRequest):
	request = new_request
	customer.set_texture(request.customer)
	dialogue.set_text(request.dialogue)
