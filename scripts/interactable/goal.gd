class_name Goal extends Interactable


## How many locks are preventing this door from opening.
@export_range(1, 4) var lock_count := 1


var _lock_indicators: Array[LockIndicator] = []


func _ready() -> void:
	for i in range(lock_count):
		$LockIndicatorContainer.get_child(i).turn_on()
	for i in range(lock_count, 4):
		$LockIndicatorContainer.get_child(i).turn_off()
	for lock in $Locks.get_children():
		if lock is Lock:
			lock.unlocked.connect(
				func() -> void:
					lock_count -= 1
					$LockIndicatorContainer.get_child(lock_count).turn_off()
					if lock_count == 0:
						open()
			)


## Open the door.
func open() -> void:
	$AnimationPlayer.play("open")


func _on_player_interact_pressed(player: Player) -> void:
	super._on_player_interact_pressed(player)
	if lock_count == 0:
		player.goal_reached.emit()
