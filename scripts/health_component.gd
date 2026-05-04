extends Node2D
class_name HealthComponent
@export var MAX_HP: float;

signal player_hurt ()
var current_hp: float

func _ready():
	current_hp = MAX_HP
	
func damage(attack: AttackComponent):
	current_hp -= attack.atkDmg;
	print("current hp is %s" % current_hp)
	if(current_hp <= 0):
		GameManager._on_game_over()
	else:
		player_hurt.emit()
