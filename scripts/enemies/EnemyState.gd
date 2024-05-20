class_name EnemyState extends Node

@export var animation_name: String
@export var move_speed: float = 300

# Add consistent gravity for this
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
# Instead of assigning Enemy type which changes
var parent: Enemy


func enter() -> void:
	if parent.has_node("AnimationPlayer"):
		parent.get_node("AnimationPlayer").play(animation_name)
	#parent.animations.play(animation_name)
	pass


func exit() -> void:
	pass


func process_input(event: InputEvent) -> EnemyState:
	return null


func process_frame(delta: float) -> EnemyState:
	return null


func process_physics(delta: float) -> EnemyState:
	return null
