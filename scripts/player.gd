class_name Player extends CharacterBody2D


## Emitted when the player presses the interact button.
signal interact_pressed
signal died
signal goal_reached
signal water_ball_created
signal water_ball_released


@export var stats: PlayerConfig
var current_state: State
var acceleration: Vector2
@onready var water_meter: WaterMeter = %WaterMeter


## Maps [enum State.Player] to [class State] nodes found in Player's children.
@onready var states := {
	State.Player.STILL_GROUND: $StillGroundState,
	State.Player.MOVE_GROUND: $MoveGroundState,
	State.Player.STILL_AIR: $StillAirState,
	State.Player.MOVE_AIR: $MoveAirState,
	State.Player.DEAD: $DeadState,
}


func _ready() -> void:
	transition_to(State.Player.STILL_GROUND)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact_pressed.emit()
	if event.is_action_pressed("water_ball"):
		if water_meter.get_water_level() > 0:
			water_meter.remove_water(1)
			water_ball_created.emit()
		else:
			# TODO: Indicator to show we lack water (e.g. flash water meter).
			pass
	elif event.is_action_released("water_ball"):
		water_ball_released.emit()


func on_level_entered(level: Level) -> void:
	$Camera2D.limit_left = level.limit_left
	$Camera2D.limit_right = level.limit_right
	$Camera2D.limit_top = level.limit_top
	$Camera2D.limit_bottom = level.limit_bottom


## Transitions to another [class State].
func transition_to(state: State.Player) -> void:
	if current_state:
		current_state.set_process(false)
		current_state.set_physics_process(false)
		current_state.set_process_input(false)
	current_state = states[state]
	current_state.on_transition()
	if current_state is MoveGroundState:
		$AnimationPlayer.play("move")
	else:
		$AnimationPlayer.play("still")


func set_facing_right(value: bool) -> void:
	$Sprite2D.flip_h = !value


## Allows the player to perform a coyote jump if they cannot already.
func set_coyote_jump_enabled(value: bool) -> void:
	if value and !is_coyote_jump_enabled():
		$CoyoteJumpTimer.start()
	elif !value:
		$CoyoteJumpTimer.stop()


func is_coyote_jump_enabled() -> bool:
	return !$CoyoteJumpTimer.is_stopped()


func die() -> void:
	transition_to(State.Player.DEAD)
	died.emit() # TODO: emit after a delay (once die animation completes)
