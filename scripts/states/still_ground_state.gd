class_name StillGroundState extends GroundState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	if fall():
		return
	if jump():
		return
	if move():
		return
