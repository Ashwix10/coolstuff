extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	print(sprite_2d)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get movement input
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()

	# Flip sprite based on movement direction
	if direction != 0:
		sprite_2d.flip_h = direction < 0

	# Animation logic
	if not is_on_floor():
		sprite_2d.animation = "Jumping"
	elif abs(velocity.x) > 1:
		sprite_2d.animation = "Running"
	else:
		sprite_2d.animation = "default"

	sprite_2d.play()
