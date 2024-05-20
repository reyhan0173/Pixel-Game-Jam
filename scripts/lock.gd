class_name Lock extends Area2D


signal unlocked


func unlock() -> void:
	print("A")
	$AnimationPlayer.play("unlock")
	unlocked.emit()
