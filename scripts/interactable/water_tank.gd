class_name WaterTank extends Interactable


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


func _on_player_interact_pressed(player: Player) -> void:
	super._on_player_interact_pressed(player)
	var amount := remove_water(player.water_meter.get_empty_water_level())
	player.water_meter.fill_water(amount)
