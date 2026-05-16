extends Area2D

signal load_next_level



func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Player"):
		load_next_level.emit()
		print("loading next level :3")

