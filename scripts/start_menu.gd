extends Control
class_name StartMenu


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_quit_pressed():
	get_tree().quit()
