extends ParallaxBackground
class_name Background

@onready var sprite = $ParallaxLayer/Sprite2D
@export var scroll_speed: float = 15.00

func _process(delta):
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	
	print(sprite.region_rect.position)

	#we don"t want the backroung to repeat itself for infinite (that will be greedy on performance)
	# we reset the position in order to go back on already existing background
	if sprite.region_rect.position >= Vector2(64,64): # the size of the image is 64 x 64 px
		sprite.region_rect.position = Vector2(0,0)
