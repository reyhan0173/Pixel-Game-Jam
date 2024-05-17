class_name HumanPatrol extends Patrol

@export var shoot_state: EnemyState
@export var investigate_state: EnemyState


var player_detected: bool
var sound_heard: bool = false
var investigate_location: Vector2
var direction_to_sound


func process_frame(delta: float) -> EnemyState:
	print("parent velocity is " + str(parent.velocity))
	#if player_detected:
		#return shoot_state
	return null


func get_splash_pos(pos: Vector2):
	investigate_location = pos
	pass

#func on_sound_heard(pos: Vector2):
	#print("heard sound")
	#target_position = pos
	#sound_heard = true
	#pass


func _on_player_detection_body_entered(body):
	player_detected = true


func process_physics(delta: float) -> EnemyState:
	speed = 100
	if parent.is_on_wall():
		direction *= -1
		parent.scale.x *= -1
		parent.move_and_slide()
	if investigate_location:
		return investigate_state
		
	#if sound_heard:
		#var direction_to_sound = (target_position - parent.position).normalized()
		#if parent.position.distance_to(target_position) < 30:
			#parent.velocity = Vector2.ZERO
			#
			##sound_heard = false
		#else:
			#parent.velocity = direction_to_sound * speed
	#else:
		#parent.velocity = Vector2(speed * direction, gravity * delta)
	parent.velocity = Vector2(speed * direction, gravity * delta)
	parent.move_and_slide()
	return null
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
