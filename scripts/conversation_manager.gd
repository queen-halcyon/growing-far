extends Node2D

@onready var dialogTurnManager = $DialogTurnManager
@onready var conversation = $Area2D

var player_node = preload("res://assets/scenes/player_node.tscn")
var npc_node = preload("res://assets/scenes/npc_node.tscn")

var npc_decks = {
	"Ashley" = preload("res://assets/decks/ashley.tres"),
	"Sydney" = preload("res://assets/decks/sydney.tres"),
	"Taylor" = preload("res://assets/decks/taylor.tres"),
	"William" = preload("res://assets/decks/william.tres")
}


func _ready() -> void:
	Events.connect("conversation_over", _on_conversation_over)


func initialize(npc):
	
	var player_node_instance = player_node.instantiate()
	var npc_node_instance = npc_node.instantiate()
	
	player_node_instance.card_deck = DataGlobal.player_deck
	
	DataGlobal.current_conversation = conversation
	
	npc_node_instance.init(npc_decks[npc])
	
	dialogTurnManager.add_child(player_node_instance)
	dialogTurnManager.add_child(npc_node_instance)
	dialogTurnManager.initialize()
	
	$CanvasLayer/CurrentHand.card_deck = DataGlobal.player_deck
	$CanvasLayer/CurrentHand.initialize()
	
	dialogTurnManager.hand_turn_over()


func _on_finish_button_pressed() -> void:
	DataGlobal.current_conversation = null
	Events.emit_signal("player_ended_conversation")


func _on_conversation_over():
	$CanvasLayer/NextTurnPanel.visible = true
