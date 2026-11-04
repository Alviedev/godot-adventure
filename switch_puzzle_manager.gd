extends Marker2D

var score: int

signal puzzle_solved
signal puzzle_failed

@export var target_score: int

func increase_score(): 
	score += 1
	print(score)
	if score >= target_score:
		puzzle_solved.emit()

func decrease_score():
	score -= 1
	print(score)
	if score < target_score:
		puzzle_failed.emit()
