class_name WaterMeter extends TextureProgressBar


## Returns the amount of water in the meter.
func get_water_level() -> int:
	return %WaterMeter.value


## Returns the amount of empty space in the water meter.
func get_empty_water_level() -> int:
	return %WaterMeter.max_value - %WaterMeter.value


## Fill the water level by [param amount].
func fill_water(amount: int) -> void:
	%WaterMeter.value += amount


## Remove the water level by [param amount].
func remove_water(amount: int) -> void:
	%WaterMeter.value -= amount
