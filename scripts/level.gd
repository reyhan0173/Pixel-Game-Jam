class_name Level extends TileMap


signal goal_reached


@export var limit_left: int
@export var limit_top: int
@export var limit_right: int
@export var limit_bottom: int


func _ready() -> void:
	spawn_player()


func spawn_player() -> void:
	var player := preload("res://scenes/player.tscn").instantiate()
	add_child(player)
	player.goal_reached.connect(
		func() -> void:
			goal_reached.emit()
	)
	player.position = $Spawn.position
	player.on_level_entered(self)
