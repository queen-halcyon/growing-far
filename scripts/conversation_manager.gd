extends Node2D

@onready var dialogTurnManager = $DialogTurnManager
@onready var conversation = $CanvasLayer/Panel/ConversationCards/CardDropTarget

var player_node = preload("res://assets/scenes/player_node.tscn")
var npc_node = preload("res://assets/scenes/npc_node.tscn")

var npc_decks = {
	"Ashley" = preload("res://assets/decks/ashley.tres"),
	"Sydney" = preload("res://assets/decks/sydney.tres"),
	"Taylor" = preload("res://assets/decks/taylor.tres"),
	"William" = preload("res://assets/decks/william.tres")
}

var npc_scenes = {
	"Ashley" = [preload("res://assets/scenes/hangout1.tres"), preload("res://assets/scenes/hangout2.tres")],
	"Sydney" = [preload("res://assets/scenes/sports1.tres"), preload("res://assets/scenes/sports2.tres")],
	"Taylor" = [preload("res://assets/scenes/hangout1.tres"), preload("res://assets/scenes/hangout2.tres")],
	"William" = [preload("res://assets/scenes/magic1.tres"), preload("res://assets/scenes/magic2.tres")]
}


func _ready() -> void:
	Events.connect("conversation_over", _on_conversation_over)


func initialize(npc):
	var possible_scenes = npc_scenes[npc]
	var chosen_scene = DataGlobal.rng.randi_range(0, possible_scenes.size() - 1)
	
	DataGlobal.current_scene = possible_scenes[chosen_scene]
	
	var player_node_instance = player_node.instantiate()
	player_node_instance.name = "Player"
	var npc_node_instance = npc_node.instantiate()
	npc_node_instance.name = "NPC"
	
	player_node_instance.card_deck = DataGlobal.player_deck
	
	DataGlobal.current_conversation = conversation
	
	npc_node_instance.init(npc_decks[npc])
	
	dialogTurnManager.add_child(player_node_instance)
	dialogTurnManager.add_child(npc_node_instance)
	dialogTurnManager.turn_announcer = $CanvasLayer/TurnAnnouncer
	dialogTurnManager.initialize()
	
	$CanvasLayer/CurrentHand.card_deck = DataGlobal.player_deck
	$CanvasLayer/CurrentHand.initialize()
	


func _on_finish_button_pressed() -> void:
	var was_successful = DataGlobal.current_scene.was_successful(conversation.successes, conversation.fails)
	DataGlobal.current_conversation = null
	Events.emit_signal("player_ended_conversation")


func _on_conversation_over():
	$CanvasLayer/NextTurnPanel.visible = true
