class_name LockIndicator extends TextureRect


func turn_off() -> void:
	$AnimationPlayer.play("turn_off")


func turn_on() -> void:
	$AnimationPlayer.play("RESET")
