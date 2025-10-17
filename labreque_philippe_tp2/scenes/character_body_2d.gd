
extends CharacterBody2D

# Vitesse de déplacement
@export var move_speed: float = 200.0
# Force de saut
@export var jump_force: float = 400.0
# Gravité (remplace gravity_project_settings pour avoir un meilleur contrôle)
@export var gravity: float = 900.0

# Référence au AnimatedSprite2D
@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Si on touche le sol et qu'on appuie sur saut
		if Input.is_action_just_pressed("fly"):
			velocity.y = -jump_force

	# Déplacement horizontal
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = direction * move_speed

	# Appliquer le mouvement
	move_and_slide()

	# Gérer les animations
	_update_animation(direction)

func _update_animation(direction: float) -> void:
	if not is_on_floor():
		sprite.animation = "jump"
	elif direction != 0:
		sprite.animation = "run"
	else:
		sprite.animation = "idle"

	# Flip horizontal selon la direction
	if direction != 0:
		sprite.flip_h = direction < 0
