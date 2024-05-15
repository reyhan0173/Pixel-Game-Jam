class_name Door extends Interactable
## Doors have a "Teleport" node as a child that defines where the Player will go
## when they interact with the door.

## Instantiate the door and set editable_children to true to change the position.


func _on_player_interact_pressed(player: Player) -> void:
	super._on_player_interact_pressed(player)
	player.position = $Teleport.global_position
