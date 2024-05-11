class_name GroundState extends State
## All states that happen on the ground.


func move() -> bool:
	if Input.is_action_pressed("move_left"):
		player.velocity.x = -player.ground_speed
		player.transition_to(State.Name.MOVE_GROUND)
		player.set_facing_right(false)
		return true
	if Input.is_action_pressed("move_right"):
		player.velocity.x = player.ground_speed
		player.transition_to(State.Name.MOVE_GROUND)
		player.set_facing_right(true)
		return true
	return false


func stop() -> bool:
	if !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		player.velocity.x = 0
		player.transition_to(State.Name.STILL_GROUND)
		return true
	return false


func jump() -> bool:
	if Input.is_action_pressed("jump"):
		player.velocity.y = -player.jump_strength
		player.transition_to(State.Name.STILL_AIR)
		return true
	return false


func fall() -> bool:
	if !player.is_on_floor():
		print("HELLO?")
		player.transition_to(State.Name.STILL_AIR)
		return true
	return false
