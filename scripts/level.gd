class_name Level extends TileMap


signal goal_reached


@export var limit_left: int
@export var limit_top: int
@export var limit_right: int
@export var limit_bottom: int


var _held_water_ball: WaterBall


func _ready() -> void:
	spawn_player()


func spawn_player() -> void:
	var player := preload("res://scenes/player.tscn").instantiate()
	add_child(player)
	player.goal_reached.connect(
		func() -> void:
			goal_reached.emit()
	)
	player.water_ball_created.connect(
		func() -> void:
			_held_water_ball = preload("res://scenes/water_ball.tscn").instantiate()
			_held_water_ball.player = player
			_held_water_ball.position = player.position
			add_child(_held_water_ball)
	)
	player.water_ball_released.connect(
		func() -> void:
			if !_held_water_ball: # There is no water ball. Probably won't reach this line.
				return
			_held_water_ball.release()
	)
	player.position = $Spawn.position
	player.on_level_entered(self)
