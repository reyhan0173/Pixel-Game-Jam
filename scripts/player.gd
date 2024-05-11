class_name Player extends CharacterBody2D


@export var ground_speed := 100
@export var jump_strength := 100
@export var gravity_strength := 1000
@export var air_speed := 100
@export var bubble_push_force := 100

var current_state: State


## Maps [enum State.Name] to [class State] nodes found in Player's children.
@onready var states := {
	State.Name.STILL_GROUND: $StillGroundState,
	State.Name.MOVE_GROUND: $MoveGroundState,
	State.Name.STILL_AIR: $StillAirState,
	State.Name.MOVE_AIR: $MoveAirState,
}


func _ready() -> void:
	transition_to(State.Name.STILL_GROUND)


#func _process(delta: float) -> void:
	#print(current_state)


func _physics_process(delta: float) -> void:
	for col_idx in get_slide_collision_count():
		var col := get_slide_collision(col_idx)
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_impulse(-col.get_normal() * bubble_push_force * delta, col.get_position() - col.get_collider().global_position)


## Transitions to another [class State].
func transition_to(state: State.Name) -> void:
	if current_state:
		current_state.set_process(false)
		current_state.set_physics_process(false)
		current_state.set_process_input(false)
	current_state = states[state]
	current_state.on_transition()


func set_facing_right(value: bool) -> void:
	$Sprite2D.flip_h = !value
