extends Node

@onready var p_title_screen = preload("res://TitleScreen/TitleScreen.tscn")
@onready var p_game_screen = preload("res://GameScreen/GameScreen.tscn")
@onready var p_results_screen = preload("res://ResultsScreen/ResultsScreen.tscn")

@onready var music = preload("res://assets/music/leaflet-fletchfest24-music.wav")

@onready var sfx_twinkle = preload("res://assets/sfx_ui/twinkle.mp3")

@onready var screen_container: Control = $ScreenContainer
@onready var screen: Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var audio_player = $AudioPlayer
@onready var music_player = $MusicPlayer

func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(.777)
	timer.set_one_shot(true)
	timer.connect("timeout", screen_exit)
	timer.connect("timeout", play_music)
	timer.start()
	
func play_music():
	music_player.set_stream(music)
	music_player.play()

func _on_start_button_pressed() -> void:
	screen_exit()

func screen_enter():
	animation_player.play("screen_enter")
	
func screen_exit():
	if (!!screen && screen.screen_id != "RESULTS"):
		audio_player.set_stream(sfx_twinkle)
		audio_player.play()
	animation_player.play("screen_exit")

func _on_animation_finished(anim_name: StringName) -> void:
	match (anim_name):
		"screen_exit":
			if (!!screen): screen_container.remove_child(screen) 
			var new_screen: Node
			
			var screen_id = "RESULTS"
			if (!!screen): screen_id = screen.screen_id
			
			if (screen_id == "TITLE"):
				new_screen = p_game_screen.instantiate()
				screen_container.add_child(new_screen)
				new_screen.connect("s_game_finished", screen_exit)
				
			elif (screen_id == "GAME"):
				new_screen = p_results_screen.instantiate()
				screen_container.add_child(new_screen)
				new_screen.connect("s_menu_button_pressed", screen_exit)
				
			elif (screen_id == "RESULTS"):	
				new_screen = p_title_screen.instantiate()
				screen_container.add_child(new_screen)
				new_screen.connect("s_start_button_pressed", screen_exit)
			else:
				print("Idk what screen you're trying to load!")
			
			
			screen = new_screen
			
				
			screen_enter()
