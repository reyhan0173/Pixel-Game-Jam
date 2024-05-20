class_name Laser extends Line2D

var tween: Tween
var direction: Vector2
var is_firing: bool
@onready var direction_node = get_node("../../direction")
@onready var raycast: RayCast2D = $RayCast2D


func _ready():
	# Initialize the width
	width = 0
	raycast.enabled = false


func fire(player_pos: Vector2):
	# Calculate the offset of the player position from the laser's position
	var local_player_pos = player_pos - get_parent().global_position
	# Setting the laser to work on both sides
	if direction_node.scale.x > 0:
		local_player_pos.x = local_player_pos.x
	elif direction_node.scale.x < 0:
		local_player_pos.x = -local_player_pos.x
	self.points = [Vector2.ZERO, local_player_pos]
	raycast.enabled = true
	raycast.target_position = local_player_pos
	self.start_firing_animation()
	pass


func start_firing_animation():
	tween = get_tree().create_tween()
	tween.tween_property(self, "width", 3, 2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(self, "width", 0, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT_IN)


func reset_laser():
	width = 0
	self.points = [Vector2.ZERO, Vector2.ZERO]


func _on_shoot_player_position(player_pos):
	fire(player_pos)
