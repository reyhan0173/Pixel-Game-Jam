class_name GroundState extends State
## All states that happen on the ground.


func move(delta: float) -> bool:
	if Input.is_action_pressed("move_left"):
		player.acceleration.x = -player.stats.ground_acceleration
		if !(player.current_state is MoveGroundState):
			player.transition_to(State.Player.MOVE_GROUND)
		player.set_facing_right(false)
		return true
	if Input.is_action_pressed("move_right"):
		player.acceleration.x = player.stats.ground_acceleration
		if !(player.current_state is MoveGroundState):
			player.transition_to(State.Player.MOVE_GROUND)
		player.set_facing_right(true)
		return true
	return false


func stop() -> bool:
	if !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		player.acceleration.x = 0
		player.transition_to(State.Player.STILL_GROUND)
		return true
	return false


func fall() -> bool:
	if !player.is_on_floor():
		player.transition_to(State.Player.STILL_AIR)
		return true
	return false


func apply_friction(delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, delta * player.stats.friction_strength)
