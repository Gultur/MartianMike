extends ParallaxBackground
class_name Background

@onready var sprite = $ParallaxLayer/Sprite2D
@export var scroll_speed: float = 15.00
@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png")

func _ready():
	sprite.texture = bg_texture

func _process(delta):
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)

	#we don"t want the backroung to repeat itself for infinite (that will be greedy on performance)
	# we reset the position in order to go back on already existing background
	if sprite.region_rect.position >= Vector2(64,64): # the size of the image is 64 x 64 px
		sprite.region_rect.position = Vector2(0,0)
