extends Node2D


var BASE_WINDOW_SIZE: Vector2
const default_cursor := preload("res://assets/cursor/cursor.png")


const DEFAULT := Input.CURSOR_ARROW
const HOVER_BUTTON := Input.CURSOR_POINTING_HAND


func _ready() -> void:
	BASE_WINDOW_SIZE.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	BASE_WINDOW_SIZE.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	update()


func update() -> void:
	var scale_multiple := mini(floor(get_tree().root.size.x / BASE_WINDOW_SIZE.x), floor(get_tree().root.size.y / BASE_WINDOW_SIZE.y))
	
	var image := default_cursor.get_image()
	image.resize(int(default_cursor.get_size().x * scale_multiple), int(default_cursor.get_size().y * scale_multiple), Image.INTERPOLATE_NEAREST)
	var texture := ImageTexture.create_from_image(image)
	Input.set_custom_mouse_cursor(texture, DEFAULT)
