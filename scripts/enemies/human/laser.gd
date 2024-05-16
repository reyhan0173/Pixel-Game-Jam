class_name Laser extends Line2D

var tween: Tween
var direction: Vector2
var is_firing: bool

func _ready():
	# Initialize the width
	width = 0


func fire(player_pos):
	self.points[1] = player_pos - get_parent().position
	self.start_firing_animation()
	pass


func start_firing_animation():
	tween = get_tree().create_tween()
	tween.tween_property(self, "width", 2.5, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)


func _on_shoot_player_position(player_pos):
	fire(player_pos)
