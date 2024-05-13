extends enemy_state

@export var patrol_state: enemy_state

var speed: float = 100

var direction: int = 1

func enter() -> void:
	#parent.animations.play(animation_name)
	
	# dont have to set character velocity
	parent.velocity = Vector2(speed * direction, 0)

func exit() -> void:
	# stop animation?
	pass

func process_frame(delta: float) -> enemy_state:
	if parent.is_on_wall():
		return patrol_state
	return null

func process_physics(delta: float) -> enemy_state:
	
	parent.velocity = Vector2(speed * direction, gravity * delta)
	parent.move_and_slide()
	
	
	return null
