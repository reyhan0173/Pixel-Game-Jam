class_name WaterBall extends Area2D

@onready var splash_sound = $Area2D/CollisionShape2D

var velocity: Vector2
var player: Player
var humans: Array
var patrol

var _control_radius := 32 # How far the player can control the ball.
var _acceleration_strength := 10
var _released := false
var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var splash_location: Vector2

signal send_pos

func _ready():
	splash_sound.disabled = true


func _physics_process(delta: float) -> void:
	if !_released:
		# Limit the range of the target position.
		var target_position := player.position + (get_global_mouse_position() - player.position).limit_length(_control_radius)
		velocity = position.lerp(target_position, delta * _acceleration_strength) - position
	else:
		# Subject the water ball to gravity when we release it.
		velocity.y += _gravity * delta
	position += velocity


func release() -> void:
	_released = true


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	var body_name = body.name
	if body is Enemy:
		body.on_hit()
	if body_name == "Level2":
		splash_sound.disabled = false
		print("sound queue given")
		print(splash_sound.disabled)
		pass
	# TODO: play splash animation before freeing. May want to lookup collision normal here.
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("detected human")
	splash_location = self.position
	#patrol_behaviour = body.get_node("state_machine/patrol")
	#patrol_behaviour.get_splash_pos(splash_location)
	patrol = body.get_node("state_machine/patrol")
	patrol.get_splash_pos(splash_location)
	pass
