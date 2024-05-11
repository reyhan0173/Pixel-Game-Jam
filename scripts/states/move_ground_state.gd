class_name MoveGroundState extends GroundState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	#player.move_and_slide()
	if fall():
		return
	if jump():
		return
	if stop():
		return
	if move():
		return
