class_name HumanShoot extends EnemyState

@export var patrol_state: EnemyState

var direction: int
var is_firing: bool
var player_list: Array
var player
var player_pos

signal player_position


func enter() -> void:
	parent.velocity = Vector2.ZERO
	is_firing = false
	pass


func exit() -> void:
	get_node("../../direction/Line2D").reset_laser()
	pass


func process_frame(delta: float) -> EnemyState:
	if parent.player_detection.has_overlapping_bodies():
		player_list = parent.player_detection.get_overlapping_bodies()
		if player_list.size() > 0:
			player = player_list[0]
			player_pos = player.global_position
			player_position.emit(player_pos)
			is_firing = true
	else:
		is_firing = false
		return patrol_state
	return null


func process_physics(delta: float) -> EnemyState:
	return null
