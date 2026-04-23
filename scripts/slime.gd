class_name Slime
extends CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
const _SPEED = 60

var awakened := false

var _direction: int = -1
var _can_move := false

@onready var _ray_cast_right: RayCast2D = $RayCastRight
@onready var _ray_cast_left: RayCast2D = $RayCastLeft
@onready var _awake_area_trigger: Area2D = $AwakeAreaTrigger
@onready var _animation_tree: AnimationTree = %AnimationTree

func _ready():
	_awake_area_trigger.slime_awake_area_entered.connect(_on_slime_awake)

func _process(delta: float) -> void:
	if _can_move:
		if _ray_cast_right.is_colliding():
			_direction = -1
			
		if _ray_cast_left.is_colliding():
			_direction = 1
		
		_update_animation_parameters()
		velocity.x = _direction * _SPEED
		
func _physics_process(delta: float) -> void:
	move_and_slide()	
	
func start_move() -> void:
	_can_move = true
	
#ANIMATION-LOGIC	
func _on_slime_awake() -> void:	
	if awakened == false:
		awakened = true

#ANIMATION
func _update_animation_parameters():
	if _animation_tree["parameters/move/blend_position"] != _direction:
		_animation_tree["parameters/move/blend_position"] = _direction
