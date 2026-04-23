extends CharacterBody2D

const SPEED: float = 130.0
const JUMP_VELOCITY: float = -300.0

signal player_jumped(jumped: bool)
signal direction_changed(dir: int)

@onready var hitbox_component: Area2D = $HitboxComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var animation_component: AnimationComponent = $AnimationComponent

var _direction: int:
	set(value):
		if not value == _direction:
			_direction = value
			direction_changed.emit(value)			
		
func _ready():
	if(hitbox_component.has_signal("took_damage")):
		hitbox_component.took_damage.connect(alertHealth)
	
	
func alertHealth(attack: AttackComponent):
	print("Check me")
	health_component.damage(attack)
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		player_jumped.emit(true)
		velocity += get_gravity() * delta
		
	if is_on_floor():
		player_jumped.emit(false)
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#Get the input direction
	_direction = Input.get_axis("move_left", "move_right")
		
	#if direction > 0:
		#animated_sprite.flip_h = false
		
	#elif direction < 0:
		#animated_sprite.flip_h = true
	#
	#Play animations
	#if is_on_floor():
		#if direction == 0:
			#animated_sprite.play("Idle")
		#else:
			#animated_sprite.play("run")
	#else:
		#animated_sprite.play("jump")
	#
	
	#Apply movement
	if _direction:
		velocity.x = _direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
