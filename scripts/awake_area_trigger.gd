extends Area2D

signal slime_awake_area_entered

func _on_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	if node.is_in_group("Player"):
		slime_awake_area_entered.emit()
