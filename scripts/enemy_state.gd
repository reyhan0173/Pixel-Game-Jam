class_name enemy_state
extends Node

@export
var animation_name: String
@export
var move_speed: float = 300

# Add consistent gravity for this
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: Enemy

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> enemy_state:
	return null

func process_frame(delta: float) -> enemy_state:
	return null

func process_physics(delta: float) -> enemy_state:
	return null
