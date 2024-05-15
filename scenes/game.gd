class_name Game extends Node2D


var current_level: Level


var _level_resource := preload("res://levels.tres")
var _current_level_index := 0

var _transition_time := 0.5


func _ready() -> void:
	transition_to_level(_current_level_index)


func transition_to_level(level_index: int) -> void:
	var level: Level = _level_resource.levels[level_index].instantiate()
	var tween := create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tween.tween_property($ColorRect, "modulate:a", 1.0, _transition_time)
	tween.tween_callback(
		func() -> void:
			if current_level:
				current_level.queue_free()
			current_level = level
			add_child(level)
			level.goal_reached.connect(
				func() -> void:
					_current_level_index += 1
					if _current_level_index >= _level_resource.levels.size():
						win()
					else:
						transition_to_level(_current_level_index)
			)
			var tween2 := create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
			tween2.tween_property($ColorRect, "modulate:a", 0.0, _transition_time)
	)


func win() -> void:
	print("YOU WON!")
