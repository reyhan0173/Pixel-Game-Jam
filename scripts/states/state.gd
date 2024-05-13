class_name State extends Node


enum Name {
	STILL_GROUND, MOVE_GROUND, STILL_AIR, MOVE_AIR,
}

var player: Player


func _ready() -> void:
	player = get_parent()
	set_process(false)
	set_physics_process(false)
	set_process_input(false)


func apply_gravity(delta: float) -> void:
	player.velocity.y += player.gravity_strength * delta
	player.move_and_slide()


## Called when the player transitions to this state.
## Override this function to initialize state variables.
func on_transition() -> void:
	set_process(true)
	set_physics_process(true)
	set_process_input(true)
