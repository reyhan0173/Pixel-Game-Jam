class_name Human
extends CharacterBody2D

@onready
var sprite: = $Temphuman

@onready
var state_machine = $state_machine
@onready
var player_detection: = $player_detection


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
