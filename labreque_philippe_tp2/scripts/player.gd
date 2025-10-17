extends CharacterBody2D

@export var move_speed: float = 200.0
@export var jump_force: float = 400.0
@export var gravity: float = 900.0

@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump_force

	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * move_speed

	move_and_slide()

	_update_animation(direction)

func _update_animation(direction: float) -> void:
	if not is_on_floor():
		sprite.animation = "jump"
	elif direction != 0:
		sprite.animation = "run"
	else:
		sprite.animation = "idle"

	if direction != 0:
		sprite.flip_h = direction < 0
