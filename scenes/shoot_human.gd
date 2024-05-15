class_name HumanShoot extends EnemyState

@export var patrol_state: EnemyState

var direction: int
var is_firing: bool
var player_list: Array
var player
var player_pos

signal player_position

func enter() -> void:
	is_firing = false
	pass


func exit() -> void:
	pass


func process_frame(delta: float) -> EnemyState:
	if !is_firing:
		player_list = parent.player_detection.get_overlapping_bodies()
		player = player_list[0]
		player_pos = player.global_position
		player_position.emit(player_pos)
		is_firing = true
	#else:
		#return patrol_state
		
	return null


func process_physics(delta: float) -> EnemyState:
	return null
