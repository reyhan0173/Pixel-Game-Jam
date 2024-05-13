class_name StillAirState extends AirState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_air_resistance(delta)
	player.move_and_slide()
	if player.is_coyote_jump_enabled() and jump():
		return
	if land():
		return
	if move_air():
		return
