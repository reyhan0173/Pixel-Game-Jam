class_name Player extends CharacterBody2D


@export var stats: PlayerConfig
var current_state: State
var acceleration: Vector2


## Maps [enum State.Player] to [class State] nodes found in Player's children.
@onready var states := {
	State.Player.STILL_GROUND: $StillGroundState,
	State.Player.MOVE_GROUND: $MoveGroundState,
	State.Player.STILL_AIR: $StillAirState,
	State.Player.MOVE_AIR: $MoveAirState,
}


func _ready() -> void:
	transition_to(State.Player.STILL_GROUND)


## Transitions to another [class State].
func transition_to(state: State.Player) -> void:
	if current_state:
		current_state.set_process(false)
		current_state.set_physics_process(false)
		current_state.set_process_input(false)
	current_state = states[state]
	current_state.on_transition()


func set_facing_right(value: bool) -> void:
	$Sprite2D.flip_h = !value



func set_coyote_jump_enabled(value: bool) -> void:
	if value and !is_coyote_jump_enabled():
		$CoyoteJumpTimer.start()
	elif !value:
		$CoyoteJumpTimer.stop()


func is_coyote_jump_enabled() -> bool:
	return !$CoyoteJumpTimer.is_stopped()

func player_die() -> void:
	queue_free()
