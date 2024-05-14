class_name BotPatrol extends Patrol

@export var alert_state: EnemyState


func process_frame(delta: float) -> EnemyState:
	if parent.player_detection.is_colliding():
		alert_state.direction = direction
		return alert_state
	return null
