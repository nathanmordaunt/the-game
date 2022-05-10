extends Actor

onready var animated_sprite = $AnimatedSprite
var playerNumber = 01;


func _physics_process(_delta) -> void:
	Controls()
	
	print(get_direction())
	

#gets input key from the player
func get_direction() -> Vector2:
	return Vector2 (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -1.0
	if Input.is_action_just_pressed("move_up") and is_on_floor() 
	else 1.0)

#processes math calculations based on input
func calc_velocity(linear_velocity: Vector2, dir: Vector2, speed: Vector2, jump_interupt: bool) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * dir.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if dir.y == -1.0:
		new_velocity.y = speed.y * dir.y
	if jump_interupt:
		new_velocity.y = 0.0
	return new_velocity

func Controls() ->void:
	var dir: = get_direction()
	var jump_interupt = Input.is_action_just_released("move_up") and velocity.y < 0.0
	velocity = calc_velocity(velocity, dir, speed, jump_interupt)
	velocity = move_and_slide(velocity, FLOOR_STD)
	Animations(dir)

#controlling animations
func Animations(direction: Vector2) -> void:
	if direction.x == 0.0 and direction.y == 1.0:
		animated_sprite.play("default")
	if  Input.is_action_just_pressed("move_up"):
		animated_sprite.play("fall")
	if  Input.is_action_pressed("move_right") && is_on_floor(): 
		animated_sprite.play("run")
		animated_sprite.flip_h = false
	if  Input.is_action_pressed("move_left") && is_on_floor():
		animated_sprite.play("run")
		animated_sprite.flip_h = true

