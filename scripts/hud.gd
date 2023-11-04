extends Control
class_name Hud

@onready var time_label = $TimeLabel

func set_time_label(value) -> void:
	time_label.text = "Time : " + str(value)
