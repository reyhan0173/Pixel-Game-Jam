extends Line2D

var tween: Tween

var direction: Vector2
var is_firing: bool

func _ready():
	is_firing = false
	# Initialize the width
	width = 0

func fire(player_pos):
	#direction = get_collision_point()
	#to_local(player_pos)
	#direction = player_pos
	#print(direction)
	#print(player_pos)
	self.points[1] = player_pos - get_parent().position
	self.start_firing_animation()
	is_firing = false
	pass


func start_firing_animation():
	# Create a tween using the SceneTree
	tween = get_tree().create_tween()

	# Interpolate the 'width' property from 0 to 10 over 2 seconds
	tween.tween_property(self, "width", 2.5, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)


func _on_shoot_player_position(player_pos):
	fire(player_pos)
