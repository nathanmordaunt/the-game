extends KinematicBody2D

const FLOOR_STD: = Vector2.UP

export var speed = Vector2(500.0, 1500.0)
export var gravity = 2500.0
var velocity: = Vector2.ZERO



func _ready():
	pass 


func get_direction() -> Vector2:
	return Vector2 (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -1.0
	if Input.is_action_just_released("move_up") and is_on_floor() 
	else 1.0)





func _physics_process(_delta) -> void:
	pass


