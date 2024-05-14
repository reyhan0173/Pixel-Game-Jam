class_name WaterTank extends Area2D


## Number of blocks of water in the tank.
var water_level: int
## Seconds to drain one block of water.
var _drain_time := 0.25
## Area of the tank in tiles.
var _area: int


func _ready() -> void:
	_area = $Border.size.x * $Border.size.y / 256 # Divide by 16^2 to get area in tiles.
	water_level = _area # Initial water level is the area of the tank.


## Removes [param amount] blocks of water from the tank.
## Returns the number of water blocks successfully removed.
func remove_water(amount: int) -> int:
	if water_level == 0: # There is no water left. Do nothing.
		return 0
	amount = min(water_level, amount) # Extract at most the water left.
	water_level -= amount
	var tween := create_tween()
	var new_height: int = $Border.size.y * (1 - 1.0 * water_level / _area) # new position of the water in pixels.
	tween.tween_property(%Water, "position:y", new_height, _drain_time * amount)
	return amount


## Highlight/dehighlight the tank to let the player know this tank can be interacted with.
func set_highlighted(value: bool) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		set_highlighted(true)
		body.interact_pressed.connect(_on_player_interact_pressed.bind(body))


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		set_highlighted(false)
		body.interact_pressed.disconnect(_on_player_interact_pressed)


func _on_player_interact_pressed(player: Player) -> void:
	var amount := remove_water(player.get_empty_water_level())
	player.fill_water(amount)
