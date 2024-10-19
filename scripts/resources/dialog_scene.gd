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


func is_dialog_over(successes: int, fails: int):
	return successes >= successes_needed or fails >= fails_needed
