extends Area2D

signal load_next_level
var next_scene_path: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		next_scene_path = LevelManager.get_path_to_next_scene(true)
		get_tree().change_scene_to_file(next_scene_path)
			
