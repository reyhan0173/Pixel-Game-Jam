class_name MoveAirState extends AirState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	player.velocity += player.acceleration * delta
	player.velocity.x = clamp(player.velocity.x, -player.stats.air_max_speed, player.stats.air_max_speed)
	player.move_and_slide()
	if land():
		return
	if move_air():
		return
	if stop_air():
		return
