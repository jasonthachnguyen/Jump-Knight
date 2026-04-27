extends Area2D


func _on_area_entered(area: Area2D) -> void:

	if has_attack:
		player_goombaed.emit(attack_node)
