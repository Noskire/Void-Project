extends Node3D

func _on_normal_button_up():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_hard_button_up():
	get_tree().change_scene_to_file("res://hardworld.tscn")

func _on_extreme_button_up():
	get_tree().change_scene_to_file("res://extremeworld.tscn")
