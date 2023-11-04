extends Node2D
class_name Level

@onready var player: Player = $Player as Player
@onready var start_area: StartArea = $StartArea as StartArea
@onready var end_area = $EndArea as EndArea
@onready var death_zone = $DeathZone
@onready var hud = $UILayer/HUD as Hud
@onready var ui_layer = $UILayer as UILayer


@export var is_final_level: bool = false

@export var next_level: PackedScene = null

@export var level_time: int = 5

var time_left = null
var timer: Timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_player()
	var traps = (get_tree().get_nodes_in_group("traps")) as Array[Trap]
	
	for trap in traps:
		#trap.connect("touched_player", _on_trap_touched_player)
		trap.touched_player.connect(_on_trap_touched_player)
		
	end_area.body_entered.connect(_on_end_area_body_entered)
	death_zone.body_entered.connect(_on_death_zone_body_entered)

	reset_timer()
	timer = Timer.new()
	timer.name = "Level Timer"
	timer.wait_time = 1
	timer.timeout.connect(_on_level_timer_timeout)
	add_child(timer)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	


func _on_death_zone_body_entered(_body: CharacterBody2D) -> void:
	reset_player()
	reset_timer()
	
func _on_trap_touched_player() -> void:
	reset_player()
	reset_timer()

func reset_player() -> void :
	player.velocity = Vector2.ZERO
	player.global_position = start_area.get_spawn_position()
	
func reset_timer() -> void :
	set_time_left(level_time)
	
func _on_end_area_body_entered(body) -> void:
	if body is Player:
		if next_level != null or is_final_level:
			timer.stop()
			end_area.animate()
			body.active = false

			await get_tree().create_timer(1.5).timeout
			if is_final_level:
				ui_layer.display_win_screen(true)
			else:
				get_tree().change_scene_to_packed( next_level)

func _on_level_timer_timeout() -> void:
	set_time_left(time_left -1)
	if time_left < 0:
		reset_player()
		reset_timer()
		

func set_time_left(time: int) -> void:
	time_left = time
	hud.set_time_label(time_left)
	
