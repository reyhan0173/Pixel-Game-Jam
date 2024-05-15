class_name Goal extends Interactable


func _on_player_interact_pressed(player: Player) -> void:
	super._on_player_interact_pressed(player)
	if player.water_meter.get_water_level() >= 0:
		player.goal_reached.emit()
