class_name MoveGroundState extends GroundState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	player.velocity += player.acceleration * delta
	player.velocity = player.velocity.limit_length(player.stats.ground_max_speed)
	player.move_and_slide()
	if fall():
		player.set_coyote_jump_enabled(true)
		return
	if jump():
		return
	if stop():
		return
	if move(delta):
		return
