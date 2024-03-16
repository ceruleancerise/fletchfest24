class_name DialogueScene extends Control

@onready var request_library: Array[PotionRequest] = [
	preload("res://PotionRequests/TestRequest1.tres"),
	preload("res://PotionRequests/TestRequest2.tres"),
	preload("res://PotionRequests/TestRequest3.tres")
]

@export var request: PotionRequest
@export var customer: TextureRect
@export var dialogue: Label
@export var animation_player: AnimationPlayer

@onready var requests: Array[PotionRequest]

func _ready() -> void:
	reset_requests()
	set_random_request()
	customer_enter()

func submit_potion(ingredients: Array[Ingredient]):
	print("Potion submitted:")
	var i_1 = "empty"
	if (ingredients.size() >= 1 && !!ingredients[0]): i_1 = ingredients[0].title
	var i_2 = "empty"
	if (ingredients.size() >= 2 && !!ingredients[1]): i_2 = ingredients[1].title
	print(i_1 + ", " + i_2)
	
	var matching_tags = get_matching_ingredient_tags(ingredients)
	print("Matching tags:")
	print(matching_tags)
	
	var is_sufficient = is_matching_tags_sufficient(matching_tags)
	print ("Is sufficient:")
	print(is_sufficient)
	
	if (is_sufficient): customer_exit()

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
	
func reset_requests():
	requests = request_library.duplicate(true)
	requests.shuffle()
	
func set_random_request():
	if (requests.size() == 0): 
		print("No requests left.")
		return
		
	var new_request = requests.pop_back()
	set_request(new_request)

func set_request(new_request: PotionRequest):	
	request = new_request
	customer.set_texture(request.customer)
	dialogue.set_text(request.dialogue)
	
func customer_exit():
	animation_player.play("customer_exit")
	
func customer_enter():
	animation_player.play("customer_enter")

func _on_animation_finished(anim_name: StringName) -> void:
	match (anim_name):
		"customer_exit": 
			set_random_request()
			customer_enter()
