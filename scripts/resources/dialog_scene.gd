extends Resource
class_name DialogScene


@export var risk : Risks

enum Risks {
	HARM,
	CONCEALMENT,
	PRESSURE
}

@export var successes_needed : int
@export var fails_needed : int
@export var defiant : int
@export var spirited : int
@export var helpful : int
@export var cunning : int

func is_dialog_over(successes: int, fails: int):
	return successes >= successes_needed or fails >= fails_needed


func was_successful(successes: int, fails: int):
	if successes >= successes_needed: return true
	return false
