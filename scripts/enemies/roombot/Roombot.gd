class_name Roombot extends Enemy

@onready var player_detection := $player_detection
@onready var sprite := $Temproombot


func on_hit() -> void:
	super.on_hit()
	# TODO: Death animation before free
	queue_free()
