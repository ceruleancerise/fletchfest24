extends Node

@onready var p_title_screen = preload("res://TitleScreen/TitleScreen.tscn")
@onready var p_game_screen = preload("res://GameScreen/GameScreen.tscn")
@onready var p_results_screen = preload("res://ResultsScreen/ResultsScreen.tscn")

@onready var screen_container: Control = $ScreenContainer
@onready var screen: Node = $ScreenContainer/TitleScreen

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_start_button_pressed() -> void:
	screen_exit()

func screen_enter():
	animation_player.play("screen_enter")
	
func screen_exit():
	animation_player.play("screen_exit")

func _on_animation_finished(anim_name: StringName) -> void:
	match (anim_name):
		"screen_exit":
			screen_container.remove_child(screen) 
			var new_screen: Node
			
			if (screen.screen_id == "TITLE"):
				new_screen = p_game_screen.instantiate()
			elif (screen.screen_id == "GAME"):
				new_screen = p_results_screen.instantiate()
			elif (screen.screen_id == "RESULTS"):	
				new_screen = p_title_screen.instantiate()
			else:
				print("Idk what screen you're trying to load!")
			
			screen_container.add_child(new_screen)
			screen = new_screen
			
				
			screen_enter()
