extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0
const GRAVITY = 2500.0  # Default Godot gravity, adjust if needed

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get movement input
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()

	# Flip sprite based on movement direction
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0

	# ANIMATION LOGIC
	if not is_on_floor():
		sprite_2d.animation = "Jumping"
	elif abs(velocity.x) > 1:
		sprite_2d.animation = "Running"
	else:
		sprite_2d.animation = "default"

	# Ensure animation plays
	sprite_2d.play()
