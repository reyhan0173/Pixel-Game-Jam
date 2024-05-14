class_name HumanPatrol extends Patrol

#@export var alert_state: enemy_state

func process_frame(delta: float) -> EnemyState:
	#if parent.player_detection.is_colliding():
		#alert_state.direction = direction
		#return alert_state
	return null
