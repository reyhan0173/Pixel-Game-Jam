extends TileMap

@onready var human = $human
@onready var player = $Player
var patrol_state = Node2D
var player_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	player_pos = player.position
	patrol_state = human.get_node("state_machine/patrol")
	patrol_state.get_splash_pos(player_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
