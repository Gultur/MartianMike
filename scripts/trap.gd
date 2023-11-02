extends Node2D
class_name Trap

signal touched_player

func _on_area_2d_body_entered(body):
	if body is Player:
		touched_player.emit()
