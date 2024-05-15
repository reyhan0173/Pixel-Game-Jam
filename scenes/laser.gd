extends RayCast2D

@onready var line = $Line2D

var direction: Vector2
var is_firing: bool

func _ready() -> void:
	is_firing = false
	pass


func _physics_process(delta: float) -> void:
	pass

func fire(player_pos):
	#direction = get_collision_point()
	#to_local(player_pos)
	#direction = player_pos
	#print(direction)
	#print(player_pos)
	line.points[1] = player_pos - get_parent().position
	line.start_firing_animation()
	is_firing = false
	pass


func _on_shoot_player_position(player_pos):
	fire(player_pos)
