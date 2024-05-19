class_name HumanPatrol extends Patrol

@export var shoot_state: EnemyState
#@export var investigate_state: EnemyState
@onready var timer = $Timer
@onready var direction_node = get_node("../../direction")
#@onready var sprite = get_node("../Temphuman")

var player_detected: bool
var sound_heard: bool = false
var investigate_location: Vector2
var direction_to_sound
var walking_to_sound: bool = false
var currently_investigating: bool = false


func process_frame(_delta: float) -> EnemyState:
	#print("walking_to_sound: " + str(walking_to_sound))
	#print("currently_investigating: " + str(currently_investigating))
	#print(timer.time_left)
	#print("investigate_location.x: " + str(investigate_location.x))
	#print("parent.velocity.x: " + str(parent.velocity.x))
	#print(direction_to_sound)
	print("Current Scale in Human: " + str(direction_node.scale.x))
	
	if player_detected:
		return shoot_state
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
## Sprite and Body does not face direction of sound

func process_physics(delta: float) -> EnemyState:
	if parent.is_on_wall():
		direction *= -1
		direction_node.scale.x *= -1
	if walking_to_sound:
		var direction_to_sound = (investigate_location - parent.position).normalized()
		var horizontal_velocity = direction_to_sound.x * speed
		if parent.position.distance_to(investigate_location) < 40:
			currently_investigating = true
			walking_to_sound = false
			timer.start()
			parent.velocity = Vector2.ZERO
		else:
			parent.velocity.x = horizontal_velocity
			parent.velocity.y = gravity * delta
			if parent.velocity.x > 0:
				direction_node.scale.x = 1
			if parent.velocity.x < 0:
				direction_node.scale.x= -1
	if currently_investigating:
		parent.velocity = Vector2.ZERO
	if !walking_to_sound && !currently_investigating:
		parent.velocity = Vector2(speed * direction, gravity * delta)
	parent.move_and_slide()
	return null

func _on_timer_timeout():
	currently_investigating = false
