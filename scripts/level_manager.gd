extends Node2D

var scene_path: String = "res://scenes/"
var scenes: Array[String] = [scene_path + "level_1.tscn", 
							 scene_path + "level_2.tscn", 
							 scene_path + "level_3.tscn", 
							 scene_path + "level_4.tscn", 
							 scene_path + "level_5.tscn"]
var curr_scene_index: int = 0

func get_path_to_next_scene(increment_index: bool) -> String:
	if increment_index:
		curr_scene_index += 1
	return scenes[curr_scene_index] 
func get_path_to_specific_scene(scene_index: int) -> String:
	return scenes[scene_index - 1]
	
