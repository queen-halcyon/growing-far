extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_animation_player_tree_entered() -> void:
	pass # Replace with function body.



func _on_tree_exiting() -> void:
	if animation_player:
		animation_player.play("fade_out")
		animation_player.play("fade_in")
