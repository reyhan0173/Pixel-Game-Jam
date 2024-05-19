class_name Laser extends Line2D

var tween: Tween
var direction: Vector2
var is_firing: bool
var flipped: bool
@onready var direction_node = get_node("../../direction")
@onready var raycast: RayCast2D = $RayCast2D

func _ready():
	# Initialize the width
	flipped = direction_node.scale.x
	width = 0

func fire(player_pos: Vector2):
	var human_scale = get_parent().scale.x
	# Calculate the offset of the player position from the laser's position
	var local_player_pos = player_pos - get_parent().global_position
	if direction_node.scale.x > 0:
		local_player_pos.x = local_player_pos.x
	elif direction_node.scale.x < 0:
		local_player_pos.x = -local_player_pos.x
	self.points = [Vector2.ZERO, local_player_pos]
	self.start_firing_animation()
	pass


func start_firing_animation():
	tween = get_tree().create_tween()
	tween.tween_property(self, "width", 3.5, 2.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)


func _on_shoot_player_position(player_pos):
	fire(player_pos)
