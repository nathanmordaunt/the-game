extends KinematicBody2D
class_name Actor

const FLOOR_STD: = Vector2.UP

export var speed = Vector2(500.0, 1500.0)
export var gravity = 2500.0
var velocity: = Vector2.ZERO

#func _physics_process(delta) -> void:
#	if velocity.y > speed.y:
#		velocity.y = speed.y
#	velocity = move_and_slide(velocity)
