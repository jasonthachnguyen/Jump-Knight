extends CharacterBody2D

@export var _base_speed: float = 130.0
@export var _jump_velocity: float = -300.0
@export var _goomba_velocity: float = -500.0
@export var _pslime_speed_bonus: float = 80.0
var _is_debug_mode: bool = false
var _curr_speed: float  = _base_speed
var _is_alive: bool = true


signal player_jumped(jumped: bool)
signal direction_changed(dir: int)
signal player_goombaed
signal player_purple_goombaed
signal player_no_purple_power

@onready var hitbox_component: Area2D = $HitboxComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var animation_component: AnimationComponent = $AnimationComponent

var _direction: float:
	set(value):
		if not value == _direction:
			_direction = value
			direction_changed.emit(value)			

var _riding_pslime: bool:
	set(value):
		if value == false:
			player_no_purple_power.emit()
		_riding_pslime = value
			
func _ready():
	if(hitbox_component.has_signal("took_damage")):
		hitbox_component.took_damage.connect(alertHealth)

	GameManager.player_died.connect(_on_player_died)
		
func alertHealth(attack: AttackComponent):
	health_component.damage(attack)
	
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		player_jumped.emit(true)
		velocity += get_gravity() * delta
		
	if is_on_floor():
		if _curr_speed == _base_speed + _pslime_speed_bonus and _riding_pslime == false:
			_curr_speed = _base_speed
		player_jumped.emit(false)
		
	if Input.is_action_just_pressed("jump") and is_on_floor() and _is_alive:
		if _riding_pslime:
			_riding_pslime = false
		velocity.y = _jump_velocity
	
	if Input.is_action_pressed("enter_debug"):
		_is_debug_mode = true

	if Input.is_action_just_pressed("load_level1") and _is_debug_mode:
		var level_one_path = LevelManager.get_path_to_specific_scene(1)
		get_tree().change_scene_to_file(level_one_path)

	if Input.is_action_pressed("load_level2") and _is_debug_mode: 
		var level_two_path = LevelManager.get_path_to_specific_scene(2)
		get_tree().change_scene_to_file(level_two_path)

	if Input.is_action_pressed("load_level3") and _is_debug_mode:
		var level_three_path = LevelManager.get_path_to_specific_scene(3)
		get_tree().change_scene_to_file(level_three_path)
	
	if Input.is_action_pressed("restart_level"):
		get_tree().reload_current_scene()

		
	var _raw_direction = Input.get_axis("move_left", "move_right")
	#Get the input direction
	if _is_alive and _riding_pslime == false:
		_direction = _raw_direction

	elif _is_alive and _riding_pslime == true:
		if _raw_direction != 0:
			_direction = _raw_direction 

	#Apply movement
	if _direction:
		velocity.x = _direction * _curr_speed
	else:
		velocity.x = move_toward(velocity.x, 0, _curr_speed)

	move_and_slide()
	
func _on_player_goombaed() -> void:
	velocity.y = _goomba_velocity 

func _on_purple_goombaed() -> void:
	_riding_pslime = true
	_curr_speed = _base_speed + _pslime_speed_bonus
	print("goomba da slime")
	player_purple_goombaed.emit()

func _on_player_died() -> void:
	velocity.x = 0
	_curr_speed = 0
	_is_alive = false	
