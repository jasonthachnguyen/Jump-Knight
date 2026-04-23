class_name AnimationComponent
extends Node2D

@onready var animation_tree: AnimationTree = %AnimationTree
@onready var sprite: Sprite2D = %Sprite2D

var jumped: bool
var is_moving: bool
var died: bool
var hurt: bool

func _on_player_direction_changed(dir) -> void:
	_change_sprite_dir(dir)
	_change_is_moving(dir)


func _on_player_player_jumped(player_jump_bool) -> void:
	if not player_jump_bool == jumped:
		_change_jump_anim(player_jump_bool)


func _change_is_moving(dir):
	if dir == 0:
		is_moving = false
	else:
		is_moving = true


func _change_jump_anim(player_jump_bool):
	jumped = player_jump_bool


func _change_sprite_dir(dir):
	sprite.flip_h = (
		true if dir < 0 	
		else false if dir > 0
		else sprite.flip_h
		)


func _on_health_component_player_died() -> void:
	died = true


func _on_health_component_player_hurt() -> void:
	hurt = true 


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		hurt = false
