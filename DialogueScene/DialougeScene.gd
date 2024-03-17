class_name DialogueScene extends Control

signal s_game_finished()

@onready var sfx_bottle = preload("res://assets/sfx_ui/bottle.wav")
@onready var sfx_bottle_grab = preload("res://assets/sfx_ui/bottle_grab.mp3")
@onready var sfx_bottle_discard = preload("res://assets/sfx_ui/bottle_discard.wav")
@onready var sfx_bell = preload("res://assets/sfx_ui/bell.wav")
@onready var sfx_door_close = preload("res://assets/sfx_ui/door_close.wav")

@onready var sfx_potion_correct = preload("res://assets/sfx_ui/potion_correct.wav")
@onready var sfx_potion_partial = preload("res://assets/sfx_ui/potion_partial.wav")
@onready var sfx_potion_wrong = preload("res://assets/sfx_ui/potion_wrong.wav")

@onready var request_library: Array[PotionRequest] = [
	preload("res://PotionRequests/Dwarf1.tres"),
	preload("res://PotionRequests/Dwarf2.tres"),
	preload("res://PotionRequests/Dwarf3.tres"),
	preload("res://PotionRequests/ElfBoy1.tres"),
	preload("res://PotionRequests/ElfBoy2.tres"),
	preload("res://PotionRequests/ElfBoy3.tres"),
	preload("res://PotionRequests/ElfGirl1.tres"),
	preload("res://PotionRequests/ElfGirl2.tres"),
	preload("res://PotionRequests/ElfGirl3.tres"),
	preload("res://PotionRequests/James1.tres"),
	preload("res://PotionRequests/James2.tres"),
	preload("res://PotionRequests/James3.tres"),
	preload("res://PotionRequests/Jessica1.tres"),
	preload("res://PotionRequests/Jessica2.tres"),
	preload("res://PotionRequests/Jessica3.tres"),
	preload("res://PotionRequests/Orc1.tres"),
	preload("res://PotionRequests/Orc2.tres"),
	preload("res://PotionRequests/Orc3.tres"),
	preload("res://PotionRequests/SchoolGirl1.tres"),
	preload("res://PotionRequests/SchoolGirl2.tres"),
	preload("res://PotionRequests/SchoolGirl3.tres"),
	preload("res://PotionRequests/TiredGirl1.tres"),
	preload("res://PotionRequests/TiredGirl2.tres"),
	preload("res://PotionRequests/TiredGirl3.tres"),
	preload("res://PotionRequests/TiredGirl4.tres"),
	preload("res://PotionRequests/VampireGirl1.tres"),
	preload("res://PotionRequests/VampireGirl2.tres"),
	preload("res://PotionRequests/VampireGirl3.tres"),
]

@onready var potion_textures: Array[Texture2D] = [
	preload("res://assets/img_potions/blue-potion.png"),
	# preload("res://assets/img_potions/green-potion.png"),
	preload("res://assets/img_potions/red-potions.png"),
	preload("res://assets/img_potions/yellow-potion.png")
]

@onready var blank_potion_texture = preload("res://assets/img_potions/blank_potion.png")

@export var audio_player: AudioStreamPlayer
@export var dialogue_audio_player: AudioStreamPlayer
@export var request: PotionRequest
@export var customer: TextureRect
@export var dialogue_container: Control
@export var dialogue: Label
@export var animation_player: AnimationPlayer
@export var dialogue_animation_player: AnimationPlayer
@export var potion: TextureRect
@onready var requests: Array[PotionRequest]

var ingredients: Array[Ingredient]

func _ready() -> void:
	dialogue_animation_player.play("speech_init")
	potion.set_texture(blank_potion_texture)
	reset_requests()
	set_random_request()
	customer_enter()

