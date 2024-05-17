class_name WaterBall extends Area2D


var velocity: Vector2
var player: Player

var _control_radius := 32 # How far the player can control the ball.
var _acceleration_strength := 10
var _released := false
var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


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
	if body is Enemy:
		body.on_hit()
		# TODO: play splash animation before freeing. May want to lookup collision normal here.
		queue_free()
	elif _released:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Lock:
		area.unlock()
		queue_free()
