class_name AirState extends State


func land() -> bool:
	if player.is_on_floor():
		player.velocity.x = 0
		player.velocity.y = 0
		player.transition_to(State.Name.STILL_GROUND)
		return true
	return false


func move_air() -> bool:
	if Input.is_action_pressed("move_left"):
		player.velocity.x = -player.air_speed
		player.transition_to(State.Name.MOVE_AIR)
		player.set_facing_right(false)
		return true
	if Input.is_action_pressed("move_right"):
		player.velocity.x = player.air_speed
		player.transition_to(State.Name.MOVE_AIR)
		player.set_facing_right(true)
		return true
	return false


func stop_air() -> bool:
	if !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		player.velocity.x = 0
		player.transition_to(State.Name.STILL_AIR)
		return true
	return false
