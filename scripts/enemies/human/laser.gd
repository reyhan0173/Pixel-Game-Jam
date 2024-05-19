class_name Laser extends Line2D

var tween: Tween
var direction: Vector2
var is_firing: bool
var flipped: bool

func _ready():
	# Initialize the width
	width = 0


func fire(player_pos: Vector2):
	var human_scale = get_parent().scale.x
	# Calculate the offset of the player position from the laser's position
	var local_player_pos = player_pos - get_parent().global_position

	if flipped:
		local_player_pos.x = -local_player_pos.x
	
	print("Player Position: ", player_pos)
	print("Laser Global Position: ", self.global_position)
	print("Local Player Position: ", local_player_pos)
	print("Human Scale: ", human_scale)
	# Ensure the laser points are set correctly
	self.points = [Vector2.ZERO, local_player_pos]
	self.start_firing_animation()

	pass


func start_firing_animation():
	tween = get_tree().create_tween()
	tween.tween_property(self, "width", 2.5, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)


func _on_shoot_player_position(player_pos):
	fire(player_pos)
