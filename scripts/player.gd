extends CharacterBody2D

@export var _speed: float = 130.0
@export var _jump_velocity: float = -300.0
@export var _goomba_velocity: float = -500.0

signal player_jumped(jumped: bool)
signal direction_changed(dir: int)
signal player_goombaed

@onready var hitbox_component: Area2D = $HitboxComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var animation_component: AnimationComponent = $AnimationComponent

var _direction: float:
	set(value):
		if not value == _direction:
			_direction = value
			direction_changed.emit(value)			
		
func _ready():
	if(hitbox_component.has_signal("took_damage")):
		hitbox_component.took_damage.connect(alertHealth)
		
func alertHealth(attack: AttackComponent):
	health_component.damage(attack)
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		player_jumped.emit(true)
		velocity += get_gravity() * delta
		
	if is_on_floor():
		player_jumped.emit(false)
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _jump_velocity

	
	#Get the input direction
	_direction = Input.get_axis("move_left", "move_right")

	#Apply movement
	if _direction:
		velocity.x = _direction * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)

	move_and_slide()
	

func _on_player_goombaed() -> void:
	velocity.y = _goomba_velocity 
