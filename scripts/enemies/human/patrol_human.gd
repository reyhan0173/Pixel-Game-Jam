class_name HumanPatrol extends Patrol

@export var shoot_state: EnemyState

var player_detected: bool
var sound_heard: bool = false
var target_position: Vector2


func process_frame(delta: float) -> EnemyState:
	#if player_detected:
		#return shoot_state
	return null


func _on_sound_heard(pos: Vector2):
	target_position = pos
	sound_heard = true
	pass


func _on_player_detection_body_entered(body):
	player_detected = true


func process_physics(delta: float) -> EnemyState:
	if parent.is_on_wall():
		direction *= -1
		parent.scale.x *= -1
	if sound_heard:
		var direction_to_sound = (target_position - parent.position).normalized()
		if parent.position.distance_to(target_position - parent.position) < 10:
			parent.velocity = Vector2.ZERO
			sound_heard = false
		else:
			parent.velocity = direction_to_sound * speed
	else:
		parent.velocity = Vector2(speed * direction, gravity * delta)
	parent.move_and_slide()
	return null
