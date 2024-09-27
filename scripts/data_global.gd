extends Node

var defiant = 0
var spirited = 0
var helpful = 0
var cunning = 0
var stress = 0

var ending : Ending


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)

func reset():
	defiant = 0
	spirited = 0
	helpful = 0
	cunning = 0
	stress = 0
