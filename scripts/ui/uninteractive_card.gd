extends Control

var sprites = [
	preload("res://assets/ui/suit_spades.png"),
	preload("res://assets/ui/suit_hearts.png"),
	preload("res://assets/ui/suit_diamonds.png"),
	preload("res://assets/ui/suit_clubs.png")
]

var card : Symbol

func display_symbols():
	$LeftSymbol.texture = sprites[card.left_symbol]
	$RightSymbol.texture = sprites[card.right_symbol]
