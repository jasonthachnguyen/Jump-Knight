extends Area2D

@onready var timer: Timer = $Timer
var timer_duration:float = 2

func _on_body_entered(body: Node2D) -> void:
	timer.start(timer_duration)

func _on_timer_timeout() -> void:
	GameManager.on_game_over()
