class_name Interactable extends Area2D
## All interactables in the game.
## Will highlight when a Player enters it, and prompt a button to be pressed.


## Highlight/dehighlight the object to let the player know this object can be interacted with.
func set_highlighted(value: bool) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		set_highlighted(true)
		body.interact_pressed.connect(_on_player_interact_pressed.bind(body))


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		set_highlighted(false)
		body.interact_pressed.disconnect(_on_player_interact_pressed)


func _on_player_interact_pressed(player: Player) -> void:
	pass
