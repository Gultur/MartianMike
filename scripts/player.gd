extends CharacterBody2D
class_name Player

@export var gravity: float = 400.00
@export var speed: int = 125
@export var jump_force: int = 200
@export var active: bool = true

var max_velocity: float = 500.00
var jump_count: int = 0

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	if is_on_floor():
		jump_count = 0
		
	if not is_on_floor():
		velocity.y = min(velocity.y + gravity * delta, max_velocity)

	var direction: float = 0.0
	if active:
		if Input.is_action_just_pressed("jump") and can_player_jump(): #is_on_floor():
			jump(jump_force)
		direction = Input.get_axis("move_left", "move_right")
		
	if direction != 0.0:
		var is_moving_left = (direction == -1)
		animated_sprite.flip_h = is_moving_left #we only flip when player move left
	velocity.x = direction * speed
	
	move_and_slide()
	update_animation(direction)

func update_animation(direction: float) -> void:
	if is_on_floor():
		if is_player_idle(direction):
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if is_player_jumping(velocity.y):
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
 
func jump(force: int) -> void:
	#velocity.y -= force
	velocity.y = - force
	jump_count += 1
	
func can_player_jump() -> bool:
	return jump_count < 2
	
func is_player_idle(direction: float) -> bool:
	return (direction == 0)
	
func is_player_jumping(velocity_y: float) -> bool:
	return velocity_y < 0

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()
