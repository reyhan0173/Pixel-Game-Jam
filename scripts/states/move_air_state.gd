class_name MoveAirState extends AirState


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	if land():
		return
	if move_air():
		return
	if stop_air():
		return
