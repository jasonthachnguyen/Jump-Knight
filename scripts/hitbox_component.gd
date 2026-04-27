extends Area2D

signal took_damage(AttackComponent)

func _on_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	#TODO: refactor this because its poop...
	if node.is_in_group("Enemy") and area.name == "AttackAreaTrigger":
		var attack_node = node.find_child("AttackComponent")	
		var has_attack = node.has_node(attack_node.get_path())
		
		if(has_attack):
			took_damage.emit(attack_node)

