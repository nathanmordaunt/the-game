extends Actor

onready var sprite = $AnimatedSprite

export var cam_speed = 250

var direction = Vector2(0, 0);
var acceleration = 1

func _physics_process(dt) -> void:
	acceleration += 0.001
	self.position.x += cam_speed * acceleration * dt

func _process(dt):
	direction = get_direction()
	process_input(dt)

	self.velocity = move_and_slide(self.velocity, FLOOR_STD)

	if direction.y == 1.0:
		sprite.play("flap-up")
	if direction.y == -1.0:
		sprite.play("flap-down")

#gets input key from the player
func get_direction() -> Vector2:
	var y = 1.0
	if Input.is_action_just_pressed("up"):
		y = -1.0
	return Vector2(0.0, y)

#processes math calculations based on input
func calc_velocity(
	dt: float,
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	jump_interupt: bool
) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * dt
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if jump_interupt:
		new_velocity.y = 0.0
	return new_velocity

func process_input(dt) -> void:
	var jump_interupt = Input.is_action_just_released("up") and self.velocity.y < 0.0
	self.velocity = calc_velocity(dt, self.velocity, direction, speed, jump_interupt)


