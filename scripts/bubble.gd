class_name Bubble extends RigidBody2D


var speed := 100
var player_on_top_speed := 50


func _ready() -> void:
	linear_velocity = Vector2(0, -speed) # The bubble moves up.
	pass


func _physics_process(delta: float) -> void:
	pass
	var contacts := get_contact_count()
	if contacts == 0:
		
		linear_velocity = Vector2(0, -speed)


func _on_body_entered(body: Node) -> void:
	if body is Player:
		#if (player.position - body.position).dot(Vector2.UP) > 0:
			
		pass
	elif body is Bubble:
		pass
	else:
		pop()


func pop() -> void:
	queue_free()
