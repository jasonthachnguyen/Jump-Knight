extends Node2D

signal player_died
var timer : Timer = Timer.new() 
var timer_duration: float = 1.0

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_game_over() -> void: 
	timer.start(timer_duration)
	player_died.emit()

func _on_timer_timeout() -> void:
	timer.stop()

func _reset_game() -> void:
	get_tree().reload_current_scene()
