class_name Lock extends Area2D


signal unlocked


func unlock() -> void:
	$AnimationPlayer.play("unlock")
	unlocked.emit()
