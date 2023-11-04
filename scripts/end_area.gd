extends Area2D
class_name EndArea

@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.play("default")


func animate() -> void:
	animated_sprite.play("pressed")
