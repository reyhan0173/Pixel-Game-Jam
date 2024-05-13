class_name StillGroundState extends GroundState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_friction(delta)
	player.move_and_slide()
	if fall():
		return
	if jump():
		return
	if move(delta):
		return
