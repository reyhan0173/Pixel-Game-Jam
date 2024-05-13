extends enemy_state

@export var patrol_state: enemy_state

var speed: float = 0

var direction: int = 1

func enter() -> void:
	#parent.animations.play(animation_name)
	parent.velocity = Vector2(speed * direction, 0)

func exit() -> void:
	# stop animation?
	pass

func process_frame(delta: float) -> enemy_state:
	return null

func process_physics(delta: float) -> enemy_state:
	
	if parent.is_on_wall():
		direction *= -1
		parent.scale.x *= -1
		
	parent.velocity = Vector2(speed * direction, gravity * delta)
	parent.move_and_slide()
	
	
	return null