func submit_potion(submitted_ingredients: Array[Ingredient]):
	print("Potion submitted:")
	var i_1 = "empty"
	if (ingredients.size() >= 1 && !!ingredients[0]): i_1 = ingredients[0].title
	var i_2 = "empty"
	if (ingredients.size() >= 2 && !!ingredients[1]): i_2 = ingredients[1].title
	print(i_1 + ", " + i_2)
	
	ingredients = submitted_ingredients
	
	potion_exit()
	Global.is_action_allowed = false
	dialogue_animation_player.play("speech_exit")
		
func check_potion():
	var matching_tags = get_matching_ingredient_tags(ingredients)
	print("Matching tags:")
	print(matching_tags)
	
	var is_sufficient = is_matching_tags_sufficient(matching_tags)
	print ("Is sufficient:")
	print(is_sufficient)
	
	if (is_sufficient):
		Global.correct_count += 1
		set_correct_dialogue() 
		potion_exit_and_take()
	else:
		if (Global.try_count > 0):
			set_hint_dialogue(matching_tags)
		else:
			set_final_dialogue()
		
	ingredients = []

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
	Global.is_action_allowed = false
	animation_player.play("customer_exit")
	dialogue_animation_player.play("speech_exit")
	potion.set_texture(blank_potion_texture)
	
func customer_enter():
	animation_player.play("customer_enter")
	
func potion_enter():
	potion.set_texture(potion_textures.pick_random())
	animation_player.play("potion_enter")
	audio_player.set_stream(sfx_bottle)
	audio_player.play()
	
func potion_exit():
	animation_player.play("potion_exit")
	audio_player.set_stream(sfx_bottle_discard)
	audio_player.play()
	
func potion_exit_and_take():
	animation_player.play("potion_exit_and_take")
	audio_player.set_stream(sfx_bottle_grab)
	audio_player.play()

func _on_animation_finished(anim_name: StringName) -> void:
	match (anim_name):
		"potion_exit":
			potion_enter()
		"potion_enter":
			check_potion()
		"customer_enter":
			Global.is_action_allowed = true
			dialogue_animation_player.play("speech_enter")
			audio_player.set_stream(sfx_bell)
			audio_player.play()
		"customer_exit": 
			if (Global.try_count > 0):
				set_random_request()
				customer_enter()
			else:
				s_game_finished.emit()
				audio_player.set_stream(sfx_door_close)
				audio_player.play()
		"potion_exit_and_take":
			customer_exit()
			audio_player.set_stream(sfx_door_close)
			audio_player.play()
			
func _on_dialogue_animation_finished(anim_name: StringName) -> void:
	match (anim_name):
		"speech_enter":
			if (Global.try_count <= 0):
				customer_exit()
			
func set_hint_dialogue(matching_tags: Array[String]):
	var new_dialogue = ""
	
	if (matching_tags.size() == 0):
		new_dialogue = "That's not quite it. Could you try again?"
		dialogue_audio_player.set_stream(sfx_potion_wrong)
		dialogue_audio_player.play()
	else:
		new_dialogue = "I'm glad the potion seems "
		for i in range(matching_tags.size()):
			new_dialogue = new_dialogue + matching_tags[i] + ", "
			if (i == matching_tags.size() - 2): 
				new_dialogue = new_dialogue + "and "
		new_dialogue = new_dialogue + "but it's missing something..."
		dialogue_audio_player.set_stream(sfx_potion_partial)
		dialogue_audio_player.play()
		
	new_dialogue = new_dialogue + "\n\n" + request.dialogue
	
	dialogue.set_text(new_dialogue)
	dialogue_animation_player.play("speech_enter")
	Global.is_action_allowed = true

func set_final_dialogue():
	dialogue.set_text("That's not quite it.\nI'll come back tomorrow, it's getting pretty late.")
	dialogue_animation_player.play("speech_enter")
	dialogue_audio_player.set_stream(sfx_potion_wrong)
	dialogue_audio_player.play()

func set_correct_dialogue():
	dialogue.set_text("That's it!\nThanks so much for your help!")
	dialogue_animation_player.play("speech_enter")
	dialogue_audio_player.set_stream(sfx_potion_correct)
	dialogue_audio_player.play()
