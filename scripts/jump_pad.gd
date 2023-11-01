extends Area2D
class_name JumpPad

@export var jump_force: int = 400
@onready var animated_sprite = $AnimatedSprite2D

func _on_body_entered(body):
	if body is Player:
		animated_sprite.play("jump")
		body.jump(jump_force)

