extends CanvasLayer 

@onready var restart_button: Button = $Control/Button

func _ready() -> void:
	GameManager.timer.timeout.connect(_on_timeout)
	restart_button.pressed.connect(_on_button_pressed)

func _on_timeout() -> void:
	show()

func _on_button_pressed() -> void:
	GameManager._reset_game()
