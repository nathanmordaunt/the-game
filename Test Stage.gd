extends Node2D

# vertical distance to annihilate the player. 
export var kill_barrier = 300

# block_distance to wait before generating a new block.
export var block_distance_range = Vector2(200, 500)
var block_distance = 200

# display debug lines for the kill barriers.
export var show_kill_barrier = false

onready var rng = RandomNumberGenerator.new()
onready var camera = $Camera2D
onready var player = $Player
onready var barrier = preload("res://kill-barrier.tscn")

# distance the player has travelled without placing a new block.
var distance = 0
var previous_position = Vector2(0, 0)

# debug_lines follow the kill barriers.
# They cover the entire viewport width and move with the player. 
var debug_lines = []

func _ready():
	rng.randomize()
	if show_kill_barrier:
		create_debug_lines()

func _process(delta):
	process_kill_barriers()
	update_debug_lines()
	update_camera_position()
	maybe_place_new_block()

# maybe_place_new_block if we have travelled enough distance
# since the last block.
func maybe_place_new_block():
	# compute the distance travelled between frames. 
	distance += player.position.x - previous_position.x
	previous_position = player.position

	# maybe place block.
	if distance > block_distance:
		distance = 0
		block_distance = rng.randf_range(block_distance_range.x, block_distance_range.y)
		var b = barrier.instance()
		b.position = Vector2(player.position.x + get_viewport().size.x, rng.randf_range(-300, 300))
		b.scale = Vector2(rng.randf_range(0.5, 3), rng.randf_range(1, 5))
		self.add_child(b)

func create_debug_lines():
	# hacky construction of line nodes... 
	var vp = get_viewport()

	var debug_line_top = Line2D.new()
	debug_line_top.set_points([Vector2(-vp.size.x*2, -kill_barrier-1), Vector2(vp.size.x*2, -kill_barrier-1)])
	debug_line_top.set_default_color(Color(100, 100, 100, 0.5))
	debug_line_top.width = 1
	debug_lines.append(debug_line_top)
	self.add_child(debug_line_top)

	var debug_line_bot = Line2D.new()
	debug_line_bot.set_points([Vector2(-vp.size.x*2, kill_barrier), Vector2(vp.size.x*2, kill_barrier)])
	debug_line_bot.set_default_color(Color(100, 100, 100, 0.5))
	debug_line_bot.width = 1
	debug_lines.append(debug_line_bot)
	self.add_child(debug_line_bot)

func update_debug_lines():
	for line in debug_lines:
		line.position.x = player.position.x

# track the camera against the player. 
func update_camera_position():
	camera.position.x = player.position.x

# reset scene when player wanders too far. 
func process_kill_barriers():
	if player.position.y >= kill_barrier or player.position.y <= -kill_barrier:
		get_tree().reload_current_scene()
