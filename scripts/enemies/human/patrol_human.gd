class_name HumanPatrol extends Patrol

@export var shoot_state: EnemyState
#@export var investigate_state: EnemyState
@onready var timer = $Timer

var player_detected: bool
var sound_heard: bool = false
var investigate_location: Vector2
var direction_to_sound
var walking_to_sound: bool = false
var currently_investigating: bool = false


func process_frame(delta: float) -> EnemyState:
	#print("walking_to_sound: " + str(walking_to_sound))
	#print("currently_investigating: " + str(currently_investigating))
	#print(timer.time_left)
	print("investigate_location.x: " + str(investigate_location.x))
	print("parent.position.x: " + str(parent.position.x))
	print(direction_to_sound)
	
	#if player_detected:
		#return shoot_state
	return null


func get_splash_pos(pos: Vector2):
	investigate_location = pos
	walking_to_sound = true
	pass

#func on_sound_heard(pos: Vector2):
	#print("heard sound")
	#target_position = pos
	#sound_heard = true
	#pass


func _on_player_detection_body_entered(body):
	player_detected = true


##### CURRENT ISSUES: ########
## Gravity does not apply when walking to sound
## Sprite and Body does not face direction of sound

func process_physics(delta: float) -> EnemyState:
	if parent.is_on_wall():
		direction *= -1
		parent.scale.x *= -1
	if walking_to_sound:
		var direction_to_sound = (investigate_location - parent.position).normalized()
		if parent.position.distance_to(investigate_location) < 40:
			currently_investigating = true
			walking_to_sound = false
			timer.start()
			parent.velocity = Vector2.ZERO
		else:
			parent.velocity = direction_to_sound * speed
			#
			if investigate_location.x > parent.position.x:
				parent.sprite.x = 1
			elif investigate_location.x < parent.position.x:
				parent.scale.x = -1
				
	if currently_investigating:
		parent.velocity = Vector2.ZERO
	if !walking_to_sound && !currently_investigating:
		parent.velocity = Vector2(speed * direction, gravity * delta)
	parent.move_and_slide()
	return null

func _on_timer_timeout():
	currently_investigating = false
