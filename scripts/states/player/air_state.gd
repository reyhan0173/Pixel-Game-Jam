class_name AirState extends State


func land() -> bool:
	if player.is_on_floor():
		player.transition_to(State.Player.STILL_GROUND)
		return true
	return false


func move_air() -> bool:
	if Input.is_action_pressed("move_left"):
		player.acceleration.x = -player.stats.air_acceleration
		if !(player.current_state is MoveAirState):
			player.transition_to(State.Player.MOVE_AIR)
		player.set_facing_right(false)
		return true
	if Input.is_action_pressed("move_right"):
		player.acceleration.x = player.stats.air_acceleration
		if !(player.current_state is MoveAirState):
			player.transition_to(State.Player.MOVE_AIR)
		player.set_facing_right(true)
		return true
	return false


func stop_air() -> bool:
	if !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		player.acceleration.x = 0
		player.transition_to(State.Player.STILL_AIR)
		return true
	return false


func apply_air_resistance(delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, delta * player.stats.air_resistance_strength)
