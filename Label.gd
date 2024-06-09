extends Label

@export var player_path: NodePath

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player:
		var player_position = player.global_position
		var player_speed = player.velocity.length()
		text = "Player Position: " + str(player_position) + "\nPlayer Speed: " + str(player_speed)
