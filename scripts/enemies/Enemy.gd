class_name Enemy extends CharacterBody2D

@onready var state_machine := $state_machine
@onready var animations


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


## Called when hit by a water ball.
func on_hit() -> void:
	pass
