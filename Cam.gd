extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export var cam_speed = 250

func _process(dt):
	self.position.x += cam_speed * dt

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
