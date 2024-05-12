class_name StillAirState extends AirState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	if land():
		return
	if move_air():
		return
