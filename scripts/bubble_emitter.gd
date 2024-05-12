extends Node2D


@export var bubble_spawn_time := 1.0:
	set(value):
		bubble_spawn_time = value
		$Timer.wait_time = value


func _on_timer_timeout() -> void:
	spawn_bubble()


func spawn_bubble() -> void:
	var bubble := preload("res://scenes/bubble.tscn").instantiate()
	bubble.position = position
	get_parent().add_child(bubble) # Add the bubble to the world.
