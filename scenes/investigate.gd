class_name HumanInvestigate extends HumanPatrol

@export var patrol_state: EnemyState

@onready var investigate_pause = $Patrol_Pause

var target_position: Vector2
var return_to_patrol := false

func process_frame(delta: float) -> EnemyState:
	if return_to_patrol:
		return_to_patrol = false
		investigate_location = Vector2.ZERO
		return patrol_state
	print("distance is") 
	print(parent.position.distance_to(target_position))
	return null


#func on_sound_heard(pos: Vector2):
	#print("heard sound")
	#target_position = pos
	#sound_heard = true
	#pass
	


func _on_player_detection_body_entered(body):
	player_detected = true


func process_physics(delta: float) -> EnemyState:
	if investigate_location:
		var direction_to_sound = (investigate_location - parent.position).normalized()
		if parent.position.distance_to(investigate_location) < 30:
			parent.velocity = Vector2.ZERO
			investigate_pause.start()
		else:
			parent.velocity = direction_to_sound * speed
	else:
		return patrol_state
	parent.move_and_slide()
	return null



func _on_patrol_pause_timeout():
	return_to_patrol = true # Replace with function body.
