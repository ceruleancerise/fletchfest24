extends Control

signal s_menu_button_pressed()

@export var screen_id: String = "RESULTS"

@export var score: Label
@export var letter_grade: Label
@export var letter_grade_description: Label

func _ready() -> void:
	set_score()
	set_letter_grade()
	set_letter_grade_description()
	
func set_score():
	score.set_text(str(Global.correct_count) + " / " + str(Global.MAX_TRY_COUNT))
	
func set_letter_grade():
	var percentage = float(Global.correct_count) / float(Global.MAX_TRY_COUNT)
	print("Percentage: " + str(percentage))
	
	var grade = ""
	# You know how floats are
	if (percentage >= 0.99):
		grade = "A+"
	elif (percentage >= 0.89):
		grade = "A"
	elif (percentage >= 0.79):
		grade = "B"
	elif (percentage >= 0.69):
		grade = "B-"
	elif (percentage >= 0.59):
		grade = "C"
	elif (percentage >= 0.49):
		grade = "C-"
	elif (percentage >= 0.39):
		grade = "D"
	else:
		grade = "F"
	
	letter_grade.set_text(grade)
	
func set_letter_grade_description():
	var percentage = float(Global.correct_count) / float(Global.MAX_TRY_COUNT)
	print("Percentage: " + str(percentage))
	
	var description = ""
	# You know how floats are
	if (percentage >= 0.99):
		description = "Perfect performance!\nYou are a potion brewing master!"
	elif (percentage >= 0.89):
		description = "Amazing work!\nYou have a supreme knack for this stuff!"
	elif (percentage >= 0.79):
		description = "Well done!\nA greatly skilled apothecary is always appreciated!"
	elif (percentage >= 0.69):
		description = "Great work!\nYou've shown skill in potion making!"
	elif (percentage >= 0.59):
		description = "Alright!\nDespites some mistakes, you brewed some good potions!"	
	elif (percentage >= 0.49):
		description = "Nice try!\nWith some more practice, you'll get there one day!"	
	elif (percentage >= 0.39):
		description = "Oh dear!\nMight giving it another try?"	
	else:
		description = "Oh no...\nThere's always next time!"	
	
	letter_grade_description.set_text(description)

func _on_menu_button_pressed() -> void:
	s_menu_button_pressed.emit()
