class_name Enemy
extends CharacterBody2D

@onready
var state_machine = $state_machine
@onready
var player_detection: = $player_detection
@onready
var ledgeCheckRight: = $LedgeCheckRight
@onready
var ledgeCheckLeft: = $LedgeCheckLeft
@onready
var sprite: = $Temproombot


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)


