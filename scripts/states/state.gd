class_name State extends Node


enum Player {
	STILL_GROUND, MOVE_GROUND, STILL_AIR, MOVE_AIR, DEAD,
}

var player: Player


func _ready() -> void:
	player = get_parent()
	set_process(false)
	set_physics_process(false)
	set_process_input(false)


func apply_gravity(delta: float) -> void:
	player.velocity.y += player.stats.gravity_strength * delta


## Called when the player transitions to this state.
## Override this function to initialize state variables.
func on_transition() -> void:
	set_process(true)
	set_physics_process(true)
	set_process_input(true)


func jump() -> bool:
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = -player.stats.jump_strength
		player.transition_to(State.Player.STILL_AIR)
		return true
	return false
